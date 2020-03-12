
#REF :
# https://stedolan.github.io/jq/tutorial/
# https://stedolan.github.io/jq/manual/
# https://shapeshed.com/jq-json/
# https://programminghistorian.org/en/lessons/json-and-jq
# https://github.com/stedolan/jq/wiki/FAQ


#list the whole jq
 cat arrays1.json | jq .
jq . -f arrays1.json
#get one element from json arrays
cat arrays1.json | jq '.[0]'

#get one key from all elements of json arrays
cat arrays1.json | jq '.[]|.id'

#filter in jq
# ref https://programminghistorian.org/en/lessons/json-and-jq#create-new-json--and-
.artObjects[] | select(.productionPlaces | length >= 1) | .id -f arrays1.json
.artObjects[] | select(.principalOrFirstMaker | test("van")) | {id: .id, artist: .principalOrFirstMaker} -f arrays1.json


#Select operation sample2
TestSuiteResults=( passbucket1:failbucket1 passbucket2:failbucket2 passbucket3:failbucket3 )
jq -Rn '
  def instructionsForPair($source): {
    "--src=\($source)"
  };
 [ inputs | capture("^(?<pass>[^:]+):(?<fail>.*)$"; "") | select(.) | instructionsForPair(.pass) ]' < <(printf '%s\n' "${TestSuiteResults[@]}")



#create json using jq template
echo "testName" $testName
#testName UnitTest
echo "testDuration" $testDuration
#testDuration 6
echo "testSuite_result" $testSuite_result
#testSuite_result [ { "name": "com.myexamples.maven.AppTest", "statistic": { "failed": 0, "broken": 0, "skipped": 0, "passed": 1, "unknown": 0, "total": 1 } } ]
echo "testStatistic" $testStatistic
#testStatistic {"failed":0,"broken":0,"skipped":0,"passed":1,"unknown":0,"total":1}
jq -n --arg testName $testName --argjson testStatistic $testStatistic --argjson testSuiteResult "$testSuite_result" --arg testDuration $testDuration '{name: $testName, statistic: $testStatistic, time: {duration: $testDuration, startTime: null }, testsuites: $testSuiteResult}'

# usage of --arg and --argjson
#--arg name value:
#This option passes a value to the jq program as a predefined variable. If you run jq with --arg foo bar, then $foo is available in the program and has the value "bar". Note that value will be treated as a string, so --arg foo 123 will bind $foo to "123".
#
#--argjson name JSON-text:
#This option passes a JSON-encoded value to the jq program as a predefined variable. If you run jq with --argjson foo 123, then $foo is available in the program and has the value 123.

jq '{stats:{name:{text:"Name",type:"string" , name:.items|.[`$ctr`].name},failed:{text:"Failed",type:"integer","value":.items|.[`$ctr`].statistic.failed},broken:{text:"Broken",type:"integer",value:.items|.[`$ctr`].statistic.broken},skipped:{text:"Skipped",type:"integer",value:.items|.[`$ctr`].statistic.skipped},passed:{text:"Passed",type:"integer",value:.items|.[`$ctr`].statistic.passed},unknown:{text:"Unknown",type:"integer",value:.items|.[`$ctr`].statistic.unknown},total:{"text":"Total","type":"integer","value":.items|.[`$ctr`].statistic.total}},time: {duration: {text: "Duration",type: "integer",value: 0}}}' $allureDir/widgets/suites.json

#how to create json array from steams
$ (echo 1; echo 2) | jq -nc '[inputs]'
$ (echo 1; echo 2) | jq -nc 'reduce inputs as $row ([]; . + [$row])'

echo {"failed":0,"broken":0,"skipped":0,"passed":4,"unknown":0,"total":4}{"failed":0,"broken":0,"skipped":0,"passed":4,"unknown":0,"total":4} > some.json
jq -s . some.json