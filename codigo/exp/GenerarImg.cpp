#include "../helper/libbmp.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <vector>
using namespace std;

int main (){

	srand(time(NULL));

	vector<int> data[512*512];
	int i = 0;
	int r;
	int g;
	int b;
	int a = 0;
	while(i < 512*512){
		r = rand() % 255;
		g = rand() % 255;
		b = rand() % 255;

		data[i+0] = b;
		data[i+1] = g;
		data[i+2] = r;
		data[i+3] = a;

		i = i + 4;
	}

	BMPV5H* header = get_BMPV5H(512, 512);
	*BMP img = bmp_create(header, data);

	snprintf(img, sizeof(img), "img/random.bmp");

	return 0;
}
