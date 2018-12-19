import React from 'react';
import { Text, View } from 'react-native';
import { createBottomTabNavigator, createAppContainer, createStackNavigator } from 'react-navigation';
import {ScheduleScreen} from './app/schedule/schedule';
import {StoreScreen} from './app/store/store';
import {TestScreen} from './app/schedule/test';

const MyNavigator = createStackNavigator(
  {
    Schedule: ScheduleScreen,
    Test: TestScreen,
    Store: StoreScreen
  }
);

export default class Navig extends React.Component {
  render() {
    return <MyNavigator />;
  }
}