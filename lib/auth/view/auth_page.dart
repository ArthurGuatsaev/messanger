import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/auth/domain/cubit/auth_cubit.dart';
import 'package:messanger/const/extension.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите ваше имя',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 15),
            SizedBox(
              height: 42,
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'Иван Иванов',
                      hintStyle: context.text.hintStyle)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().auth(controller.text);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.color.myMessage),
              child: Text(
                'Готово',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
