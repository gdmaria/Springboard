#!/usr/bin/env python
import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    line = line.strip()
    values = line.split(',')

    vin_number = values[2]
    incident_type = values[1]
    make = values[3]
    year = values[5]

    print('%s\t%s,%s,%s' % (vin_number, incident_type, make, year))
