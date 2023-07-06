import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/models/user_status.dart';
import 'package:wechange_mobile/src/modules/auth/services/auth_service.dart';
import 'package:wechange_mobile/src/modules/auth/views/signup_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';
import 'package:wechange_mobile/src/styles/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String route = "/signin";

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
    UserStatus? userStatus = await AuthService.signIn(
        _emailController.text, _passwordController.text);

    if (userStatus == null) {
      return;
    }

    if (userStatus.role == 'Ngo') {
      Navigator.pushReplacementNamed(context, NgoView.route);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  const Image(
                    image: AssetImage('lib/src/assets/logo.png'),
                  ),

                  const SizedBox(height: 50),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'E-mail',
                      hintText: 'Digite seu email',
                    ),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Por favor, digite seu e-mail!';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                    ),
                    obscureText: true,
                    validator: (senha) {
                      if (senha!.isEmpty) {
                        return 'Por favor, digite sua senha!';
                      }
                      return null;
                    },
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
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 75.0, vertical: 15.0),
                      shape: const StadiumBorder(),
                      shadowColor: Colors.grey,
                    ),
                    onPressed: signIn,
                    child: buildTextButton('Entrar'),
                  ),

                  const SizedBox(
                    height: 100,
                  ),
                  //buildTextRegisterLogIn(
                  //'Não possui cadastro?',
                  //'cadastre-se',
                  //),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não possui cadastro? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, SignUpView.route);
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
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
