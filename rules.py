import csv
import glob
import json
import os
import itertools
from os import path
import re
import types
import string
from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
from collections import defaultdict, Counter
from sklearn.tree import DecisionTreeClassifier
from restaurantOriginalData import readResturants, featureMap
from resturant import Restaurant, Label, getResturants
from functional import seq
from sklearn.datasets import load_iris, load_boston
from sklearn import tree

from nltk.classify.util import names_demo, binary_names_demo_features



#
# def readResturants():
#     restaurants = []
#     features = featureMap()
#     for file in glob.glob('dataset/*.txt'):
#         if not file == 'dataset/features.txt':
#             with open(file, 'r') as fin:
#                 for food in map(cleanFood, fin):
#                     restaurants.append(Restaurant(file, food, features))
#     return restaurants

def clean_up():
    restaurants = []
    labels = []
    labelsMapped = {}

    with open('projectData/labels.json', 'r') as cin:
        ls = json.load(cin)  # type: dict[str,list]
        for k, v in ls.items():
            for vv in v:
                labelsMapped[vv] = k

    with open('projectData/uniqueFeatures.json', 'r') as cin:
        uf = json.load(cin)  # type: dict[str,list]

    featuresMapped = {}
    features = featureMap()

    for k, v in uf.copy().items():
        featuresMapped[k] = v
        featuresMapped[v] = k

    # for k, v in featuresMapped.items():
    #     print(k, v)

    restaurants = readResturants()  # type: list

    nr = []
    for r in restaurants:
        nrf = []
        nff = []
        for rf in r.rawFeatureVector:
            raw = featuresMapped[features[rf]]
            nrf.append(raw)
            nff.append(featuresMapped[raw])
            r.mapped.append({"num": raw, "f": featuresMapped[raw]})
        r.rawFeatureVector = nrf
        r.featureVector = nff
        nr.append(r)

    with open('projectData/cleanedCityData.json', 'w+') as cc:
        json.dump(nr, cc, indent=2, sort_keys=True, default=lambda x: x.for_json())


def finalize_resturants_json():
    with open('projectData/cleanedCityData.json', 'r') as cc:
        cleaned = json.load(cc)

    labelsMapped = {}
    unique = {}
    with open('projectData/labels.json', 'r') as cin:
        ls = json.load(cin)  # type: dict[str,list]
        for k, v in ls.items():
            for vv in v:
                labelsMapped[vv] = k

    with open('projectData/uniqueFeatures.json', 'r') as cin:
        uf = json.load(cin)  # type: dict[str,list]
        for k, v in uf.items():
            unique[v] = k

    restaurants = []
    for it in cleaned:
        labels = []
        for m in it['mapped']:
            l = m['f']
            labels.append(Label(m['num'], labelsMapped[l], l))
        restaurants.append(Restaurant(it['id'], it['city'], it['name'], labels))

    with open('projectData/restaurants.json', 'w+') as cc:
        json.dump(restaurants, cc, indent=2, sort_keys=True, default=lambda x: x.for_json())


def final2():
    labelsMapped = {}
    unique = {}
    with open('projectData/labels.json', 'r') as cin:
        ls = json.load(cin)  # type: dict[str,list]
        for k, v in ls.items():
            for vv in v:
                labelsMapped[vv] = k

    reduce = ['Indian', 'Mexican', 'Italian', 'French', 'American', 'Mex']
    newUnique = set()
    newcuisine = set()
    reduceMapping = {}
    for c in ls['cuisine']:
        wasIn = False
        it = None
        for r in reduce:
            if r in c:
                if c != 'French-Japanese':
                    it = 'Mexican' if r == 'Mex' or r == 'Mexican' else r
                    wasIn = True
                    newcuisine.add(it)
        if not wasIn:
            newcuisine.add(c)
    ls['cuisine'] = sorted(list(newcuisine))
    for k, v in ls.items():
        for vv in v:
            newUnique.add(vv)
    out = {}
    for idx, it in enumerate(sorted(newUnique)):
        out[idx] = it

    with open('projectData/reducedFeatures.json', 'w+') as cin:
        json.dump(out, cin, indent=2, sort_keys=True)

    with open('projectData/labels2.json', 'w+') as cin:
        json.dump(ls, cin, indent=2, sort_keys=True)

    bway = {}
    with open('projectData/reducedFeatures.json', 'r') as cin:
        uf = json.load(cin)  # type: dict[str,list]
        for k, v in uf.items():
            bway[v] = k
            bway[k] = v

    rs = getResturants()  # type: list[Restaurant]
    reduce = ['Indian', 'Mexican', 'Italian', 'French', 'American', 'Mex']
    for r in rs:
        newlabels = []
        for l in r.labels:
            if l.label == 'cuisine':
                for r in reduce:
                    if r in l.val:
                        # print('before change', l)
                        it = 'Mexican' if r == 'Mex' or r == 'Mexican' else r
                        l.val = it
            l.num = bway[l.val]
            # print('after change', l)

    for r in rs:
        for l in r.labels:
            if l.label == 'cuisine':
                print(l, l.num)

    with open('projectData/restaurants.json', 'w+') as cc:
        json.dump(rs, cc, indent=2, sort_keys=True, default=lambda x: x.for_json())


