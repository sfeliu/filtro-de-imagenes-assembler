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
			bgra_t = src_matrix[i][j];
			if(max(src_matrix[i][j]->b, src_matrix[i][j]->g) ==	max(src_matrix[i][j]->g, src_matrix[i][j]->r))
			{
				dst_matrix[i/4][j/4] = src_matrix[i/4][j/4]->g;
			}else{
				dst_matrix[i/4][j/4] = max(src_matrix[i][j]->b, src_matrix[i][j]->r);
			}

		}
	}

	for (int i = 0; i < height; i++)
	{
		for (int j = 0; j < width; j++)
		{
			if(max(src_matrix[i][j][0], src_matrix[i][j][1]) ==	max(src_matrix[i][j][1], src_matrix[i][j][2]))
			{
				dst_matrix[i][j] = src_matrix[i][j][1];
			}else{
				dst_matrix[i][j] = max(src_matrix[i][j][0], src_matrix[i][j][2]);
			}
		}
	}
}
