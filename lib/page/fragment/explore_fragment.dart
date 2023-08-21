import 'dart:convert';

import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_explore.dart';
import 'package:discuss_app/page/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/c_user.dart';
import '../../domain/models/topic.dart';
import '../widgets/item_topic.dart';

class ExploreFragment extends StatelessWidget {
  const ExploreFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final cUser = context.read<CUser>();
    if (cUser.data == null) {
      return DView.loadingCircle();
    } else {
      context.read<CExplore>().setTopics();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DView.textTitle('Explore', size: 24),
              DButtonElevation(
                mainColor: primaryColor,
                onClick: () {},
                width: 36,
                height: 36,
                child: Icon(
                  Icons.search,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Consumer<CExplore>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) {
                return DView.empty();
              }
              return ListView.builder(
                padding: const EdgeInsets.all(0),
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
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
