import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/ngo/views/event_edit_view.dart';

class EventCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EventCard(this._event);
  final EventInfo _event;

  void _toEdit(BuildContext context) {
    //Navigator.pushReplacementNamed(context, EventEditView.route, arguments: event);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventEditView(_event),
      ),
    );
  }

  void _toEventRequests() {}

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
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _event.title!,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: PopupMenuButton(
                            onSelected: (value) {
                              switch (value) {
                                case 0:
                                  _toEdit(context);
                                  break;
                                case 1:
                                  _toEventRequests();
                                  break;
                              }
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: Theme.of(context).primaryColor,
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 0,
                                child: Text("Editar"),
                              ),
                              const PopupMenuItem(
                                value: 1,
                                child: Text("Solicitações"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Image.network(_event.imageThumb!),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //starsRating(
                                              //hotel.rating!.toInt(), /* 25 */
                                              //)
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  '${_event.volunteersLimit}',
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Icon(
                                                    Icons.how_to_reg,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  '${_event.volunteersCount}',
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                            Text(
                                              '${_event.startDate} - ${_event.endDate}',
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
