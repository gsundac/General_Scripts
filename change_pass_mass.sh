# Script to change passwords en mass...almost there

##Gen a list of passwords per host...
# for i in `cat /tmp/list`; do  PRE=`echo $i| cut -c1-2`; POST=`echo $i | awk '{print substr($0, length($0)-1)}'`; SEED="YerMaMa" ; HASH="$PRE"$SEED"$POST"; echo $i " , " $HASH; done

## Gen the new passwords and go out to each host and change it...
#for i in `cat /tmp/list`;  do PRE=`echo $i| cut -c1-2`; POST=`echo $i | awk '{print substr($0, length($0)-1)}'`; HASH="$PRE"'B!l0'"$POST"; COMMAND=`echo ssh $i "'echo \"$HASH $HASH\" | passwd'"`; $COMMAND ; done
for i in `cat /tmp/list`;  do PRE=`echo $i| cut -c1-2`; POST=`echo $i | awk '{print substr($0, length($0)-1)}'`; SEED="YerMama" ; HASH="$PRE"$SEED"$POST"; COMMAND=`echo ssh $i "'echo \"$HASH $HASH\" | passwd'"`; echo $COMMAND ; done
