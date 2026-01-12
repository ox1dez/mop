#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(short* arr, int n, short* res);

int main()
{
	ifstream fin("input.txt");
	ofstream fout("output.txt");
	short a[5000], res[5000];
	int n, n_res;
	fin >> n;
	for (int i = 0; i < n; i++) {
		fin >> a[i];
	}
	main_f(a, n, res);
	n_res = n + 1;
	for (int i = 0; i < n_res; i++) {
		fout << res[i] << endl;
	}
}