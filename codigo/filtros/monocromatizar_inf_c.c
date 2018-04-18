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
	
	for (int i = 0; i < height; i++)
	{
		for (int j = 0; j < width; j++)
		{
			if(max(src_matrix[i][j*4+0], src_matrix[i][j*4+1]) == max(src_matrix[i][j*4+1], src_matrix[i][j*4+2]))
			{
				dst_matrix[i][j*4+0] = src_matrix[i][j*4+1];
				dst_matrix[i][j*4+1] = src_matrix[i][j*4+1];
				dst_matrix[i][j*4+2] = src_matrix[i][j*4+1];
			}else{
				dst_matrix[i][j*4+0] = max(src_matrix[i][j*4+0], src_matrix[i][j*4+2]);
				dst_matrix[i][j*4+1] = max(src_matrix[i][j*4+0], src_matrix[i][j*4+2]);
				dst_matrix[i][j*4+2] = max(src_matrix[i][j*4+0], src_matrix[i][j*4+2]);
			}
		}
	}
}
