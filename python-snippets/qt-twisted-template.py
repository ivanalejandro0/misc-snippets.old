#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import random
import time

from PySide import QtCore, QtGui

from twisted.internet import reactor, threads
from twisted.internet.task import LoopingCall

# flag to control if we want to display GUI widgets or run console only.
USE_GUI = False


class DemoClass(QtGui.QWidget):
    """
    Class that does something.
    """

    def __init__(self, name):
        """
        DemoClass constructor.

        :param name: the name of our demo instance.
        :type name: str or unicode
        """
        QtGui.QWidget.__init__(self)
        self._name = name

    def do_something(self):
        """
        Do something.
        """
        def do_some_thing():
            """
            Do the actual task
            """
            delay = random.randint(1, 5)
            print "{0}: do something... delay: {1}".format(self._name, delay)
            time.sleep(delay)  # Simulate some delay.
            print "{0}: do something end.".format(self._name)

        def result_ok(_):
            """
            Callback handler for `do_something`.

            :param _: ignored
            """
            print "{0}: result ok.".format(self._name)
            if USE_GUI:
                title = self.tr("Operation OK")
                msg = self.tr("{0}: your operation finished successfully.")
                msg = msg.format(self._name)
                QtGui.QMessageBox.information(None, title, msg)
            # show_msg = lambda: QtGui.QMessageBox.information(
            #     None, self.tr("Operation OK"), msg)
            # reactor.callLater(0, show_msg)

        def result_err(failure):
            """
            Errback handler for `do_something`.

            :param failure: the failure that triggered the errback.
            :type failure: twisted.python.failure.Failure
            """
            print "{0}: failure... {1!r}".format(self._name, failure)
            # failure.raiseException()
            if USE_GUI:
                title = self.tr("Operation Error")
                msg = self.tr("{0}: your operation failed.").format(self._name)
                QtGui.QMessageBox.critical(None, title, msg)

        d = threads.deferToThread(do_some_thing)
        d.addCallback(result_ok)
        d.addErrback(result_err)


if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)

    demo = DemoClass('Test A')
    if USE_GUI:
        demo.show()
    demo.do_something()

    demo2 = DemoClass('Test B')
    if USE_GUI:
        demo2.show()
    demo2.do_something()

    # using twisted's reactor to call the Qt's event processor since we are
    # not using the Qt reactor.
    l = LoopingCall(QtCore.QCoreApplication.processEvents, 0, 10)
    l.start(0.01)
    reactor.run()
