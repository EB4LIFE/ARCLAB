#Eitan Brown
#346816549
#Done with Yoni Rubin

#Eitan Brown 
#346816549 
#done with Yoni Rubin
#Arthmetic sequence / Geometric sequence

.data
#Arthmetic: 3, 9, 15, 21, 27 -- comon dif
#Geometric: 2, 4, 8, 16, 32 -- comon ratio
#Neither: 5, 4, 3, 2, 7
list: .byte 5, 4, 3, 2, 7
size: .word 5
#message for final print
Arit: .asciiz "d = "
Geo: .asciiz "q = "
Non: .asciiz "Not a progression"

.text
la $a0, list
lw $a1, size

Arithmetic:
#Arithmetic sequence is known by common differnce between 2 elements of seuqence
#to prove we must compare the first two value to check their differnce 

#Loading first value of a0 into t1 then 2nd value into t2
#we need to use 2 elements at a time to find the difference
lb $t1, 0($a0)
lb $t2, 1($a0)
#subtracting t2 and t1 to get the difference of the two elements into t0
sub $t0, $t2, $t1 
#s1 is our counter and at this point we counted the first two element of a0 so s1 = 2
li $s1, 2 

ArithmeticLoop:
#if our counter s1 aka 'i' has reached end of list aka no longer i < size
beq $a1, $s1, endAr
#incrementing to next value in the list
addi $a0, $a0, 1 
#next comparison
lb $t1, 0($a0)
lb $t2, 1($a0)
#subtracting t2 and t1 to get the difference of the two elements into t3
sub $t3, $t2, $t1 

#now need to compare t0 and t3 to see if their differnce is the same
bne $t0, $t3, notAr
#add another to the counter aka i++
addi $s1, $s1, 1 
j ArithmeticLoop


notAr:
#this line is for the counter for if the sequence is neither Arithmetic nor geo 
#which is why we now jump to geo loop
addi $s3, $s3, 1 
j Geometric

endAr:
#printing d = 
la $a0, Arit
li $v0, 4
syscall
#printing d value
add $a0, $0, $t0
li $v0, 1
syscall
#printing new line
li $a0, '\n'
li $v0, 11
syscall

Geometric:
#all about finding the common ration between two elements
#if it remains the same throughout the seuqence it is geometric
#Note: The ratio should be a clean number (no remainder, decimal) 
#must compare two at a time
lb $t1, 0($a0)
lb $t2, 1($a0)
#this line will find the ratio
div $t2, $t1
#similiar to multiplication will have a hi register and a lo register
#lo reigster is reuslt 
#hi reg is the remainder if it exists
mflo $t3 
mfhi $t4 
#if the remainder was not simple as stated above we know its not a geo
bne $t4 $zero notGeo
#As before a counter of +=2 for elements of the list 
li $s2, 2 

geoLoop:
#if our counter s2 aka 'i' has reached end of list aka no longer i < size
beq $a1, $s2, endGeo 
addi $a0, $a0, 1
lb $t1, 0($a0) 
lb $t2, 1($a0)

div $t2, $t1
#reuslt aka ratio must be same as t3 from before to work
mflo $t5 
#remainder aka 0, must be same as t4
mfhi $t6 
#if reminader is not zero for both
bne $t6, $t4, notGeo 
#ratio is not the same 
bne $t5, $t3, notGeo
#increment the 'i' aka s2 by and go back to beg of loop until beq cond is satitsfied
addi $s1, $s1, 1 
j geoLoop

notGeo:
#addiing 1 to current value s3 for neither counter
addi $s3, $s3, 1

j neither

endGeo:
#printing q = 
la $a0, Geo
li $v0, 4
syscall
#printing q value
add $a0, $0, $t3
li $v0, 1
syscall
#printing new line
li $a0, '\n'
li $v0, 11
syscall

neither:
li $t7, 2
bne $s3, $t7, exit

la $a0, Non
li $v0, 4
syscall

exit:
