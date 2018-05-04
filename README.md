# impire

LLVM Syntax

- i1	            A unsigned 1 bit integer
- i32	            A unsigned 32 bit integer
- i32*	            A pointer to a 32 bit integer
- i32**	            A pointer to a pointer to a 32 bit integer
- double	        A 64-bit floating point value
- float (i32)	    A function taking a i32 and returning a 32-bit floating point float
- <4 x i32>	        A width 4 vector of 32-bit integer values.
- {i32, double}	    A struct of a 32-bit integer and a double.
- <{i8*, i32}>	    A packed structure of an integer pointer and 32-bit integer.
- [4 x i32]	        An array of four i32 values.
