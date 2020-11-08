import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final topIconsWidget = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    IconButton(
      icon: Icon(Icons.message),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {},
    )
  ],
);
final searchWidget = Row(
  children: [
    Flexible(
      child: TextField(
        decoration: InputDecoration(hintText: 'Search for products'),
      ),
    ),
    SizedBox(
      width: 16,
    ),
    FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.camera_alt),
      backgroundColor: Colors.orange,
    ),
  ],
);

final slideShowWidget = Image.asset('images/ite_banner.jpg');

final categoriesListView = SizedBox(
  height: 120,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
      categoryItemWidget(FontAwesomeIcons.book, 'Book'),
      categoryItemWidget(FontAwesomeIcons.elementor, 'Electronic'),
      categoryItemWidget(FontAwesomeIcons.accessibleIcon, 'Kitchens'),
      categoryItemWidget(FontAwesomeIcons.creativeCommonsNcEu, 'Cosmetics'),
      categoryItemWidget(FontAwesomeIcons.bicycle, 'Vehicle'),
    ],
  ),
);

final thisWeekDealTitleWidget = Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('This week\'s deals', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('See all')
  ],
);

final thisWeekDealContentWidget = Row(
  children: [
    Expanded(
        child: Container(
      height: 200,
      color: Colors.grey,
    )),
    Expanded(
        child: Container(
      height: 200,
      color: Colors.blue,
    )),
  ],
);

final body = Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topIconsWidget,
        searchWidget,
        SizedBox(
          height: 16,
        ),
        slideShowWidget,
        SizedBox(
          height: 16,
        ),
        Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        categoriesListView,
        thisWeekDealTitleWidget,
        thisWeekDealContentWidget
      ],
    )));

final bottomNavBar = BottomNavigationBar(items: [
  BottomNavigationBarItem(
      icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.blue),
  BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
  BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
  BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
]);

final homeScreen = Scaffold(
  body: body,
  bottomNavigationBar: bottomNavBar,
);

final app = MaterialApp(
  home: homeScreen,
);

void main() {
  runApp(app);
}

Widget categoryItemWidget(IconData iconData, String name) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            iconData,
            color: Colors.orange,
          ),
        ),
        Text(name)
      ],
    ),
  );
}
