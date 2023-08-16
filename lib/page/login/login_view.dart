import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/domain/models/user.dart';
import 'package:discuss_app/domain/session.dart';
import 'package:discuss_app/domain/usecases/user_source.dart';
import 'package:discuss_app/page/app_route.dart';
import 'package:discuss_app/page/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) {
    UserSource.login(controllerUsername.text, controllerPassword.text).then(
      (responseBody) {
        if (responseBody['success']) {
          var mapUser = Map<String, dynamic>.from(responseBody['data']);
          User user = User.fromJson(mapUser);
          Session.setUser(user);
          context.read<CUser>().data = user;
          DInfo.dialogSuccess(context, 'Login Success');
          DInfo.closeDialog(context, actionAfterClose: () {
            // context.go(AppRoute.home);
          });
        } else {
          DInfo.snackBarError(context, 'Login Failed');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.purple,
            ],
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(16),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          DView.textTitle('Login first', color: Colors.blue),
                          DView.spaceHeight(8),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          DView.spaceHeight(4),
                          DInput(
                            controller: controllerUsername,
                            title: 'Username',
                            spaceTitle: 4,
                          ),
                          DView.spaceHeight(4),
                          DInput(
                            controller: controllerPassword,
                            title: 'Password',
                            spaceTitle: 4,
                          ),
                          DView.spaceHeight(4),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => login(context),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(AppRoute.register);
                          },
                          child: Text(
                            "Register here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
