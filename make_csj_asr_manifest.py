"""
Helper script to pre-compute embeddings for a flashlight (previously called wav2letter++) dataset
"""

import argparse
import os


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("tsv")
    parser.add_argument("--output-dir", required=True)
    parser.add_argument("--output-name", required=True)
    parser.add_argument("--preserve-dict", action="store_false")
    args = parser.parse_args()

    os.makedirs(args.output_dir, exist_ok=True)

    transcriptions = {}
    dicts = {}
    dict_file = os.path.join(args.output_dir, "dict.ltr.txt")
    if os.path.exists(dict_file):
        with open(dict_file) as d:
            lines = d.readlines()
            for line in lines:
                l = line.strip().split(" ")
                dicts[l[0]] = int(l[1])

    # tsvに対応したtranscriptionをtextから取り出して文字数をカウントする処理
    with open(args.tsv, "r") as tsv, open(
        os.path.join(args.output_dir, args.output_name + ".ltr"), "w"
    ) as ltr_out, open(
        os.path.join(args.output_dir, args.output_name + ".wrd"), "w"
    ) as wrd_out:
        root = next(tsv).strip()
        for line in tsv:
            line = line.strip()
            dir = os.path.dirname(line)
            
            dir = dir.split("/")[0]
            if dir not in transcriptions:
                parts = dir.split(os.path.sep)
                trans_path = "text"
                path = os.path.join(root, os.path.dirname(dir), "text")
                print(path)
                assert os.path.exists(path)
                texts = {}
                with open(path, "r") as trans_f:
                    for tline in trans_f:
                        items = tline.strip().split()
                        texts[items[0]] = " ".join(items[1:])
                transcriptions[dir] = texts
            part = os.path.basename(line).split(".")[0]
            assert part in transcriptions[dir]
            print(transcriptions[dir][part], file=wrd_out)
            print(
                " ".join(list(transcriptions[dir][part].replace(" ", "|"))) + " |",
                file=ltr_out,
            )
            for w in list(transcriptions[dir][part].replace(" ","")):
                if w not in dicts:
                    dicts[w] = 1
                else:
                    dicts[w] += 1
    dict_list = []
    for k, v in dicts.items():
        dict_list.append(f"{k} {v}\n")

    if args.preserve_dict:
        # fairseq finetuning用のtokenlist
        with open(os.path.join(args.output_dir, "dict.ltr.txt"),"w") as d:
            d.writelines(dict_list)
                    


if __name__ == "__main__":
    main()
