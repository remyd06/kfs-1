#include "vga.h"
#include "../../utils/string.h"

volatile uint16_t	*vga_ptr = (uint16_t *)VGA;

void    set_char_vga(uint8_t c, uint16_t x_pos, uint16_t y_pos, uint8_t fg, uint8_t bg)
{
    vga_ptr[y_pos * VGA_WIDTH + x_pos] = (uint16_t)(bg << 12 | fg << 8 | c);
}
