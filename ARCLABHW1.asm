Eitan Brown
346816549
Done with Yoni Rubin

#Write a program that copies a block of words that starts at an address located in $a0 to a block of words that begin with an address found in $a1. 
#The program will count the number of words copied and save the result in the register $v0. 
#The last word to be copied but not counted has value 0


.data 
Array1: .word 1, 7, 4, 6, 5, 0, 8, 3 #first array filled with blocks of words
Array2: .space 240 #empty array of adresses without values 

.text
la $a0 Array 1
la $a1 Array 2

Loopstart:
lw $t0 ($a0)
sw $t0 ($a1)

beq $t0 $zero exit

addi $s0 $s0 1

addi $a0 $a0 4
addi $a1 $a1 4

j loop

exit
