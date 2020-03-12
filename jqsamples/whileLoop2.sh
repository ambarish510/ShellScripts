#!/bin/bash
allureDir="/Users/ambarish.a/Documents/codebase/flowPocUnitTesting/allure-junit-example/target/allure-report"
countTestSuite=$(jq '.total' $allureDir/widgets/suites.json)
ctr=0
touch testsuites.json
while [ $ctr -lt $countTestSuite ]; do
  jq --argjson ctr $ctr '{stats:{name:{text:"Name",type:"string",value:.items[$ctr].name},failed:{text:"Failed",type:"integer","value":.items[$ctr].statistic.failed},broken:{text:"Broken",type:"integer",value:.items[$ctr].statistic.broken},skipped:{text:"Skipped",type:"integer",value:.items[$ctr].statistic.skipped},passed:{text:"Passed",type:"integer",value:.items[$ctr].statistic.passed},unknown:{text:"Unknown",type:"integer",value:.items[$ctr].statistic.unknown},total:{"text":"Total","type":"integer","value":.items[$ctr].statistic.total},pass_percentage:{"text":"Pass Percentage","type":"float","value":(.items[$ctr].statistic.passed*100/.items[$ctr].statistic.total)}},time: {duration: {text: "Duration",type: "integer",value: .time.sumDuration}}}' $allureDir/widgets/suites.json >> testsuites.json
  ctr=`expr $ctr + 1`
done
testSuite_result=$(jq -s . testsuites.json)
testSuite_result=$(echo $testSuite_result | tr -d ' ')
rm -f testsuites.json
jq --argjson suites $testSuite_result '{stats:{name:{text:"Name",type:"string" , value:.reportName},failed:{text:"Failed",type:"integer","value":.statistic.failed},broken:{text:"Broken",type:"integer",value:.statistic.broken},skipped:{text:"Skipped",type:"integer",value:.statistic.skipped},passed:{text:"Passed",type:"integer",value:.statistic.passed},unknown:{text:"Unknown",type:"integer",value:.statistic.unknown},total:{"text":"Total","type":"integer","value":.statistic.total},pass_percentage:{"text":"Pass Percentage","type":"float","value":(.statistic.passed*100/.statistic.total)}},time: {duration: {text: "Duration",type: "integer",value: .time.sumDuration}},"suites": $suites}' $allureDir/widgets/summary.json