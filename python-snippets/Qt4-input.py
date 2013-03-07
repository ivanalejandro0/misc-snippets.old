#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

try:
    from PyQt4 import QtGui
except ImportError:
    print "PyQt4 (Qt4 bindings for Python) is required for this application."
    print "You can find it here: http://www.riverbankcomputing.co.uk"
    sys.exit()


def ask(title='', question=''):
    response, ok = QtGui.QInputDialog.getText(None, title, question)
    return response, ok

if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    res, ok = ask('Title', 'Question?')
    if ok:
        print res
