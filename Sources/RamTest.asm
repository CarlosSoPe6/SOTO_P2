.text
	addi	$t0, $zero, 0xA
	add		$t1, $t0, $t0
	sw		$t1, 0($t0)
	add		$t1, $zero, $zero
	lw		$t2, 0($t0)
	add		$t2, $zero, $zero