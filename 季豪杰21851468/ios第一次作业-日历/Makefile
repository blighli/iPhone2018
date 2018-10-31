objects = main.o GetYearAndMonthOfToday.o Judge.o
cal : $(objects)
	cc -o cal $(objects) -framework Foundation
main.o : GetYearAndMonthOfToday.h Judge.h
GetYearAndMonthOfToday.o : GetYearAndMonthOfToday.h
Judge.o : Judge.h
.PHONY : clean
clean :
	-rm cal $(objects)
