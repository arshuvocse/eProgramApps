import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/helpers/database_helper.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'widget_test.mocks.dart';

@GenerateMocks([DatabaseHelper, AuthService, http.Client])
void main() {
  testWidgets('LoginView allows user to log in', (WidgetTester tester) async {
    final mockDatabaseHelper = MockDatabaseHelper();
    final mockAuthService = MockAuthService();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<DatabaseHelper>.value(value: mockDatabaseHelper),
          Provider<AuthService>.value(value: mockAuthService),
        ],
        child: const MaterialApp(home: LoginView()),
      ),
    );

    // Enter text into the username and password fields.
    await tester.enterText(find.byKey(const Key('username_field')), 'testuser');
    await tester.enterText(find.byKey(const Key('password_field')), 'password');

    // Stub the login method to return a user.
    final user = User(
      userId: 1,
      empInfoId: 1,
      userName: 'testuser',
      empMasterCode: 'test',
      userType: 'test',
      loginName: 'test',
      password: 'password',
      userEmail: 'test@test.com',
      contactInfo: 'test',
      userCo: 'test',
      roleTypeId: 1,
      isApprove: true,
      isForward: true,
      roleType: 'test',
      isImeiMatched: 1,
      versionName: '1.0',
      isTrackEnable: true,
      empRole: 'test',
      desigName: 'test',
    );
    when(mockAuthService.login('testuser', 'password', ''))
        .thenAnswer((_) async => user);

    // Tap the login button.
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pump();

    // Verify that the insertUser method was called.
    verify(mockDatabaseHelper.insertUser(user)).called(1);
  });
}
