import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechange_mobile/matsallz/methods/methods.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Por favor, digite seu email!';
                      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text)) {
                        return 'Por favor, digite um e-mail correto!';
                      }
                      return null;
                    },
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
                    validator: (senha) {
                      if (senha!.isEmpty) {
                        return 'Por favor, digite sua senha!';
                      } else if (senha.length < 6) {
                        return 'Por favor, digite uma senha maior que 6 caracteres';
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
                    style: buildConfirmStyleButton,
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_formKey.currentState!.validate()) {
                        //logar();
                        bool logando = await login();
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (logando) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          _passwordController.clear();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text('E-mail ou senha inválidos!'),
                            ),
                          );
                        }
                        // ignore: avoid_print
                        print('Logando');
                      }
                    },
                    child: buildTextButton('Entrar'),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  buildTextRegisterLogIn(
                    'Não possui cadastro?',
                    'cadastre-se',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://wechange-api.azurewebsites.net/auth/signin/');

    Map<String, dynamic> body = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      await sharedPreferences.setString('token', "Token $jsonDecode(response.body)['access_token']");
      //print(jsonDecode(response.body)['access_token']);
      return true;
    } else {
      // ignore: avoid_print
      print('F');
      // ignore: avoid_print
      print(jsonDecode(response.body));
      return false;
    }
  }
}
