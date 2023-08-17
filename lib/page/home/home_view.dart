import 'package:discuss_app/domain/session.dart';
import 'package:discuss_app/page/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ElevatedButton(
        onPressed: () {
          Session.clearUser();
          context.go(AppRoute.login);
        },
        child: const Text('Logout'),
      ),
    );
  }
}
