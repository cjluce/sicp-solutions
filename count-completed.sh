#!/bin/bash

# Exercises by chapter
#  1  2  3  4  5
# 46 97 82 79 52
total_exercises=356
completed_exercises=`find -name '*ex-*' | grep -v '.*~' | wc -l`
share_completed=`awk -v var1=$completed_exercises \
		     -v var2=$total_exercises \
		     'BEGIN { print  ( var1 / var2 * 100) }'`
echo "Completed" \
     $completed_exercises \
     "out of" \
     $total_exercises \
     "exercises" \
     "(" \
     $share_completed \
     "%)"

exit 0
