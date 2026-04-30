#include "stdint.h"

inline uint32_t    ft_strlen(char *str)
{
	uint32_t	i = 0;

	while (str[i])
		i++;
	return (i);
}