SRC = ./
OBJECTS = $(wildcard ${SRC}*.m)


TARGET = mycal

CFLAGS = -framework Foundation

$(TARGET) : $(OBJECTS)
	cc -o $(TARGET) $(OBJECTS) $(CFLAGS)

run :
	./$(TARGET)

test :
	./$(TARGET) && ./$(TARGET) 2018 && ./$(TARGET) 5 2018 && ./$(TARGET) -m 8 && ./$(TARGET) -2 2018

.PHONY : clean
clean :
	-rm $(TARGET)
