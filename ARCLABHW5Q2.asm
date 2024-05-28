#eitan brown
#346816549
#done with Yoni Rubin
#MEMORY SHI(F)T

.data 
Mess: .asciiz "Please enter a number\n"
Error: .asciiz "Do it properly\n"

.text
#We will loop input of user so that if input is wrong then we make them try again
User:
#prompt to user input
la $a0, Mess
li $v0, 4
syscall
#read user int and put it into t9
li $v0, 5
syscall
add $t9, $v0, $0

#Per intrcustion if user enter 0 then we must exit program
beq $t9, $0, exit 

#if not zero then we must do options per instruction for 8 left most bits
li $s0, 0x31
li $s1, 0x30
li $s2, 0x48
li $s3, 0x74
#shifting right logical to check left most 8 bits to compare (24 is for 8 bits uppermost)
srl  $t0, $t9, 24

#now we need to see which case was chosen by user
beq $t0, $s0, bits31
beq $t0, $s1, bits30
beq $t0, $s2, bits48
beq $t0, $s3, bits74
#as stated above if got here then input was incorrect and we Error and go back to beginging
la $a0, Error
li $v0, 4
syscall
j User


#Now we do the cases chosen by user

#first the 0X31
bits31:
#put uppermost 8 bits value int $a0
add $a0, $0, $t9
#print that value in hex form before we make changes
li $v0, 34
syscall
#for this case we make changes to digits 0,1,6,7 and make them a 1
#0,1,6,7 = 195
#loading value into k0
li $k0, 195 
#Oring t9 and k0 and when a 1 is present in either value spot answer will be 1 for the new number 
or $t9, $t9, $k0
j newnum

#first the 0X30
bits30:
#put uppermost 8 bits value int $a0
add $a0, $0, $t9
#print that value in hex form before we make changes
li $v0, 34
syscall
#Per the case everything is a zero execept 0,1,6,7 which remain ones 
#so add values of bits to 32 not including 0167 and get result 2147483453 
li $k0, 2147483453 
and $t9, $t9, $k0
j newnum


#first the 0X48
bits48:
#put uppermost 8 bits value int $a0
add $a0, $0, $t9
#print that value in hex form before we make changes
li $v0, 34
syscall
#value 8-15 are now ones 1 using a mask so that when we xor it the og value will be inverted 
#bits 8-15 value is 65280
li, $k0, 65280 
xor $t9, $t9, $k0
j newnum

#first the 0X74
bits74:
#program should perform shift left by N places. The N is equal
#to the value of the five bits 20-24.

#put uppermost 8 bits value int $a0
add $a0, $0, $t9
#print that value in hex form before we make changes
li $v0, 34
syscall

#getting N for shift amount (20-24)
##shifting left by N places
srl $k0, $t9, 20
sllv $t9, $t9, $k0 
j newnum

newnum:
#printing space
li $a0, ' '
li $v0, 11
syscall
#printing number in hex
add $a0, $0, $t9
li $v0, 34
syscall
#printing new line
li $a0, '\n'
li $v0, 11
syscall
j User

exit:

