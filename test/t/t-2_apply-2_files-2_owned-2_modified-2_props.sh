#!/bin/bash
source ./lib.bash

# Test applying file properties.

TestPhase_Setup ###############################################################
TestAddPackageFile test-package /testfile.txt 'Test file contents'
TestAddPackage test-package native explicit
TestAddConfig AddPackage test-package
TestAddConfig SetFileProperty /testfile.txt owner billy
TestAddConfig SetFileProperty /testfile.txt group wheel
TestAddConfig SetFileProperty /testfile.txt mode 600

TestPhase_Run #################################################################
AconfApply

TestPhase_Check ###############################################################
diff -u <(stat --format=%a /testfile.txt) <(echo 600)
diff -u <(stat --format=%U /testfile.txt) <(echo billy)
diff -u <(stat --format=%G /testfile.txt) <(echo wheel)

TestDone ######################################################################
