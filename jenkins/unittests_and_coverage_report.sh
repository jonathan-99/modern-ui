#!/bin/bash

echo "Run unittests"
python3 -m unittest discover -s testing -p 'test_*.tsx'

echo "coverage report"
python3 -m venv myenv

source myenv/bin/activate

pip install coverage
coverage run -m unittest discover -s testing -p 'test_*.tsx'
coverage report -m