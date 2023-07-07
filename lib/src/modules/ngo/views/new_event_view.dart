import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wechange_mobile/src/modules/common/style/app_styles.dart';
import 'package:wechange_mobile/src/modules/common/utils/image_utils.dart';
import 'package:wechange_mobile/src/modules/common/widgets/select_photo_options.dart';
import 'package:wechange_mobile/src/modules/ngo/models/event.dart';
import 'package:wechange_mobile/src/modules/ngo/services/event_service.dart';
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
  int _limit = 1;
  late DateTime _start;
  late DateTime _end;

  final _firstdate = TextEditingController();
  final _lastdate = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);

      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException {
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<void> _newEvent() async {
    DateFormat dateformat = DateFormat('yyyy-MM-dd');

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Selecione a imagem do evento'),
        ),
      );
    }

    if (_formKey.currentState!.validate()) {
      Event event = Event();
      event.title = _title.text;
      event.description = _title.text;
      event.volunteersLimit = _limit;
      event.startDate = '${dateformat.format(_start)}T00:00:00.000Z';
      event.endDate = '${dateformat.format(_end)}T00:00:00.000Z';
      event.imageThumb = ImageUtils.ConvertToBase64(_image!);
      await EventService.newEvent(event);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptions(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  Future<void> _dateTimeRangePicker() async {
    DateFormat dateformat = DateFormat('dd/MM/yy');
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: -1)),
      lastDate: DateTime.now().add(
        const Duration(days: 31),
      ),
    );

    if (picked != null) {
      _start = picked.start;
      _end = picked.end;

      _firstdate.text = dateformat.format(_start).toString();
      _lastdate.text = dateformat.format(_end).toString();
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _showSelectPhotoOptions(context);
                          },
                          child: Center(
                            child: Container(
                              height: 150.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.grey.shade200,
                              ),
                              child: Center(
                                  child: _image == null
                                      ? const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              size: 45,
                                              Icons.image,
                                            ),
                                            Text(
                                              'Sem imagem',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        )
                                      : //CircleAvatar(
                                      //backgroundImage: FileImage(_image!),
                                      //radius: 150.0,
                                      //),
                                      Image(image: FileImage(_image!))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _title,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Título do evento',
                    hintText: 'Digite o título do evento',
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Digite o título do evento';
                    }
                    return null;
                  },
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
                        return 'Digite a descrição do evento';
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
                          initialValue: 5,
                          minValue: 5,
                          maxValue: 50,
                          direction: Axis.horizontal,
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
                    onTap: _dateTimeRangePicker,
                    validator: (firstdate) {
                      if (firstdate!.isEmpty) {
                        return 'Selecione a data inicial do evento!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: TextFormField(
                    readOnly: true,
                    controller: _lastdate,
                    style: const TextStyle(color: Colors.black),
                    decoration: inputDecorationBookingIcon(context, 'Data Final', Icons.date_range),
                    validator: (lastdate) {
                      if (lastdate!.isEmpty) {
                        return 'Selecione a data final do evento!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
                  child: ElevatedButton(
                    onPressed: _newEvent,
                    child: const Text('Confirmar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
