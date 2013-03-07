#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

try:
    from PyQt4 import QtGui
except ImportError:
    print "PyQt4 (Qt4 bindings for Python) is required for this application."
    print "You can find it here: http://www.riverbankcomputing.co.uk"
    sys.exit()


def showMessage():
    msgBox = QtGui.QMessageBox()
    msgBox.setText('Main message')
    msgBox.setInformativeText('Informative message')
    msgBox.setIcon(QtGui.QMessageBox.Warning)
    msgBox.exec_()
    return
