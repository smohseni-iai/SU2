
rm -f ConcDyn.dat
touch ConcDyn.dat

for (( i=0; i<=$1; i+=1000 )) 
do

  if [[ $i -lt 10 ]]; then
    p='0000'
  elif [[ $i -lt 100 ]]; then
    p='000'
  elif [[ $i -lt 1000 ]]; then
    p='00'
  elif [[ $i -lt 10000 ]]; then
    p='0'
  else
    p=''
  fi

  name='restart_flow_'$p$i'.dat'
  echo $name
  line=`sed -n 5p $name`  
  
  

  N=`echo $line | awk '{print $4}'`
  O=`echo $line | awk '{print $5}'`
  NO=`echo $line| awk '{print $6}'`
  N2=`echo $line| awk '{print $7}'`
  O2=`echo $line| awk '{print $8}'`

  Dt=`echo $i $2 | awk '{print $1*$2}'`


  Nn=`echo $N 6.022e23 14.00674 4.623e19 | awk '{print ($1*$2/$3)/$4}'`
  On=`echo $O 6.022e23 15.9994 4.623e19 | awk '{print ($1*$2/$3)/$4}'`
  NOn=`echo $NO 6.022e23 30.00614 4.623e19 | awk '{print ($1*$2/$3)/$4}'`
  N2n=`echo $N2 6.022e23 28.01348 4.623e19 | awk '{print ($1*$2/$3)/$4}'`
  O2n=`echo $O2 6.022e23 31.9988 4.623e19 | awk '{print ($1*$2/$3)/$4}'`
  
  #N2nn=`echo $N2n $Nn | awk '{print($1)/($1+$2)}'`
  #Nnn=`echo $N2n $Nn | awk '{print($2)/($1+$2)}'`

  echo $Dt $Nn $On $NOn $N2n $O2n >> ConcDyn.dat

done
