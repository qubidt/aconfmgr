#!/bin/bash
source ./lib.bash

# Test basic 'aconfmgr diff' functionality.

TestPhase_Run #################################################################
aconfmgr_action_args=(/)
AconfDiff

TestPhase_Check ###############################################################

TestDone ######################################################################
