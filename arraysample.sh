

#create array
TestSuiteResults=( {"passbucket1":"failbucket1"} {"passbucket2"::"failbucket2"} {'passbucket3':'failbucket3'})
echo ${TestSuiteResults[*]}

#to display in separate lines
printf '%s\n' "${TestSuiteResults[@]}"

#to pass array elements as inputs to another command
cut -d':' -f2 < <(printf '%s\n' "${TestSuiteResults[@]}")