ROOT=Project1

all: 
	clang++ ./${ROOT}/*.m -o ./cal -framework Foundation
	@echo "Usage:"
	@echo "  Command:"
	@echo "    cal"
	@echo "    cal -m [month]"
	@echo "    cal [month] [year]"
	@echo "    cal [year]"
	@echo "  Constraint:"
	@echo "    year: a positive integer"
	@echo "    month: an integer between 1 and 12"


clean:
	rm ./cal
