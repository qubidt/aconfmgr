#!/bin/bash
source ./lib.bash

# Test 'aconfmgr diff' with stray files.

TestPhase_Setup ###############################################################
TestAddFile /testfile.txt $'foo\n'
# shellcheck disable=SC2016
TestAddConfig 'echo bar > $(CreateFile /testfile.txt)'

TestPhase_Run #################################################################
aconfmgr_action_args=(/testfile.txt)
AconfDiff 2>&1 | tee "$tmp_dir"/diff-results.txt

TestPhase_Check ###############################################################
grep -Fx -- '-foo' "$tmp_dir"/diff-results.txt
grep -Fx -- '+bar' "$tmp_dir"/diff-results.txt

TestDone ######################################################################
