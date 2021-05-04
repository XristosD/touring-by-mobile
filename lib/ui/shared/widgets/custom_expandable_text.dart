import 'package:flutter/material.dart';

class CustomExpandableText extends StatefulWidget {
  final String text;
  final int expandBreakPoint;
  CustomExpandableText({@required this.text, this.expandBreakPoint = 200});

  @override
  _CustomExpandableTextState createState() => _CustomExpandableTextState();
}

class _CustomExpandableTextState extends State<CustomExpandableText> {
  bool _isExpanded;
  bool _expand;
  int _descrLength;

  void initState() {
    super.initState();
    _descrLength = this.widget.text.length;
    _isExpanded = _descrLength > this.widget.expandBreakPoint;
    _expand = false;
  }

  @override
  Widget build(BuildContext context) {
    return  _isExpanded &&  !_expand ?
    GestureDetector(
      child: Text("${this.widget.text.substring(0, this.widget.expandBreakPoint)} ...read more"),
      onTap: () {
        setState(() {_expand = !_expand;});
      },
    ) :
    GestureDetector(
      child: Text("${this.widget.text}"),
      onTap: () {
        setState(() {_expand = !_expand;});
      },
    );
  }
}