#!/bin/bash
STATES=(172.20.3.17:15013 172.20.3.25:15061 172.20.3.16:15033 172.20.3.16:15001)
tam=${#STATES[@]}
DIV=$(($tam))
R=$(($RANDOM%$DIV))
echo "${STATES[R]}"
adb connect ${STATES[R]}
