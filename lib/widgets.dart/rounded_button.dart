import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double paddingVertical;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.paddingVertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: Material(
        elevation: 5.0,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: Text(
            text,
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
