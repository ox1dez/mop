#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n, short* res);

int main()
{
	ifstream fin("input.txt");
	int n, k;
	short a[5000], res[5000];
	fin >> n;
	for (int i = 0; i < n; i++) {
		fin >> a[i];
	}
	k = main_f(a, n, res);
	cout << k << endl;
	for (int i = 0; i < k; i++) {
		cout << res[i] << endl;
	}
}
