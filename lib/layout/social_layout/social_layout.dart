import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit=SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions:
            [
              IconButton(onPressed: (){}, icon: Icon(
                IconBroken.Notification,
                size: 30,
              )),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(onPressed: (){}, icon: Icon(
                    IconBroken.Search,
                  size: 30,
                )),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items:
            [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
            ],
            onTap: (index){
              cubit.changeBottomNavBar(index,context);
            },
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screens[cubit.currentIndex],
          ///email verification firebase send and ui
          // body: ConditionalBuilder(
          //   condition: cubit.model!=null,
          //   builder: (context){
          //   var  model=cubit.model;
          //   return  Column(
          //       children: [
          //        // if(model!.isEmailVerified==false)
          //         if(!FirebaseAuth.instance.currentUser!.emailVerified)
          //         Container(
          //           color: Colors.amber.withOpacity(.6),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               children: [
          //                 Icon(Icons.info_outline_rounded),
          //                 SizedBox(width: 10,),
          //                 Text('Please verify your email',style: TextStyle(fontSize: 15),),
          //                 Spacer(),
          //                 TextButton(onPressed: (){
          //                   FirebaseAuth.instance.currentUser!.sendEmailVerification()
          //                       .then((value) {
          //                     showToast(text: 'check your email', state: ToastState.SUCCESS);
          //                   }).catchError((error){
          //                     print(error);
          //                     showToast(text: 'Failed', state: ToastState.ERROR);
          //                   });
          //                 }, child: Text('Send verification',style: TextStyle(fontSize: 15),),),
          //               ],
          //             ),
          //           ),
          //         )
          //       ],
          //     );
          //   },
          //   fallback:(context)=> Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }
}
