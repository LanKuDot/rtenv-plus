ENTRY(main)
MEMORY
{
  FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 128K
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

SECTIONS
{
	.text :
	{
		KEEP(*(.isr_vector))
 		*(.text)
 		*(.text.*)
		*(.rodata)
		*(.rodata*)
		_sromdev = .;
		*(.rom.*)
		_eromdev = .;
		_sidata = .;
	} >FLASH

	/* Initialized data will initially be loaded in FLASH at the end of the .text section. */
	.data : AT (_sidata)
	{
		_sdata = .;
		*(.data)		/* Initialized data */
		*(.data*)
		_edata = .;
	} >RAM

	.bss : {
		_sbss = .;
		*(.bss)         /* Zero-filled run time allocate data memory */
		_ebss = .;
	} >RAM

    _estack = ORIGIN(RAM) + LENGTH(RAM);
}
