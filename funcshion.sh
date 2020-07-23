#!/bin/bash

funcshion() {
FILES=""
while test $# -gt 0;
    do
    case "$1"
        in
        -f)
            shift
            FUNCTION="$1"
            shift
		    ;;
        *)
            FILES="$FILES $1"
            shift
            ;;
    esac
done

while FILE in $FILES; do
    runAwk $FILE
done

}

# funcshion src/directory/test.sh
runAwk() {
if [ -z "$FUNCTION" ]; then
    awk -f funcshion.awk $1
else
    awk -f function.awk -v specificFunction=$FUNCTION $1
fi
}
