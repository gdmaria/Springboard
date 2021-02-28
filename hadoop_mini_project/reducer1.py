#!/usr/bin/env python
import sys

# [Define group level master information]
group_vin = None
group_make = None
group_year = None
group_accident_cnt = 0


def flush():
    if group_vin:
        # write result to STDOUT
        for i in range(group_accident_cnt):
            print('%s\t%s,%s,%s' % (group_vin, 'A', group_make, group_year))


# input comes from STDIN
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()

    # parse the input we got from mapper.py
    vin, values = line.split('\t', 1)
    incident_type, make, year = values.strip().split(',', 2)

    if not group_vin:
        group_vin = vin

    if make and year:
        group_make = make
        group_year = year

    if group_vin != vin:
        flush()

        group_vin = vin
        group_make = None
        group_year = None
        group_accident_cnt = 0

    if incident_type == 'A':
        group_accident_cnt += 1

# output the last group
if group_vin == vin:
    flush()
