import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/models/message_model/message_model.dart';
import 'package:social_app_firebase/models/user_model/user_model.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  ChatDetailsScreen({this.userModel});
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getChatMessages(receiverId: userModel!.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${userModel!.image}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userModel!.name}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            height: 1.4,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages?.length !=null,
              builder: (context )=>Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                   Expanded(
                     child: ListView.separated(
                       physics: BouncingScrollPhysics(),
                         itemBuilder: (context, index){
                          var message=SocialCubit.get(context).messages![index];
                           if(SocialCubit.get(context).model!.uId == message.senderId)
                             return buildMyMessage(message);

                           return buildMessage(message);
                         },
                         separatorBuilder: (context,index)=>SizedBox(height: 8,),
                         itemCount: SocialCubit.get(context).messages!.length,
                     ),
                   ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'write your message here...'),
                                controller: messageController,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                    text: messageController.text,
                                    receiverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                  );
                                  messageController.text = '';
                                  // SocialCubit.get(context).getChatMessages(receiverId: userModel!.uId!);
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              '${model.text}',
              style: TextStyle(fontSize: 16),
            )),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(
              '${model.text}',
              style: TextStyle(fontSize: 16),
            )),
      );
}
