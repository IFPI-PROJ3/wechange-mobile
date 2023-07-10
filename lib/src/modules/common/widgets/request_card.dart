import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/ngo/models/volunteer_request.dart';
import 'package:wechange_mobile/src/modules/ngo/services/event_volunteer_service.dart';
import 'package:wechange_mobile/src/modules/ngo/views/widgets/profile_widget.dart';
import 'package:wechange_mobile/src/modules/volunteer/views/volunteer_view.dart';

class RequestCard extends StatefulWidget {
  const RequestCard(this._callback, this._request, this._option, {super.key});

  final Function _callback;
  final VolunteerRequest _request;
  final RequestCardOptions _option;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  void _acceptRequest() {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aceitar participante'),
        content: Text(
          'Deseja realmente aceitar a participação de ${widget._request.volunteer_name} para este evento?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Voltar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Aceitar'),
          ),
        ],
      ),
    ).then(
      (accept) async {
        if (accept == null) {
          return;
        }
        if (accept) {
          EventVolunteerService.acceptEventRequest(widget._request.id!);
          widget._callback();
        } else {
          return;
        }
      },
    );
  }

  void _refuseRequest() {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Recusar participante'),
        content: Text(
          'Deseja realmente recusar a participação de ${widget._request.volunteer_name} para este evento?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Voltar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Recusar'),
          ),
        ],
      ),
    ).then(
      (refuse) async {
        if (refuse == null) {
          return;
        }
        if (refuse) {
          EventVolunteerService.refuseEventRequest(widget._request.id!);
          widget._callback();
        } else {
          return;
        }
      },
    );
  }

  void _toVolunteerProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VolunteerView(widget._request.volunteer_id!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
          child: Card(
            elevation: 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.100,
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ProfileWidget(imagePath: widget._request.profile_image!, size: 50),
                                  Container(
                                    width: 140,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget._request.volunteer_name!,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: _toVolunteerProfile,
                                    icon: const Icon(
                                      Icons.perm_contact_cal_outlined,
                                      color: Colors.black87,
                                      size: 40,
                                    ),
                                  ),
                                  widget._option == RequestCardOptions.undefined
                                      ? IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: _refuseRequest,
                                          icon: const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        )
                                      : const Row(),
                                  widget._option == RequestCardOptions.undefined
                                      ? IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: _acceptRequest,
                                          icon: Icon(
                                            Icons.check_circle_outline,
                                            color: Theme.of(context).primaryColor,
                                            size: 40,
                                          ),
                                        )
                                      : const Row(),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                widget._request.volunteer_email!,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 15, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

enum RequestCardOptions { undefined, confirmed }
