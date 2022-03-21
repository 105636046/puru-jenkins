my_array=( `kubectl get subnamespace | awk {\'print $1\'}` )
my_array_length=${#my_array[@]} 
OUTPUTFILE=/opt/out.txt
rm -rf $OUTPUTFILE
echo "Execution in progress :"
i=1
for n in "${my_array[@]}"
do
res=`echo "$(kubectl get pods -n $n)" | grep -v \'resources\' | grep -v \'NAME\' | grep -v \'READY\' | grep -v \'STATUS\' | grep -v \'RESTARTS\' | grep -v \'AGE\' | grep \'0/1\'`
printf "."
if [ "$res" != "" ]
then
echo "$i.NameSpace: $n" >> $OUTPUTFILE
echo $res >> $OUTPUTFILE
i=`expr $i + 1`
fi
done
echo ""
echo "Execution completed. output in $OUTPUTFILE file"
cat $OUTPUTFILE
