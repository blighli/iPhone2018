# Project 1

## Build
```Shell
$ make
```
## Usage
```Shell
# 输出 当月月历
$ ./myCal
# 输出 当年该月月历
$ ./myCal -m <month>
# 输出 该年该月月历
$ ./myCal <month> <year>
# 输出 该年年历
$ ./myCal <year>
```

## Example
当月月历
```Shell
$ ./myCal
```
![example-1](http://img.daixinye.com/20181023163826.png?imageMogr2/thumbnail/x150)

当年该月月历
```Shell
$ ./myCal -m 10
```
![example-2](http://img.daixinye.com/20181023164207.png?imageMogr2/thumbnail/x150)

该年该月月历
```Shell
$ ./myCal 10 2018
```
![example-3](http://img.daixinye.com/20181023164303.png?imageMogr2/thumbnail/x150)

该年年历
```Shell
$ ./myCal 2018
```
![example-4](http://img.daixinye.com/20181023165251.png?imageMogr2/thumbnail/500x)

## Error Handling
### Illegal Option
```Shell
$ ./myCal -x
```
![illegal option](http://img.daixinye.com/20181023170109.png?imageMogr2/thumbnail/x30)

### Invalid Month
```Shell
$ ./myCal -m 13
```
![invalid month](http://img.daixinye.com/20181023170411.png?imageMogr2/thumbnail/x30)

### Invalid Year
```Shell
$ ./myCal 10 99999
```
![invalid year](http://img.daixinye.com/20181023170614.png?imageMogr2/thumbnail/x30)


