import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/cubit.dart';
import 'package:social_app_firebase/layout/social_layout/cubit/states.dart';
import 'package:social_app_firebase/models/post_model/post_model.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).posts!.length>0 ,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/photo-delighted-cheerful-afro-american-woman-with-crisp-hair-points-away-shows-blank-space-happy-advertise-item-sale-wears-orange-jumper-demonstrates-where-clothes-shop-situated_273609-26392.jpg?w=1060&t=st=1659792472~exp=1659793072~hmac=72af37059b59288c035e9c2055b72171251e2c4464fe4e88f4b9888d606ec818',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts![index],context,index),
                    itemCount: SocialCubit.get(context).posts!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator()),
          ),
        );
      },

    );
  }

  Widget buildPostItem(PostModel model,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 7,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.check_circle,
                        size: 18,
                      ),
                    ],
                  ),
                  Text(
                    '${model.dateTime}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(height: 1.2),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.text}',
            style: TextStyle(
              height: 1.1,
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(right: 5.0),
          //         child: Container(
          //           height: 22,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 1,
          //             onPressed: () {},
          //             child: Text(
          //               '#softwate',
          //               style: TextStyle(color: Colors.blue),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 5.0),
          //         child: Container(
          //           height: 22,
          //           child: MaterialButton(
          //             minWidth: 1,
          //             padding: EdgeInsets.zero,
          //             onPressed: () {},
          //             child: Text(
          //               '#flutter',
          //               style: TextStyle(color: Colors.blue),
          //             ),
          //             clipBehavior: Clip.antiAliasWithSaveLayer,
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 5.0),
          //         child: Container(
          //           height: 22,
          //           child: MaterialButton(
          //             onPressed: () {},
          //             child: Text(
          //               '#softwate_flutter',
          //               style: TextStyle(color: Colors.blue),
          //             ),
          //             minWidth: 1,
          //             padding: EdgeInsets.zero,
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 5.0),
          //         child: Container(
          //           height: 22,
          //           child: MaterialButton(
          //             onPressed: () {},
          //             child: Text(
          //               '#softwate_development',
          //               style: TextStyle(color: Colors.blue),
          //             ),
          //             minWidth: 1,
          //             padding: EdgeInsets.zero,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          if(model.postImage !='')
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${model.postImage}'
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          SizedBox(height: 2,),
          Row(
            children:
            [
              Expanded(

                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Icon(IconBroken.Heart,color: Colors.red,),
                        SizedBox(width: 5,),
                        Text('${SocialCubit.get(context).likes![index]}',style: Theme.of(context).textTheme.caption,)
                      ],),
                  ),
                ),
              ),
              Expanded(

                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                      [
                        Icon(IconBroken.Chat,color: Colors.amber,),
                        SizedBox(width: 5,),
                        Text('0 comments',style: Theme.of(context).textTheme.caption,)
                      ],),
                  ),
                ),
              ),                      ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).model!.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: (){},
                  child: Text(
                    'write a comment...',
                    style: Theme.of(context)
                        .textTheme
                        .caption,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            SocialCubit.get(context).likePost(SocialCubit.get(context).postsId![index]);
                          },
                          child: Row(
                            children:
                            [
                              Icon(IconBroken.Heart,color: Colors.red,),
                              Text('Like',style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
