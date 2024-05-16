#Eitan Brown 
#346816549
#Done with Yoni Rubin
#Write a program for the implementation of a simple calculator according to the following rules: 
#A) The computer will display the following message: ENTER VALUE. In response the user enters a decimal value. The data will be input as an INTEGER. 
#B) The computer displays a message on the screen: ENTER OP-CODE .
#The input will be in the CHAR format and is one of 4 options: *, - , + , @ (multiply, subtract, addition, end the program, respectively).
#C) If the user ends the program, the result of the calculation should be displayed with the accompanying message : The result is 
#D) If a non-termination action code is requested, then: The computer will display the following message: ENTER VALUE In response, 
#the user will enter a decimal value. The data will be input as INTEGER. 
#Assume that the maximum addition and subtraction operations are 32 bit. 
.data
p1: .asciiz "ENTER VALUE\n"
p2: .asciiz "ENTER OP-CODE\n"
error1: .asciiz "Overflow detected\n"
error2: .asciiz "Op-Code not recognised"

.text
# Set op code to '+' (ASCII value of '+')
li $s2, 43

# Print "ENTER VALUE"
print1:
la $a0, p1
addi $v0, $zero, 4
syscall

# Read in an integer into $s1
readInt:
addi $v0, $zero, 5
syscall
add $s1, $zero, $v0

# Check which op code was input
if:
# '*' asciiz 42
li $t0, 42 
beq $s2, $t0, multiply
 # '-' asciiz 45
li $t0, 45
beq $s2, $t0, subtract
 # '+' asciiz 43
li $t0, 43
beq $s2, $t0, sum

# Op Code not recognised
la $a0, error2
addi $v0, $zero, 4
syscall

j print2

multiply:
mult $s0, $s1
# If $s0 or $s1 are 0, result is 0
beq $s0, $zero, multiplyByZero
beq $s1, $zero, multiplyByZero
# Else
# Is $s0 negative
slt $t0, $s0, $zero
# Is $s1 negative
slt $t1, $s1, $zero
beq $t0, $t1, sameSign
j differentSign

multiplyByZero:
add $s0, $zero, $zero
j print2

sameSign:
# If HI is negative, overflow
mfhi $t0
slt $t0, $t0, $zero
bne $t0, $zero, overflow
# Else if LO is negative, overflow
mflo $s0
slt $t0, $s0, $zero
bne $t0, $zero, overflow
j print2

differentSign:
# If HI is not -1, overflow
mfhi $t0
addi $t1, $zero, -1
bne $t0, $t1, overflow
# Else if LO is positive, overflow
mflo $s0
slt $t0, $s0, $zero
bne $t0, $zero, print2
j overflow

subtract:
# Flip sign of right side operand
subu $s1, $zero, $s1
# Then continue to sum

sum:
slt $t0, $s0, $zero
slt $t1, $s1, $zero
addu $s0, $s0, $s1
# If two operands are different signs, no overflow possible
bne $t0, $t1, print2
# Else check for overflow: If signs of operands != sign of result, overflow
slt $t0, $s0, $zero
bne $t0, $t1, overflow
j print2

# Print "ENTER OP-CODE"
print2:
la $a0, p2
addi $v0, $zero, 4
syscall

# Read op code into $s2
readOp:
addi $v0, $zero, 12
syscall
add $s2, $zero, $v0

# Print new line
li $a0, '\n'
addi $v0, $zero, 11
syscall

# If op code isn't '@' read in another number
li $t0, 64 # '@' asciiz 64
bne $s2, $t0, print1

# Print result
add $a0, $zero, $s0
addi $v0, $zero, 1
syscall

j exit

overflow:
la $a0, error1
addi $v0, $zero, 4
syscall

exit:

