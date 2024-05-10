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
LoopStart1:
# Print prompt
la $a0, prompt
addi $v0, $zero 4
syscall
# Read integer from user
addi $v0, $zero 5
syscall
 # Check if input is 0
beq $v0, $zero, EndLoop1
# Check if input is between -99 and 99
slti $t0, $v0, -99 #Set $t0 to 1 if $v0 < -99, if not then zero
slti $t1, $v0, 100 # Set $t1 to 1 if $v0 < 100,  if not then zero
xor $t0, $t0, $t1 #Like a typical xor gate: XOR $t0 with $t1 to get 1 if either is 1 but not both
bne $t0, $zero, Forward
Forward: 
 # Add input to sum
add $s0, $s0, $v0
j LoopStart1

#if it was out of range
#Print error message
la $a0, invalid
li $v0, 4
syscall
j LoopStart1

EndLoop1:
# Print result
la $a0, result
addi $v0, $zero 4
syscall
# Print sum use moved instead of li because it appeared to be our issue
move $a0 $s0
#stores the address of the sum $s0 into $a0
addi $v0, $zero, 1
syscall
#calls the print string code and prints out the currernt string stored in $a0
#these 2 lines are cout
