import React,{Component} from 'react';
import { View, Text, TextInput, StyleSheet, Button, Alert, AsyncStorage } from 'react-native';
import { createStackNavigator } from 'react-navigation';
import { TopBar } from '../common/topBar';
import MyData from '../tools/storage';
import { AddForm } from '../add/myForm';
import Icon from 'react-native-vector-icons/FontAwesome';

const inputHeight = 40;


class AddInput extends React.Component{
    constructor(props) {
    super(props);
    this.state = { text: '' };
  }

  render() {
    return (
      <View style={{flexDirection:'row'}}>
        <Text style={{flex:1,height:inputHeight,lineHeight:inputHeight}} >{ this.props.name }</Text>
            <TextInput
              style={{height: 40, borderColor: 'gray', borderWidth: 1,flex:6}}
              onChangeText={(text) => this.setState({text})}
              value={this.state.text}
            />
      </View>
    );
  }
}

class AddSche extends React.Component{

    _onPress = () => {
        Alert('123');
        
    };

  render() {
    return(
      <View>
        <Text>{this.props.name}</Text>
        <AddInput name="任务名" style={styles.addInput}/>
        <AddInput name="奖励" style={styles.addInput}/>
        <Button title="确认添加" onPress={this._onPress}/>
      </View>
    )
  }
}





class TestBtn extends React.Component{
  constructor(props) {
      super(props);
  
      // This binding is necessary to make `this` work in the callback
      this.testAdd = this.testAdd.bind(this);
    }
  testAdd() {

    MyData.addTestTasks();
  }


    render() {
      return (
          <View>
            <Button title="重置任务" style={{marginTop:300}} onPress={this.testAdd} />
          </View>
      );
    }
}

class TestDis extends React.Component{
  constructor(props) {
      super(props);
      // This binding is necessary to make `this` work in the callback
      this.testAdd = this.testAdd.bind(this);
    }
    testAdd() {
      MyData.resetMoney();
    }


    render() {
      return (
          <View>
            <Button title="重置商品" style={{marginTop:300}} onPress={this.testAdd} />
          </View>
      );
    }
}


class PersonInfo extends React.Component{

    constructor(props) {
        super(props);
        this.state = {
            coins: 1234,
            record: "1243"
        }
    }

    componentDidMount = () => {
      MyData.getMoney((result) => {
          this.setState({
            coins:result
          })
      })
    }

    componentWillUpdate(nextProps, nextState) {
      //  Alert.alert("123");
    }
    

    render() {
        return (
            <View style={{}}>
              <Text style={styles.diamond}>
                  {this.state.coins}
                  <Icon name="diamond" size={70} color="#349CEA"  />
              </Text>


            </View>

        )
    }
}

export class AddScreen extends React.Component {

    render() {
      return (
          <View>
            <TopBar name='个人'/>
            <PersonInfo style={styles.diamond}/>
            {/* <AddForm/> */}
          </View>
      );
    }
  }

const styles = StyleSheet.create({
    addScreen: {
      flexDirection: 'column'
    },
    addView: {
      flex: 1
    },
    addInput: {
      height:inputHeight,
      margin:10
    },
    diamond: {
      fontSize: 80,
      lineHeight: 500,
      marginLeft: 120
    }
})
