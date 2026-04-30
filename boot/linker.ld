ENTRY(start)

SECTIONS
{
	. = 1M;

	.text :
	{
		*(.multiboot)
		*(.text*)
	} :RE

	.rodata :
	{
		*(.rodata*)
	} :R

	.data :
	{
		*(.data*)
	} :RW

	.bss :
	{
		*(.bss*)
	} :RW
}
