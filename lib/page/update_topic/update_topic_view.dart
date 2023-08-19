import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/domain/usecases/topic_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/models/topic.dart';
import '../utils/theme.dart';

class UpdateTopicView extends StatefulWidget {
  const UpdateTopicView({super.key, required this.topic});
  final Topic topic;

  @override
  State<UpdateTopicView> createState() => _UpdateTopicViewState();
}

class _UpdateTopicViewState extends State<UpdateTopicView> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  updateTopic() {
    TopicSource.update(
      widget.topic.id,
      controllerTitle.text,
      controllerDescription.text,
    ).then(
      (success) {
        if (success) {
          context.read<CMyTopic>().setTopics(widget.topic.idUser);
          DInfo.snackBarSuccess(context, 'Update Success');
          context.pop();
        } else {
          DInfo.snackBarError(context, 'Update Failed');
        }
      },
    );
  }

  @override
  void initState() {
    controllerTitle.text = widget.topic.title;
    controllerDescription.text = widget.topic.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Update Topic'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () => updateTopic(),
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Text(
            'Update Topic',
            style: TextStyle(color: whiteColor),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            controller: controllerTitle,
            title: 'Title',
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerDescription,
            title: 'Description',
            minLine: 1,
            maxLine: 5,
          ),
        ],
      ),
    );
  }
}
