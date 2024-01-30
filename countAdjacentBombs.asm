.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	addi $t1, $s1, -1 #row - 1
	addi $t2, $s1, 1 #row + 1
	addi $t3, $s2, -1 #column - 1
	addi $t4, $s2, 1 #column + 1
	li $s3 , 0 #count = o
	
  begin_for_i_it:				# for (int i = row - 1; i < row + 1; ++i) {
  bgt $t1,$t2,end_for_i_it
  
  begin_for_j_it:				# for (int j = column - 1; j < column + 1; ++j) {
  bgt $t3,$t4,end_for_j_it
  
  
  
  addi $t3,$t3,1 #j++
  j begin_for_j_it
  end_for_j_it:
  addi $t1, $t1, 1 #i++
  j begin_for_i_it
  end_for_i_it
  restore_context
  jr $ra