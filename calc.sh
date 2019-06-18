printf "1. Addition\n2. Subtraction\n3. Division\n4. Multiplication"

printf "\nChoose a number\n"
read var

if  [ $var -eq 1 ]
then
	echo "a value: "
	read a
	echo "b value: "
	read b
	echo "Addition = $(( $a+ $b ))"
elif [ $var -eq 2 ]
then
	echo "a value: "
	read a
	echo "b value: "
	read b
	echo "Subtraction = $(( $a - $b))"
elif [ $var -eq 3 ]
then
        echo "a value: "
        read a
        echo "b value: "
        read b
	echo "Division  = "
	bc <<< "scale=2; $a/$b"
	echo "$bc"
        #echo "Division = $(( $a / $b))" | bc -l
elif [ $var -eq 4 ]
then
        echo "a value: "
        read a
        echo "b value: "
        read b
        echo "Multiplication = $(( $a * $b))"
else
	echo "Wrong Input!! Please enter a correct input"
	exit 0;
fi

