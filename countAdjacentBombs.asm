.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $t1, $s1
	move $t2, $s2
	addi $s1, $t1, -1 #row - 1
	addi $s2, $t1, 1 #row + 1
	addi $s3, $t2, -1 #column - 1
	addi $s4, $t2, 1 #column + 1
	li $s5 , 0 #count = 0
	
  begin_for_i_it:				# for (int i = row - 1; i <= row + 1; ++i) {
  bgt $s1,$s2,end_for_i_it
  
  begin_for_j_it:				# for (int j = column - 1; j <= column + 1; ++j) {
  bgt $s3,$s4,end_for_j_it
  
  li $t0, SIZE
  blt $s1, $zero, else_invalid                  # if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -1)
  bge $s1, $t0, else_invalid
  blt $s3, $zero, else_invalid
  bge $s3, $t0, else_invalid
  	sll $t1, $s1, 5
	sll $t2, $s3, 2
	add $t3, $t1, $t2
	add $t4, $t3, $s0
	lw  $t5, 0 ($t4)
	li $t6, -1
  bne $t5, $t6, else_invalid

  addi $s5, $s5, 1 #count++
  
  else_invalid:
  addi $s3,$s3,1 #j++
  j begin_for_j_it
  end_for_j_it:
  addi $s1, $s1, 1 #i++
  j begin_for_i_it
  end_for_i_it
  move $v1, $s3
  restore_context
  jr $ra