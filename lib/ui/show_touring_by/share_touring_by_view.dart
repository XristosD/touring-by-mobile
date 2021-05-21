import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/services/validation_service.dart';
import 'package:touring_by/core/viewmodels/share_touring_by_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/authentication/widgets/custom_text_form_field.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class ShareTouringByView extends StatefulWidget {
  @override
  _ShareTouringByViewState createState() => _ShareTouringByViewState();
}

class _ShareTouringByViewState extends State<ShareTouringByView> {
  String email;
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final int touringById = ModalRoute.of(context).settings.arguments as int;
    return MainView(
      body: ChangeNotifierProvider<ShareTouringByModel>(
        create: (context) => locator<ShareTouringByModel>(),
        child: Consumer<ShareTouringByModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Find a user to share by email",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: primaryColor
                          ),
                        )
                      ],
                    ),
                    AnimatedPadding(
                      padding: EdgeInsets.fromLTRB(0.0, model.sharedUserFound ? 10.0 : 120.0, 0.0, model.sharedUserFound ? 120.0 : 10.0),
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: CustomTextFormField(
                              onSaved: (value) => email = value,
                              labelText: 'Email',
                              obscureText: false,
                              validator: (value) {
                                if(model.errorReturned){
                                  return model.errorMessage;
                                }
                                String tmp;
                                tmp = locator<ValidationService>().notEmpty(
                                    value: value,
                                    fieldName: "Email",
                                    shouldTrim: true);
                                if (tmp != null) {
                                  return tmp;
                                }
                                tmp = locator<ValidationService>()
                                    .email(value: value, shouldTrim: true);
                                return tmp;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>( primaryColor ),
                                    foregroundColor: MaterialStateProperty.all<Color>( Colors.white ),
                                    shape: MaterialStateProperty.all<StadiumBorder>(
                                        StadiumBorder(
                                            side: BorderSide(color: primaryColor)
                                        )
                                    )
                                ),
                                onPressed: () async {
                                  print("ok");
                                  print(model.state.toString());
                                  if(model.state == ViewState.Idle){
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      await model.findUserByEmail(email);
                                      if(model.errorReturned){
                                        _formKey.currentState.validate();
                                        _formKey.currentState.save();
                                        model.resetError();
                                      }
                                    }
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "FIND ", style: TextStyle(fontSize: 12.0),
                                    ),
                                    Icon(Icons.search, size: 12.0,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    model.sharedUserFound ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(model.sharedUserName),
                        !model.shareResult ?
                        TextButton(
                            onPressed: () async {
                              bool result = await model.shareTouringByToUser(touringById);
                              if(!result){
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Share didn't complete due to an error"),
                                      duration: Duration(seconds: 3),
                                      action: SnackBarAction(label: "OK", onPressed: (){},),
                                    )
                                );
                              }
                            },
                            child: Text("SHARE", style: TextStyle(fontSize: 10, color: primaryColor),)
                        ) :
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.done , color: primaryColor, size: 10,),
                        )
                      ],
                    ) :
                    Container()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
