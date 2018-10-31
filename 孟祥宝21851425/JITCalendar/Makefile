##
##	Created by JuicyITer on 18/10/2018.
##	Copyright © 2018 JuicyITer. All rights reserved.
##
#SHELL := /bin/bash
OBJS = main.o JITIn.o JITOut.o JITError.o JITArray.o JITDateComponents.o JITInteger.o JITString.o
CC = clang -O3 -fobjc-arc

#PATH = 
##SCRIPT = source alias.sh && source ~/.bash_profile
#export PATH := $$PATH:$$PWD

jcal : $(OBJS)
	$(CC) -o jcal $(OBJS)
	@sh script.sh

main.o : JITIn.h
$(OBJS) : JITDateComponents.h
main.o JITOut.o :JITArray.h
main.o JITIn.o : JITOut.h JITError.h
main.o JITOut.o JITInteger.o : JITString.h
main.o JITIn.o JITOut.o JITError.o JITArray.o JITString.o : JITInteger.h

.PHONY : clean
clean :
	rm $(OBJS) jcal
