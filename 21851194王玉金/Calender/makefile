
DIR_SRC = .
SRC = $(wildcard ${DIR_SRC}/*.m)

TARGET = cal

cc = clang

CFLAGS = -fno-objc-arc -framework foundation

install:${SRC}
	${cc} ${CFLAGS} ${SRC} -o ${TARGET}

clean:
	rm ${TARGET}
