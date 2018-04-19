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
			dst_matrix[i][j*4+0] = (src_matrix[i-1][(j-1)*4+0]*0.5) + src_matrix[i-1][j*4+0] + (src_matrix[i-1][(j+1)*4+0]*0.5) +
									src_matrix[i][(j-1)*4+0] + (src_matrix[i][j*4+0]*-6) + src_matrix[i][(j+1)*4+0] +
									(src_matrix[i+1][(j-1)*4+0]*0.5) + src_matrix[i+1][j*4+0] + (src_matrix[i+1][(j+1)*4+0]*0.5);

			dst_matrix[i][j*4+1] = (src_matrix[i-1][(j-1)*4+0]*0.5) + src_matrix[i-1][j*4+0] + (src_matrix[i-1][(j+1)*4+0]*0.5) +
									src_matrix[i][(j-1)*4+0] + (src_matrix[i][j*4+0]*-6) + src_matrix[i][(j+1)*4+0] +
									(src_matrix[i+1][(j-1)*4+0]*0.5) + src_matrix[i+1][j*4+0] + (src_matrix[i+1][(j+1)*4+0]*0.5);

			dst_matrix[i][j*4+2] = (src_matrix[i-1][(j-1)*4+0]*0.5) + src_matrix[i-1][j*4+0] + (src_matrix[i-1][(j+1)*4+0]*0.5) +
									src_matrix[i][(j-1)*4+0] + (src_matrix[i][j*4+0]*-6) + src_matrix[i][(j+1)*4+0] +
									(src_matrix[i+1][(j-1)*4+0]*0.5) + src_matrix[i+1][j*4+0] + (src_matrix[i+1][(j+1)*4+0]*0.5);
		}
	}
}
