import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';

import '../../../../packets/chat/domain/bloc/chat/chat_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.color.searchBox),
        height: 42,
        padding: const EdgeInsets.all(8),
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Поиск',
              hintStyle: context.text.searchBox
                  .copyWith(color: context.color.commentColor),
              prefixIcon: Icon(Icons.search, color: context.color.commentColor),
              contentPadding: const EdgeInsets.all(0),
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
            context.read<ChatBloc>().add(SetAllUsers(empty: true));
          },
          onTap: () => context.read<ChatBloc>().add(SetAllUsers()),
          onChanged: (value) {},
        ));
  }
}
