.text
	addi	$s0, $zero, 0x2
	
	loop:
	beq		$s0, $zero, MemTest
	add		$t1, $t1, $zero
	j 	testJump
	less:
	subi	$s0, $s0, 1
	j loop
	MemTest:
	j end
	testJump:
	j less
	end:
	
