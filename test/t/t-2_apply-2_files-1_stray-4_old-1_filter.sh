#!/bin/bash
source ./lib.bash

# Test that a file whose filtered contents hasn't changed isn't overwritten.

TestPhase_Setup ###############################################################

TestAddFile /file.txt $'This is an important line\nThis line is garbage\n'

TestAddConfig 'function MyFilter() { grep -v garbage ; }'
TestAddConfig AddFileContentFilter '/file.txt' MyFilter
# shellcheck disable=SC2016
TestAddConfig 'echo This is an important line > $(CreateFile file.txt)'

TestPhase_Run #################################################################
AconfApply

TestPhase_Check ###############################################################
diff -u "$test_fs_root"/file.txt /dev/stdin <<< $'This is an important line\nThis line is garbage'

TestDone ######################################################################
