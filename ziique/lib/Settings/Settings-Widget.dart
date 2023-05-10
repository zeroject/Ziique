import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String scene = 'Account';
String friendcode = '1234';

const snackBar = SnackBar(content: Text('Code has been copied!'));

class SettingsPageDesktop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}

class SettingsPageMobile extends StatefulWidget {
    SettingsPageMobile(BuildContext context);

  @override
  State<SettingsPageMobile> createState() => _SettingsPageMobileState();
}

class _SettingsPageMobileState extends State<SettingsPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (scene.contains('Account')) {
            return Build1(context);
          } else if(scene.contains('Payment')){
            return Build2(context);
          };
          return Build1(context);
        }
    ),
    );
  }



Widget Build1(BuildContext context){

  return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12, alignment: Alignment.topCenter,
          ),
          const SizedBox(
            width: 10
          ),
        ],
      ), backgroundColor: Color.fromARGB(255, 44, 41, 41),),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/grey-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 600,
              height: MediaQuery.of(context).size.height - 56,
              color: Colors.black26.withOpacity(1),

              child:
              Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){}, child: Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){}, child: Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){}, child: Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(84.0),
                      child: Container(
                        child: Column(
                          children: [
                            Text('Name', style: TextStyle(color: Colors.white, fontSize: 24),),
                            Text('Email', style: TextStyle(color: Colors.white, fontSize: 24),),
                            TextButton(onPressed: (){}, child: Text('Change Email', style: TextStyle(decoration: TextDecoration.underline,fontSize: 24, color: Colors.blue),)),
                            SizedBox(
                              height: 30,
                            ),
                            Text('Your Friend Code:', style: TextStyle(color: Colors.white, fontSize: 14),),
                            Text(friendcode, style: TextStyle(color: Colors.white, fontSize: 24, backgroundColor: Colors.grey),),
                            OutlinedButton(onPressed: (){
                              Clipboard.setData(ClipboardData(text: friendcode))
                              .then((value){ScaffoldMessenger
                              .of(context)
                              .showSnackBar(snackBar);});
                              }, 
                              child: Text('Copy', style: TextStyle(color: Colors.white, fontSize: 24),))
                          ],
                        )
                      ),
                    )
                  ],
                ),
             ),
            ),
            ],
            ),
            ),
  );
}

Widget Build2(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/ZiiQue-Logo.png',
          scale: 12, alignment: Alignment.topCenter,
        ),
        const SizedBox(
            width: 10
        ),
      ],
    ), backgroundColor: Color.fromARGB(255, 44, 41, 41),),
    body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/grey-background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 600,
            height: MediaQuery.of(context).size.height - 56,
            color: Colors.black26.withOpacity(1),

            child:
            Container(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){}, child: Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){}, child: Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){}, child: Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(84.0),
                    child: Container(
                        child: Column(
                          children: [
                            Text('Card Name', style: TextStyle(color: Colors.white, fontSize: 24),),
                            Text('Funny 3 numbers on the back', style: TextStyle(color: Colors.white, fontSize: 24),),
                            TextButton(onPressed: (){}, child: Text('Change Email', style: TextStyle(decoration: TextDecoration.underline,fontSize: 24, color: Colors.blue),))
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}