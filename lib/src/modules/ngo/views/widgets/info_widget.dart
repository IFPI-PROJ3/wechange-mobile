import 'package:flutter/material.dart';

Widget infoWidget(BuildContext context, double rating, int active_events, int events) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context, rating == -1 ? "--" : rating.toString(), 'Avaliação'),
        buildDivider(),
        buildButton(context, active_events.toString(), 'Eventos Ativos'),
        buildDivider(),
        buildButton(context, events.toString(), 'Eventos'),
      ],
    );

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
