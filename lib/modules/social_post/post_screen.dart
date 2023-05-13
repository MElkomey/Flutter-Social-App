import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/shared/components/components.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

class PostScreen extends StatelessWidget {

var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Create Post', actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    if(SocialCubit.get(context).postImage==null){
                      SocialCubit.get(context).createPost(dateTime: DateTime.now().toString(), text: textController.text);
                    }else{
                      SocialCubit.get(context).uploadPostImage(dateTime: DateTime.now().toString(), text: textController.text);
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 25),
                  )),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 5,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).model!.image}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${SocialCubit.get(context).model!.name}',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Public',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Whats in your mind ...',
                        border: InputBorder.none),
                  ),
                ),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: FileImage(SocialCubit.get(context).postImage!) as ImageProvider ,
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      IconButton(onPressed: (){
                        SocialCubit.get(context).removePostImage();
                      }, icon:Icon( Icons.close))
                    ],
                  ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap:(){
                            SocialCubit.get(context).pickPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              Text(
                                'add photos',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '# tags',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
