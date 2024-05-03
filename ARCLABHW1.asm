.data 
Array1: .word 1, 7, 4, 6, 5, 0, 8, 3 #first array filled with blocks of words
Array2: .space 240 #empty array of adresses without values 

.text
la $a0 Array 1
la $a1 Array 2

