import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_feed.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/domain/models/topic.dart';
import 'package:discuss_app/page/widgets/item_topic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedFragment extends StatelessWidget {
  const FeedFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final cUser = context.read<CUser>();
    if (cUser.data == null) {
      return DView.loadingCircle();
    } else {
      context.read<CFeed>().setTopics(cUser.data!.id);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: DView.textTitle('Feed', size: 24),
        ),
        Expanded(
          child: Consumer<CFeed>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DView.empty(),
                    DView.empty('Or you are not following anybody'),
                  ],
                );
              }
              return ListView.builder(
                  itemCount: _.topics.length,
                  itemBuilder: (context, index) {
                    Topic topic = _.topics[index];
                    List images = jsonDecode(topic.images);
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        8,
                        16,
                        index == _.topics.length - 1 ? 30 : 8,
                      ),
                      child: ItemTopic(topic: topic, images: images),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
