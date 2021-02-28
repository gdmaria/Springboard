#!/usr/bin/env python
import sys

# [Define group level master information]
group_make_year = None
group_cnt = 0


def flush():
    if group_make_year:
        # write result to STDOUT
        print('%s\t%s' % (group_make_year, group_cnt))


# input comes from STDIN
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()

    # parse the input we got from mapper.py
    make_year, cnt = line.split('\t', 1)

    if not group_make_year:
        group_make_year = make_year

    if group_make_year != make_year:
        flush()

        group_make_year = make_year
        group_cnt = 0

    group_cnt += 1

# output the last group
if group_make_year == make_year:
    flush()
