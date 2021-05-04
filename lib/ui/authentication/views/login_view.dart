import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/services/validation_service.dart';
import 'package:touring_by/core/viewmodels/login_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/authentication/widgets/app_big_logo.dart';
import 'package:touring_by/ui/authentication/widgets/custom_snackbar.dart';
import 'package:touring_by/ui/authentication/widgets/custom_text_form_field.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData _size = MediaQuery.of(context);

    return ChangeNotifierProvider<LoginModel>(
      create: (context) => locator<LoginModel>(),
      child: Consumer<LoginModel>(
        builder: (context, model, child) {
          return Scaffold(
            //resizeToAvoidBottomInset: false,
            body: Builder(
              builder: (context) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AppBigLogo(
                      width: _size.size.width,
                      height: _size.size.height,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              onSaved: (value) => email = value,
                              labelText: 'Email',
                              obscureText: false,
                              validator: (value) {
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
                            CustomTextFormField(
                              onSaved: (value) => password = value,
                              labelText: 'Password',
                              obscureText: true,
                              validator: (value) {
                                String tmp;
                                tmp = locator<ValidationService>().notEmpty(
                                    value: value,
                                    fieldName: "Password",
                                    shouldTrim: false);
                                return tmp;
                              },
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 30.0),
                              child: ElevatedButton(
                                onPressed: model.state == ViewState.Idle
                                    ? () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          var loginSuccess = await model.login(
                                              email, password);
                                          if (loginSuccess) {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/',
                                                (Route<dynamic> route) =>
                                                    false);
                                          } else {
                                            CustomSnackbar.show(
                                                model.errorMessage, context);
                                          }
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  minimumSize: Size(200, 50),
                                ),
                                child: model.state == ViewState.Busy
                                    ? CustomLoadingIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Login'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Not registered yet?"),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          "Register",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
