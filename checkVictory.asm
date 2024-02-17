.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0
	
	li $t0, SIZE
	li $t1, BOMB_COUNT
	li $s3, 0 # int count = 0
	
	li $s1, 0 # i = 0
	begin_for_i_it:				# for (int i = 0; i < SIZE; ++i) {
  	bge $s1, $t0, end_for_i_it
  
	li $s2, 0 # j = 0
	begin_for_j_it:				# for (int j = 0; j < SIZE; ++j) {
  	bge $s2, $t0, end_for_j_it
	
	sll $t2, $s1, 5
	sll $t3, $s2, 2
	add $t4, $t2, $t3
	add $t5, $t4, $s0
	lw $t6, 0 ($t5)
	
	bltz $t6, end_if_1 # if(board[i][j] >= 0){
	
	addi $s3, $s3, 1 # count++;
	
	end_if_1:
	
	addi $s2, $s2, 1 # j++;
  	j begin_for_j_it
  	
  	end_for_j_it:
  	addi $s1, $s1, 1 # i++;
  	j begin_for_i_it
  	
  	end_for_i_it:
  	
  	mul $t6, $t0, $t0
  	sub $t7, $t6, $t1
  	
  	bge $s3, $t7, else
  	
  	li $v0, 0
  	j end_if_2
  	
  	else:
  	
  	li $v0, 1
  	
  	end_if_2:
  	
  	restore_context
  	jr $ra
	
