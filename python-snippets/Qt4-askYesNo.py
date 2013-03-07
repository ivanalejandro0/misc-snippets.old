#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

try:
    from PyQt4 import QtGui
except ImportError:
    print "PyQt4 (Qt4 bindings for Python) is required for this application."
    print "You can find it here: http://www.riverbankcomputing.co.uk"
    sys.exit()


def askYesNo(title='', question=''):
    ret = False
    res = QtGui.QMessageBox.question(
        None, title, question,
        QtGui.QMessageBox.Yes | QtGui.QMessageBox.No,
        QtGui.QMessageBox.No)  # default No

    if res == QtGui.QMessageBox.Yes:
        ret = True

    return ret


if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    askYesNo('Title', 'Question?')
