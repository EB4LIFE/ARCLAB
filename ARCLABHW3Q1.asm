#Eitan Brown
#346816549
#Done with Yoni Rubin
#Subject: Bubble sorting
#Eitan Brown 
#346816549 
#done with Yoni Rubin
#Bubble sort
.data
array: .word 4, -2, 9, 5, -10, 0 
size: .word 6
space: .asciiz " "
#array amd size
#space for printing
.text
#setting $a0 and $a1 resepctively to adress 0 of array and size of array
la $a0, array
lw $a1, size
#extra register to store the og address of $a0 
la $s7 array
#making the loop condition so that when increment in loop I then the 'i' will not go more than n-1 so it stays in bounds
addi $s2, $a1, -1
la $s6 array

#beging the outer loop "i"
Iloop:
#we beging by condition of loop
#make s0 the j, and if it is equal to than n-1 the parameter than print values 
beq $s0, $a1, ploop
#otherwise continue
#if i(s1) is not equal to n-1, check if need to swap
bne $s1, $s2, check
#decreasing size of array by 1, biggest element will not be the in last place of the array
addi $s2, $s2, -1
#reset to OG address to help restart the process
la $s7, array 
#increment j by 1 and continue
addi $s0, $s0, 1 
#reseting i to -1
addi $s1, $0, -1 
j Iloop

check:
#loading first element of array into t0
lw $t0, 0($s7)
#loading next element so can compare t1 to t0 for swapping
lw $t1, 4($s7) 
#if t1 < t0, basically current element is greater than one after we need to swap
#stores 1 in t3
slt $t3, $t1, $t0  
#if the next element is in fact greater (t3 = 0) no swap nec
beq $t3, $0, Swappernoswappping
#other wise swap by putting value into the opp addr 
sw $t1, 0($s7) 
sw $t0, 4($s7)  
#after swap we move over to compare more elements and increement i by one 
addi $s7, $s7, 4 
addi $s1, $s1, 1 
#as if continuing to next iteration
j Iloop 

Swappernoswappping: 
#incrementing i to check next element same process as above
addi $s1, $s1, 1 
addi $s7, $s7, 4 
j Iloop


ploop:
#if at the end of array
beq $a1, $t4, exit 
lw $a0, 0($s6) #taking next number to be printed
li $v0, 1 #function to print integer
syscall

#printing space
la $a0, space
li $v0, 4
syscall

#counter ++
#next element 
addi $t4, $t4, 1 
addi $s6, $s6, 4 
j ploop

exit:

