#define C(X,Y) X ## Y
#define S(X) SS(X)
#define SS(X) # X
#define M(X,Y) S(C(X,Y))

char* a=M(HELLO,KITTY);

#

#define VOO 42
#define F(X) #X[X]

F(33)
F(VOO)
F(C(VOO,VOO))


# 1 "hello"



#define f(a,b,c) {a,b,c}
f(
#define aa 1
#define bb 2
#define cc 3
  aa,
#if 0
  )
#endif
  bb,
#undef cc
  cc)
