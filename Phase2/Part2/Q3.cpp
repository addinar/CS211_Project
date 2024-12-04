#include <iostream>
using namespace std;

// define fun1
int fun1(int t0) {
    int t2 = 40;
    int t1;
    if (t0 < t2) {
        t1 = 0;
    } else {
        t1 = t0 - t2;
    }
    return t1;
}

// define fun2
int fun2(int t0, int t1, int t2) {
    int t3 = t0 * t1;
    int t4 = t2 * t1;
    t3 += t4;
    return t3;
}

int main() {
    int* t4 = new int(10);
    int* t5 = new int(50);
    int* t6 = new int(60);

   
    *t4 = *t4 + *t5 + *t6; 

    
    delete t6;  
    t6 = new int(5);
    int t1 = fun1(*t6); 

   
    int t2 = t1;
    int t3 = fun2(*t6, 10, t2);


    delete t6;  
    t6 = new int(t3);


    cout << "t4: " << *t4 << endl; // Value at pointer t4
    cout << "t5: " << *t5 << endl; // Value at pointer t5
    cout << "t6: " << *t6 << endl; // Value at pointer t6
    cout << "t1: " << t1 << endl;  
    cout << "t2: " << t2 << endl;  
    cout << "t3: " << t3 << endl;  


    delete t4;
    delete t5;
    delete t6;

    return 0;
}
