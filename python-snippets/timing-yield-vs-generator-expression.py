#!/usr/bin/env python
# -*- coding: utf-8 -*-
from timeit import Timer

ITERATIONS = 10000


def go_loop():
    for i in xrange(ITERATIONS):
        yield i**2


def go_generator_expression():
    return (x**2 for x in xrange(ITERATIONS))


def test01():
    list(go_loop())


def test02():
    list(go_generator_expression())


if __name__ == '__main__':
    t01 = Timer("test01()", "from __main__ import test01")
    test01_time = t01.timeit(number=10000)

    t02 = Timer("test02()", "from __main__ import test02")
    test02_time = t02.timeit(number=10000)

    print "yield time: %f" % test01_time
    print "generator expression time: %f" % test02_time

# My results
# yield time: 24.367199
# generator expression time: 23.710827
