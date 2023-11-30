part of 'password_bloc.dart';

// ignore: must_be_immutable
class PasswordState extends Equatable {
  final List<PasswordEntity> allPasswords;
  // const PasswordState(
  //     {this.allPasswords,
  //     this.creditCardList,
  //     this.favoriteList,
  //     this.otherList,
  //     this.recentUsedList,
  //     this.socialList,
  //     this.webSiteList});
  PasswordState(
      {List<PasswordEntity>? allPasswords,
      List<PasswordEntity>? socialList,
      List<PasswordEntity>? creditCardList,
      List<PasswordEntity>? favoriteList,
      List<PasswordEntity>? otherList,
      List<PasswordEntity>? recentUsedList,
      List<PasswordEntity>? webSiteList})
      : allPasswords = allPasswords ?? [],
        socialList = socialList ?? [],
        creditCardList = creditCardList ?? [],
        favoriteList = favoriteList ?? [],
        otherList = otherList ?? [],
        recentUsedList = recentUsedList ?? [],
        webSiteList = webSiteList ?? [];

  final List<PasswordEntity> socialList;
  final List<PasswordEntity> otherList;
  final List<PasswordEntity> creditCardList;
  final List<PasswordEntity> webSiteList;
  final List<PasswordEntity> favoriteList;
  final List<PasswordEntity> recentUsedList;

  @override
  List<Object?> get props => [
        allPasswords,
        socialList,
        otherList,
        creditCardList,
        webSiteList,
        favoriteList,
        recentUsedList
      ];

  static PasswordState copyWith(Map<String, List<PasswordEntity>> passwordMap) {
    return PasswordState(
      allPasswords: passwordMap['All']??[],
      creditCardList: passwordMap['CreditCard']??[],
      otherList: passwordMap['Other']??[],
      socialList: passwordMap['Social']??[],
      webSiteList: passwordMap['WebSite']??[]
    );
  }
}

class GetAllPasswordState extends PasswordState {
  final List<PasswordEntity> passwordsList;
  GetAllPasswordState(this.passwordsList) : super(allPasswords: passwordsList);
}

class LoadingState extends PasswordState {}

class ErrorState extends PasswordState {
  final String message;
  ErrorState({required this.message});
}

class PasswordAddedState extends PasswordState {}

class PasswordDeletedState extends PasswordState {}
