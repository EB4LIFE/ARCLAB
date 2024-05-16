#Eitan Brown 
#346816549
#Done with Yoni Rubin

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
#'*' asciiz 42
li $t0, 42 
beq $s2, $t0, multiply

 #'-' asciiz 45
li $t0, 45
beq $s2, $t0, subtract

 #'+' asciiz 43
li $t0, 43
beq $s2, $t0, sum

#Op Code not recognised
la $a0, error2
addi $v0, $zero, 4
syscall

j print2

multiply:
mult $s0, $s1
#If $s0 or $s1 are 0, result is 0
beq $s0, $zero, multiplyByZero
beq $s1, $zero, multiplyByZero

#Else
#Is $s0 negative
slt $t0, $s0, $zero

# Is $s1 negative
slt $t1, $s1, $zero

#Both of the same sign
beq $t0, $t1, sameSign
j differentSign

#Self explanatory: if any of two operands are 0 then result will be 0
multiplyByZero:
add $s0, $zero, $zero
j print2


sameSign:
#Chechicking: If HI is negative = overflow

#set $t0 to become the high register
mfhi $t0

#t0 < 0 aka (-1) 
slt $t0, $t0, $zero

#If t0 is negative, go to overflow tag label
bne $t0, $zero, overflow

#Else if LO is negative, overflow
#same logic for hi
mflo $s0
slt $t0, $s0, $zero
bne $t0, $zero, overflow
j print2

differentSign:
# If HI is not -1 = overflow

#set $t0 to become the high register
mfhi $t0

#t1 set to -1
addi $t1, $zero, -1

#if t1 is neg but hi-reg is postive it is overflow (go to label)
bne $t0, $t1, overflow

# Else 
#if LO is positive = overflow

#set s0 to lo
mflo $s0

#s0 < 0 aka (-1)
slt $t0, $s0, $zero

#if t0 is not zero meaning postive so it is negative then skip to print2 (meaning goto enter opcode)
bne $t0, $zero, print2

#otherwise if it is postive and hi as we know is negative then it is overflow
j overflow

#subtraction done as followed flips sign of right side  so instead of A - B, its A + -B 
subtract:
subu $s1, $zero, $s1
#Then continue to sum so less overflow chances


sum:
#s0 < zero (negative)
slt $t0, $s0, $zero

#s1 < zero (negative)
slt $t1, $s1, $zero

#meaning they are the same sign so add them 
addu $s0, $s0, $s1

# If two operands are different signs, no overflow possible so goto print2 (meaning goto enter opcode)
bne $t0, $t1, print2 


#Else check for overflow: If signs of operands does not equal the sign of the result, then goto overflow
#s0 < 0
slt $t0, $s0, $zero

#if they are no equal then goto overflow
bne $t0, $t1, overflow

#otherwise print2 (meaning goto enter opcode)
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

# If op code isn't '@' read in another value aka print1 label above
# '@' asciiz 64
li $t0, 64 
bne $s2, $t0, print1

# Print result
add $a0, $zero, $s0
addi $v0, $zero, 1
syscall

#result prints no overflow, so exit program without issue
j exit

overflow:
la $a0, error1
addi $v0, $zero, 4
syscall

exit:

