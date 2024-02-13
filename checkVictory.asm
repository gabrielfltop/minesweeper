.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0

	li $s1, 0 # int count = 0
	li $t0, SIZE
	li $t1, BOMB_COUNT
	li $t2, 0 # i = 0
	li $t3, 0 # j = 0
	
	begin_for_i_it:				# for (int i = 0; i < SIZE; ++i) {
  	bge $t2, $t0, end_for_i_it
  
	begin_for_j_it:				# for (int j = 0; j < SIZE; ++j) {
  	bge $t3, $t0, end_for_j_it
	
	sll $t4, $t2, 5
	sll $t5, $t3, 2
	add $t6, $t4, $t5
	add $t7, $t6, $s0
	lw $t6, 0 ($t7)
	
	blt $t6, $zero, end_if_1 # if(board[i][j] >= 0){
	
	addi $s1, $s1, 1 # count++;
	
	end_if_1:
	
	addi $t3, $t3, 1 # j++;
  	j begin_for_j_it
  	
  	end_for_j_it:
  	addi $t2, $t2, 1 # i++;
  	j begin_for_i_it
  	
  	end_for_i_it:
  	
  	mul $t4, $t0, $t0
  	sub $t7, $t4, $t1
  	
  	bge $s1, $t7, else
  	
  	li $v0, 0
  	j end_if_2
  	
  	else:
  	
  	li $v0, 1
  	
  	end_if_2:
  	
  	restore_context
  	jr $ra
	
