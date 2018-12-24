import { AsyncStorage, Alert } from 'react-native';

export default class MyData{
    constructor() {
        
    }

    static getTasks(callback) {
        AsyncStorage.getItem('tasks', function (error, result) {
            callback(JSON.parse(result));
        })
    }

    static getTasksArr(callback) {
        AsyncStorage.getItem('tasks', function (error, result) {
            callback(JSON.parse(result).tasks);
        })
    }

    static getTasksStr(callback){
        AsyncStorage.getItem('tasks', function (error, result) {
            callback(result);
        })
    }

    static addTask(task) {
        AsyncStorage.getItem('tasks', function (error, result) {
            let taskList = JSON.parse(result);
            taskList.tasks.push(task);
            AsyncStorage.setItem('tasks', JSON.stringify(taskList), function (error) {
                
            })
        })
    }

    static deleteTask(taskName,callback) {
        AsyncStorage.getItem('tasks', function (error, result) {
            let taskList = JSON.parse(result);
            let index;
            let pay;
            for (let i = 0; i < taskList.tasks.length; i++) {
                let task = taskList.tasks[i];
                if(task.name == taskName){
                    index = i;
                    pay = task.award;
                }   
            }

            taskList.tasks.splice(index,1);
            AsyncStorage.setItem('tasks', JSON.stringify(taskList), function (error) {
                AsyncStorage.getItem('money', function (error, coins) {
                    let money = Number(coins);
                    money += Number(pay);
                    AsyncStorage.setItem('money', money + '', function (error) {
                        Alert.alert("完成任务"+taskName+","+pay+"个钻石get！");
                        callback();
                    })
                })
            })
        })
    }

    static clearTasks(){
        let clearData = {
            tasks: []
        }
        AsyncStorage.setItem('tasks', JSON.stringify(clearData), function (error) {        
        })
    }

    static addTestTasks(){

        let testData = {
            tasks:[
                {name:"早起",award:"10"},
                {name:"看书1小时",award:"30"},
                {name:"背200个单词",award:"50"},
                {name:"跑步30分钟",award:"30"},
            ]
        }

        AsyncStorage.setItem('tasks', JSON.stringify(testData), function (error) {        
        })
    }


    static getItems(callback) {
        AsyncStorage.getItem('items', function (error, result) {
            callback(JSON.parse(result));
        })
    }

    static getItemsArr(callback) {
        AsyncStorage.getItem('items', function (error, result) {
            callback(JSON.parse(result).items);
        })
    }

    static getItemsStr(callback){
        AsyncStorage.getItem('items', function (error, result) {
            callback(result);
        })
    }

    static addItem(item) {
        AsyncStorage.getItem('items', function (error, result) {
            let itemList = JSON.parse(result);
            itemList.tasks.push(item);
            AsyncStorage.setItem('items', JSON.stringify(itemList), function (error) {
                
            })
        })
    }

    static deleteItem(itemName,callback) {
        AsyncStorage.getItem('items', function (error, result) {
            let itemList = JSON.parse(result);
            let index;
            let pay;
            for (let i = 0; i < itemList.items.length; i++) {
                let item = itemList.items[i];
                if(item.name == itemName){
                    index = i;
                    pay = item.award;
                }   
            }

            itemList.items.splice(index,1);
        })
    }

    static clearItems(){
        let clearData = {
            items: []
        }
        AsyncStorage.setItem('items', JSON.stringify(clearData), function (error) {        
        })
    }

    static addTestItems(){

        let testData = {
            items:[
                {name:"奶茶一杯",award:"30"},
                {name:"刷一集剧",award:"100"},
                {name:"看一部电影",award:"150"},
                {name:"偷懒1小时",award:"100"},
            ]
        }

        AsyncStorage.setItem('items', JSON.stringify(testData), function (error) {        
        })
    }

    static getMoney(callback) {
        AsyncStorage.getItem('money', function (error, result) {
            callback(result);
        })
    }

    static resetMoney() {
        AsyncStorage.setItem('money', '0', function (error) {        
        })
    }

    static buyItem(cost,callback) {
        AsyncStorage.getItem('money', function (error, result) {
            let money = result;
            result -= cost
            AsyncStorage.setItem('money', result+'', function (error) {
                Alert.alert("花了"+cost+"个钻石");
                callback();
            })
        })
    }

    static resetRecord() {
        let testData = {
            records: [
            ]
        }
        AsyncStorage.setItem('record', JSON.stringify(testData), function (error) {        
        })
    }

    static addRecord(record,callback) {
        AsyncStorage.getItem('record', function (error, result) {
            let recordList = JSON.parse(result);
            recordList.records.push(record);
            AsyncStorage.setItem('record', JSON.stringify(recordList), function (error) {
                callback();
            })
        })
    }

    static getRecords(callback) {
        AsyncStorage.getItem('record', function (error, result) {
            callback(result.records);
        })
    }
}