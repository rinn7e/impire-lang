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


Use JIT (just in time) compilation to optimize, ast folding 

Our demonstration for Chapter 3 is elegant and easy to extend. Unfortunately, it does not produce wonderful code. However the naive construction of the LLVM module will perform some minimal transformations to generate a module which not a literal transcription of the AST but preserves the same semantics.

The "dumb" transcription would look like:

ready> def test(x) 1+2+x;
define double @test(double %x) {
entry:
  %addtmp = fadd double 2.000000e+00, 1.000000e+00
  %addtmp1 = fadd double %addtmp, %x
  ret double %addtmp1
}
The "smarter" transcription would eliminate the first line since it contains a simple constant that can be computed at compile-time.

ready> def test(x) 1+2+x;
define double @test(double %x) {
entry:
  %addtmp = fadd double 3.000000e+00, %x
  ret double %addtmp
}

Control Flow - If - Else

def fib(x)
   if x < 3 then
      1
   else
      fib(x-1) + fib(x-2);

0.0 is considered to be false and everything else is considered to be true.