import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final Function onPressedFunction;
  CommonButton(this.label, this.onPressedFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50.0,
            margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment(0.9, 0.0),
                colors: [Colors.purple[900], Colors.purple],
              ),
              borderRadius: new BorderRadius.circular(18.0),
            ),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              onPressed: onPressedFunction,
              textColor: Colors.white,
              color: Colors.transparent,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
