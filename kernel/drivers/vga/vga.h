#include "../../utils/stdint.h"

# define VGA        	0xb8000
# define VGA_WIDTH  	80
# define VGA_HEIGHT		25

enum	VGA_COLORS
{
	BLACK				= 0x0,
	BLUE				= 0x1,
	GREEN				= 0x2,
	CYAN				= 0x3,
	RED					= 0x4,
	MAGENTA				= 0x5,
	BROWN				= 0x6,
	LIGHT_GREY			= 0x7,
	DARK_GREY			= 0x8,
	LIGHT_BLUE			= 0x9,
	LIGHT_GREEN			= 0xA,
	LIGHT_CYAN			= 0xB,
	LIGHT_RED			= 0xC,
	LIGHT_MAGENTA		= 0xD,
	YELLOW				= 0xE,
	WHITE				= 0xF,
};

void    set_char_vga(uint8_t c, uint16_t x_pos, uint16_t y_pos, uint8_t fg, uint8_t bg);
