DIR_SRC = ./MyCalendar
SRC = $(wildcard ${DIR_SRC}/*.m)

TARGET = mycal

CC = clang 
CFLAGS = -fno-objc-arc -framework foundation

${TARGET}: ${SRC} 
	${CC} ${CFLAGS} ${SRC} -o ${TARGET}

run:
	${TARGET}

clean:
	rm ${TARGET}