
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/social_layout.dart';
import 'package:social_app_firebase/modules/social_login/login_cubit/cubit.dart';
import 'package:social_app_firebase/modules/social_login/login_cubit/states.dart';
import 'package:social_app_firebase/modules/social_register/socail_register_screen.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/network/local/shared_preferences/cashe_helper.dart';

class SocialLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if(state is SocialLoginSuccessState){
            showToast(text: 'Logging successfully', state: ToastState.SUCCESS);
            CasheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                              color: Colors.black,
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          'Login now to communicate with your friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          contrl: emailController,
                          typ: TextInputType.emailAddress,
                          validte: (value) {
                            if (value?.isEmpty) {
                              return 'Email Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          onSubmitd: (value) {
                            if (formKey.currentState!.validate()) {
                              // SocialLoginCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text);
                            }
                          },
                          contrl: passwordController,
                          typ: TextInputType.visiblePassword,
                          isPasswrd: SocialLoginCubit.get(context).isPassword,
                          validte: (value) {
                            if (value?.isEmpty) {
                              return 'Password Is Too SHort';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defalultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont\'t have an account?',
                              style: TextStyle(fontSize: 16),
                            ),
                            defaultTextButton(
                              text: 'register now',
                              function: () {
                                navigateTo(context, SocialRegister());
                              },
                            )
                          ],
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
