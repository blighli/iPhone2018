cc = gcc
prom = myCal
source = ./cal/main.m ./cal/Date.m ./cal/Cal.m

$(prom):$(source)
	$(cc) -framework Foundation -o $(prom) $(source);

clean:
	rm $(prom)