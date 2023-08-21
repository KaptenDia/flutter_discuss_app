import 'dart:convert';

import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/data/constants.dart';
import 'package:discuss_app/page/utils/app_format.dart';
import 'package:discuss_app/page/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/topic.dart';
import '../app_route.dart';

class DetailTopicView extends StatelessWidget {
  const DetailTopicView({super.key, required this.topic});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    List<String> images = List<String>.from(jsonDecode(topic.images));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  '${Api.imageUser}/${topic.user!.image}',
                  fit: BoxFit.cover,
                  width: 36,
                  height: 36,
                ),
              ),
            ),
            DView.spaceWidth(),
            Text(topic.user!.username),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () {
            context.push(AppRoute.comment, extra: topic);
          },
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Comments',
                style: TextStyle(color: whiteColor),
              ),
              DView.spaceWidth(4),
              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: whiteColor,
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DView.textTitle(topic.title),
          DView.spaceHeight(4),
          Row(
            children: [
              const Icon(
                Icons.event,
                color: Colors.grey,
                size: 15,
              ),
              DView.spaceWidth(4),
              Text(
                AppFormat.fullDateTime(
                  topic.createdAt,
                ),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          Text(topic.description),
          DView.spaceHeight(),
          if (images.isNotEmpty)
            ...images.map((e) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return Column(
                            children: [
                              DView.spaceHeight(),
                              DButtonCircle(
                                diameter: 40,
                                onClick: () => Navigator.pop(contextDialog),
                                child: const Icon(Icons.clear),
                              ),
                              Expanded(
                                child: InteractiveViewer(
                                  child: Image.network(
                                    '${Api.imageTopic}/$e',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${Api.imageTopic}/$e',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
