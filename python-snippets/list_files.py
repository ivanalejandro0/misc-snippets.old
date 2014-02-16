#!/usr/bin/env python
# encoding: utf-8

import fnmatch
import os
import os.path
import re


# thanks to http://stackoverflow.com/a/5141829/687989
def list_files(includes, excludes, start='.'):
    """
    Returns a list of files matching the glob expressions of the included
    parameter and excluding the files and directories matching the parameter
    excludes.

    :param includes: the files to match, using glob's format.
    :type includes: list of str
    :param excludes: the files and directories to exclude, using glob's format.
    :type excludes: list of str
    """
    # transform glob patterns to regular expressions
    includes = r'|'.join([fnmatch.translate(x) for x in includes])
    excludes = r'|'.join([fnmatch.translate(x) for x in excludes]) or r'$.'

    files_list = []

    for root, dirs, files in os.walk(start):
        # exclude dirs
        if excludes:
            dirs[:] = [d for d in dirs if not re.match(excludes, d)]

        # exclude/include files
        if excludes:
            files = [f for f in files if not re.match(excludes, f)]
        files = [f for f in files if re.match(includes, f)]
        files = [os.path.join(root, f) for f in files]

        for fname in files:
            files_list.append(fname)

    return files_list


if __name__ == '__main__':
    includes = ["*.py"]
    excludes = ['__init__.py', 'setup.py']
    sources = list_files(includes, excludes)

    print sources
