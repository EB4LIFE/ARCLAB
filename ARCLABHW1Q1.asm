#Eitan Brown
#346816549
#Yoni Rubin
#648831051

#Write a program that copies a block of words that starts at an address located in $a0 to a block of words that begin with an address found in $a1. 
#The program will count the number of words copied and save the result in the register $v0. 
#The last word to be copied but not counted has value 0

.data 
Array1: .word 1, 7, 4, 6, 5, 0, 8, 3 #first array filled with blocks of words
Array2: .space 240 #empty array of adresses without values


.text
la $a0 Array1
la $a1 Array2

loopstart:
lw $t0 0($a0) 
#copied address into $t0 

sw $t0 0($a1) 
#saving it "pasting" into $a1

beq $t0 $zero exit 
#line 22 if copied value is zero , it will be the last one copied but not counted so we exit here.

addi $v0 $v0 1 
#Line 24 counts the number of words copied over (increments one at a time)

addi $a0 $a0 4
addi $a1 $a1 4
#itterates the address to move onto the next word 
#for the array we're copying from and copying too

j loopstart
#jumps to the label loopstart 7 commands up

exit:
