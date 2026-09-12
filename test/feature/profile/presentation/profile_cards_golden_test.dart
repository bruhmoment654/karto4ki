import 'package:flutter/material.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';
import 'package:quizzerg/feature/profile/presentation/widget/profile_account_card.dart';
import 'package:quizzerg/feature/profile/presentation/widget/profile_sign_in_card.dart';
import 'package:zoloto/zoloto.dart';

const _user = AuthUserEntity(
  id: 'user-1',
  email: 'artem.kuznetsov@gmail.com',
  plan: 'free',
  displayName: 'Артём Кузнецов',
);

const _userWithoutName = AuthUserEntity(
  id: 'user-2',
  email: 'artem.kuznetsov@gmail.com',
  plan: 'free',
);

Widget _wrap(Widget child) => Padding(
      padding: const EdgeInsets.all(16),
      child: child,
    );

void main() {
  Zoloto.zolotoTest(
    'profile_account_card',
    widgetBuilder: (context, tester, testCase) =>
        _wrap(const ProfileAccountCard(user: _user)),
    testHeight: const TestHeight$BasedOnContent(),
  );

  // Имени нет — берём часть почты до @, инициалы остаются фолбэком аватара.
  Zoloto.zolotoTest(
    'profile_account_card_no_name',
    widgetBuilder: (context, tester, testCase) =>
        _wrap(const ProfileAccountCard(user: _userWithoutName)),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'profile_sign_in_card',
    widgetBuilder: (context, tester, testCase) =>
        _wrap(ProfileSignInCard(onTap: () {})),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
