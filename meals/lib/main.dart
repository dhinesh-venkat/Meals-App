import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filters.dart';
import './screens/tabs_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/meal_item.screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeal.indexWhere((element) => element.id == mealId);
    if(existingIndex >=0){
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
      }
    else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
    
  }

  bool isFavorite(String id){
    return _favoriteMeal.any((element) => element.id == id);
  }

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
        }
        );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMeals',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.purple[200],
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ), 
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx)=>TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routeName: (ctx)=> CategoryMealsScreen(_availableMeal),
        MealItemScreen.routeName: (ctx)=> MealItemScreen(_toggleFavorite,isFavorite),
        FiltersScreen.routeName: (ctx)=> FiltersScreen(_filters,_setFilters),
      },
    );
  }
}

