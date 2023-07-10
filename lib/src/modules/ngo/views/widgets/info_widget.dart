import 'package:flutter/material.dart';

Widget infoNgoWidget(BuildContext context, double rating, int activeEvents, int events, List<String> categories) =>
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, rating == -1 ? "--" : rating.toString(), 'Avaliação'),
            buildDivider(),
            buildButton(context, activeEvents.toString(), 'Eventos Ativos'),
            buildDivider(),
            buildButton(context, events.toString(), 'Eventos'),
          ],
        ),
      ],
    );

Widget infoVolunteerWidget(BuildContext context, int activeEvents, int events, List<String> categories) {
  return Column(
    children: [
      /*
      ListView(
        //scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          ...categories
              .map((category) => Center(
                    child: Text(
                      ' #${category.toLowerCase()} ',
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ))
              .toList(),
        ],
      ),*/
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, activeEvents.toString(), 'Eventos Ativos'),
          buildDivider(),
          buildButton(context, events.toString(), 'Participação'),
        ],
      ),
      //Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      //children: [

      //],
      //),
    ],
  );
}

Widget buildDivider() => const SizedBox(
      height: 24,
      child: VerticalDivider(),
    );

Widget buildButton(BuildContext context, String value, String text) => MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
