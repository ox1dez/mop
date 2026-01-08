#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n);

int main()
{
	ifstream fin("input.txt");
	int n, k;
	short a[5000];
	fin >> n;
	for (int i = 0; i < n; i++) {
		fin >> a[i];
	}
	main_f(a, n);
	for (int i = 0; i < n; i++) {
		cout << a[i] << endl;
	}
}
