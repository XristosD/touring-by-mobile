import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/services/validation_service.dart';
import 'package:touring_by/core/viewmodels/register_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/authentication/widgets/app_big_logo.dart';
import 'package:touring_by/ui/authentication/widgets/custom_snackbar.dart';
import 'package:touring_by/ui/authentication/widgets/custom_text_form_field.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String name;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _size = MediaQuery.of(context);

    return ChangeNotifierProvider<RegisterModel>(
      create: (context) => locator<RegisterModel>(),
      child: Consumer<RegisterModel>(
        builder: (context, model, child) {
          return Scaffold(
            //resizeToAvoidBottomInset: false,
            body: Builder(
              builder: (context) => Stack(
                children: [
                  SingleChildScrollView(
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
                                  onSaved: (value) => name = value,
                                  labelText: 'Name',
                                  obscureText: false,
                                  validator: (value) {
                                    String tmp;
                                    tmp = locator<ValidationService>().notEmpty(
                                        value: value,
                                        fieldName: "Name",
                                        shouldTrim: true);
                                    return tmp;
                                  },
                                ),
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
                                  controller: passwordController,
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
                                CustomTextFormField(
                                  onSaved: null,
                                  labelText: 'Repeat password',
                                  obscureText: true,
                                  validator: (value) {
                                    String tmp;
                                    tmp = locator<ValidationService>().notEmpty(
                                        value: value,
                                        fieldName: "Password",
                                        shouldTrim: false);
                                    if (tmp != null) {
                                      return tmp;
                                    }
                                    tmp = locator<ValidationService>().equals(
                                        value: value,
                                        shouldTrim: false,
                                        fieldName: 'Repeat password',
                                        equalsController: passwordController,
                                        equalsFieldName: 'password');
                                    return tmp;
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: ElevatedButton(
                                    onPressed: model.state == ViewState.Idle
                                        ? () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              var registerSuccess =
                                                  await model.register(
                                                      name, email, password);
                                              if (registerSuccess) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              } else {
                                                CustomSnackbar.show(
                                                    model.errorMessage,
                                                    context);
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
                                        : Text('Register'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                      child: BackButton(
                    color: primaryColor,
                    // onPressed: () => Navigator.pop(context),
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
