import 'package:flutter/material.dart';
import 'package:whichone/components/button.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BodyCheckEmail(),
    );
  }
}

class BodyCheckEmail extends StatelessWidget {
  BodyCheckEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                width: 350,
                height: 350,
                child: Image.asset('assets/images/email_sent.png'),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Check your mail',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'We have sent a password recover instructions to your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Button(
                textColor: Colors.white,
                fontSize: 20,
                text: 'Login',
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/Login',
                  (Route<dynamic> route) => false,
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Did not receive the email ? Check your spam filter,',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          ' try another email address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffdc8c97),
                            fontFamily: 'Montserrat',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
