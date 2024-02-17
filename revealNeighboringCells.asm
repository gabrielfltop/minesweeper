.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	addi $s3, $s1, -1 # row - 1
	addi $s4, $s1, 1 # row + 1
	begin_for_i_it:				# for (int i = row - 1; i <= row + 1; ++i) {
  	bgt $s3, $s4, end_for_i_it
  
  	addi $s5, $s2, -1 # column - 1
  	addi $s6, $s2, 1 # column + 1
	begin_for_j_it:				# for (int j = column - 1; j <= column + 1; ++j) {
  	bgt $s5, $s6, end_for_j_it
  	
  	li $t0, SIZE
  	bltz $s3, end_if
  	bge $s3, $t0, end_if
  	bltz $s5 end_if
  	bge $s5, $t0, end_if
  	
  	sll $t1, $s3, 5
	sll $t2, $s5, 2
	add $t3, $t1, $t2
	add $s7, $t3, $s0
	lw $t4, 0 ($s7)
	li $t5, -2
	
	bne $t4, $t5, end_if
	
	move $a0, $s0
	move $a1, $s3
	move $a2, $s5
	jal countAdjacentBombs
	
	sw $v1, 0 ($s7)
	
	bnez $v1, end_if
	
	move $a0, $s0
	move $a1, $s3
	move $a2, $s5
	jal revealNeighboringCells
							
  	end_if:
  	
  	addi $s5, $s5, 1 # j++;
  	j begin_for_j_it
  	
  	end_for_j_it:
  	addi $s3, $s3, 1 #i++;
  	j begin_for_i_it
  	
  	end_for_i_it:
  	
  	restore_context
  	jr $ra
  	
