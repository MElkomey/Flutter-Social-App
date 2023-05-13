import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
       var userModel=SocialCubit.get(context).model;
       nameController.text=userModel!.name!;
       bioController.text=userModel.bio!;
       phoneController.text=userModel.phone!;
       var profileImage=SocialCubit.get(context).profileImage;
       var coverImage=SocialCubit.get(context).coverImage;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: (){
                      SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                    },
                    child: Text('Update',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),),
                  ),
                )
              ]

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateUserProfileLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUpdateUserProfileLoadingState)
                    SizedBox(height: 10,),
                  Container(
                    height: 230,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                        image:
                                        coverImage==null? NetworkImage(
                                            '${userModel.cover!}'
                                        ) : FileImage(coverImage) as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(child: IconButton(onPressed: (){
                                  SocialCubit.get(context).pickCoverImage();
                                }, icon: Icon(IconBroken.Camera))),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:  profileImage==null ? NetworkImage(
                                  '${userModel.image}',
                                ) :FileImage(profileImage)as ImageProvider,
                              ),
                               CircleAvatar(child: IconButton(onPressed: (){
                                 SocialCubit.get(context).pickProfileImage();
                               }, icon: Icon(IconBroken.Camera))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  if(SocialCubit.get(context).profileImage!=null ||SocialCubit.get(context).coverImage!=null)
                  Row(
                    children:
                    [
                      if(SocialCubit.get(context).profileImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defalultButton(
                              function: (){
                                SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              text: 'Upload Image'
                            ),
                            if(state is SocialUploadProfileImageLoadingState|| state is SocialUpdateUserProfileLoadingState)
                            SizedBox(height: 5,),
                            if(state is SocialUploadProfileImageLoadingState|| state is SocialUpdateUserProfileLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).coverImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defalultButton(
                                function: (){
                                  SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                                },
                                text: 'Upload Cover'
                            ),
                            if(state is SocialUploadCoverImageLoadingState|| state is SocialUpdateUserProfileLoadingState)
                              SizedBox(height: 5,),
                            if(state is SocialUploadCoverImageLoadingState|| state is SocialUpdateUserProfileLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  defaultTextForm(
                      contrl: nameController,
                      typ: TextInputType.name,
                      validte: (value){
                        if(value?.isEmpty){
                          return 'Name musn\'t be empty';
                        }else{
                          return null;
                        }
                      },
                      labell: 'Name',
                      prefix: IconBroken.User1,
                  ),
                  SizedBox(height: 20,),
                  defaultTextForm(
                    contrl: bioController,
                    typ: TextInputType.text,
                    validte: (value){
                      if(value?.isEmpty){
                        return 'Bio musn\'t be empty';
                      }else{
                        return null;
                      }
                    },
                    labell: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(height: 20,),
                  defaultTextForm(
                    contrl: phoneController,
                    typ: TextInputType.phone,
                    validte: (value){
                      if(value?.isEmpty){
                        return 'Phone musn\'t be empty';
                      }else{
                        return null;
                      }
                    },
                    labell: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
