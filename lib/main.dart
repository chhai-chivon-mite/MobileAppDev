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

final thisWeekDealTitleWidget = sectionTitleWidget('This week\'s deals');

final thisWeekDealContentWidget = productsRowWidget(
    productItemWidget('BeoPlay Speaker', 'Bang and Olufsen', 755),
    productItemWidget('Leather Wristwatch', 'Tag Heuer', 450));

final bestSellingTitleWidget = sectionTitleWidget('Best Selling');

final bestSellingContentWidget = productsRowWidget(
    productItemWidget('BeoPlay Speaker 2', 'Bang and Olufsen 2', 555),
    productItemWidget('Leather Wristwatch 2', 'Tag Heuer 2', 444));

final body = Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SafeArea(
        child: ListView(
      children: [
        topIconsWidget,
        searchWidget,
        verticalMargin(16),
        slideShowWidget,
        verticalMargin(16),
        Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        categoriesListView,
        thisWeekDealTitleWidget,
        verticalMargin(16),
        thisWeekDealContentWidget,
        verticalMargin(16),
        bestSellingTitleWidget,
        verticalMargin(16),
        bestSellingContentWidget
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

final productHorizontalListView = ListView(
  scrollDirection: Axis.horizontal,
  children: [
    horizontalListItemWidget('Tag Heuer', 1100),
    horizontalListItemWidget('BeoPlay Speaker', 450),
    horizontalListItemWidget('Electric Kettle', 95),
    horizontalListItemWidget('ABC', 123),
  ],
);

final summaryContentWidget = ListView(
  children: [
    Container(
      height: 180,
      child: productHorizontalListView,
    ),
    Divider(),
    labelAndValueWidget('Subtotal', 3950),
    labelAndValueWidget('Discount', 50),
    labelAndValueWidget('Shipping', 1.5),
    Divider(),
    labelAndValueWidget('Total', 5000, valueColor: Colors.orange),
    Divider(),
    summarySectionTitleWidget('Shipping Address'),
    ListTile(
        title: Text(
            '#123, laksjdf lksdjfk jsdkjfs lkfjslkfjsa dfkjsfklj sldkjfsl kfjsdlkf jsdlkf sadlf jsdlk fjsdfj sdfsdf sdf sdf'),
        trailing: Icon(Icons.check_circle, color: Colors.orange)),
    Wrap(
      children: [
        FlatButton(
            onPressed: () {}, child: Text('Change'), textColor: Colors.orange)
      ],
    ),
    Divider(),
    summarySectionTitleWidget('Payment'),
    ListTile(
        leading: Icon(Icons.account_balance),
        title: Text('ABA Bank'),
        subtitle: Text('000000000'),
        trailing: Icon(Icons.check_circle, color: Colors.orange)),
    Wrap(
      children: [
        FlatButton(
            onPressed: () {}, child: Text('Change'), textColor: Colors.orange)
      ],
    ),
  ],
);
final actionButtonsWidget = Row(
  children: [
    Expanded(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {},
        child: Text('Back'),
        color: Colors.white,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.orange)),
      ),
    )),
    Expanded(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
          onPressed: () {},
          child: Text(
            'Buy',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.orange),
    ))
  ],
);

final checkOutSummaryBody = Column(
  children: [
    Expanded(child: summaryContentWidget),
    SafeArea(child: actionButtonsWidget)
  ],
);

final checkOutSummaryScreen = Scaffold(
  appBar: AppBar(
    title: Text('Summary', style: TextStyle(color: Colors.black)),
    backgroundColor: Colors.white,
  ),
  body: checkOutSummaryBody,
);

final app = MaterialApp(
  home: checkOutSummaryScreen,
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

Widget verticalMargin(double value) {
  return SizedBox(
    height: value,
  );
}

Widget horizontalMargin(double value) {
  return SizedBox(
    width: value,
  );
}

Widget productItemWidget(String title, String brand, double price) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset('images/ite_banner.jpg', height: 140),
      Text(title, textAlign: TextAlign.left),
      Text(brand),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('\$$price'), Icon(Icons.star)],
      )
    ],
  );
}

Widget sectionTitleWidget(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      Text('See all')
    ],
  );
}

Widget productsRowWidget(Widget p1, Widget p2) {
  return Row(
    children: [
      Expanded(
          child: Container(
        height: 200,
        child: p1,
      )),
      horizontalMargin(16),
      Expanded(child: Container(height: 200, child: p2)),
    ],
  );
}

Widget labelAndValueWidget(String label, double value, {Color valueColor}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        Text(label),
        Spacer(),
        Text(
          '\$$value',
          style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
        )
      ],
    ),
  );
  /*return ListTile(
    title: Text(label),
    trailing: Text(
      '\$$value',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );*/
}

Widget summarySectionTitleWidget(String title) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget horizontalListItemWidget(String title, double price) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Image.asset(
          'images/ite_banner.jpg',
          height: 100,
          width: 100,
        ),
        Text(title),
        Text('\$$price', style: TextStyle(color: Colors.orange)),
      ],
    ),
  );
}
