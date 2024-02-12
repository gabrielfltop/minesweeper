.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	
	
	addi $s1, $s1, -1 # row - 1
	addi $s2, $s1, 2 # row + 1
	addi $s3, $s2, -1 # column - 1
	addi $s4, $s2, 1 # column + 1
	
	li $s5, SIZE
	
	begin_for_i_it:				# for (int i = row - 1; i <= row + 1; ++i) {
  	bgt $s1, $s2, end_for_i_it
  
	begin_for_j_it:				# for (int j = column - 1; j <= column + 1; ++j) {
  	bgt $s3, $s4, end_for_j_it
  	
  	blt $s1, $zero, end_if
  	bge $s1, $s5, end_if
  	blt $s3, $zero, end_if
  	bge $s3, $s5, end_if
  	
  	sll $t0, $s1, 5
	sll $t1, $s3, 2
	add $t2, $t0, $t1
	add $s6, $t2, $s0
	lw $t2, 0 ($s6)
	li $t0, -2
	
	bne $t2, $t0, end_if
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s3
	jal countAdjacentBombs
	  
	move $s7, $v1
	
	sw $s7, 0 ($s6)
	
	bne $s7, $zero, end_if
	
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
  	