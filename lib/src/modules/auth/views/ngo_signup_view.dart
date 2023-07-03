import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wechange_mobile/matsallz/methods/methods.dart';
import 'package:wechange_mobile/src/modules/auth/models/signup_ngo.dart';
import 'package:wechange_mobile/src/modules/auth/services/auth_service.dart';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';
import 'package:wechange_mobile/src/modules/common/models/categories.dart';
import 'package:wechange_mobile/src/modules/common/services/category_services.dart';
import 'dart:io';
import 'package:wechange_mobile/src/modules/common/utils/geocoder_utils.dart';

class NgoSignUpView extends StatefulWidget {
  const NgoSignUpView({super.key});

  @override
  State<NgoSignUpView> createState() => _NgoSignUpViewState();
}

class _NgoSignUpViewState extends State<NgoSignUpView> {
  //SIGNUP DATA
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _latitude = 0;
  double _longitude = 0;
  // ignore: unused_field
  List<int> _categoriesIds = []; // PARA CADASTRO

  ImagePicker imagePicker = ImagePicker();
  String _addressDescription = "";
  List<Category> _categories = []; // PARA VISUALIZACAO

  bool locationIsLoading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      SignUpNgo signUpNgo = SignUpNgo(_usernameController.text, _emailController.text, _passwordController.text,
          _nameController.text, _descriptionController.text, _latitude, _longitude, _categoriesIds);

      await AuthService.signUpNgo(signUpNgo);
    }
  }

  Widget locationWidget() {
    return locationIsLoading ? const Center(child: CircularProgressIndicator()) : const Icon(Icons.location_on);
  }

  Future<Position?> _getLocation() async {
    setState(() {
      locationIsLoading = true;
    });
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return null;
      }
    }

    Position location = await Geolocator.getCurrentPosition();
    _latitude = location.latitude;
    _longitude = location.longitude;

    _addressDescription = await GeoCoderUtils.getAddressByLatLng(_latitude, _longitude);

    setState(() {
      locationIsLoading = false;
    });

    developer.log("Latitude: $_latitude Longitude: $_longitude");
    developer.log(_addressDescription);

    return location;
  }

  selectImageFromGallery() async {
    final XFile? imageTemp = await imagePicker.pickImage(source: ImageSource.gallery);

    if (imageTemp != null) {
      setState(() {
        _selectedImage = File(imageTemp.path);
      });
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
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pushReplacementNamed(context, '/signup-view'),
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
                _selectedImage == null
                    ? IconButton(
                        onPressed: selectImageFromGallery,
                        icon: const Icon(Icons.camera_alt),
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage: FileImage(_selectedImage!),
                          radius: 50,
                          //child: Image.file(selectedImage!),
                        ),
                      ),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                Column(
                  children: [
                    //ButtonTheme(
                    //minWidth: 20,
                    //child: ElevatedButton(onPressed: _getLocation, child: const Icon(Icons.location_on)),
                    //),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      onPressed: _getLocation,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          locationWidget(),
                          const SizedBox(height: 2),
                          const Text(
                            'Localização',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _addressDescription,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<Category>>(
                  future: CategoryService.getCategories(),
                  builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                    if (snapshot.hasData) {
                      _categories = snapshot.data!;
                      return const Text('');
                      //
                    } else {
                      return const Column(
                        children: [CircularProgressIndicator()],
                      );
                    }
                  },
                ),
                ElevatedButton(onPressed: _signUp, child: const Text('Cadastrar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
