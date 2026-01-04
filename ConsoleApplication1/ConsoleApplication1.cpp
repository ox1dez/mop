#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n);

int main()
{
	ifstream fin("input.txt");
	int n;
	fin >> n;
	short a[1000];
	for (int i = 0; i < n; fin >> a[i++]);
	main_f(a, n);
	cout << n << endl;
	for (int i = 0; i < n; i++) {
		cout << a[i] << endl;
	}
}
