#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n, short* counts);

int main()
{
	ifstream fin("input.txt");
	int n, k, mx;
	short a[5000], counts[5000];
	fin >> n;
	for (int i = 0; i < n; i++) {
		fin >> a[i];
	}
	mx = main_f(a, n, counts);
	cout << "Max cnt = " << mx << endl;
	for (int i = 0; i < n; i++) {
		cout << counts[i] << endl;
	}
}
