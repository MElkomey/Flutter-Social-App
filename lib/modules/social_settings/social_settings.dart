import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/modules/social_edit_profile/social_edit_profile.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context,state){},
      builder: (context,state){
       var usermodel=SocialCubit.get(context).model;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
              condition: usermodel!=null,
              builder: (context)=>Column(
                children: [
                  Container(
                    height: 230,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${usermodel!.cover!}'
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              '${usermodel.image!}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${usermodel.name!}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${usermodel.bio!}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '265',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Photos',
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              fallback:(context)=> Center(child: CircularProgressIndicator(),),
            ),
          ),
        );
      },

    );
  }
}
