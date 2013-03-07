#!/usr/bin/env python
# -*- coding: utf-8 -*-

alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
alphabet_plus13 = 'NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm'
rot13_trans = str.maketrans(alphabet, alphabet_plus13)


def rot13(text):
    return text.translate(rot13_trans)

if __name__ == '__main__':
    rot13('Hello world!')
