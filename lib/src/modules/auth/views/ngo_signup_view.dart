import 'package:flutter/material.dart';
import 'package:wechange_mobile/matsallz/methods/methods.dart';
import 'package:wechange_mobile/src/modules/auth/models/signup_ngo.dart';
import 'package:wechange_mobile/src/modules/auth/models/user_status.dart';
import 'package:wechange_mobile/src/modules/auth/services/auth_service.dart';

class NgoSignUpView extends StatefulWidget {
  const NgoSignUpView({super.key});

  @override
  State<NgoSignUpView> createState() => _NgoSignUpViewState();
}

class _NgoSignUpViewState extends State<NgoSignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _latitude = 0;
  double _longitude = 0;
  final List<int> _categories = [0];

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      SignUpNgo signUpNgo = SignUpNgo(_usernameController.text, _emailController.text, _passwordController.text,
          _nameController.text, _descriptionController.text, _latitude, _longitude, _categories);

      await AuthService.signUpNgo(signUpNgo);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTextTitle('Nome de usuario'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Nome da usuário',
                    hintText: 'Digite seu nome de usuário',
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Por favor, digite seu nome da usuário!';
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
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Por favor, digite seu email!';
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
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite o nome para sua Ong',
                  ),
                  validator: (nome) {
                    if (nome!.isEmpty) {
                      return 'Por favor, o nome para sua Ong!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Digite a descrição para sua Ong',
                  ),
                  validator: (nome) {
                    if (nome!.isEmpty) {
                      return 'Por favor, a descrição para sua Ong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: signUp, child: const Text('Cadastrar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
