#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n, int* len, int* start);

int main()
{
	ifstream fin("input.txt");
	int n, ln, st;
	fin >> n;
	short a[1000];
	for (int i = 0; i < n; fin >> a[i++]);
	main_f(a, n, &ln, &st);
	//cout << n << endl;
	for (int i = st; i < st + ln; i++) {
		cout << a[i] << endl;
	}
}
