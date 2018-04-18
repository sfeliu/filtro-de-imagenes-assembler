#define max(a, b) ((a)>(b))?(a):(b)

void monocromatizar_inf_c (
	unsigned char *src, 
	unsigned char *dst, 
	int width, 
	int height, 
	int src_row_size, 
	int dst_row_size
) {
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;

	// ~ completar
}
