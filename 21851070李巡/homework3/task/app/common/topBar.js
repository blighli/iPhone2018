import React from 'react';
import { View, Text, StyleSheet, Platform } from 'react-native';
import { MenuBtn, NoMenuBtn } from './menuBtn';

const barHeight = 50;

const styles = StyleSheet.create({
    bar: {
        marginTop: 20,
        height: barHeight,
        backgroundColor: '#fff',
        flexDirection: 'row',
        justifyContent: 'space-between',

        elevation: 20,
        shadowOffset: {width: 0, height: 1},
        shadowColor: '#111',
        shadowOpacity: 1,
        shadowRadius: 1
    },
    title: {
        height: barHeight,
        width: 100,
        textAlign: 'center',
        fontSize: 20,
        ...Platform.select({
            ios:{
                lineHeight:barHeight,
            },
            android:{
            }
        }),
    }
});

export class TopBar extends React.Component{
    render() {
        
        return(
            <View style = { styles.bar }>
                <NoMenuBtn />
                <Text style = { styles.title }>{this.props.name}</Text>
                <MenuBtn />
            </View>
        )
    }
}