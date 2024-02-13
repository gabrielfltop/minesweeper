.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0
	move $t1, $a1
	move $t2, $a2
	
	
	
	addi $s1, $t1, -1 # row - 1
	addi $s2, $t1, 1 # row + 1
	addi $s3, $t2, -1 # column - 1
	addi $s4, $t2, 1 # column + 1
	
	li $t0, SIZE
	
	begin_for_i_it:				# for (int i = row - 1; i <= row + 1; ++i) {
  	bgt $s1, $s2, end_for_i_it
  
	begin_for_j_it:				# for (int j = column - 1; j <= column + 1; ++j) {
  	bgt $s3, $s4, end_for_j_it
  	
  	blt $s1, $zero, end_if
  	bge $s1, $t0, end_if
  	blt $s3, $zero, end_if
  	bge $s3, $t0, end_if
  	
  	sll $t3, $s1, 5
	sll $t4, $s3, 2
	add $t5, $t3, $t4
	add $s5, $t5, $s0
	lw $t5, 0 ($s5)
	li $t6, -2
	
	bne $t5, $t6, end_if
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s3
	jal countAdjacentBombs
	
	sw $v1, 0 ($s5)
	
	bnez $s6, end_if
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s3
	jal revealNeighboringCells
							
  	end_if:
  	
  	addi $s3, $s3, 1 # j++;
  	j begin_for_j_it
  	
  	end_for_j_it:
  	addi $s1, $s1, 1 #i++;
  	j begin_for_i_it
  	
  	end_for_i_it:
  	
  	restore_context
  	jr $ra
  	
