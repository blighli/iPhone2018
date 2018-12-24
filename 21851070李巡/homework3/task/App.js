/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React from 'react';
import { Text, View } from 'react-native';
import { createBottomTabNavigator, createAppContainer, createStackNavigator } from 'react-navigation';
import {ScheduleScreen} from './app/schedule/schedule';
import {StoreScreen} from './app/store/store';
import {AddScreen}  from './app/add/add';

const TabNavigator = createBottomTabNavigator({

    任务: { screen: ScheduleScreen },
    商城: { screen: StoreScreen },
    个人: { screen: AddScreen },
});

export default createAppContainer(TabNavigator);


// export default class Main extends React.Component{
//     render() {
//         return(
//             <AddScreen/>
//         )
//     }
// }
