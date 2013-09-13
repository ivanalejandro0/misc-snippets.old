#!/usr/bin/env python
# -*- coding: utf-8 -*-
import string

alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
alphabet_plus13 = 'NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm'
rot13_trans = string.maketrans(alphabet, alphabet_plus13)


def rot13(text):
    return text.translate(rot13_trans)

if __name__ == '__main__':
    msg = 'Hello world!'
    msg_rot13 = rot13(msg)
    msg2 = rot13(msg_rot13)

    print "Original message: {0}".format(msg)
    print "Original message through rot13: {0}".format(msg_rot13)
    print "Original message through rot13 twice: {0}".format(msg2)
