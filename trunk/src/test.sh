#!/bin/sh


./midilc -c < tests/test-$1.m > test.csv

echo "=============CSV=================="
cat test.csv
echo "=================================="

java -jar CSV2MIDI.jar test.csv test.midi

mv test.csv test-$1.out

echo "========Converting MIDI==========="
timidity test.midi --volume=250 -Ow1S -s 44100 -o test.wav
echo "===========Playing MIDI==========="
timidity test.midi
