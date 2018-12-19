import React from 'react';
import { FlatList, TouchableOpacity, Text, View, TextInput, StyleSheet, Alert } from 'react-native';
import MyData from '../tools/storage';

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    item: {
        height: 80,
        margin: 8,
        borderRadius: 4,
        borderWidth: 1,
        borderColor: '#d6d7da',

        backgroundColor: '#fff',

        elevation: 20,
        shadowOffset: {width: 0, height: 1},
        shadowColor: '#111',
        shadowOpacity: 1,
        shadowRadius: 1

    }
})


export class RecordList extends React.Component{
    // 数据容器，用来存储数据
    dataContainer = [];

    constructor(props) {
        super(props);

        this.state = {
            // 存储数据的状态
            sourceData : [],
            selected: (new Map(): Map<String, boolean>)
        }
    }

    componentDidMount() {
        MyData.getRecords((result)=>{
            this.dataContainer = result;
            this.setState({
                sourceData: this.dataContainer
            })
        });
    }

    _keyExtractor = (item, index) => index;

    _onPressItem = (id: string) => {
        this.setState((state) => {
            const selected = new Map(state.selected);
            selected.set(id, !selected.get(id));
            return {selected}
        });

        Alert.alert(id);
        this.setState((state) => {
            MyData.deleteTask(id,() => {
                MyData.getTasksArr((result) =>{
                        this.dataContainer = result;
                        this.setState({
                            sourceData: this.dataContainer
                    });
            });
        })
        });
        // this.props.onPressItem(id)
    };

    // 加载item布局
    _renderItem = ({item}) =>{
        return(
            <FlatListItem
                id={item.id}
                onPressItem={ this._onPressItem }
                selected={ !!this.state.selected.get(item.id) }
                name = { item.name }
                award={ item.award }
            />
        );
    };

    // 空布局
    _renderEmptyView = () => (
        <View><Text>EmptyView</Text></View>
    );

    render() {
        return(
            <FlatList
                style = {styles.container}
                data={ this.state.sourceData }
                // 实现PureComponent时使用
                extraData={ this.state.selected }
                keyExtractor={ this._keyExtractor }
                renderItem={ this._renderItem }
                ListEmptyComponent={ this._renderEmptyView }
            />
        );
    }
}

// 封装Item组件
class FlatListItem extends React.PureComponent {
    _onPress = () => {
        this.props.onPressItem(this.props.name);
    };

    render() {
        return(
            <TouchableOpacity
                {...this.props}
                onPress={this._onPress}

            >
                <View style = {styles.item}>
                    <View>
                        <Text>{this.props.name}</Text>
                        <Text>{this.props.award}</Text>
                    </View>
                </View>
            </TouchableOpacity>
        );
    }
}