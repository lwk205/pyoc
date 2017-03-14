OBJS=metlib3.o oclablas.o ocnum.o gtp3.o matsmin.o lmdif1lib.o smp2.o pmon6.o  
EXE=oc4A

all:
	gfortran -o linkoc linkocdate.F90
	./linkoc
	make $(EXE)


metlib3.o:	utilities/metlib3.F90
	gfortran -c -fbounds-check  -finit-local-zero utilities/metlib3.F90

oclablas.o:	numlib/oclablas.F90
	gfortran -c -fbounds-check  -finit-local-zero numlib/oclablas.F90

ocnum.o:	numlib/ocnum.F90
	gfortran -c -fbounds-check  -finit-local-zero numlib/ocnum.F90

lmdif1lib.o:      numlib/lmdif1lib.F90
	gfortran -c -fbounds-check  -finit-local-zero numlib/lmdif1lib.F90  

gtp3.o:	models/gtp3.F90
	gfortran -c -fbounds-check -finit-local-zero models/gtp3.F90

matsmin.o:	minimizer/matsmin.F90
	gfortran -c -fbounds-check  -finit-local-zero minimizer/matsmin.F90

smp2.o:		stepmapplot/smp2.F90
	gfortran -c -fbounds-check  -finit-local-zero stepmapplot/smp2.F90

pmon6.o:	userif/pmon6.F90
	gfortran -c -fbounds-check  -finit-local-zero userif/pmon6.F90

 

$(EXE): 
	make $(OBJS)
# liboceq.a
	ar sq liboceq.a metlib3.o oclablas.o ocnum.o gtp3.o matsmin.o lmdif1lib.o 
# oc4A
	gfortran -o $(EXE) -fbounds-check  pmain1.F90 pmon6.o smp2.o liboceq.a

clean:
	rm -r *.o *.mod linkoc liboceq.a oc4A  
