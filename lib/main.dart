import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/firebase_options.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/layout/social_layout/social_layout.dart';
import 'package:social_app_firebase/modules/social_login/social_login_screen.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/components/constants.dart';
import 'package:social_app_firebase/shared/network/local/shared_preferences/cashe_helper.dart';
import 'package:social_app_firebase/shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
showToast(text: 'on background message', state: ToastState.SUCCESS);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // get token of user on cloud messaging
  var fcmToken= await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  //if app is opened it will print the data of notification
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
//if app is working but in back it will print the data
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  // show toast if app is in background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CasheHelper.init();
  Widget startWidget;
   uId=CasheHelper.getData(key: 'uId');
  print('UID is : ${uId}');
  if(uId != null) {
    startWidget = SocialLayout();
  }else{
    startWidget=SocialLogin();
  }

  runApp(MyApp(startWidget:startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context)=>SocialCubit()..getUserData()..getPosts(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social App',
            theme:lightTheme,
            home: startWidget,
          );
        },
    ),
    );
  }

}


