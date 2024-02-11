.include "macros.asm"

.globl play

play:
save_context
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	sll $t1, $s1, 5
	sll $t2, $s2, 2
	add $t3, $t1, $t2
	add $s3, $t3, $s0
	
	lw  $s4, 0 ($s3)
	li $s5, -1
	li $s6, -2
	
bne $s4, $s5, first_if_else #if (board[row][column] == -1)

li $s7, 0
j play_end

first_if_else:
bne $s4, $s6, second_if_else #if (board[row][column] == -2)
jal countAdjacentBombs
sw $v1, 0 ($s3) #int x = countAdjacentBombs(board, row, column); board[row][column] = x;
bne $v1, $zero, second_if_else
jal revealAdjacentCells

second_if_else:
li $s7, 1

play_end:
move $v0, $s7
restore_context
 jr $ra
