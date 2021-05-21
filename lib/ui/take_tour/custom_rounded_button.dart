import 'package:flutter/material.dart';

class CustomRoundedButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool  iconLeading;
  final Widget loadingIndicator;
  final bool showLoadingIndicator;
  final VoidCallback action;

  const CustomRoundedButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.iconLeading,
    @required this.loadingIndicator,
    @required this.showLoadingIndicator,
    @required this.action
  }) : super(key: key);

  @override
  _CustomRoundedButtonState createState() => _CustomRoundedButtonState();
}

class _CustomRoundedButtonState extends State<CustomRoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: this.widget.action,
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white,
                  width: 3
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              textDirection: this.widget.iconLeading ? TextDirection.ltr : TextDirection.rtl,
              children: [
                SizedBox(
                  height: 30,
                  width: 20,
                  child: Center(
                    child: this.widget.showLoadingIndicator ?
                    SizedBox(height:10, width: 10,child: Center(child: this.widget.loadingIndicator)) :
                    Icon(
                      this.widget.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0, left: 5.0, top: 2.0, right: 5.0),
                  child: Text(
                    this.widget.label,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}