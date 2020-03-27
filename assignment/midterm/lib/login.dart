import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState(); // 여기 들어오면 바로 _LoginState() 실행
}

class _LoginPageState extends State<LoginPage>{
  Widget build(BuildContext context) { // 계속해서 그려줄거임
    return Scaffold(
      body: SafeArea( // MediaQuery로 디바이스 화면 면적을 계산해서 컨텐츠가 잘리거나 겹쳐지는 문제를 자동으로 잡아준다.
        child: ListView( // 스크롤이 가능하게 하려고
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
          ],
        ),
      ),
    );
  }
}