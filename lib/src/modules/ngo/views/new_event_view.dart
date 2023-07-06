import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';
import 'package:number_selection/number_selection.dart';

class NewEventView extends StatefulWidget {
  const NewEventView({super.key});

  static String route = 'new-event';

  @override
  State<NewEventView> createState() => _NewEventView();
}

class _NewEventView extends State<NewEventView> {
  @override
  void initState() {
    super.initState();
  }

  File? _image;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _firstdate = TextEditingController();
  final _lastdate = TextEditingController();
  int _limit = 1;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
  }

  Future<void> _dateTimeRangePicker() async {
    DateFormat dateformat = DateFormat('dd/MM/yyyy');
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: -1)),
      lastDate: DateTime.now().add(
        const Duration(days: 31),
      ),
    );

    if (picked != null) {
      DateTime start = picked.start;
      DateTime end = picked.end;

      _firstdate.text = dateformat.format(start).toString();
      _lastdate.text = dateformat.format(end).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pushReplacementNamed(context, NgoView.route),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Título do evento',
                  hintText: 'Digite o título do evento',
                ),
                validator: (name) {
                  if (name!.isEmpty) {
                    return 'Por favor, digite o título do evento!';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: _description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Descrição do evento',
                  hintText: 'Digite a descrição do evento',
                ),
                validator: (name) {
                  if (name!.isEmpty) {
                    return 'Por favor, digite a descrição do evento!';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(5),
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    'Selecione o limite de inscritos',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height * 1,
                    height: MediaQuery.of(context).size.height * 0.07,
                    margin: const EdgeInsets.only(top: 10),
                    child: NumberSelection(
                      theme: NumberSelectionTheme(
                          draggableCircleColor: Theme.of(context).primaryColor,
                          iconsColor: Theme.of(context).primaryColor,
                          numberColor: Colors.white,
                          backgroundColor: Colors.white,
                          outOfConstraintsColor: Colors.deepOrange),
                      initialValue: 1,
                      minValue: 1,
                      maxValue: 50,
                      direction: Axis.vertical,
                      withSpring: true,
                      onChanged: (value) => {_limit = value},
                      enableOnOutOfConstraintsAnimation: false,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                readOnly: true,
                enabled: true,
                controller: _firstdate,
                style: const TextStyle(color: Colors.black),
                decoration: inputDecorationBookingIcon(context, 'Data Inicial', Icons.date_range),
                //validator: (firstdate) => Validators.validateText(firstdate!),
                onTap: _dateTimeRangePicker,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: TextFormField(
                readOnly: true,
                controller: _lastdate,
                style: const TextStyle(color: Colors.black),
                decoration: inputDecorationBookingIcon(context, 'Data Final', Icons.date_range),
                //validator: (lastdate) => Validators.validateText(lastdate!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration inputDecorationBookingIcon(BuildContext context, txt, icon) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: txt,
    labelStyle: const TextStyle(color: Colors.white),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    ),
    prefixIcon: Icon(
      icon,
      color: Theme.of(context).primaryColor,
    ),
  );
}
