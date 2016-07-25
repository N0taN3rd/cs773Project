import json
import csv
import glob
import os
from itertools import zip_longest


def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
    args = [iter(iterable)] * n
    return zip_longest(*args, fillvalue=fillvalue)


def ruleExtraction(rd):
    if rd is None:
        return None
    else:
        return rd['rules'].replace('>', '\\textgreater').replace('$', '\$').replace('{', '\{').replace('}',
                                                                                                       '\}').replace(
            '&', '\&')


def xxx():
    for file in sorted(glob.glob('q3/presentable/*.csv')):
        if file == 'q3/presentable/restaurantsq3.csv':
            continue
        rc = 0
        confidence = []
        support = []
        lift = []
        conviction = []
        with open(file, 'r') as fin:
            for r in csv.DictReader(fin):
                rc += 1
                if r['confidence'] != 'NA':
                    confidence.append(float(r['confidence']))
                if r['support'] != 'NA':
                    support.append(float(r['support']))
                if r['lift'] != 'NA':
                    lift.append(float(r['lift']))
                if r['conviction'] != 'NA':
                    conviction.append(float(r['conviction']))
            rstring = '%s & $%d$ & $[%f,%f]$ & $[%f,%f]$ & $[%f,%f]$ & $[%f,%f]$ \\\\' % (os.path.basename(file).replace('.csv', '').replace('_','\_'),
            rc, min(support), max(support),
            min(confidence), max(confidence), min(lift), max(lift), min(conviction), max(conviction))
            print(rstring)

if __name__ == '__main__':
    for file in glob.glob('q3/presentable/*.csv'):
        if file == 'q3/presentable/restaurantsq3.csv':
            continue
        print(os.path.basename(file).replace('csv', 'txt'))
        with open(file, 'r') as fin:
            count = 0
            with open('q3/%s' % os.path.basename(file).replace('csv', 'txt'), 'w+') as fout:
                for a1, a2 in grouper(csv.DictReader(fin), 2):
                    count += 1
                    if count < 51:
                        fout.write('%s & %s \\\\ \n' % (ruleExtraction(a1), ruleExtraction(a2)))
                    # with open('q1/q1Labels.json') as q1l:

            # with open('q1/q1Labels.json') as q1l:
            #     labs = json.load(q1l)
            #
            # for l, lvals in labs.items():
            #     if l == 'mapping':
            #         continue
            #     print(l)
            #
            #     if l == 'cuisine':
            #         for a1,a2,a3, a4,a5 in grouper(lvals,5):
            #             print('%s & %s & %s & %s & %s \\\\'%(a1,a2,a3,a4,a5))
            #     else:
            #         for a1,a2,a3, a4 in grouper(sorted(lvals),4):
            #             print('%s & %s & %s & %s \\\\'%(a1,a2,a3,a4))
            #     # else:
            #     #     for a1,a2,a3 in grouper(lvals,3):
            #     #         print('%s & %s & %s \\\\'%(a1,a2,a3))
            #     print('----------------------------------------')
