#!/usr/bin/env python
# -*- coding: utf-8 -*-


class Person(object):
    def __init__(self):
        self.name = ''
        self.email = ''
        self.details = ''

    def _attributes(self):
        return {'name': self.name,
                'email': self.email,
                'details': self.details}

    def __str__(self):
        # preferred string formatting, look at: PEP-3101
        data = u'Name: {name}; e-mail: {email}; Details: {details}'
        return data.format(**self._attributes())


if __name__ == '__main__':
    p = Person()
    p.nombre = 'John Doe'
    p.email = 'john.doe@test.com'
    p.details = 'some details about John'

    print p
