abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserDataLoadingState extends SocialStates{}
class SocialGetUserDataSuccessState extends SocialStates{}
class SocialGetUserDataErrorState extends SocialStates{
  final String error;
  SocialGetUserDataErrorState(this.error);
}

class SocialBottomNavigationBarChangeState extends SocialStates{}

class SocialPostState extends SocialStates{}

class SocialPickProfileImageSuccessState extends SocialStates{}
class SocialPickProfileImageErrorState extends SocialStates{}

class SocialPickCoverImageSuccessState extends SocialStates{}
class SocialPickCoverImageErrorState extends SocialStates{}

class SocialUploadProfileImageLoadingState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageLoadingState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserProfileLoadingState extends SocialStates{}
class SocialUpdateUserProfileErrorState extends SocialStates{}

//post creation states

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialPickPostImageSuccessState extends SocialStates{}
class SocialPickPostImageErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}


//get all posts
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}

//like post
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}

//get all users
class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

//messages

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  final String error;
  SocialSendMessageErrorState(this.error);
}

class SocialGetMessagesSuccessState extends SocialStates{}
class SocialGetMessagesErrorState extends SocialStates{
  final String error;
  SocialGetMessagesErrorState(this.error);
}
//get chat messages
class SocialGetChatMessagesSuccessState extends SocialStates{}