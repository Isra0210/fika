import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../../presentation/utils/constants/keys.dart';
import '../../models/user_model.dart';
import '../../storage/storage_service.dart';

class AuthService {
  static const logHeader = '[ServiceAuth]';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = Get.find<StorageService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> getUserInfo(String? userId) async {
    if (userId == null) return null;
    final user = await firestore
        .collection(kUsers)
        .doc(userId)
        .withConverter<UserModel>(
          fromFirestore: (snapshots, _) => UserModel.fromMap(snapshots.data()!),
          toFirestore: (user, _) => user.toMap(),
        )
        .get();
    Get.log('$logHeader Get ${user.data()?.name} from firestore');
    final userData = user.data();
    if (userData != null) await storage.setUser(userData);
    return userData;
  }

  Future<void> deleteUserAccount(UserModel user) async {
    try {
      await firestore.collection(kUsers).doc(user.id).delete();

      await FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      if (e.toString().contains('requires-recent-login')) {
        throw Exception("Por favor, reautentique o usuário antes de deletar.");
      }
    }
  }

  Future<UserModel?> updateUserOnCollection(UserModel user) async {
    final userWithUpdatedAt = user.copyWith(
      updatedAt: Timestamp.fromDate(DateTime.now()),
    );
    await firestore.collection(kUsers).doc(user.id).set(
          userWithUpdatedAt.toMap(),
          SetOptions(merge: true),
        );

    Get.log('$logHeader Save user to firestore');

    return getUserInfo(user.id);
  }

  Future<String> getFCMToke() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? deviceToken = await messaging.getToken();
    if (deviceToken == null) return '';
    return deviceToken;
  }

  Future<Either<String, UserModel>> signUp({
    required UserModel user,
    required String password,
  }) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      Get.log('$logHeader User ${credentials.user?.uid} was created');
      if (credentials.user == null) {
        return left("Erro ao finalizar o cadastro");
      }
      await credentials.user?.updateDisplayName(user.name);
      await credentials.user?.updateDisplayName(user.name);
      final userCredential = credentials.user!;
      final userModel = user.copyWith(
        id: userCredential.uid,
        // notificationId: await getFCMToke(),
      );
      final userWithUpdatedId = await updateUserOnCollection(userModel);
      if (userWithUpdatedId != null) {
        await storage.setUser(userWithUpdatedId);
      }
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      Get.log('$logHeader Error when created user ${e.message} - ${e.code}');
      if (e.code == "email-already-in-use") {
        return left("Esse e-mail já está cadastrado");
      }
      return left(e.message ?? "Algo deu errado");
    }
  }

  Future<Either<String, UserModel>> signIn({
    required String email,
    required String password,
    required void Function(String message, {Color? textColor}) onError,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await getUserInfo(credential.user!.uid);
      if (user == null) {
        return Left('Algo deu errado!');
      }

      return Right(user);
      // final userWithFCMToken = user.copyWith(
      //   notificationId: await getFCMToke(),
      // );
      // await updateUserOnCollection(userWithFCMToken);
      // await storage.setUser(userWithFCMToken);
      // return userWithFCMToken;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        return Left('Perfil desativado');
      } else {
        return Left('Usuário ou senha incorreto!');
      }
    } catch (e) {
      return Left('Algo deu errado!');
    }
  }

  Future<void> signOut() => _auth.signOut();

  Future<bool> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageToStorage({
    required String userId,
    required File userImage,
  }) async {
    try {
      final extensionFile = path.extension(userImage.path);
      final storageRef = FirebaseStorage.instance.ref().child(
            '$userId/images/${DateTime.now().millisecondsSinceEpoch}$extensionFile',
          );
      if (!userImage.existsSync()) return '';
      // if (!kDebugMode) {
      await storageRef.putFile(File(userImage.path));
      // }
      final url = await storageRef.getDownloadURL();
      return url;
    } catch (e) {
      Get.log('$logHeader Error when upload image to storage $e.');
      return '';
    }
  }
}
