import 'package:discuss_app/controller/c_add_topic.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_following.dart';
import 'package:discuss_app/controller/c_profile.dart';
import 'package:discuss_app/controller/c_search.dart';
import 'package:discuss_app/domain/session.dart';
import 'package:discuss_app/page/error/error_view.dart';
import 'package:discuss_app/page/home/home_view.dart';
import 'package:discuss_app/page/login/login_view.dart';
import 'package:discuss_app/page/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/c_follower.dart';
import '../domain/models/user.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const addTopic = '/add-topic';
  static const profile = '/profile';
  static const search = '/search';
  static const follower = '/follower';
  static const following = '/following';
  static const comment = '/comment';

  static GoRouter routerConfig = GoRouter(
    errorBuilder: (context, state) => ErrorView(
      title: 'Terjadi kesalahan',
      description: state.error.toString(),
    ),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      User? user = await Session.getUser();
      if (user == null) {
        if (state.matchedLocation == login ||
            state.matchedLocation == register) {
          return null;
        }
        return login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: addTopic,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CAddTopic(),
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CProfile(),
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: search,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CSearch(),
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: follower,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollower(),
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: following,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollowing(),
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: comment,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CComment(),
          child: const Scaffold(),
        ),
      ),
    ],
  );
}
