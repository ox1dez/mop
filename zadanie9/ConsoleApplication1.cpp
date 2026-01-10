#include <iostream>
#include <fstream>
using namespace std;

extern "C" int main_f(char* arr, char* res);

int main()
{
	ifstream fin("input.txt");
	char a[5000], res[5000];
	fin >> a;
	main_f(a, res);
	cout << res << endl;
}