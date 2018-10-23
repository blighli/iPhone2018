cc -c main.m
cc -c MonthCalendar.m
cc MonthCalendar.o main.o -framework Foundation
./a.out cal
./a.out cal -m 10
./a.out cal 10 2018
./a.out cal 2018