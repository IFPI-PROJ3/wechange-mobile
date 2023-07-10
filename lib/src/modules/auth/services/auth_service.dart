import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';
import 'package:wechange_mobile/src/modules/auth/models/signup_ngo.dart';
import 'package:wechange_mobile/src/modules/auth/models/signup_volunteer.dart';
import 'package:wechange_mobile/src/modules/auth/services/token_service.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import '../models/user_status.dart';
import 'dart:developer' as developer;

class AuthService {
  static UserStatus? user;

  // verifica e salva token de usuario
  static Future<bool> getCurrentUser() async {
    RefreshToken? tokens = await TokenService.getTokens();

    if (tokens == null) {
      return false;
    }

    developer.log("access_token: ${tokens.accessToken}");
    developer.log("refresh_token: ${tokens.refreshToken}");

    try {
      final response = await Dio().put(
        "${ApiParams.apiBaseUrl}/auth/refresh-token",
        data: tokens.toJson(),
        options: ApiParams.dioRequestDefaultOptions,
      );

      if (response.statusCode == 200) {
        TokenService.saveTokens(RefreshToken.fromJson(response.data));
        var userStatus = UserStatus.fromJson(response.data);
        _authenticated(userStatus);
        return true;
      }
    } on Exception {
      TokenService.deleteTokens();
      return false;
    }

    return false;
  }

  static Future<UserStatus?> signIn(BuildContext context, String email, String password) async {
    late Response response;

    try {
      response = await Dio().post(
        "${ApiParams.apiBaseUrl}/auth/signin",
        data: {"email": email, "password": password},
        options: ApiParams.dioRequestDefaultOptions,
      );

      if (response.statusCode == 200) {
        await TokenService.saveTokens(RefreshToken.fromJson(response.data));
        var userStatus = UserStatus.fromJson(response.data);
        _authenticated(userStatus);
        return userStatus;
      } else if (response.statusCode == 401) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('E-mail ou senha inválidos!'),
          ),
        );
      }
    } on Exception {}

    return null;
  }

  static Future<UserStatus?> signUpNgo(BuildContext context, SignUpNgo signUpNgo) async {
    developer.log("cheguemo");
    developer.log("cheguemo1");

    final response = await Dio().post(
      "${ApiParams.apiBaseUrl}/auth/signup-ngo",
      data: signUpNgo.toJson(),
      options: ApiParams.dioRequestDefaultOptions,
    );

    if (response.statusCode == 201) {
      signIn(context, signUpNgo.email, signUpNgo.password);
      var userStatus = UserStatus.fromJson(response.data);
      return userStatus;
    } else {
      return null;
    }
  }

  static Future<UserStatus?> signUpVolunteer(SignUpVolunteer signUpVolunteer) async {
    final response = await Dio().post(
      "${ApiParams.apiBaseUrl}/auth/signup-volunteer",
      data: signUpVolunteer.toJson(),
      options: ApiParams.dioRequestDefaultOptions,
    );

    if (response.statusCode == 201) {
      var userStatus = UserStatus.fromJson(response.data);
      _authenticated(userStatus);
      return userStatus;
    } else {
      return null;
    }
  }

  static Future logOut() async {
    RefreshToken refreshToken = await TokenService.getTokens() as RefreshToken;

    final response = await Dio().put("${ApiParams.apiBaseUrl}/auth/logout",
        options: ApiParams.dioRequestDefaultOptionsAuthBearer(refreshToken.accessToken));

    if (response.statusCode == 204) {
      TokenService.deleteTokens();
      _deauthenticated();
      return;
    }
  }

  static void _authenticated(UserStatus userStatus) {
    user = userStatus;
  }

  static void _deauthenticated() {
    user = null;
  }
}
