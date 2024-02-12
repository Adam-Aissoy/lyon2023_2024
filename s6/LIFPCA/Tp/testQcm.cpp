#include <thread>
#include <iostream>
#include <mutex>
using namespace std;
#define N 100

int v = 0;
mutex m1, m2;

void incr(int &v) {
	for (int i = 0; i < N; ++i) {
		m1.lock();
		m2.lock();
		++v;
		m2.unlock();
		m1.unlock();
	}
}

void decr(int &v) {
	for (int i = 0; i < N; ++i) {
		m1.lock();
		m2.lock();
		--v;
		m2.unlock();
		m1.unlock();
	}
}

int main() {
	thread t1(incr, ref(v));
	thread t2(decr, ref(v));
	t1.join();
	t2.join();
	cout << v << endl;
}

