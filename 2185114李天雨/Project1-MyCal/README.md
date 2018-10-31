# MyCal

开发macOS下的cal命令

＃使用说明

```
mycal [[month] year]
my [-m moth] [year]
mycal [-n year] n in range (1...12)
```


- 编译

 make

- 测试

 make test
 
 包括:
 ```
./mycal   //输出当前月份的日历
./mycal 2018  //输出2018年全年的日历 默认每行输出3个月份
./mycal 5 2018  //输出2018年5月的日历
./mycal -m 8    //输出当前年份8月的日历 
./mycal -2 2018  //输出2018年全年的日历 设置每行输出2个月份
```

- 运行

 make run

- 卸载

 make clean
