.data
    A: .word 1 -3 5 7 9 0 2 -4 6 8 1 3 -1 0 1 0 0 0 -5 7 9 0 1 0
    B: .word 0
.text
    
    add		$zero, $zero, $zero		# NOP
    add		$zero, $zero, $zero		# NOP
    add		$zero, $zero, $zero		# NOP

    addi	$s0, $zero, 4			# $s0 = $zero + 4
    addi	$s1, $zero, 3			# $s1 = $zero + 3
    addi	$s2, $zero, 6			# $s2 = $zero + 6
    addi	$s3, $zero, 2			# $s3 = $zero + 2
    lui		$s4, 0x1001				# $s4 = 0x10010000
    li		$s5, 0x10010060			# $s5 = 0x10010060
    
    add		$t0, $zero, $zero		# $t0 = $zero + $zero
    
    forI:
    beq		$t0, $s0, endForI	    # if $t0 == $s0 tendForI
    add		$t1, $zero, $zero		# $t3 = $zero + $zero
    forJ:
    beq		$t1, $s1, endForJ	    # if $t1 == $s1 then endForJ
    
    # A Access
    mul     $t8, $t1, $s3
    mul     $t9, $t0, $s2
    add		$t8, $t8, $t9		# $t8 = $t8 + $t9
    sll     $t8, $t8, 2
    add		$t8, $t8, $s4		# $t8 = $t8 + $s4
    lw		$t2, 0($t8)		    # 
    lw		$t3, 4($t8)		    # 
    sub		$t3, $zero, $t3		# $t3 = $zero - $t3

    # B access
    mul     $t8, $t1, $s2
    mul     $t9, $t0, $s3
    add		$t8, $t8, $t9		# $t8 = $t8 + $t9
    sll     $t8, $t8, 2
    add		$t8, $t8, $s5		# $t8 = $t8 + $s5
    sw		$t2, 0($t8)	        #
    sw		$t3, 4($t8)		    #
    
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    j		forJ				# jump to forJ

    endForJ:
    
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j		forI				# jump to forI
    
    endForI:
    
