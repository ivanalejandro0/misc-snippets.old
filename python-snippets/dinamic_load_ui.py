#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

try:
    from PyQt4 import QtGui, QtCore, uic
except ImportError:
    print "PyQt4 (Qt4 bindings for Python) is required for this application."
    print "You can find it here: http://www.riverbankcomputing.co.uk"
    sys.exit()

import os


class DemoWindow(QtGui.QMainWindow):
    def __init__(self):
        QtGui.QMainWindow.__init__(self)

        file_path = os.path.abspath(os.path.dirname(__file__))
        uifile = os.path.join(file_path, 'window.ui')
        uic.loadUi(uifile, self)

        self.ui = self

    def on_widget_name_signal_name(self):
        '''
        SLOT
        Triggered on:
            widget_name.signal_name
            for instance: test_button.clicked

        Automatic connection made by uic.
        '''
        pass

    # test action
    @QtCore.pyqtSlot()
    def on_actionSomething_triggered(self):
        pass


if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    dw = DemoWindow()
    dw.show()
    sys.exit(app.exec_())
