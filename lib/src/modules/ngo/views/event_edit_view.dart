import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/common/utils/image_utils.dart';
import 'package:wechange_mobile/src/modules/common/widgets/select_photo_options.dart';
import 'package:wechange_mobile/src/modules/ngo/services/event_service.dart';

class EventEditView extends StatefulWidget {
  const EventEditView(this._event, {super.key});

  static String route = '/event-edit-view';

  final EventInfo _event;

  @override
  State<EventEditView> createState() => _EventEditView();
}

class _EventEditView extends State<EventEditView> {
  //var mngo = NgoService.ngo!.upcomingEvents[0].title = "IAIAIAIA";
  File? _image;
  final _title = TextEditingController();
  final _description = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void editEvent() {
    widget._event.title = _title.text;
    widget._event.description = _description.text;
    if (_image != null) {
      widget._event.imageBase64ToUpload = ImageUtils.ConvertToBase64(_image!);
    } else {
      widget._event.imageBase64ToUpload = null;
    }

    EventService.editEvent(widget._event);
    Navigator.of(context).pop();
  }

  void initializeFields() {
    _title.text = widget._event.title!;
    _description.text = widget._event.description!;
  }

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

  @override
  void initState() {
    super.initState();
    initializeFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
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
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
                  child: ElevatedButton(
                    onPressed: editEvent,
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
