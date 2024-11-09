// Part 2, Q3: Done by Addina Rahaman


#include <iostream>
#include <map>
using namespace std;

int fun1(int t0) {
    int t2  = 40;
    int t1;
    if (t0 < t2) {
        t1 = 0; 
    }
    else {
        t1 = t0 - t2;
    }
    return t1;
}

int fun2 (int t0, int t1, int t2) {
    int t3 = t0 * t1;
    int t4 = t2 * t1;
    t3 += t4;
    return t3;
}

int main() {
    // Initialze 3 pointers with corresponding values
    int* t4 = new int(20);
    int* t5 = new int(30);
    int* t6 = new int(40);

    // Load the dereferenced values of the pointers into 3 new variables
    int t0 = *t4;
    int t1 = *t5;
    int t2 = *t6;

    // Adding variables
    int t3;
    t3 = t0 + t1;
    t3 = t3 + t2;

    // Assign the value of t3 to t4
    *t4 = t3;

    t6 = new int(5);
    t0 = *t6;

    t1 = fun1(t0);

    t2 = t1;
    t1 = 10;

    t3 = fun2(t0, t1, t2);

    t6 = new int(50);
    t3 = *t6;

    t1 = 2;

    cout << "t0: " << t0 << endl;
    cout << "t1: " << t1 << endl;
    cout << "t2: " << t2 << endl;
    cout << "t3: " << t3 << endl;

    return 0;
}

