import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class RateDialog extends StatefulWidget {
  final VoidCallback onCloseDialog;
  final Function(double rate) onSaveDialog;
  const RateDialog({
    this.onSaveDialog,
    this.onCloseDialog,
    Key key,
  }) : super(key: key);

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  bool _isRating = false;
  double _rating = 1.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: primaryColor,
                    size: 25.0,
                  ),
                  onPressed: this.widget.onCloseDialog,
                ),
                padding: EdgeInsets.all(5.0),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3.0,
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RatingBar.builder(
                              initialRating: 1,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: primaryColor,
                              ),
                              onRatingUpdate: (rating) {
                                _rating = rating;
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 0,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            color: Colors.white,
                            child: Text(
                              "Did you enjoy the tour?",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isRating = true;
                            });
                            this.widget.onSaveDialog(_rating);
                          },
                          child: _isRating ? CustomLoadingIndicator() : Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: primaryColor,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}