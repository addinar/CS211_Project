#Question 1: Raeesah Iram
#Translate the following C++ code into assembly: 
# #include <iostream> 
#using namespace std; 
#void summation_3(int A[],int& sum){      
#    for(int i=0; i<5;i++){      
#        A[i]=A[i]+3;      
#        sum = sum+3; 
#    } 
#} 
#int main(){ 
#    int A[]={1,2,3,4,5}; 
#    int sum=0; 
#    for(int i=0;i<5;i++)      
#        cout<<A[i]<<endl; 
#    summation_3(A,sum); 
#    for(int i=0; i<5;i++)      
#        cout<<A[i]<<endl; 
#    cout<<"The sum value is:"<<sum<<endl; }


.data
newline: .asciiz "\n"           # Newline character for printing
before_msg: .asciiz "Array before summing:"
orig_sum_msg: .asciiz "Original sum of array:"
final_sum_msg: .asciiz "Sum of array after adding 10:"

.text
.globl main

main:
    addi $sp, $sp, -36         # Allocate space for array A on stack
    move $t0, $sp              # Set $t0 to base address of A

    # Initialize array A
    li $t1, 1
    sw $t1, 0($t0)             # A[0] = 1
    li $t1, 2
    sw $t1, 4($t0)             # A[1] = 2
    li $t1, 3
    sw $t1, 8($t0)             # A[2] = 3
    li $t1, 4
    sw $t1, 12($t0)            # A[3] = 4
    li $t1, 5
    sw $t1, 16($t0)            # A[4] = 5

    # Print "Array before summing"
    li $v0, 4                  # Print string syscall
    la $a0, before_msg
    syscall

    # Print array A
    li $t3, 0                  # i = 0
PrintArray:
    slti $t5, $t3, 5           # Check if i < 5
    beq $t5, $zero, StartSum   # Exit loop if i >= 5

    mul $t6, $t3, 4            # Calculate offset i * 4
    add $t6, $t0, $t6          # Address of A[i]
    lw $a0, 0($t6)             # Load A[i] into $a0

    li $v0, 1                  # Print integer syscall
    syscall

    la $a0, newline            # Print newline
    li $v0, 4                  # Print string syscall
    syscall

    addi $t3, $t3, 1           # i++
    j PrintArray               # Repeat loop

StartSum:
    # Initialize variables for summation
    li $t3, 0                  # i = 0
    li $t2, 0                  # sum = 0

SumLoop:
    slti $t5, $t3, 5           # Set $t5 = 1 if i < 5
    beq $t5, $zero, PrintOrigSum  # If i >= 5, exit the loop

    mul $t6, $t3, 4            # Calculate byte offset (i * 4)
    add $t6, $t0, $t6          # Address of A[i]
    lw $t7, 0($t6)             # Load A[i] into $t7

    add $t2, $t2, $t7          # sum += A[i]
    addi $t3, $t3, 1           # i++
    j SumLoop                  # Repeat loop

PrintOrigSum:
    # Print "Original sum of array"
    li $v0, 4                  # Print string syscall
    la $a0, orig_sum_msg
    syscall

    # Print the original sum
    move $a0, $t2              # $a0 = sum
    li $v0, 1                  # Print integer syscall
    syscall

    la $a0, newline            # Print newline
    li $v0, 4                  # Print string syscall
    syscall

    # Add 10 to the sum
    addi $t2, $t2, 10          # sum += 10

    # Print "Sum of array after adding 10"
    li $v0, 4                  # Print string syscall
    la $a0, final_sum_msg
    syscall

    # Print the updated sum
    move $a0, $t2              # $a0 = sum
    li $v0, 1                  # Print integer syscall
    syscall

    # Exit program
    li $v0, 10                 # Exit syscall
    syscall