def indexCityId():
    cspace = re.compile('\s')
    cities = set()
    rCity = list()
    rs = getResturants()  # type: list[Restaurant]

    with open('projectData/labels2.json', 'r+') as cin:
        labels = json.load(cin)

    for r in rs:
        rCity.append(r.city + r.id)

    indexCitiesName = {}

    for idx, c in enumerate(rCity):
        indexCitiesName[c] = str(idx)
        indexCitiesName[str(idx)] = c

    for r in rs:
        r.cid = indexCitiesName[r.city + r.id]

    with open('projectData/restaurants.json', 'w+') as cc:
        json.dump(rs, cc, indent=2, sort_keys=True, default=lambda x: x.for_json())

    with open('projectData/indexCityName.json', 'w+') as cc:
        json.dump(indexCitiesName, cc, indent=2)


def write_arff(fname, features, datas):
    with open('projectData/%s.arff' % fname, 'w+') as arff:
        arff.write('%%\n')
        arff.write('@relation %s\n' % (fname))
        arff.write('@attribute restaurant numeric\n')
        arff.write('@attribute features relational\n')

        arff.write('\t@attribute f numeric\n')
        arff.write('@end features\n')
        arff.write('@dataset\n')
        for r in datas:
            arff.write(r.for_arff())
        arff.write('%%\n%s' % os.linesep)


class DictList:
    def __init__(self):
        self.map = defaultdict(list)  # type: dict[list]

    def __setitem__(self, key, value):
        if type(value) == list:
            self.map[key].extend(value)
        else:
            self.map[key].append(value)

    def __getitem__(self, item):
        return self.map[item]

    def get(self, k, d=None):
        return self.map.get(k, d)

    def keys(self):
        return self.map.keys()

    def itemSet(self):
        out = {}
        for k, v in self.map.items():
            out[k] = set(v)
        return out

    def itemSet_with_count(self):
        out = {}
        for k, v in self.map.items():
            kCounter = Counter()
            for vv in v:
                kCounter[vv] += 1

            out[k] = set(v), kCounter
        return out

    def items(self):
        return self.map.items()


def orderIncreasing(groupedLabels):
    ordered = []
    for k, v in groupedLabels.items():
        ordered.append((k, v, len(v)))
    return sorted(ordered, key=lambda x: x[2], reverse=True)


def q2():
    rs = getResturants()
    headers = ['cuisine', 'atmosphere', 'occasion', 'price', 'style']
    cuisineGrouped = defaultdict(DictList)  # type: dict[DictList]
    cuisineFilter = ['Indian', 'Mexican', 'Italian', 'French', 'American']
    with open('q2/cuisineCharacters2.csv', 'w+') as cOut:
        cOut.write('cuisine,atmosphere,occasion,price,style\n')
        finalOut = []
        for r in filter(lambda x: x.hasLabelValue(('cuisine', cuisineFilter)), rs):
            print(r.name_city)
            rLabelCount = r.label_count(lambda x: x[0] != 'cuisine')
            glables = r.group_labels_for_label('cuisine', cuisineFilter)
            lkey = glables[0]
            grouped = glables[1]
            listOfLabels = []
            if len(lkey) == 1:
                key = lkey[0]
                for l in ['atmosphere', 'occasion', 'price', 'style']:
                    ll = grouped.get(l)
                    if ll is None:
                        listOfLabels.append(['none'])
                    else:
                        listOfLabels.append(ll)
                print(list(itertools.product(*listOfLabels)))
                for product in itertools.product(*listOfLabels):
                    finalOut.append ((key,product[0],product[1],product[2],product[3]))
            else:
                # for key in lkey:
                for l in ['atmosphere', 'occasion', 'price', 'style']:
                    ll = grouped.get(l)
                    if ll is None:
                        listOfLabels.append(['none'])
                    else:
                        listOfLabels.append(ll)
                for product in itertools.product(*listOfLabels):
                    for key in lkey:
                        finalOut.append((key, product[0], product[1], product[2], product[3]))
                print(list(itertools.product(*listOfLabels)))
            print('----------------------------------------')
        for entry in finalOut:
            print(entry)
            cOut.write('%s,%s,%s,%s,%s\n'%(entry[0],entry[1],entry[2],entry[3],entry[4]))


def q3():
    rs = getResturants()
    finalOut = []
    labels = ['atmosphere', 'occasion', 'price', 'style']
    onlyQuisine = set()
    with open('q3/restaurantsq3.csv','w+') as rout:
        rout.write('cuisine,atmosphere,occasion,price,style\n')
        for r in rs:
            print(r)
            listOfLabels = []
            grouped = r.group_labels()
            cuisine = grouped.get('cuisine',None)
            if cuisine is not None:
                print(cuisine)
                for l in labels:
                    ll = grouped.get(l)
                    if ll is None:
                        listOfLabels.append(['none'])
                    else:
                        listOfLabels.append(ll)

                if isinstance(cuisine,list):
                    for product in itertools.product(*listOfLabels):
                        for c in cuisine:
                            finalOut.append((c, product[0], product[1], product[2], product[3]))
                else:
                    for product in itertools.product(*listOfLabels):
                        finalOut.append((cuisine, product[0], product[1], product[2], product[3]))
        for entry in finalOut:
            rout.write('%s,%s,%s,%s,%s\n' % (entry[0], entry[1], entry[2], entry[3], entry[4]))
            # for l in labels:
            #     ll = grouped.get(l)
            #     if ll is None:
            #         listOfLabels.append(['none'])
            #     else:
            #         listOfLabels.append(ll)


if __name__ == '__main__':
    print("hi")
    q2()
    # rs = getResturants()
    # foodQualityCounter = Counter()
    # for r in rs:
    #     for l in filter(lambda x: x.label == 'atmosphere',r.labels):
    #             if 'Food' in l.val:
    #                 foodQualityCounter[l.val] += 1
    #                 foodQualityCounter['total'] += 1
    # print(foodQualityCounter)