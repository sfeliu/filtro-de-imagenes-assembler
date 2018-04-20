#include <stdio.h>
#include "../tp2.h"

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
				dst_matrix[i][j] = 0;
			}
			else
			{
				dst_matrix[i][j] = (unsigned int)(	(src_matrix[i-1][j-1]*0.5)	+ src_matrix[i-1][j] 	+ (src_matrix[i-1][j+1]*0.5) 	+
													src_matrix[i][j-1] 			+ (src_matrix[i][j]*-6) + src_matrix[i][j+1] 			+
													(src_matrix[i+1][j-1]*0.5) 	+ src_matrix[i+1][j] 	+ (src_matrix[i+1][j+1]*0.5)	);
			}
		}
	}
}
