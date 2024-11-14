main:
    addi $sp, $sp, -36         # Allocate space for array A on stack
    addi $t0, $sp, 0           # Set $t0 to base address of A

    # Initialize array A
    addi $t1, $zero, 1
    sw $t1, 0($t0)             # A[0] = 1
    addi $t1, $zero, 2
    sw $t1, 4($t0)             # A[1] = 2
    addi $t1, $zero, 3
    sw $t1, 8($t0)             # A[2] = 3
    addi $t1, $zero, 4
    sw $t1, 12($t0)            # A[3] = 4
    addi $t1, $zero, 5
    sw $t1, 16($t0)            # A[4] = 5

    # Sum all elements in A
    addi $t3, $zero, 0         # i = 0
    addi $t2, $zero, 0         # sum = 0

SumLoop:
    addi $t4, $t3, -5          # Subtract 5 from i (t3)
    slt $t5, $zero, $t4         # Set $t5 = 1 if i >= 5 (i.e., $t3 - 5 > 0)
    bne $t5, $zero, Exit        # If $t5 != 0 (i >= 5), jump to Exit

    addi $t6, $zero, 4          # Load constant 4 into $t6
    mul $t6, $t3, $t6          # Calculate the byte offset (i * 4)
    add $t8, $t0, $t6          # Add the offset to base address of A
    lw $t7, 0($t8)             # Load A[i] into $t7

    add $t2, $t2, $t7          # sum += A[i]
    addi $t3, $t3, 1           # i++
    j SumLoop                  # Repeat loop

Exit:
    add $a0, $zero, $t2        # Copy sum to $a0 for printing
    addi $v0, $zero, 1         # Print integer syscall
    syscall

    addi $v0, $zero, 10        # Exit syscall
    syscall
