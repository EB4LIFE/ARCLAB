#Eitan Brown 346816549
#Done with Yoni Rubin

#Write a program that gets a decimal number (double digits) through the keyboard and finds the sum of all the numbers received so far. 
#When the value 0 is entered, the program stops and prints the sum on the screen. 
#Note: You must verify that the number is between -99 and +99. For the purposes of this program, consider single digit numbers as the same as two digit numbers.

#If input is 0, exit loop
beq $v0 $zero exit

#Check if input is between -99 and 99
slti $to $v0 -99
slti $t1 $v0 100

xor $to $to $t1

#If within range, continue
bne $to $zero continue
#If out of range, print error and input number again
la $a0 errог

addi $vo Szero 4
syscall

j loop

continue:

#Add input to sum

add $50 $50 $v0

j loop

exit:

#Print sum of all inputs

la $a0 result

addi $vo $zero 4

syscall

move $a0 $50

addi $v0 $zero 1

syscall

