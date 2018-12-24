import React,{Component} from 'react';
import { View, Text, StyleSheet, Alert } from 'react-native';
import { createStackNavigator } from 'react-navigation';
import { TopBar } from '../common/topBar';
import { ItemList } from './itemList';

const styles = StyleSheet.create({
    rootView:{
        flex: 1,
    }
})


export class StoreScreen extends React.Component {
    constructor(props) {
        super(props);
        this.onPressItem = this.onPressItem.bind(this)
    }

    onPressItem(message) {
        //Alert.alert("点击了" + message.toString())
    }
    
    render() {
      return (
          <View style={styles.rootView}>
              <TopBar name="商品"></TopBar>
              <ItemList onPressItem =  {this.onPressItem.bind(this)}/>
          </View>
      );
    }
  }
