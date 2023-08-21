import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/c_search.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/user.dart';
import '../widgets/item_topic.dart';
import '../widgets/item_user.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerSearch = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: controllerSearch,
            decoration: InputDecoration(
              hintText: 'Search...',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: Colors.white54,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  if (controllerSearch.text != '') {
                    context.read<CSearch>().search(controllerSearch.text);
                  }
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: context.watch<CSearch>().filter,
              items: context.read<CSearch>().filters.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                context.read<CSearch>().filter = value!;
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              style: const TextStyle(fontSize: 14, color: Colors.black),
              underline: const SizedBox(),
            ),
          ),
        ],
      ),
      body: Consumer<CSearch>(
        builder: (context, _, child) {
          if (_.filter == 'Topic') {
            if (_.topics.isEmpty) return DView.empty();
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
                    index == _.topics.length - 1 ? 16 : 8,
                  ),
                  child: ItemTopic(
                    topic: topic,
                    images: images,
                  ),
                );
              },
            );
          } else {
            if (_.user.isEmpty) return DView.empty();
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: _.user.length,
              itemBuilder: (context, index) {
                User user = _.user[index];
                return ItemUser(user: user);
              },
            );
          }
        },
      ),
    );
  }
}
