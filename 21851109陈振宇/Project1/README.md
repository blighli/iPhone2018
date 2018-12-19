# 使用object-c实现cal命令
## 具体功能
- 运行cal，输出当月的月历
- 运行cal [month] [year]，输出year.month的月历
- 运行cal -m [month]，输出当年month的月历
- 运行cal [year]，输出year的月历
## 输入约束
- year: 一个正整数
- month: 一个介于1和12之间的整数
## 如何使用
### 打开终端进入当前目录，执行编译命令
```
$ make
clang++ ./Project1/*.m -o ./cal -framework Foundation
Usage:
  Command:
    cal
    cal -m [month]
    cal [month] [year]
    cal [year]
  Constraint:
    year: a positive integer
    month: an integer between 1 and 12
```
### 执行删除命令
```
$ make clean
rm ./cal
```
## 功能测试
- 运行cal，输出当月的月历。
```
$ ./cal
    October  2018
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31
```
- 运行cal [month] [year]，输出year.month的月历
```
$ ./cal 10 2008
    October  2008
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31
```
- 运行cal -m [month]，输出当年month的月历
```
$ ./cal -m 8
    August   2018
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31 
```
- 运行cal [year]，输出year的月历
```
$ ./cal 2008
                               2008

       January               Fabruary                 March       
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
       1  2  3  4  5                   1  2                      1
 6  7  8  9 10 11 12    3  4  5  6  7  8  9    2  3  4  5  6  7  8
13 14 15 16 17 18 19   10 11 12 13 14 15 16    9 10 11 12 13 14 15
20 21 22 23 24 25 26   17 18 19 20 21 22 23   16 17 18 19 20 21 22
27 28 29 30 31         24 25 26 27 28 29      23 24 25 26 27 28 29
                                              30 31               

        April                   May                   June        
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
       1  2  3  4  5                1  2  3    1  2  3  4  5  6  7
 6  7  8  9 10 11 12    4  5  6  7  8  9 10    8  9 10 11 12 13 14
13 14 15 16 17 18 19   11 12 13 14 15 16 17   15 16 17 18 19 20 21
20 21 22 23 24 25 26   18 19 20 21 22 23 24   22 23 24 25 26 27 28
27 28 29 30            25 26 27 28 29 30 31   29 30               

        July                  August                September     
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
       1  2  3  4  5                   1  2       1  2  3  4  5  6
 6  7  8  9 10 11 12    3  4  5  6  7  8  9    7  8  9 10 11 12 13
13 14 15 16 17 18 19   10 11 12 13 14 15 16   14 15 16 17 18 19 20
20 21 22 23 24 25 26   17 18 19 20 21 22 23   21 22 23 24 25 26 27
27 28 29 30 31         24 25 26 27 28 29 30   28 29 30            
                       31                                         

       October               November               December      
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
          1  2  3  4                      1       1  2  3  4  5  6
 5  6  7  8  9 10 11    2  3  4  5  6  7  8    7  8  9 10 11 12 13
12 13 14 15 16 17 18    9 10 11 12 13 14 15   14 15 16 17 18 19 20
19 20 21 22 23 24 25   16 17 18 19 20 21 22   21 22 23 24 25 26 27
26 27 28 29 30 31      23 24 25 26 27 28 29   28 29 30 31         
                       30                                      
```
### 约束检测
- 第二个参数不是“-m”
```
$ ./cal -l 10
Invalid month or second option is not "-m".
Usage:
  Command:
    cal
    cal -m [month]
    cal [month] [year]
    cal [year]
  Constraint:
    year: a positive integer
    month: an integer between 1 and 12
```
- 月份不合法
```
$ ./cal -m 0
Invalid month or second option is not "-m".
Usage:
  Command:
    cal
    cal -m [month]
    cal [month] [year]
    cal [year]
  Constraint:
    year: a positive integer
    month: an integer between 1 and 12
```
- 年份不合法
```
$ ./cal 0
Invalid year.
Usage:
  Command:
    cal
    cal -m [month]
    cal [month] [year]
    cal [year]
  Constraint:
    year: a positive integer
    month: an integer between 1 and 12
```
