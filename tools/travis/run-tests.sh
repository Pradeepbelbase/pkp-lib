#!/bin/bash

# @file tools/travis/run-tests.sh
#
# Copyright (c) 2014-2018 Simon Fraser University
# Copyright (c) 2010-2018 John Willinsky
# Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
#
# Script to run data build, unit, and integration tests.
#

set -xe

# Run data build suite
if [[ "$TEST" == "mysql" ]]; then
	./lib/pkp/tools/runAllTests.sh -bHd
else
	./lib/pkp/tools/runAllTests.sh -bd
fi

./lib/pkp/tools/travis/dump-database.sh

# Run test suite.
sudo rm -f cache/*.php
if [[ "$DBTYPE" == "MySQL" ]]; then
	./lib/pkp/tools/runAllTests.sh -CcPpfHd
else
	./lib/pkp/tools/runAllTests.sh -CcPpfd
fi
