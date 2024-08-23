import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:testapp/model/chatmodel.dart';
import 'package:testapp/model/message_model.dart';

class APIs {
  //  for the firbase authentication i.e login/signup

  static FirebaseAuth auth = FirebaseAuth.instance;

  // for the  firebase database handling

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage

  static FirebaseStorage storage = FirebaseStorage.instance;

//  to return current user

  static User get user => auth.currentUser!;

  // for storing selfInformation

  static late ChatUser me;

// For user Existed

  static Future<bool> userExist() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .get())
        .exists;
  }

// for getting selfinfo

  static Future<void> getSelfInfo() async {
    (
      await firestore.collection('users').doc(auth.currentUser?.uid).get().then(
        (user) async {
          if (user.exists) {
            me = ChatUser.fromJson(user.data()!);
            log("My data: ${user.data()}");
          } else {
            await createUser().then((value) => getSelfInfo());
          }
        },
      ),
    );
  }

// for creating new user

  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        about: "Hey, You are using ChatApp",
        createdAt: time,
        lastActive: time,
        id: user.uid,
        isOnline: false,
        email: user.email.toString(),
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

// for Getting all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static String getCOnversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

// last seen of the user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  //udate user last seen and update user info
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      "is_online": isOnline,
      "last_active": DateTime.now().microsecondsSinceEpoch.toString()
    });
  }

// for gettig all the message of specific conversation through firebase database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      ChatUser user) {
    return firestore
        .collection('chat/${getCOnversationID(user.id)}/message/')
        .orderBy("sent", descending: true)
        .snapshots();
  }

// for sending message

  static Future<void> sendMessage(
      ChatUser chat_user, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(
        toID: chat_user.id,
        msg: msg,
        read: "",
        type: type,
        sent: time,
        fromID: user.uid);
    final ref = firestore
        .collection('chat/${getCOnversationID(chat_user.id)}/message/');
    await ref.doc(time).set(message.toJson());
  }

// Update read message status for the blue tick
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chat/${getCOnversationID(message.fromID)}/message/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

// For user update

  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

  //for getting last messasge at the profile page

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chat/${getCOnversationID(user.id)}/message/')
        .orderBy("sent", descending: true)
        .limit(1)
        .snapshots();
  }

// for the prfile picture update

  static Future<void> updateProfilePicture(
      File file, VoidCallback onCompleted) async {
    final ext = file.path.split('.').last;
    log("Extension: $ext");
    log("Done here");
    final ref = storage.ref().child("profile_picture/ ${user.uid}");
    log("Not done here $ref");

    // Uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log("Data transfered: ${p0.bytesTransferred / 1000} kb");
    });

// updating image in firebase datbase

    me.image = await ref.getDownloadURL();

    log("ImageURl ${me.image}");
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
    onCompleted;
  }

// Send Chat Image to the storage
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    final ext = file.path.split('.').last;

    final ref = storage.ref().child(
        "image/${getCOnversationID(chatUser.id)} ${DateTime.now().microsecondsSinceEpoch}");

    // Uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log("Data transfered: ${p0.bytesTransferred / 1000} kb");
    });

// updating image in firebase datbase

    final imageUrl = await ref.getDownloadURL();

    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
