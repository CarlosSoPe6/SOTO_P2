.text
	add		$zero, $zero, $zero
	add		$zero, $zero, $zero
	add		$zero, $zero, $zero
	addi 	$t0, $zero, 5
	add 	$t1, $zero, $t0
	addi 	$t1, $t1, 2
	addi 	$t2, $t1, 3
	lui		$t3, 0x000001001
	sw		$t2, 0($t3)
	add		$s0, $t2, $t1
	sub		$s1, $s0, $t3
	lw		$t2, 0($t3)
	add		$zero, $zero, $zero
	add		$zero, $zero, $zero
	addi	$s2, $t2, -2
	or		$s2, $s2, $t4
	sll		$s7, $s2, 2
	
