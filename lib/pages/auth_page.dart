import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/packets/chat/domain/bloc/auth/auth_bloc.dart';
import 'package:messanger/packets/navigation/router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController nameCntr = TextEditingController();
  late final TextEditingController lastNameCntr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isSuccess) MyNavigatorManager.instance.pushHome();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameCntr,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                controller: lastNameCntr,
                onTap: () {},
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SetUserEvent(
                        name: nameCntr.text, lastName: lastNameCntr.text));
                  },
                  child: const Text('Submite'))
            ],
          ),
        ),
      ),
    );
  }
}