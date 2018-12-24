import React from 'react';
import { TouchableOpacity, Text, View, StyleSheet, Button, Alert, TouchableHighlight } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';

const styles = StyleSheet.create({
    menuBtn: {
        width: 50,
    },
    press: {
        flex: 1,
    },
    content: {
        justifyContent: 'center',
    }
})

export class NoMenuBtn extends React.Component{
    render() {
        return(
            <View style = { styles.menuBtn }>
            </View>
        )
    }
}

export class MenuBtn extends React.Component{

    constructor(props) {
        super(props);
        
    }
    

    _onPressButton() {
    }


    render() {
        const addIcon = <Icon name="plus" size={30} color="#000" style={{height:50,marginLeft:20,marginTop:10}}/>;
        return (
            <View style = { styles.menuBtn }>
                <TouchableHighlight
                style = { styles.press }
                onPress = { () => this.props.navigation.navigate('Test')}>
                    <View style = { styles.content }>
                        { addIcon }
                    </View>
                </TouchableHighlight>
            </View>
        )
    }


}





