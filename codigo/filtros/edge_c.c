#include <stdio.h>
#include "../tp2.h"

// unsigned int saturarE(float value)
// {
// 	if(value < 0) value = 0;
// 	if(value > 255) value = 255;
// 	return (unsigned int)value;
// }

void edge_c(
	unsigned char *src,
	unsigned char *dst,
	int width,
	int height,
	int src_row_size,
	int dst_row_size)
{
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;

	for (int i = 0; i < height; i++)
	{
		for (int j = 0; j < width; j++)
		{
			if(j == 0 || i == 0 || j == width-1 || i == height-1)
			{
				dst_matrix[i][j] = src_matrix[i][j];
			}
			else
			{
				float res =	src_matrix[i-1][j-1]/2	+ 	src_matrix[i-1][j] 		+	src_matrix[i-1][j+1]/2 	+
							src_matrix[i][j-1]		+	src_matrix[i][j]*(-6)	+	src_matrix[i][j+1]		+
							src_matrix[i+1][j-1]/2 	+	src_matrix[i+1][j] 		+	src_matrix[i+1][j+1]/2	;

				// saturarE(res);

				if(res < 0) res = 0;
				if(res > 255) res = 255;

				dst_matrix[i][j] = (unsigned int)res;
			}
		}
	}
}
