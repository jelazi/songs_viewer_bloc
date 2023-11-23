import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../blocs/export_blocs.dart';

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

//login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isLogin) {
              Navigator.pushNamed(context, '/');
            }
          },
          builder: (context, state) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 300,
                height: 500,
                child: Column(
                  children: [
                    Text('login'.tr()),
                    //text field for username
                    TextField(
                      controller: usernameController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'username'.tr(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //text field for password

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        context.read<LoginBloc>().add(Login(password: passwordController.text, username: usernameController.text));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
