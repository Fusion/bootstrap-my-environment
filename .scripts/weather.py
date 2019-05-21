#!/usr/bin/env python3

import json
import urllib
import urllib.parse
import urllib.request
import os


def main():
    try:
        with open(os.path.join(
                os.path.expanduser("~"),
                '.scripts',
                'weather.json')) as f:
            payload = json.load(f)
            api_key = payload['api_key']
            latlong = payload['latlong']
    except:
        return ''

    try:
        weather = json.loads(urllib.request.urlopen(
            'https://api.darksky.net/forecast/' + api_key + '/' + latlong)
            .read())
        temp = int(float(weather['currently']['temperature']))
        return '{}°F'.format(temp)
    except:
        return ''


if __name__ == "__main__":
    print(main())
