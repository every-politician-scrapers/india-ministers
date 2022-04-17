#!/bin/bash

bundle exec ruby bin/scraper/chief-ministers-wikipedia.rb > data/chief-ministers-wikipedia.csv
bundle exec ruby bin/diff-chief-ministers.rb > data/diff-chief-ministers.csv
