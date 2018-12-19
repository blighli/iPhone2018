import React from 'react';
import { TouchableOpacity, Text, View, StyleSheet, Button, Alert, TouchableHighlight } from 'react-native';
import { createStackNavigator } from 'react-navigation';

export class TestScreen extends React.Component{
    static navigationOptions = {
        headerTitle: 'Test',
    };

    render() {
        return (
            <View>
                <Text>1234</Text>
            </View>
        );
    }
}

// const MyNavigator = createStackNavigator(
//   {
//     Schedule: ScheduleScreen,
//     Test: TestScreen,
//     Store: StoreScreen
//   }
// );