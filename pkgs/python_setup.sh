#!/usr/bin/env sh

# pip
python -m ensurepip
pip install --upgrade pip

# linters
pip install mccabe
pip install mypy
pip install pep257
pip install pyflakes
pip install pylint
pip install vim-vint
pip install 3to2
pip install language-check

# autocomplete
pip install jedi
pip install rope
pip install pybashcomplete

# formatters
pip install autopep8
pip install yapf

# other
pip install virtualenv

# distribution
pip install cx_freeze
pip install distribute
pip install setuptools
pip install pyzzer

# database
pip install sqlalchemy
pip install pymongo
pip install mongoengine

# web
pip install pyramid
pip install waitress
pip install requests
pip install requests-futures
pip install suds

# binary utilities
pip install binstruct
pip install bitstruct
pip install bitarray
pip install bitstring
pip install ctypesgen

# test
pip install nose
pip install nose-parameterized
pip install coverage
pip install injector
pip install pdb

# network
pip install scapy

# debug
pip install voltron
pip install pykd
