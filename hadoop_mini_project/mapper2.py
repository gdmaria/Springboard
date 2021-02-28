#!/usr/bin/env python
import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    line = line.strip()
    vin_number, values = line.split('\t', 1)
    incident_type, make, year = values.strip().split(',', 2)

    print('%s\t%s' % (make + '_' + year, 1))
