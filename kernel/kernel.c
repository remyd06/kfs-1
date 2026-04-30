#include "drivers/vga/vga.h"
#include "utils/stdint.h"
#include "utils/string.h"

void	kmain()
{
	char 		*str = "Welcome on KFS-1 !";
	uint16_t	x_pos = (VGA_WIDTH - ft_strlen(str)) / 2;
	uint16_t	y_pos = 0;

	for (uint32_t i = 0; i < ft_strlen(str); ++i)
	{
		set_char_vga(str[i], x_pos, y_pos, RED, BLACK);
		if (str[i])
			x_pos++;
	}


	while (1)
	{
		__asm__("cli");
	}
}
