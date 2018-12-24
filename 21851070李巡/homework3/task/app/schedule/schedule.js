import React from 'react';
import { FlatList, TouchableOpacity, Text, View, TextInput, StyleSheet, Button, Alert } from 'react-native';
import { createStackNavigator } from 'react-navigation';
import { TopBar }  from '../common/topBar';
import { ScheList } from './scheList';


const styles = StyleSheet.create({
    rootView:{
        flex: 1,
    }
})

export class ScheduleScreen extends React.Component{
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
                <TopBar name="任务"></TopBar>
                <ScheList onPressItem =  {this.onPressItem.bind(this)}/>
            </View>
        );
    }
}
