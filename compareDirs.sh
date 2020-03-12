#!/bin/bash

diffInDir=`diff ABC/ DEF/ | wc -l`
echo $diffInDir
