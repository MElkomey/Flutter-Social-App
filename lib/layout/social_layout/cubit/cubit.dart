import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/models/message_model/message_model.dart';
import 'package:social_app_firebase/models/post_model/post_model.dart';
import 'package:social_app_firebase/models/user_model/user_model.dart';
import 'package:social_app_firebase/modules/social_chats/social_chats.dart';
import 'package:social_app_firebase/modules/social_home/social_home.dart';
import 'package:social_app_firebase/modules/social_post/post_screen.dart';
import 'package:social_app_firebase/modules/social_settings/social_settings.dart';
import 'package:social_app_firebase/modules/social_users/social_users.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromjson(value.data());
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  void changeBottomNavBar(index, context) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      navigateTo(context, PostScreen());
      emit(SocialPostState());
    } else {
      currentIndex = index;
      emit(SocialBottomNavigationBarChangeState());
    }
  }

  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  ///using image picker
  File? profileImage;
  var picker = ImagePicker();
  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialPickProfileImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialPickProfileImageErrorState());
    }
  }

  File? coverImage;
  Future<void> pickCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialPickCoverImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialPickCoverImageErrorState());
    }
  }

  // String? profileImageUrl;
  void uploadProfileImage({required name, required phone, required bio}) {
    emit(SocialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, profileImage: value);
        // profileImageUrl = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // String? coverImageUrl;
  void uploadCoverImage({required name, required phone, required bio}) {
    emit(SocialUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        // coverImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio, coverImage: value);
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required name,
    required phone,
    required bio,
    String? profileImage,
    String? coverImage,
  }) {
    emit(SocialUpdateUserProfileLoadingState());
    UserModel newModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: model!.email,
      uId: model!.uId,
      isEmailVerified: model!.isEmailVerified,
      cover: coverImage ?? model!.cover,
      image: profileImage ?? model!.image,
    );
    print(model!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(newModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserProfileErrorState());
    });
  }

  void uploadPostImage({
    required dateTime,
    required text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
        // coverImageUrl = value;
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  File? postImage;
  Future<void> pickPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialPickPostImageErrorState());
    }
  }

  void createPost({
    required dateTime,
    required text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel newModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    print(model!.uId);
    FirebaseFirestore.instance
        .collection('posts')
        .add(newModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel>? posts = [];
  List? postsId = [];
  List<int>? likes = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes?.add(value.docs.length);
          postsId?.add(element.id);
          emit(SocialGetPostsSuccessState());
          posts?.add(PostModel.fromjson(element.data()));
        }).catchError((error) {});
      });
      print('the first post publisher: ${posts?.first.name}');
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<UserModel>? users = [];
  void getAllUsers() {
    users=[];
      emit(SocialGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId) {
            users?.add(UserModel.fromjson(element.data()));
          }
        });
        print('the first user name: ${users?.first.name}');
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });

  }

  void sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    MessageModel messageModel =MessageModel(
      senderId: model!.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc(model!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toMap()).then((value) {
emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel>? messages=[];
  void getChatMessages({required String receiverId}){

    FirebaseFirestore.instance
    .collection('users')
    .doc(model!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages?.add(MessageModel.fromjson(element.data()));
        emit(SocialGetChatMessagesSuccessState());
      });
      emit(SocialGetChatMessagesSuccessState());
    });

  }
}
