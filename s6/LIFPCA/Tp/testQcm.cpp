#include <thread>
#include <iostream>
using namespace std;

int v = 0;

void incr(int &v) {
	++v;
}

void decr(int &v) {
	--v;
}

int main() {
    thread t2(decr, ref(v));
	thread t1(incr, ref(v));
	t2.join();
	t1.join();
	
	cout << v << endl;
}