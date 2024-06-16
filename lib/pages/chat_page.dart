import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messanger/const/extension.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          const CustomScrollView(
            slivers: [],
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              height: 42,
              child: Row(
                children: [
                  Container(
                    color: context.color.searchBox,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.note),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: context.color.searchBox,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.note),
                      ),
                    ),
                  ),
                  Container(
                    color: context.color.searchBox,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
