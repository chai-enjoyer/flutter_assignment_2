import 'package:flutter/material.dart';
import 'components/theme_button.dart';
import 'components/color_button.dart';
import 'constants.dart';

import 'components/category_card.dart';
import 'models/food_category.dart';

import 'components/post_card.dart';
import 'models/post.dart';

import 'components/restaurant_landscape_card.dart';
import 'models/restaurant.dart';


class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
  });
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int tab = 0;

  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.category_rounded),
      label: 'Category',
      selectedIcon: Icon(Icons.category_rounded),
    ),
    NavigationDestination(
      icon: Icon(Icons.post_add_rounded),
      label: 'Post',
      selectedIcon: Icon(Icons.post_add_rounded),
    ),
    NavigationDestination(
      icon : Icon(Icons.restaurant_rounded),
      label: 'Restaurant',
      selectedIcon: Icon(Icons.restaurant_rounded),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final pages = [
      // 1
      SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
              MediaQuery.of(context)
              .size.height - kToolbarHeight - kBottomNavigationBarHeight,
          ),
          child: Column(
            children: categories.map((category) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: CategoryCard(category: category),
                ),
              ),
            )).toList(),
          ),
        ),
      ),
      // Center(
      //   // 2
      //   child: ConstrainedBox(
      //     constraints: const BoxConstraints(maxWidth: 300),
      //     // 3
      //     child: CategoryCard(category: categories[0]),
      //   ),
      // ),

      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: posts.map((post) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: PostCard(post: post),
              )).toList(),
            ),
          ),
        ),
      ),
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: PostCard(post: posts[0]),
      //   ),
      // ),
      //1
      SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
              MediaQuery.of(context)
              .size.height - kToolbarHeight - kBottomNavigationBarHeight,
          ),
          child: Column(
            children: restaurants.map((restaurant) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: RestaurantLandscapeCard(restaurant: restaurant),
                ),
              ),
            )).toList(),
          ),
        ),
      ),
      // Center(
      //   //2
      //   child: ConstrainedBox(
      //     constraints: const BoxConstraints(
      //       maxWidth: 400
      //     ),
      //     //3
      //     child: RestaurantLandscapeCard(
      //       restaurant: restaurants[0]
      //     ),
      //   ),
      // )
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor:
        Theme.of(context).colorScheme.background,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),

          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),

      body: IndexedStack(
        index: tab,
        children: pages,
      ),

      // 1
      bottomNavigationBar: NavigationBar(
        // 2
        selectedIndex: tab,
        // 3
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        // 4
        destinations: appBarDestinations,
      ),
    );
  }
}
