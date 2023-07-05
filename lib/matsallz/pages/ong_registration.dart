import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wechange_mobile/matsallz/methods/methods.dart';

class OngRegistration extends StatefulWidget {
  const OngRegistration({super.key});

  @override
  State<OngRegistration> createState() => _OngRegistrationState();
}

class _OngRegistrationState extends State<OngRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _entityController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ongTypeController = TextEditingController();
  List<String> categoryList = [
    'Humanitária',
    'Educacional',
    'Paz',
    'Desenvolvimento Social',
    'Direitos Humanos',
    'Ambiental',
    'Saúde',
  ];
  List<String>? selectedCategory = [];
  //late Future<List<Category>?> categoryList = getCategorys();

  // Future<List<Category>?> getCategorys() async {
  //   var url = Uri.parse('https://wechange-api.azurewebsites.net/category/all');
  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     List<Category> categories = jsonDecode(response.body).map((jsonObject) {
  //       return Category(
  //         jsonObject['id'],
  //         jsonObject['name'],
  //         jsonObject['description'],
  //       );
  //     }).toList();
  //     return categories;
  //   }
  //   return null;
  // }

  // @override
  // void initState() {
  //   categoryList = getCategorys();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTextTitle('Entidade'),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _entityController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Entidade',
                    hintText: 'Digite o nome da entidade',
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Por favor, digite o nome da entidade!';
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
                    hintText: 'Digite seu e-mail',
                  ),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Por favor, digite o email da entidade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                  ),
                  validator: (senha) {
                    if (senha!.isEmpty) {
                      return 'Por favor, digite sua senha!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // TextFormField(
                //   controller: _confirmPasswordController,
                //   keyboardType: TextInputType.visiblePassword,
                //   decoration: const InputDecoration(labelText: 'Confirmar Senha', hintText: 'Digite sua senha',),
                //   validator: (senha) {
                //     if (senha!.isEmpty) {
                //       return 'Por favor confirme sua senha!';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20),

                TextFormField(
                    controller: _ongTypeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de ONG',
                      hintText: 'Digite o tipo da sua ONG',
                    ),
                    validator: (tipo) {
                      if (tipo!.isEmpty) {
                        return 'Por favor, digite o tipo da sua ONG';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),

                Wrap(
                  children: categoryList.map(
                    (category) {
                      bool isSelected = false;
                      if (selectedCategory!.contains(category)) {
                        isSelected = true;
                      }
                      return GestureDetector(
                        onTap: () {
                          if (!selectedCategory!.contains(category)) {
                            setState(() {
                              selectedCategory!.add(category);
                            });
                          } else {
                            setState(() {
                              selectedCategory!.removeWhere((element) => element == category);
                            });
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                      color: isSelected ? const Color(0xFF116B67) : Colors.grey, width: 2)),
                              child: Text(
                                category,
                                style: TextStyle(
                                    color: isSelected ? const Color(0xFF116B67) : Colors.grey, fontSize: 14),
                              ),
                            )),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var url = Uri.parse(
                        'https://wechange-api.azurewebsites.net/auth/signup-ngo/',
                      );
                      Map<String, String> headers = {"Content-Type": "application/json"};
                      Map<String, dynamic> body = {
                        "username": _entityController.text,
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      };
                      var response = await http.post(
                        url,
                        body: jsonEncode(body),
                        headers: headers,
                      );
                      if (response.statusCode == 201) {
                        // ignore: avoid_print
                        print(response.body);
                        // Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const homeUser()));
                      } else {
                        // ignore: avoid_print
                        print(response.body);
                      }
                    }
                  },
                  child: buildTextButton('Registrar'),
                ),

                const SizedBox(height: 20),
                buildTextRegisterLogIn(
                  'Já possui cadastro?',
                  'Entrar',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
