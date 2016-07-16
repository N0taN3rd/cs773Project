import json
import os

if __name__ == '__main__':
    print('hi')
    out = []
    fixCuisine = ['Indian','Argentinean','Nicaraguan','Russian','Venezuelan' ]
    with open(os.path.join(os.getcwd(), 'q1/q1Labels.json'), 'r') as lin:
        labels = json.load(lin)

    cuisine = labels['cuisine']
    style = labels['style']
    with open(os.path.join(os.getcwd(),'q1/restaurants.json'),'r') as rin:
        for r in json.load(rin):
            labs = r['labels']
            for l in labs:
                val = l['val']
                if val in cuisine:
                    l['label'] = 'cuisine'
                    # if l['label'] != 'cuisine':
                    #     print('%s is in corrected cuisine and currently is in %s' % (val, l['label']))
                if val in style:
                    l['label'] = 'style'
                    # if l['label'] != 'style':
                    #     print('%s is in corrected style and currently is in %s'%(val,l['label']))
            r['labels'] = labs
            out.append(r)
    with open(os.path.join(os.getcwd(), 'q1/restaurants.json'), 'w+') as rout:
        json.dump(out,rout,sort_keys=True,indent=1)