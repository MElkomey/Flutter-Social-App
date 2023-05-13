import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/models/user_model/user_model.dart';
import 'package:social_app_firebase/modules/social_chat_details/social_chat_details.dart';
import 'package:social_app_firebase/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ConditionalBuilder(
              condition: SocialCubit.get(context).users!.length > 0,
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    SocialCubit.get(context).users![index], context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
                itemCount: SocialCubit.get(context).users!.length,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16, height: 1.4, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
  );
}
