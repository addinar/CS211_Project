; Question 2:
; Done by Saanavi Goyal

; #include <iostream>
; using namespace std;
; int main() 
; {
;   int A[] = {6, 34, -7, 3, 0, -20, 6, -2, 10}; 
;   int B[] = {3, -1, 2, -9, -1, 4, 6, 11, 4}; 
  
;   for (int i=0; i<9; i++) 
;   { 
;     A[i]=A[i]+B[i]; } 
;     for (int i=0; i<9; i++) 
;     {
;       cout << A[i] << endl; 
;     }
    
;     int sum = 0; // Start the total sum at 0. 
;     for (int i=0; i<9; i++) { 
;     sum = sum + A[i] + B[i]; // Add the next element to the total 
;     sum++; 
;   } 
  
;   cout << " Array elements sum = " << sum << endl; 
;   return 0;
; } 

; Steps:
;   - Assign a base address arrays A[] and B[]
;   - Manually load elements from individual arrays using addi, and sw
;   - Convert the for loop to while:
;     - initialize a variable to a new register
;     - Use bge, and perform arithmetic as needed
;     - increment the new variable created
;   - find sum of arrays A and B
;   - print, and exit!
  

; Set-up Array A and be
  
  addi $sp, $sp, -72 ;36 bytes for each array, adds up to 72 bytes in total
  addi $t0, $sp, 0   ; A[] base address
  
  ;loading elements from A[]
  ;int A[] = {6, 34, -7, 3, 0, -20, 6, -2, 10}; 
  
  addi $t1, $zero, 6
  sw $t1, 0($t0)     ;A[0] = 6
  
  addi $t1, $zero, 34
  sw $t1, 4($t0)     ;A[1] = 34
  
  addi $t1, $zero, -7
  sw $t1, 8($t0)     ;A[2] = -7
  
  addi $t1, $zero, 3
  sw $t1, 12($t0)     ;A[3] = 3
  
  addi $t1, $zero, 0
  sw $t1, 16($t0)     ;A[4] = 0
  
  addi $t1, $zero, -20
  sw $t1, 20($t0)     ;A[5] = -20
  
  addi $t1, $zero, 6
  sw $t1, 24($t0)     ;A[6] = 6

  addi $t1, $zero, -2
  sw $t1, 28($t0)     ;A[7] = -2
  
  addi $t1, $zero, 10
  sw $t1, 32($t0)     ;A[8] = 10
  
  addi $t2, $sp, 36  ; B[] base address
  
  ;loading elements from B[]
  ;int B[] = {3, -1, 2, -9, -1, 4, 6, 11, 4}; 
  
  addi $t1, $zero, 3
  sw $t1, 0($t2)     ;B[0] = 3
  
  addi $t1, $zero, -1
  sw $t1, 4($t2)     ;B[1] = -1
  
  addi $t1, $zero, 2
  sw $t1, 8($t2)     ;B[2] = 2
  
  addi $t1, $zero, -9
  sw $t1, 12($t2)    ;B[3] = -9
  
  addi $t1, $zero, -1
  sw $t1, 16($t2)    ;B[4] = -1
  
  addi $t1, $zero, 4
  sw $t1, 20($t2)    ;B[5] = 4
  
  addi $t1, $zero, 6
  sw $t1, 24($t2)    ;B[6] = 6

  addi $t1, $zero, 11
  sw $t1, 28($t2)    ;B[7] = 11
  
  addi $t1, $zero, 4
  sw $t1, 32($t2)    ;B[8] = 4
  
  ;initialize index i=0 for the loop
  addi $t3, $zero, 0
  
  ;functions for within the first for loop 
  Loop1:
    beq $t3, 9, After1 ;loop runs until i < 9, then exits to sum_loop 
    
    mul $t4, $t3, 4 ;offset for A[i] and B[i]
    lw $t5, 0($t0)  ;load A[i]
    lw $t6, 0($t2)  ;load B[i]
    
    add $t5, $t5, $t6
    sw $t5, 0($t0)  ;A[i] = A[i]+B[i]
    
    addi $t3, $t3, 1 ;increment i in the loop
    
    j Loop1
    
  addi #t3, $zero, 0 
 
  After1:
  ; reset index for loop2
  li $t3, 0

  ;second for loop - converted to while
  Loop2:
    bge $t3, 9, After2

    mul $t4, $t3, 4         
    add $t7, $t0, $t4       
    lw $a0, 0($t7)          ; load A[i] into $a0 for printing
    
    addi $t1, $zero, 1      ; syscall code for print integer (1) into $t1
    move $v0, $t1           ; move syscall code into $v0
    syscall                 ; print A[i]

    addi $t1, $zero, 11     ; syscall code for newline (11) into $t1
    move $v0, $t1           ; move newline syscall code into $v0
    addi $a0, $zero, 10     ; load ASCII value for newline (10) into $a0
    syscall             

    addi $t3, $t3, 1        ; increment i
    j Loop2

  After2:
    ; i = 0 , sum = 0 
    li $t3, 0
    li $t9, 0            

  ;sum of all elements in A and B
  SumLoop:
      bge $t3, 9, AfterSum
  
      mul $t4, $t3, 4    
      add $t7, $t0, $t4   
      
      lw $t5, 0($t7)      ; load A[i]
      add $t9, $t9, $t5   ; sum = sum + A[i]
  
      add $t8, $t2, $t4   ; address of B[i]
      lw $t6, 0($t8)      ; load B[i]
      add $t9, $t9, $t6   ; sum = sum + B[i]
  
      addi $t9, $t9, 1    ; sum++
  
      addi $t3, $t3, 1    ; i++
      j SumLoop
  
  AfterSum:
    ; final sum
    move $a0, $t9        ; load sum into $a0 for printing
  
    li $v0, 1            ; syscall for print integer
    syscall              ; print sum
  
    ; Exit program
    li $v0, 10           ; syscall for exit
    syscall
