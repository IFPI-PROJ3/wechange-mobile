import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/views/login_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';

import '../../../auth/services/auth_service.dart';

AppBar buildAppBar(BuildContext context) {
  Future<void> logout() async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmação de logout'),
        content: const Text(
          'Deseja realmente sair da aplicação',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    ).then((exit) async {
      if (exit == null) {
        return;
      }
      if (exit) {
        Navigator.pushReplacementNamed(context, LoginView.route);
        await AuthService.logOut();
      } else {
        Navigator.pushReplacementNamed(context, NgoView.route);
        //Navigator.pop(context);
      }
    });
  }

  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    elevation: 0,
    actions: [
      PopupMenuButton(
        color: Colors.white,
        onSelected: (value) {
          switch (value) {
            case 0:
              break;
            case 1:
              logout();
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 0, child: Text('Editar perfil')),
          const PopupMenuItem(value: 1, child: Text('Sair'))
        ],
      ),
    ],
  );
}
