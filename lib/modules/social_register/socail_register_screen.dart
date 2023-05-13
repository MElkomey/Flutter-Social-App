


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/social_layout.dart';
import 'package:social_app_firebase/modules/social_register/register_cubit/cubit.dart';
import 'package:social_app_firebase/modules/social_register/register_cubit/states.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/network/local/shared_preferences/cashe_helper.dart';

class SocialRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialRegisterErrorState){
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if(state is SocialCreateUserSuccessState){
            showToast(text: 'Registered successfully', state: ToastState.SUCCESS);
            CasheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });

          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to communicate with your friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          contrl: nameController,
                          typ: TextInputType.name,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Name Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 10,),
                        defaultTextForm(
                          contrl: emailController,
                          typ: TextInputType.emailAddress,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Email Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          onSubmitd: (value) {},
                          contrl: passwordController,
                          typ: TextInputType.visiblePassword,
                          isPasswrd: SocialRegisterCubit.get(context).isPassword,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Password Is Too SHort';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          contrl: phoneController,
                          typ: TextInputType.phone,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Phone Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is SocialRegisterLoadingState|| state is SocialCreateUserLoadingState,
                          fallback: (context) => defalultButton(
                            text: 'register',
                            toUpperCase: state is !SocialRegisterLoadingState,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            },
                          ),
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
