.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0

	li $t0, 0
	li $t1, 0 # i = 0
	li $t2, SIZE
	li $t3, 0 # j = 0
	li $t4, SIZE
	
	begin_for_i_it:				# for (int i = 0; i < SIZE; ++i) {
  	bge $t1, $t2, end_for_i_it
  
	begin_for_j_it:				# for (int j = 0; j <= SIZE; ++j) {
  	bgt $t3, $t4, end_for_j_it
	
	sll $t5, $t1, 5
	sll $t6, $t3, 2
	add $t7, $t5, $t6
	add $t5, $t7, $s0
	lw $t7, 0 ($t5)
	
	blt $t7, $zero, end_if # if(board[i][j] >= 0){
	
	addi $t0, $t0, 1 # count++;
	
	end_if:
	
	addi $t3, $t3, 1 # j++;
  	j begin_for_j_it
  	
  	end_for_j_it:
  	addi $t1, $t1, 1 # i++;
  	j begin_for_i_it
  	
  	end_for_i_it:
  	
  	sll $t5, $t2, 3
  	addi $t6, $t5, -10
  	
  	bge $t0, $t6, else
  	
  	move $v1, $zero
  	j end_if_2
  	
  	else:
  	
  	li $v1, 1
  	
  	end_if_2:
  	
  	restore_context
  	jr $ra
	