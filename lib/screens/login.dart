import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';

// Utilities
import 'package:jantari/utils/size_config.dart';
import 'package:jantari/widgets/c_button.dart';

// BLoCs
import 'package:jantari/bloc/auth/bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController(text: "lo@kmbl.com");
  final _passwordController = TextEditingController(text: "Kmbl@123");
  // final _usernameController = TextEditingController(text: "muskan.faheem25@gmail.com");
  // final _passwordController = TextEditingController(text: "New@1234");
  // final _usernameController = TextEditingController(text: "wajiha.umar@unikrew.com");
  // final _passwordController = TextEditingController(text: "New@12345");
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  String hashPassword(String value) {
    var bytes = utf8.encode(value);
    var hash = sha256.convert(bytes);
    return base64.encode(hash.bytes);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          /*This method here will hide the soft keyboard.*/
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: SizeConfig.resizeWidth(5.7)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/logo.jpg", width: 200),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            key: const Key('LoginForm_Username'),
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: 'Username',
                                hintStyle: TextStyle(fontSize: 16),
                                filled: true,
                                contentPadding: EdgeInsets.all(16)
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            key: const Key('LoginForm_Password'),
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(fontSize: 16),
                                filled: true,
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                              suffixIcon: IconButton(
                                icon: hidePassword
                                    ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(
                                        () {
                                      hidePassword = !hidePassword;
                                    },
                                  );
                                },
                              )
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "Forgot your credentials?",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.resizeWidth(3.6),
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is LoginStateLoaded) {
                                context.read<AuthBloc>().add(FetchUser(
                                  state.authStateModel.loginResponse?.userCode ?? ""
                                ));
                              }
                              if(state is userStateLoaded) {
                                context.read<AuthBloc>().add(FetchGroupDetail(
                                    state.authStateModel.userDetail?.groupCodes ?? []
                                ));
                              }
                              if(state is groupStateLoaded) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/products', (route) => false);
                              }
                            },
                            builder: (context, state) {
                              if (state is LoginStateLoading || state is userStateLoading || state is groupStateLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return CButton(
                                  text: "Login",
                                  lightTheme: false,
                                  onPressed: () {
                                    context.read<AuthBloc>().add(LoginSubmitted(
                                      _usernameController.text,
                                      hashPassword(_passwordController.text),
                                    ));
                                  },
                                );
                              }
                            },

                          )
                        ],
                      ),
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
