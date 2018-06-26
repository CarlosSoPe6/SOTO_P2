.text
	addi	$s0, $zero, 0x2
	addi	$s0, $s0, 0x2
	addi	$s0, $s0, 0x2
	addi	$s0, $s0, 0x2
	
	beq		$s0, $zero, MemTest
	lui		$at, 0x1000
	ori		$sp, $at, 0x8400
	lui		$at, 0x1234
	ori		$t0, $at, 0x5678
	sw		$t0, 0($sp)
	add		$t1, $zero, $zero
	lw		$t1, 0($sp)
	add		$t1, $t1, $zero
	j 	testJump
	less:
	subi	$s0, $s0, 1
	MemTest:
	j end
	testJump:
	j less
	end:
	