import 'package:flutter/material.dart';

class CheckOutSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: checkOutSummaryBody,
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

}