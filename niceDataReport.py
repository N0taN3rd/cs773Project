import json
from itertools import zip_longest

def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
    args = [iter(iterable)] * n
    return zip_longest(*args, fillvalue=fillvalue)

if __name__ == '__main__':
    with open('q1/q1Labels.json') as q1l:
        labs = json.load(q1l)

    for l, lvals in labs.items():
        if l == 'mapping':
            continue
        print(l)

        if l == 'cuisine':
            for a1,a2,a3, a4,a5 in grouper(lvals,5):
                print('%s & %s & %s & %s & %s \\\\'%(a1,a2,a3,a4,a5))
        else:
            for a1,a2,a3, a4 in grouper(sorted(lvals),4):
                print('%s & %s & %s & %s \\\\'%(a1,a2,a3,a4))
        # else:
        #     for a1,a2,a3 in grouper(lvals,3):
        #         print('%s & %s & %s \\\\'%(a1,a2,a3))
        print('----------------------------------------')
