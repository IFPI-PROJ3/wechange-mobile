import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/ngo/views/event_edit_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/event_requests_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/event_volunteers_view.dart';

class EventCard extends StatefulWidget {
  const EventCard(this.callback, this._event, this._option, {super.key});

  final Function callback;
  final EventInfo _event;
  final EventCardOptions _option;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  void _toEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventEditView(widget._event),
      ),
    ).then((_) => reloadParentView());
  }

  void _toEventRequests(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventRequestsView(widget._event),
      ),
    ).then((_) => reloadParentView());
  }

  void _toEventVolunteers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventVolunteersView(widget._event),
      ),
    );
  }

  void reloadParentView() {
    widget.callback();
    setState(() {});
  }

  Widget eventCardOptions() {
    switch (widget._option) {
      case EventCardOptions.current:
        return PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 0:
                _toEventVolunteers(context);
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
              child: Text("Participantes"),
            ),
          ],
        );

      case EventCardOptions.upcoming:
        return PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 0:
                _toEdit(context);
                break;
              case 1:
                _toEventRequests(context);
                break;
              case 2:
                _toEventVolunteers(context);
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
            const PopupMenuItem(
              value: 2,
              child: Text("Participantes"),
            ),
          ],
        );
      case EventCardOptions.ended:
        return const Center();
      case EventCardOptions.exibition:
        return const Center();
    }
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
                                widget._event.title!,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(right: 5), child: eventCardOptions()),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Image.network(widget._event.imageThumb!),
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
                                                  padding: const EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  'Limite: ${widget._event.volunteersLimit}',
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        widget._option != EventCardOptions.current &&
                                                widget._event.volunteersLimit! > widget._event.volunteersCount!
                                            ? Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(2),
                                                    child: Icon(
                                                      Icons.perm_contact_cal_outlined,
                                                      color: Theme.of(context).primaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Solicitações: ${widget._event.requestsCount!}',
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                  ),
                                                ],
                                              )
                                            : const Row(),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(
                                                Icons.how_to_reg,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                            Text(
                                              'Participantes: ${widget._event.volunteersCount!}',
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                            Text(
                                              '${widget._event.startDate} - ${widget._event.endDate}',
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

enum EventCardOptions { current, upcoming, ended, exibition }
