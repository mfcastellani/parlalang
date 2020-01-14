# parlalang

## About

*Parla programming language*, for learning purpouses

Parla is a small programming language created for learning purpouses, just for fun.

Parla means *speaks" in italian. The name was choosen because you have methodos to show details about variables and understand how the memory is at the moment.

Currently it just work with integer numbers, stored in a structure. 

You can store data into the structure using load method:

```
load 10 into a
```

or

```
load a * b into c
```

You can show the value using say

```
say a
```

and show the structure using say details about or just about

```
say details about a
about a
```

You can use basic flow control with if and while

```
while (a <= 10) do
	say a
	load a + 1 into a
end
```

or 

```
if (d >= e) do
	say d
	about d
end else do
	say e
	about e
end
```

So you can use Parla to explain logic to your students or just for fun, or as an base to your own programming language.

I hope this can be useful to you and if you agree just let me know.

Cheers!

## Buildind

You need build-essentials and bison. Take a look at `makefile`.

