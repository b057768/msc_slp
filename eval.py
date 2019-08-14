#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 19 11:03:43 2019

@author: s1527110, modified by s1444568
"""

import argparse
import re, string

parser = argparse.ArgumentParser(description='Prints word accuracy of predictions given gold standard.')
parser.add_argument("predictions", type = argparse.FileType('r'), help="predictions filepath")
parser.add_argument("gold",type = argparse.FileType('r'), help="gold standard filepath")
parser.add_argument('-out', type=argparse.FileType('w'), help="file to write errors")
args = parser.parse_args()

print("Calculating word accuracy, please wait...")

with args.predictions as p:
    predictions = p.readlines()

with args.gold as g:
    gold = g.readlines()

total_correct = 0
total_errors = 0
error_lines = [] #list of tuples
index = 0
for pred in predictions:
    if pred == gold[index]:
        total_correct += 1
    else:
        total_errors +=1
        error_lines.append((predictions[index].strip(), gold[index]))
    index +=1

if args.out:
    with args.out as outfile:
        outfile.write("WORD,PREDICTION,GOLD\n" )

        for error in error_lines:
            word = re.sub(r'\W+', '', error[1])
            outfile.write(word+","+error[0]+","+error[1])

print("This is gold line 1: ",gold[0])
print("This is predicted line 1: ",predictions[0])
print("If these look weird, look at fixing your data")

print("Total: ", len(predictions), "\tTotal correct: ", total_correct, "\tTotal errors: ", total_errors)
print("Word accuracy: ", (total_correct/index)*100, "%")
