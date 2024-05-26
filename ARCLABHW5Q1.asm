#eitan brown
#346816549
#done with Yoni Rubin
#5.1 codeword
.data

Prompt: .asciiz "Enter a code size\n"
Prompt2: .asciiz "Enter code\n"
Found: .asciiz "Code found"
NotF: .asciiz "Code not found"
list: .byte 45, -8, 17, 63, -2, 23, 48, 0, 74, 3, 3, 2, 4, 60, -1, -6, 30, 67, 20, 5, 4, -2, 6, 9, -1, 7, 7, 9, 8, 5, 4, 2
code: .space 500

.text
#tries to get user code
la $a0, Prompt
li $v0, 4
syscall
#reads user input and puts it a2
li $v0, 5
syscall
add $a2, $v0, $0
#Put values into list  
la $a0, list
li $a1, 32
la $a3, code
 #address holder for printing the code
la $s7, code

#actual code
la $a0, Prompt2
li $v0, 4
syscall


InputC:
#if counter is greater than emppty space goto printingcode label otherwise read user int
beq $s0, $a2, PrintC
li $v0, 5
syscall
#setting the byte from users input into intial space from above
sb $v0 0($a3) 
#incrmeenmt so to input next space in code
addi $a3, $a3, 1 
#counter++
addi $s0, $s0, 1 
j InputC

PrintC:
#loading byte first address of list and printing
lb $a0, 0($s7) 
li $v0, 1
syscall
#making t0 a counter to check if printed our full code
addi $t0, $t0, 1 
#increment printer var
addi $s7, $s7, 1 
#loop condition
bne $a2, $t0, PrintC


checkCode:
#ptr to the outer loop from being used as counter 
la $t0, list 
#size essentaaly n-1
sub $s1, $a1, $a2 


outerLoop:
#resseting code back to beginging 
la $a3, code 
#finished checking for code in list branch if not found 
beq $t2, $s1, pNotFound 
add $t1, $0, $t0 #inner loop pointer will equal outer loop pointer
li $t3, -1 #counter for inner loop

innerLoop:
#checking if reached limit of code length
beq $t3, $a2, increment
#getting first element of code to compare
lb $t4, 0($a3) 
 #getting first element of list to compare
lb $t5, 0($t1)
 #code not found at this point in list, can leave
bne $t4, $t5, increment
#flag++
li $t9, 1 
 #counter for how many times set flag to 1
addi $t8, $t8, 1
#checking if each number in code was found in list, like a break
beq $t8, $a2, pFound 
#if not then 
#incrementing to next element in code
addi $a3, $a3, 1 
#ptr++
addi $t1, $t1, 1 
#iterator for inner loop++
addi, $t3, $t3, 1 
j innerLoop

increment:
#flag reset
li $t9, 0 
#flag counter reset
li $t8, 0 
#ptr++
addi $t0, $t0, 1
#loop++ for outer condition 
addi $t2, $t2, 1
j outerLoop


pNotFound:
#cout << endl
li $a0, '\n'
li $v0, 11
syscall
la $a0, NotF #printing message if code was not found
li $v0, 4
syscall
j exit

pFound:
#cout << endl
li $a0, '\n'
li $v0, 11
syscall
la $a0, Found #printing message if code was found
li $v0, 4
syscall
j exit

exit:





