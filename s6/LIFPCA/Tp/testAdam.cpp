#include <thread>
#include <iostream>
#include <mutex>
#include <condition_variable>
#include <unistd.h>
using namespace std;

int go = false;
mutex m;
condition_variable cond_var;

void attendre() {
	cout << "Je vais attendre" << endl;
	unique_lock<mutex> l(m);
	while (go == false) {
		;
	}
	cout << "Je suis réveillé" << endl;
}

void reveiller() {
	sleep(1); // Attendre 1 seconde
	cout << "Je vais réveiller" << endl;
	unique_lock<mutex> l(m);
	go = true;
}

int main() {
	thread t1(attendre);
	thread t2(reveiller);
	t1.join();
	t2.join();
}