#eitan brown
#346816549
#done with Yoni Rubin


.data

usernum: .asciiz "Enter a number"
userop: .asciiz "Choose Multiplication, addition, or power operator"

.text
#starts off to similiar form of how we did the calculator last time
#printing prompt for number
la $a0, usernum
li $v0, 4
syscall
#space enter for reaadbility like cout << endl;
li $a0, '\n'
li $v0, 11
syscall


#Reading ther user int input and putting as instructed into $s0
li $v0, 5
syscall
add $s0, $0, $v0

#Now we ask user for what math operator they wish to use
la $a0, userop
li $v0, 4
syscall
#cout<<endl
li $a0, '\n'
li $v0, 11
syscall


#reading in user operator  and putting it in s7 to be used later  for branching
li $v0, 12
syscall
add $s7, $0, $v0
#cout<<endl
li $a0, '\n'
li $v0, 11
syscall


#Now we ask for the second number for the calculator
la $a0, usernum 
li $v0, 4
syscall
#cout<<endl
li $a0, '\n'
li $v0, 11
syscall


#reading in the second user number and addding it to s1
li $v0, 5
syscall
add $s1, $0, $v0

#what we will do now is set operators into temp and branch to particular operators
li $t0, '+'
li $t1, '*'
li $t2, '^'

#$s7 is user op so if user op equals one of these we will goto function 
beq $s7, $t0, Add
beq $s7, $t1  Mul
beq $s7, $t2  UNLIMITEDPOWER	



Add: 
#s0 and s1 are both reg with user ints so as specified we put them in a0 and a1
add $a0, $s0, $0   
add $a1, $s1, $0
#they way jal works jump and link we will jump to addfunction add it then come right back and continue with print result
jal addFunction
j print

Mul:
#s0 and s1 are both reg with user ints so as specified we put them in a0 and a1
add $a0, $s0, $0   
add $a1, $s1, $0
#they way jal works jump and link we will jump to mulfunction add it then come right back and continue with print result
jal mulFunction
j print

UNLIMITEDPOWER:
#s0 and s1 are both reg with user ints so as specified we put them in a0 and a1
add $a0, $s0, $0   
add $a1, $s1, $0
#they way jal works jump and link we will jump to powfunction add it then come right back and continue with print result
jal powFunction
j print

#JAL FUNCTIONS #$RA JUMPS FOR +/*/^
addFunction:
#where we add the ints and put it into v0 then as said jump back to where this was called 
add $v0, $a0, $a1
jr $ra

mulFunction:
#must use stack regisers
#We need to free memory for a0, a1, ra, t1 & t8 for comparison 
addi $sp, $sp,-20   
#storing original values of registers in memory
sw $ra, 0($sp)  
sw $t1, 4($sp)
sw $t8, 8($sp)
sw $a0, 12($sp)
sw $a1, 16($sp)

#since we are doing mul we need to check signs of the numbers
#first we check if a0 < 0 using slt t1
slt $t1, $a0, $0
#if result is postive (meaning t1 = 0 because a0 not neg) branch
beq $t1, $0, positive
#if we do this line then it was negative so we gotta swap signs
#now both will have same sign so counter 
#Logic for counter is that since we can't use mult we do it manually with addition
sub $a0, $0, $a0 
sub $a1, $0, $a1

#if t1=0 branched from beq
positive: 
#if t1=0 
#storing a0 into t8 to be used as counter since will change a0 later on and counter as described for manual mult
add $t8, $0, $a0 
#done so we will add it coreect amount of times
li $a0, 0 
#another counter
li $t1, 0 

Mulcounter:
#if reached limit of counter go to end of function essentially treating this like a a for loop with i (t1) and size (a0 / t8)
beq $t8, $t1, leaveMul 
#if in loop
#same logic as before do add then come back here and continue
jal addFunction
#keeping track of sum so when we do add again it will get proper values
add $a0, $0, $v0 
#add 1 to counter
addi $t1, $t1, 1 
j Mulcounter


leaveMul:
#storing Final results into v0
add $v0, $0, $a0 
#putting og values back
lw $ra, 0($sp)  
lw $t1, 4($sp)
lw $t8, 8($sp)
lw $a0, 12($sp)
lw $a1, 16($sp)
#moving pointer back to top of stack
addi $sp, $sp,20
jr $ra

powFunction:
#must use stack regisers
#We need to free memory for a0, a1, ra, t4 & t7 for comparison 
addi $sp, $sp,-20   
#storing original values of registers in memory
sw $ra, 0($sp)  
sw $t4, 4($sp)
sw $t7, 8($sp)
sw $a0, 12($sp)
sw $a1, 16($sp)

#Now as similit to mul we check to see if exponenent was negative 
slt $t4, $a1, $0 
#if t4 = 1 exponent was neg and t4 =0 then exponent was positve
bne $t4, $0, leavePow 

#lgoci same as before t7 = 'size' and t4 = 'i' and setting a1 to 1 so we proper do the values just like in mul via add
add $t7, $a1, $0 
li $a1, 1 
li $t4, 0 
Powcounter:
beq $t7, $t4, leavePow
jal mulFunction
#keeping track of product, so when call mulfunc - we will be doing the proper values
add $a1, $0, $v0 
#counter + 1
addi $t4, $t4, 1 
j Powcounter


leavePow:
#storing Final results into v0
add $v0, $0, $a1
#putting og values back
lw $ra, 0($sp)  
lw $t4, 4($sp)
lw $t7, 8($sp)
lw $a0, 12($sp)
lw $a1, 16($sp)
#moving pointer back to top of stack
addi $sp, $sp,20
jr $ra

print:
add $a0, $0, $v0 
li $v0, 1
syscall 






