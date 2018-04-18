#include "monocromatizar_inf.c"
#define max(a, b) ((a)>(b))?(a):(b)

void monocromatizar_inf_c(
	unsigned char *src,
	unsigned char *dst,
	int width,
	int height,
	int src_row_size,
	int dst_row_size)
{
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;
	for (int i = 0; i < height; i = i + 4)
	{
		for (int j = 0; j < width; j = j + 4)
		{
			bgra_t* pixel_src = src_matrix[i][j];
			if(max(pixel_src->b, pixel_src->g) ==	max(pixel_src->g, pixel_src->r))
			{
				dst_matrix[i/4][j/4] = pixel_src->g;
			}else{
				dst_matrix[i/4][j/4] = max(pixel_src->b, pixel_src->r);
			}

		}
	}

	// for (int i = 0; i < height; i++)
	// {
	// 	for (int j = 0; j < width; j=j+4)
	// 	{
	// 		bgra_t pixel = src_matrix[i][j];
	// 		if(max(pixel->r, pixel->b) ==	max(pixel->r, pixel->g)
	// 		{
	// 			dst_matrix[i/4][j/4] = pixel->r;
	// 		}else{
	// 			dst_matrix[i/4][j/4] = max(pixel->g,pixel->b);
	// 		}
	// 	}
	// }
}
