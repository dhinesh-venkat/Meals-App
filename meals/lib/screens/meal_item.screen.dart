import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealItemScreen extends StatelessWidget {
  static const routeName = '/meal-item';
  final Function toggleFavorite;
  final Function isFavorite;

  MealItemScreen(this.toggleFavorite,this.isFavorite);

  Widget buildTitle(BuildContext context, String text) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: Theme.of(context).textTheme.headline6));
  }

  Widget buildNotes(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 170,
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    final selectedImage = selectedMeal.imageUrl;

    return Scaffold(
        appBar: AppBar(
          title: Text(mealId),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedImage,
                  fit: BoxFit.cover,
                ),
              ),
              buildTitle(context, 'Ingredients'),
              buildNotes(
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Colors.white,
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildTitle(context, 'Steps'),
              buildNotes(ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child:Icon(
            isFavorite(mealId) ? Icons.star : Icons.star_border
          ),
          onPressed: ()=>toggleFavorite(mealId),
          ),
        );
  }
}
