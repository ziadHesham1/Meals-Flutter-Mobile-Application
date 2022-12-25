import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = '/mealDetailRoute';

  final Function _toggleFavorite;
  final Function _isFavorite;

  const MealDetailScreen(this._toggleFavorite, this._isFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    // retrieving the selected meal id
    var mealId = ModalRoute.of(context)!.settings.arguments as String;
    // getting the meal with the received id
    var selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    //  the appbar stored in a var to get its height
    var mealDetailAppBar = AppBar(
      title: Text(selectedMeal.title),
    );
    //  the media query with its context bec its used more the one time
    var mediaQuery = MediaQuery.of(context);
    // getting the body height to calculate the lists containers height
    var bodyHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mealDetailAppBar.preferredSize.height;

    // getting the body height to calculate the lists containers width
    var bodyWidth = mediaQuery.size.width;

    // the ingredient ListView to make the body code cleaner
    var ingredientListView = ListView.builder(
      itemCount: selectedMeal.ingredients.length,
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10,
            ),
            child: Text(
              selectedMeal.ingredients[index],
            ),
          ),
        );
      },
    );
    // the steps ListView to make the body code cleaner
    var stepsListView = ListView.builder(
      itemCount: selectedMeal.steps.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  '# ${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                selectedMeal.steps[index],
              ),
            ),
            const Divider(),
          ],
        );
      },
    );

    /* the container that contains the ingredient and steps ListViews
    because it was written two times with same decorations */
    Container buildContainer(double h, double w, Widget child) {
      return Container(
        // decoration
        height: h,
        width: w,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        // list content
        child: child,
      );
    }

    /* the titles of the ingredient and steps lists
    because it was written two times with same decorations */
    Widget buildTitleWidget(BuildContext context, title) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }

    return Scaffold(
      appBar: mealDetailAppBar,
      /* wrapping the body column with SingleChildScrollView 
      because its height is larger than the available */
      body: SingleChildScrollView(
        child: Column(
          children: [
            // the image
            SizedBox(
              height: bodyHeight * 0.3,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // ingredients title
            buildTitleWidget(context, 'Ingredients'),
            // ingredients list
            buildContainer(
                bodyHeight * 0.3, bodyWidth * 0.75, ingredientListView),
            // steps title
            buildTitleWidget(context, 'Steps'),
            // steps list
            buildContainer(bodyHeight * 0.3, bodyWidth * 0.75, stepsListView),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleFavorite(mealId);
        },
        child: Icon(_isFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
