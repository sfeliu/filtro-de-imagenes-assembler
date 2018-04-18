
#include <math.h>
#include "../tp2.h"


bool between(unsigned int val, unsigned int a, unsigned int b)
{
	return a <= val && val <= b;
}

void temperature_c    (
	unsigned char *src,
	unsigned char *dst,
	int width,
	int height,
	int src_row_size,
	int dst_row_size)
{
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;

	// for (int i = 0; i < height; i++)
	// {
	// 	for (int j = 0; j < width; j++)
	// 	{
	// 		t = ((int)(src_matrix[i][j][0] + src_matrix[i][j][1] + src_matrix[i][j][2]))/3
	// 		if(t <32)
	// 		{
	// 			dst_matrix[i][j][0] = 0;
	// 			dst_matrix[i][j][1] = 0;
	// 			dst_matrix[i][j][2] = 128 + (t * 4);
	// 		}
	// 		else if(t < 96)
	// 		{
	// 			dst_matrix[i][j][0] = 0;
	// 			dst_matrix[i][j][1] = (t - 32) * 4;
	// 			dst_matrix[i][j][2] = 255;
	// 		}
	// 		else if(t < 160)
	// 		{
	// 			dst_matrix[i][j][0] = (t - 96) * 4;
	// 			dst_matrix[i][j][1] = 255;
	// 			dst_matrix[i][j][2] = 255 - (t-96) * 4;
	// 		}
	// 		else if(t < 224)
	// 		{
	// 			dst_matrix[i][j][0] = 255;
	// 			dst_matrix[i][j][1] = 255 - (t - 160) * 4;
	// 			dst_matrix[i][j][2] = 0;
	// 		}
	// 		else
	// 		{
	// 			dst_matrix[i][j][0] = 255 - (t - 224) * 4;
	// 			dst_matrix[i][j][1] = 0;
	// 			dst_matrix[i][j][2] = 0;
	// 		}
	// 	}
	// }
	/*
	for (int i_d = 0, i_s = 0; i_d < height; i_d++, i_s++) {
		for (int j_d = 0, j_s = 0; j_d < width; j_d++, j_s++) {
			bgra_t *p_d = (bgra_t*)&dst_matrix[i_d][j_d*4];
			bgra_t *p_s = (bgra_t*)&src_matrix[i_s][j_s*4];
			*p_d = *p_s;
		}
	}
	*/
}
