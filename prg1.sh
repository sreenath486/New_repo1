#!/bin/bash
# understanding trithmetic operators using the case statement
echo " enter two numbers one after another:"
read -p "num1:" num1
read -p "num2:" num2
echo "
---------------------
Arithmetic operations
---------------------
1. Addition
2. Subtraction
3. Multiplication
4. Division
5. Modulus
Choose options 1 -- 5
---------------------"
read -p " enter your option here" ch
case $ch in
1)
	echo " the addition is $((num1+num2))"
				;;
2)
	echo " the subtraction is $((num1-num2))"
				;;
3)
	echo " the multiplication is $((num1*num2))"
				;;
4)
	echo " the division is $((num1/num2))"
				;;
5)
	echo " the modulus is $((num1%num2))"
				;;
*)
	echo " you have not chosen 1--5 ... try again.."
				;;
esac
#end of case statement
#end of the script
