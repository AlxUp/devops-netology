#!/bin/bash

# display command line options


count=1

for param in "$@"; do

<<<<<<< HEAD
    echo "Next parameter: $param"
=======
    echo "\$@ Parameter #$count = $param"
>>>>>>> 199fe2e (rebase.sh)

    count=$(( $count + 1 ))

done


echo "====="
<<<<<<< HEAD

=======
>>>>>>> 199fe2e (rebase.sh)
