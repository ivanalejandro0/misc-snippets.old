#!/usr/bin/env python
# -*- coding: utf-8 -*-

from timeit import Timer
from decimal import Decimal
from random import random

data01 = []
data02 = []

LIMIT = 10


def init_decimal_data():
    for i in xrange(LIMIT):
        data01.append(Decimal(str(random())))


def init_float_data():
    for i in xrange(LIMIT):
        data02.append(random())


def sum_decimal():
    sum = 0
    for i in xrange(LIMIT):
        sum = sum + data01[i]

    return sum


def sum_float():
    sum = 0
    for i in xrange(LIMIT):
        sum = sum + data02[i]

    return sum

init_decimal_data()
init_float_data()


def test01():
    sum_decimal()


def test02():
    sum_float()


if __name__ == '__main__':
    t01 = Timer("test01()", "from __main__ import test01")
    test01_time = t01.timeit()

    t02 = Timer("test02()", "from __main__ import test02")
    test02_time = t02.timeit()

    print "test01 time: %f" % test01_time
    print "test02 time: %f" % test02_time

# My results
# test01 time: 201.225335
# test02 time: 1.769685
