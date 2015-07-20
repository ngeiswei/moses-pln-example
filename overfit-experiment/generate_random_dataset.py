#!/usr/bin/env python

# Little tool to generate dataset with random features

import os
import sys
import random

if __name__ == "__main__":
    argv = sys.argv
    argc = len(argv)

    # Parse arguments
    if argc == 3:
        n_features = int(argv[1])
        n_rows = int(argv[2])
    else:
        print "Usage: " + argv[0] + " NUM_FEATURES NUM_ROWS"
        exit(1)

    # write header
    print ",".join(["target"] + ["f" + str(i) for i in range(1, n_features)])

    # write rows
    for j in range(0, n_rows):
        print ",".join([str(random.randint(0, 1)) for i in range(0, n_features)])
