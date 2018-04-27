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
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;
	unsigned char (*b_matrix)[b_row_size] = (unsigned char (*)[b_row_size]) blit;

	for (int i = 0; i < h; i++)
	{
		for (int j = 0; j < w; j++)
		{
			if(i < bh && j < bw)
			{
				if(!(b_matrix[i][j*4+0] == 255 && b_matrix[i][j*4+1] == 0 && b_matrix[i][j*4+2] == 255))
				{
					dst_matrix[h - bh + i][(w -bw +j)*4+0] = b_matrix[i][j*4+0];
					dst_matrix[h - bh + i][(w -bw +j)*4+1] = b_matrix[i][j*4+1];
					dst_matrix[h - bh + i][(w -bw +j)*4+2] = b_matrix[i][j*4+2];
				}
				else
				{
					dst_matrix[i][j*4+0] = src_matrix[i][j*4+0];
					dst_matrix[i][j*4+1] = src_matrix[i][j*4+1];
					dst_matrix[i][j*4+2] = src_matrix[i][j*4+2];
				}
			}
			else
			{
				dst_matrix[i][j*4+0] = src_matrix[i][j*4+0];
				dst_matrix[i][j*4+1] = src_matrix[i][j*4+1];
				dst_matrix[i][j*4+2] = src_matrix[i][j*4+2];
			}
		}
	}

	// for (int i = 0; i < bh; i++)
	// {
	// 	for (int j = 0; j < bw; j++)
	// 	{
	// 		if(!(b_matrix[i][j*4+0] == 255 && b_matrix[i][j*4+1] == 0 && b_matrix[i][j*4+2] == 255))
	// 		{
	// 			dst_matrix[h - bh + i][(w -bw +j)*4+0] = b_matrix[i][j*4+0];
	// 			dst_matrix[h - bh + i][(w -bw +j)*4+1] = b_matrix[i][j*4+1];
	// 			dst_matrix[h - bh + i][(w -bw +j)*4+2] = b_matrix[i][j*4+2];
	// 		}
	// 	}
	// }
}
