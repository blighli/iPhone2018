TARGET = cal

CC = clang

CFLAGS = -fobjc-arc -framework foundation

SRC = $(wildcard *.m)

install:

	${CC} ${CFLAGS} ${SRC} -o ${TARGET}




run:

	./${TARGET}




clean:

	rm ${TARGET}
