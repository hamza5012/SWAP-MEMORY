# Get current swap usage for all running processes
# Erik Ljungstrom 27/05/2011
# Modified by Mikko Rantalainen 2012-08-09
# Pipe the output to "sort -nk3" to get sorted output
# Modified by Marc Methot 2014-09-18
# removed the need for sudo
#After Modified By M.Hamza Javed
#8/4/24

echo"SCRIPT FOR CHECKING SWAP MEMORY IN LINUX"
HAMZA=0
OVERALL=0
for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"`
do
    PID=`echo $DIR | cut -d / -f 3`
    P=`ps -p $PID -o comm --no-headers`
    for SWAP in `grep VmSwap $DIR/status 2>/dev/null | awk '{ print $2 }'`
    do
        let SUM=$SUM+$SWAP
    done
    if (( $SUM > 0 )); then
        echo "PID=$PID swapped $SUM KB ($P)"
    fi
    let OVERALL=$OVERALL+$HAMZA
    HAMZA=0
done
echo "Overall swap used: $OVERALL KB"
