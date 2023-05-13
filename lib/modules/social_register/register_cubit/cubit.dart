import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/models/user_model/user_model.dart';
import 'package:social_app_firebase/modules/social_register/register_cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(email: email, uId: value.user!.uid, name: name, phone: phone);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        bio: 'write your bio...',
        image:
            'https://img.freepik.com/premium-vector/profile-icon-arab-male-emotion-avatar_48369-1989.jpg?w=740',
      cover: 'https://img.freepik.com/free-photo/beautiful-tropical-beach-sea-with-coconut-palm-tree-paradise-island_74190-2206.jpg?w=1060&t=st=1659873944~exp=1659874544~hmac=38fcb8e0e8a46145ee3fa03e4de02f270a1eb80f976228e885476961ed0afbaa',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }
}
