import React from 'react';
import { FlatList, TouchableOpacity, Text, View, TextInput, StyleSheet, Alert } from 'react-native';
import MyData from '../tools/storage';
import Icon from 'react-native-vector-icons/FontAwesome';


export class ItemList extends React.Component{
    dataContainer = [];

    constructor(props) {
        super(props);

        this.state = {
            sourceData : [],
            selected: (new Map(): Map<String, boolean>)
        }
    }

    componentDidMount() {

        MyData.getItemsArr((result) =>{
            this.dataContainer = result;
            this.setState({
                sourceData: this.dataContainer
            });
        })
    }

    _keyExtractor = (item, index) => index;


    _onPressItem = (id: string) => {
        this.setState((state) => {
            const selected = new Map(state.selected);
            selected.set(id, !selected.get(id));
            return {selected}
        });


        MyData.buyItem(id,()=>{
        })
    };

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

    _renderEmptyView = () => (
        <View><Text>EmptyView</Text></View>
    );

    render() {
        return(
            <FlatList
                style = {styles.container}
                data={ this.state.sourceData }
                extraData={ this.state.selected }
                keyExtractor={ this._keyExtractor }
                renderItem={ this._renderItem }
                ListEmptyComponent={ this._renderEmptyView }
            />
        );
    }
}

class FlatListItem extends React.PureComponent {
    _onPress = () => {
        this.props.onPressItem(this.props.award);
    };

    render() {
        const icon = <Icon name="far fa-gem" size={20} color="#000" />;
        return(
            <TouchableOpacity
                {...this.props}
                onPress={this._onPress}
            >
                <View style = {styles.item}>
                    <View style = {{flexDirection:'row'}}>
                        <Text style={styles.itemTitle}>{this.props.name}</Text>
                        <View style={styles.itemAward}>
                            {/* <Text style={styles.itemAwardText}>+</Text> */}
                            <Text style={styles.itemAwardText}>{this.props.award}</Text>
                            <Icon name="diamond" size={20} color="#349CEA" style={styles.itemAwardText} />
                        </View>
                    </View>
                </View>
            </TouchableOpacity>
        );
    }
}
let itemHeight = 80;
const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    item: {
        height: itemHeight,
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

    },
    itemTitle: {
        flex:5,
        marginLeft:30,
        lineHeight: itemHeight,
        fontSize:18
    },
    itemAward: {
        flex:1,
        flexDirection:'row',
        marginRight: 20
    },
    itemAwardText: {
        flex:1,
        lineHeight: itemHeight,
        fontSize:18
    }
})