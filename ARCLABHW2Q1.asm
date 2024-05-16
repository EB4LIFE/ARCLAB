#Eitan Brown
#346816549
#Yoni Rubin
#648831051

#Topic: Finding the biggest number.
#A data list is given in the data memory. Each data is sized in bytes. The list begins at the address located in the register $a0 
#and its length is given in register $a1. Assume that the data list is signed. 
#Find the largest number and enter it into register $v0. Display the largest data on your computer screen. 
#Remarks: 
#Each program should be accompanied by a flowchart (and the algorithm of the solution if necessary). 
#Comments in the body of the program are mandatory. 
.data
#a list of 9 values all within a byte aka 8 bits
 list: .byte  -42 -14 -101 -127 -24 -30 -99
 size: .word 7
 
.text
#loading array bye list in #$a0
la $a0 list
#loading size of list into  $a1
lw $a1 size
#first element of array 'list' into s1
lb $s1, 0($a0)

while: 
# While $s0 is less than size (essentilay like an int I=0; i < n etc)
slt $t0 $s0 $a1
#meaning if it is no longer i<n exit loop 
beq $t0 $zero exit
#NOW IS THE INSIDE OF THE LOOP
#load curent value from list into $t0
lb $t0 ($a0)
# If $s1 (current max value) < current value of array ($t0)
slt $t1 $s1 $t0
#if values are the same then no need to change value so skip to the incrementation 
beq $t1 $zero skipto
#if skipto, we are not setting a new max value

# Store highest so far into $s1
add $s1 $t0 $zero
skipto:		
#Increment list pointer/$a0 to next value 
#increment iteration variable/$s0 esstialny i closer to n
addi $a0 $a0 1
addi $s0 $s0 1	

j while
#now loop is over		
exit:
# Print highest value
add $a0 $s1 $zero
addi $v0 $zero 1
syscall
# Put result in register $v0
add $v0 $s1 $zero
