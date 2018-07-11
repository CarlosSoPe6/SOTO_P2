.text
	add		$zero, $zero, $zero	
	add		$zero, $zero, $zero
	add		$zero, $zero, $zero
	
	lui 	$t0, 0x1001
	add		$t1, $t0, $t0
	sw		$t1, 0($t0)
	add		$t1, $zero, $t0
	lw		$t2, 0($t1)
	add		$t2, $zero, $t2
	add		$zero, $zero, $zero
