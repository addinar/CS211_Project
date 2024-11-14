#Question 1: Raeesah Iram
#Translate the following C++ code into assembly: 
#include <iostream> 
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


#ANSWER
main:
    addi $sp, $sp, -36         # Allocate space for array A on stack
    addi $t0, $sp, 0           # Set $t0 to base address of A

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

    addi $t3, $zero, 0         # i = 0
    addi $t2, $zero, 0         # sum = 0

SumLoop:
    addi $t4, $t3, -5          # Subtract 5 from i (t3)
    slt $t5, $zero, $t4        # Set $t5 = 1 if i >= 5
    bne $t5, $zero, Exit       # If $t5 != 0 (i >= 5), jump to Exit

    addi $t6, $zero, 4         # Load constant 4 into $t6
    mul $t6, $t3, $t6          # Calculate the byte offset (i * 4)
    add $t6, $t0, $t6          # Add the offset to base address of A
    lw $t6, 0($t6)             # Load A[i] into $t6

    add $t2, $t2, $t6          # sum += A[i]
    addi $t3, $t3, 1           # i++
    j SumLoop                  # Repeat loop

Exit:
    # Copy sum from $t2 to $a0 for printing
    add $a0, $zero, $t2        # $a0 = sum

    # Load 1 into $v0 (for print integer syscall)
    addi $v0, $zero, 1         # $v0 = 1 (print integer syscall)
    syscall

    # Exit syscall
    addi $v0, $zero, 10        # $v0 = 10 (exit syscall)
    syscall
