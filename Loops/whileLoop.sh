#!/bin/bash
a=0
while [ $a -lt 10 ]
do
   bucketName="fk-artifactory-"$a
   echo $bucketName
   #sh ./SetaclOnObjectsInBucket.sh $bucketName
   a=`expr $a + 1`
done