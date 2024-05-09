#Eitan Brown 346816549
#Done with Yoni Rubin

#Write a program that gets a decimal number (double digits) through the keyboard and finds the sum of all the numbers received so far. 
#When the value 0 is entered, the program stops and prints the sum on the screen. 
#Note: You must verify that the number is between -99 and +99. For the purposes of this program, consider single digit numbers as the same as two digit numbers.

.data

prompt: .asciiz "Enter a number between -99 and 99: \n"
invalid: .asciiz "Invalid input: "
result: .asciiz "The sum is: "

.text
sub $s0, $s0, $s0

LoopStart1:
la $a0, prompt
#stores the address of the string prompt into $a0
addi $v0, $zero, 4
syscall
#calls the print string code and prints out the currernt string stored in $a0
#these 2 lines are cout
addi $v0, $zero, 5
syscall
#this is how to read user input
#these 2 lines are equivillant of cin for ints
beq $v0, $zero, EndLoop1
#if the unput, $v0, is equal to 0, we end the loop by jumping to EndLoop1

slti $t0 $v0 -99
slti $t1 $v0 100
xor $t0 $t0 $t1
bne $t0 $zero continue
la $a0 error
addi $v0 $zero 4
syscall
j loop

continue:
add $s0, $s0, $v0
j loop

EndLoop1:

#print out the sum

la $a0, result
#stores the address of the string result into $a0

addi $v0, $zero, 4
syscall
#calls the print string code and prints out the currernt string stored in $a0
#these 2 lines are cout
la $a0, ($s0)
#stores the address of the sum $s0 into $a0

addi $v0, $zero, 1
syscall
#calls the print string code and prints out the currernt string stored in $a0
#these 2 lines are cout
