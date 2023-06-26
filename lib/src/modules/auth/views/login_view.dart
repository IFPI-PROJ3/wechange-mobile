import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/models/user_status.dart';
import 'package:wechange_mobile/src/modules/auth/services/auth_service.dart';
import 'package:wechange_mobile/src/styles/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signIn() async {
    UserStatus? userStatus = await AuthService.signIn(_emailController.text, _passwordController.text);

    if (userStatus == null) {
      return;
    }

    if (userStatus.role == 'Ngo') {
      Navigator.pushReplacementNamed(context, '/ngo-view');
    } else if (userStatus.role == 'Volunteer') {
      Navigator.pushReplacementNamed(context, '/volunteer-view');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 128,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'Digite seu email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 20,
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Recuperar Senha",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: buildConfirmStyleButton,
                    onPressed: signIn,
                    child: buildTextButton('Entrar'),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  //buildTextRegisterLogIn(
                  //'Não possui cadastro?',
                  //'cadastre-se',
                  //),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não possui cadastro?'),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup-view');
                        },
                        child: const Text(
                          "cadastre-se",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF116B67),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
