import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function setFilters;
  final Map<String,bool> current;
  FiltersScreen(this.current,this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  initState(){
    _glutenFree = widget.current['gluten'];
    _lactoseFree = widget.current['lactose'];
    _vegan = widget.current['vegan'];
    _vegetarian = widget.current['vegetarian'];
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String description, bool currentValue, Function update) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(title: Text('Filters')),
        body: Column(
          children: <Widget>[
            buildSwitchListTile(
                'Gluten Free', 'Show only gluten free meals', _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            buildSwitchListTile(
                'Lactose Free', 'Show only lactose free meals', _lactoseFree,
                (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            buildSwitchListTile('Vegan', 'Show only vegan meals', _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
            buildSwitchListTile(
                'Vegetarian', 'Show only vegetarian meals', _vegetarian,
                (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
          ],
        ),
        floatingActionButton: RaisedButton.icon(
            elevation: 11,
            color: Colors.cyan,
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.setFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
            label: Text('Save filters')));
  }
}
