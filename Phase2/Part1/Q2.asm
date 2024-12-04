# MIPS Program: Convert C++ to MIPS
# Author: Saanavi Goyal

# Set up arrays A and B in the stack
addi $sp, $sp, -72       # Allocate 72 bytes for arrays A and B
addi $t0, $sp, 0         # Base address of A[]
addi $t2, $sp, 36        # Base address of B[]

# Load elements into A[]
addi $t1, $zero, 6       # A[0] = 6
sw $t1, 0($t0)
addi $t1, $zero, 34      # A[1] = 34
sw $t1, 4($t0)
addi $t1, $zero, -7      # A[2] = -7
sw $t1, 8($t0)
addi $t1, $zero, 3       # A[3] = 3
sw $t1, 12($t0)
addi $t1, $zero, 0       # A[4] = 0
sw $t1, 16($t0)
addi $t1, $zero, -20     # A[5] = -20
sw $t1, 20($t0)
addi $t1, $zero, 6       # A[6] = 6
sw $t1, 24($t0)
addi $t1, $zero, -2      # A[7] = -2
sw $t1, 28($t0)
addi $t1, $zero, 10      # A[8] = 10
sw $t1, 32($t0)

# Load elements into B[]
addi $t1, $zero, 3       # B[0] = 3
sw $t1, 0($t2)
addi $t1, $zero, -1      # B[1] = -1
sw $t1, 4($t2)
addi $t1, $zero, 2       # B[2] = 2
sw $t1, 8($t2)
addi $t1, $zero, -9      # B[3] = -9
sw $t1, 12($t2)
addi $t1, $zero, -1      # B[4] = -1
sw $t1, 16($t2)
addi $t1, $zero, 4       # B[5] = 4
sw $t1, 20($t2)
addi $t1, $zero, 6       # B[6] = 6
sw $t1, 24($t2)
addi $t1, $zero, 11      # B[7] = 11
sw $t1, 28($t2)
addi $t1, $zero, 4       # B[8] = 4
sw $t1, 32($t2)

# Initialize loop counter i = 0
addi $t3, $zero, 0

# First loop: A[i] = A[i] + B[i]
Loop1:
    bge $t3, 9, After1      # Exit loop when i >= 9

    mul $t4, $t3, 4         # Offset for A[i] and B[i]
    add $t5, $t0, $t4       # Address of A[i]
    lw $t6, 0($t5)          # Load A[i]
    add $t7, $t2, $t4       # Address of B[i]
    lw $t8, 0($t7)          # Load B[i]
    add $t6, $t6, $t8       # A[i] = A[i] + B[i]
    sw $t6, 0($t5)          # Store back in A[i]

    addi $t3, $t3, 1        # Increment i
    j Loop1

After1:
# Reset i = 0
addi $t3, $zero, 0

# Second loop: Print A[i]
Loop2:
    bge $t3, 9, After2      # Exit loop when i >= 9

    mul $t4, $t3, 4         # Offset for A[i]
    add $t5, $t0, $t4       # Address of A[i]
    lw $a0, 0($t5)          # Load A[i] into $a0 for printing
    li $v0, 1               # Syscall for print integer
    syscall

    li $a0, 10              # Newline
    li $v0, 11              # Syscall for print char
    syscall

    addi $t3, $t3, 1        # Increment i
    j Loop2

After2:
# Reset i = 0 and initialize sum = 0
addi $t3, $zero, 0
addi $t9, $zero, 0

# Sum loop: sum += A[i] + B[i] + 1
SumLoop:
    bge $t3, 9, AfterSum    # Exit loop when i >= 9

    mul $t4, $t3, 4         # Offset for A[i] and B[i]
    add $t5, $t0, $t4       # Address of A[i]
    lw $t6, 0($t5)          # Load A[i]
    add $t9, $t9, $t6       # sum += A[i]

    add $t7, $t2, $t4       # Address of B[i]
    lw $t8, 0($t7)          # Load B[i]
    add $t9, $t9, $t8       # sum += B[i]

    addi $t9, $t9, 1        # sum++

    addi $t3, $t3, 1        # Increment i
    j SumLoop

AfterSum:
# Print sum
move $a0, $t9              # Load sum into $a0
li $v0, 1                  # Syscall for print integer
syscall

# Exit program
li $v0, 10                 # Syscall for exit
syscall
