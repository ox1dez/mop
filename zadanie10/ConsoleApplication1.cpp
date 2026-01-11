#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n, int* start, int* n_res);

int main()
{
	ifstream fin("input.txt");
	short a[5000];
	int n, n_res, sr, ost, start;
	fin >> n;
	for (int i = 0; i < n; i++) {
		fin >> a[i];
	}
	main_f(a, n, &start, &n_res);
	cout << n_res << endl;
	for (int i = start; i < start + n_res; i++) {
		cout << a[i] << endl;
	}
}