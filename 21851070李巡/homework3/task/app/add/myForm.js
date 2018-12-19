import React from 'react';
import { View, Text, StyleSheet, Platform, TextInput, Button } from 'react-native';


class FormLine extends React.Component{

    constructor(props) {
        super(props);
    }

    render() {
        return (
            <View style={styles.formLine}>
                <Text style={styles.formLineText}>{this.props.title}</Text>
                <TextInput
                    style={styles.formLineInput}
                    placeholder={this.props.ph}
                />
            </View>
        )
    }
}


export class AddForm extends React.Component{

    render() {
        return (
            <View style={{flexDirection:'column'}}>
                <View>
                    <Text style={styles.formTitle}>添加任务</Text>
                    <View style={styles.formDivide}></View>
                    <FormLine title="任务名" ph="例:跑步10min"/>
                    <FormLine title="奖励" ph="10"/>
                    <Button title="提交"></Button>
                </View>
                <View style={{marginTop:100}}>
                    <Text style={styles.formTitle}>添加商品</Text>
                    <View style={styles.formDivide}></View>
                    <FormLine title="商品名" ph="例:一杯奶茶"/>
                    <FormLine title="消耗" ph="20"/>
                    <Button title="提交"></Button>
                </View>
            
            </View>
        )
    }
}

const formLineHeight = 40;

const styles = StyleSheet.create({

    formTitle: {
        marginTop: 20,
        marginLeft: 10,
        fontSize:20
    },
    formLine: {
        height: formLineHeight,
        flexDirection: 'row',
        marginLeft: 30,
        marginRight: 30
    },
    formLineText: {
        flex: 1,
        lineHeight: formLineHeight
    },
    formLineInput: {
        flex: 3
    },
    formDivide: {
        height: 1,
        marginLeft: 10,
        marginRight: 10,
        marginTop: 5,
        backgroundColor: '#999'
    }
})