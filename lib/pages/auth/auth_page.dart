import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/const/extension.dart';
import 'package:messanger/packets/chat/domain/bloc/auth/auth_bloc.dart';
import 'package:messanger/packets/chat/domain/bloc/chat/chat_bloc.dart';
import 'package:messanger/packets/navigation/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          if (state.isSuccess) {
            context.read<ChatBloc>().add(InitUpdateStreamEvent());
            MyNavigatorManager.instance.pushHome();
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return Padding(
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
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: context.color.searchBox),
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (nameCntr.text.isEmpty) return;
                              if (lastNameCntr.text.isEmpty) return;
                              context.read<AuthBloc>().add(SetUserEvent(
                                  name: nameCntr.text,
                                  lastName: lastNameCntr.text));
                            },
                      child: state.isLoading
                          ? CircularProgressIndicator.adaptive(
                              backgroundColor: context.color.text)
                          : Text(AppLocalizations.of(context)!.submit))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
