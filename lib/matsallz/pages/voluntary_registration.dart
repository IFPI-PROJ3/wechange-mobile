import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wechange_mobile/matsallz/methods/methods.dart';
import 'package:http/http.dart' as http;

class VoluntaryRegistration extends StatefulWidget {
  const VoluntaryRegistration({super.key});

  @override
  State<VoluntaryRegistration> createState() => _VoluntaryRegistrationState();
}

class _VoluntaryRegistrationState extends State<VoluntaryRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTextTitle('Voluntário'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, digite seu nome!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, digite seu email!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, digite sua senha!';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   controller: _confirmPasswordController,
                //   keyboardType: TextInputType.visiblePassword,
                //   obscureText: true,
                //   decoration: const InputDecoration(
                //     labelText: 'Repetir senha',
                //     hintText: 'Repita sua senha',
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Por favor, repita sua senha!';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var url = Uri.parse(
                        'https://wechange-api.azurewebsites.net/auth/signup-volunteer/',
                      );
                      Map<String, String> headers = {"Content-Type": "application/json"};
                      Map<String, dynamic> body = {
                        "username": _nameController.text,
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      };
                      var response = await http.post(
                        url,
                        body: jsonEncode(body),
                        headers: headers,
                      );
                      if (response.statusCode == 201) {
                        //print(response.body);
                        // Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const homeUser()));
                      } else {
                        //print(response.body);
                      }
                    }
                  },
                  child: buildTextButton('Entrar'),
                ),
                const SizedBox(height: 10),
                buildTextRegisterLogIn(
                  'Já possui cadastro?',
                  'Entrar',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
