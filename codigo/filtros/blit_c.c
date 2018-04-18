#include <stdio.h>

void blit_c(
	unsigned char *src,
	unsigned char *dst,
	int w,
	int h,
	int src_row_size,
	int dst_row_size,
	unsigned char *blit,
	int bw,
	int bh,
	int b_row_size)
{
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) src;
	unsigned char (*b_matrix)[b_row_size] = (unsigned char (*)[b_row_size]) blit;

	// for (int i = 0; i < h - bh; i++)
	// {
	// 	for (int j = w - bw; j < bw; j++)
	// 	{
	// 		if(!(b_matrix[i][j][0] == 255 && b_matrix[i][j][1] == 0 && b_matrix[i][j][2] == 255))
	// 		{
	// 			dst_matrix[i][w - bw -j][0] = b_matrix[i][j][0];
	// 			dst_matrix[i][w - bw -j][1] = b_matrix[i][j][1];
	// 			dst_matrix[i][w - bw -j][2] = b_matrix[i][j][2];
	// 		}
	// 	}
	// }
}
