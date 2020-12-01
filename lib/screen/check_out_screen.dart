import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CheckOutScreen> {
  int _currentStep = 0;
  String _currentPaymentMethod = PaymentMethod.cod;
  String _currentBankName = BankName.aba;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final stepper = Stepper(
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Row(
            children: [
              FlatButton(onPressed: onStepCancel, child: Text('Back')),
              RaisedButton(
                onPressed: onStepContinue,
                child: Text('Next'),
              )
            ],
          );
        },
        onStepContinue: () {
          setState(() {
            if (_currentStep < 2) {
              _currentStep++;
            } else {}
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep--;
            }
          });
        },
        currentStep: _currentStep,
        type: StepperType.horizontal,
        steps: [
          Step(
              isActive: (_currentStep == 0),
              title: Text('Delivery'),
              content: _deliveryContentWidget(context)),
          Step(
              isActive: (_currentStep == 1),
              title: Text('Address'),
              content: _addressContentWidget(context)),
          Step(
              isActive: (_currentStep == 2),
              title: Text('Payments'),
              content: _paymentsContentWidget(context))
        ]);

    return Theme(
        data: ThemeData(accentColor: Colors.blueAccent), child: stepper);
  }

  Widget _deliveryContentWidget(BuildContext context) {
    return Text('Delivery Content');
  }

  Widget _addressContentWidget(BuildContext context) {
    return Text('Address Content');
  }

  Widget _paymentsContentWidget(BuildContext context) {
    final paymentMethodsWidget = Row(
      children: [
        _paymentItemWidget(Icons.money, PaymentMethod.cod),
        _paymentItemWidget(Icons.comment_bank, PaymentMethod.bankTransfers),
        _paymentItemWidget(
            Icons.wallet_membership, PaymentMethod.transferAgents),
      ],
    );

    List<Widget> columnChildren = [paymentMethodsWidget];
    if (_currentPaymentMethod == PaymentMethod.cod) {
      columnChildren.add(_codContentWidget());
    } else if (_currentPaymentMethod == PaymentMethod.bankTransfers) {
      columnChildren.add(_bankTransfersContentWidget());
      columnChildren.add(_bankInfoWidget());
    } else {
      columnChildren.add(_transferAgentContentWidget());
    }

    return Column(
      children: columnChildren,
    );
  }

  Widget _codContentWidget() {
    return Text('COD');
  }

  Widget _bankTransfersContentWidget() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bankItemWidget(BankName.aba),
          SizedBox(
            width: 16,
          ),
          _bankItemWidget(BankName.acleda),
        ],
      ),
    );
  }

  Widget _transferAgentContentWidget() {
    return Text('Agent');
  }

  Widget _paymentItemWidget(IconData iconData, String title) {
    final color =
        (title == _currentPaymentMethod) ? Colors.orange : Colors.white;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentPaymentMethod = title;
          });
        },
        child: Card(
          color: color,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Icon(iconData),
                SizedBox(
                  height: 16,
                ),
                Text(title)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bankItemWidget(String bankName) {
    final color =
        (bankName == _currentBankName) ? Colors.orange : Colors.transparent;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentBankName = bankName;
        });
      },
      child: Column(
        children: [
          Image.asset('images/$bankName.png', width: 54, height: 54),
          Container(
            margin: EdgeInsets.only(top: 4),
            width: 54,
            height: 4,
            color: color,
          )
        ],
      ),
    );
  }

  Widget _bankInfoWidget() {
    final accountNumber =
        (_currentBankName == BankName.aba) ? '123456789' : '987654321';
    return Column(
      children: [
        Text('Account name: Sok Sao'),
        Text('Account number: $accountNumber')
      ],
    );
  }
}

class PaymentMethod {
  static const String cod = 'COD';
  static const String bankTransfers = 'Bank Transfers';
  static const String transferAgents = 'Transfer Agents';
}

class BankName {
  static const String aba = 'ABA';
  static const String acleda = 'ACLeda';
}
