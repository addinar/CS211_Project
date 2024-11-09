#include <iostream>
#include <map>
using namespace std;

// define fun1
int fun1(int t0) { // lw $t0, 0($t6)
    int t2  = 40; // addi $t2, $zero, 40
    int t1;
    if (t0 < t2) { // slt $t3, $t0, $t2
        t1 = 0; // bne $t3, $zero, R2 -> R2: addi $t1, $zero, 0
    }
    else {
        t1 = t0 - t2; // sub $t1, $t0, $t2
    }
    return t1; // j R1 -> R1: jr $ra
}

// define fun2
int fun2 (int t0, int t1, int t2) { // lw $t0, 0($t6) ; addi $t2, zero, $t1 ; addi $t1, $zero, 10
    int t3 = t0 * t1; // mul $t3, $t0, $t1
    int t4 = t2 * t1; // mul $t4, $t2, $t1
    t3 += t4; // add $t3, $t3, $t4
    return t3; // jr $ra
}

int main() {
    // Initialze 3 pointers with corresponding values
    int* t4 = new int(20); // addi $t4, $zero, 5000 (init with 20)
    int* t5 = new int(30); // addi $t5, $zero, 5004 (init with 30)
    int* t6 = new int(40); // addi $t6, $zero, 5008 (init with 40)

    // Load the dereferenced values of the pointers into 3 new variables
    int t0 = *t4; // lw $t0, 0($t4)
    int t1 = *t5; // lw $t1, 0($t5)
    int t2 = *t6; // lw $t2, 0($t6)

    // Adding variables
    int t3;
    t3 = t0 + t1; // add $t3, $t0, $t1
    t3 = t3 + t2; // add $t3, $t3, $t2

    // Store the sum to DM[5000]
    *t4 = t3; // sw $t3, 0($t4)

    t6 = t4; // addi $t6, $zero, 5000
    t6 = new int(5); // (init with 5)
    t0 = *t6; // lw $t0, 0($t6)

    t1 = fun1(t0); // jal fun1 with t0 as the arg and t1 as the return

    t2 = t1; // add $t2, $zero, $t1
    t1 = 10; // addi $t1, $zero, 10

    t3 = fun2(t0, t1, t2); // jal fun2 with t0, t1, t2 as the args and t3 as the return

    t6 = new int(50); // addi $t6, $zero, 5040 (init with 50)
    t6 = &t3; // sw $t3, 0($t6)

    t1 = 2; // j Done -> Done: addi $t1, $zero, 2

    // Print the values of the variables
    cout << "t0: " << t0 << endl;
    cout << "t1: " << t1 << endl;
    cout << "t2: " << t2 << endl;
    cout << "t3: " << t3 << endl;

    return 0;
}

