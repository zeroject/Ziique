import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ziique/CustomWidgets/change_credentials_widget.dart';
import 'package:ziique/FireService/fire_auth_service.dart';
import 'package:ziique/CustomWidgets/custom_friend_listview.dart';
import 'package:ziique/models/fire_user.dart';
import '../CustomWidgets/custom_mobile_scanner.dart';
import '../CustomWidgets/loadingscreen.dart';
import '../CustomWidgets/profile_image_widget.dart';
import '../FireService/fire_user_service.dart';
import '../models/user.dart' as beat_user;
import '../models/fire_user.dart' as fire_user;
import 'package:qr_flutter/qr_flutter.dart';


String scene = "";
String friendcode = beatuser!.uid;
beat_user.User? beatuser;
bool initialSceneSet = false;


const snackBar = SnackBar(content: Text('Code has been copied!'));

const editDisplayNameSnackBar = SnackBar(content: Text('Your Display Name has been updated!'));

class SettingsPageMobile extends StatefulWidget {
  const SettingsPageMobile(BuildContext context, {super.key, required this.initalScene});

  final String initalScene;
  @override
  State<SettingsPageMobile> createState() => _SettingsPageMobileState();
}

class _SettingsPageMobileState extends State<SettingsPageMobile> {
  bool light = true;
  bool light2 = true;
  bool light3 = true;
  TextEditingController addFriendController = TextEditingController();
  fire_user.User fireuser = FirebaseAuth.instance.currentUser!;
  final Future<beat_user.User?> userquery = Future(() => UserService().getUser(FirebaseAuth.instance.currentUser!.uid));
  TextEditingController changeDisplayName = TextEditingController();
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userquery,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(
                child: LoadingScreen(),
              );
          } else{
            if (!initialSceneSet){
              initialSceneSet = true;
              scene = widget.initalScene;
            }
            beatuser = snapshot.data;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (scene.contains('Account')) {
                return accountBuild(context);
              } else if(scene.contains('Payment')){
                return paymentBuild(context);
              } else if(scene.contains('Notifications')){
                return notificationsBuild(context);
              }else if(scene.contains('Security')){
                return securityBuild(context);
              }else if(scene.contains('Friends')){
                return friendBuild(context);
              }
              return accountBuild(context);

            });
          }
        }
      ),
    );
  }



Widget accountBuild(BuildContext context){

  return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
            width: 10
          ),
        ],
      ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Ziique_back_grey.png"),
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
              Row(
                children: [
                  kIsWeb ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                  Expanded(
                    child: ListView(
                      children: [
                      Container(
                        color: const Color.fromARGB(255, 57, 54, 54),
                        child:Padding(
                        padding: const EdgeInsets.all(30),
                        child: SizedBox(
                          width: 370,
                          child: Column(
                          children: [
                            ProfileImage(
                              imgUrl: beatuser!.profileImgUrl
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text('Displayname: ', style: TextStyle(color: Colors.white, fontSize: 24),),
                                FirebaseAuth.instance.currentUser!.displayName != null ? Text("${FirebaseAuth.instance.currentUser!.displayName}", 
                                  style: const TextStyle(color: Colors.white, fontSize: 20),) 
                                  : const Text("No DisplayName Yet", 
                                  style: TextStyle(color: Colors.white, fontSize: 20)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text('Name: ', style: TextStyle(color: Colors.white, fontSize: 24),),
                                Text("${beatuser!.firstname} ${beatuser!.lastname}", 
                                  style: const TextStyle(color: Colors.white, fontSize: 20),),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text('Email: ', style: TextStyle(color: Colors.white, fontSize: 24),),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(fireuser.email.toString(), 
                                  style: const TextStyle(color: Colors.white, fontSize: 20),)),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            const Text('Your Friend Code:', 
                              style: TextStyle(color: Colors.white, fontSize: 14),),
                      
                            Text(friendcode, style: const TextStyle(color: Colors.white, fontSize: 16, backgroundColor: Color.fromARGB(255, 77, 74, 74)),),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                                  onPressed: (){
                                    Clipboard.setData(ClipboardData(text: friendcode))
                                      .then((value){ScaffoldMessenger
                                      .of(context)
                                      .showSnackBar(snackBar);});
                                  },
                                  child: const Text('Copy code', style: TextStyle(color: Colors.white),)),
                                const Text("Or", style: TextStyle(color: Colors.white),),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                                  onPressed: (){
                                    showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: const Text("Friend QR-code"),
                                        content: SizedBox(
                                          height: 220,
                                          width: 220,
                                          child: QrImageView(data: beatuser!.uid, size: 200,)
                                        ),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("Ok")
                                        )
                                      ],
                                    ));
                                  },
                                  child: const Text("Show QR-code", style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: changeDisplayName,
                                    decoration: const InputDecoration(
                                      hintText: "New Display Name",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent),),
                                      labelStyle: TextStyle(
                                        color: Colors.white),
                                      hintStyle: TextStyle(
                                        color: Colors.white)),
                                  ),
                                ),
                              ElevatedButton(onPressed: (){
                                ChangeCredentialsService().changeDisplayName(changeDisplayName.text);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPageMobile(context, initalScene: "Account")));
                                ScaffoldMessenger.of(context).showSnackBar(editDisplayNameSnackBar);
                              }, child: const Text('Set Name', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            
                            const SizedBox(
                              height: 295,
                            ),
                            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){
                              showDialog(context: context, builder: (context) => AlertDialog(
                              title: const Text('You are trying to delete your Account, Are you sure?'),
                              content: const SizedBox(
                                height: 50,
                                width: 220,
                                child: Text('If your delete your account, you will lose all of your beats permanently.'),
                              ),
                              actions: [
                                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: (){
                                  Navigator.pop(context);
                                },
                                    child: const Text('Cancel')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                    onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  AuthService().signOut();
                                  UserService().deleteUser(FirebaseAuth.instance.currentUser!.uid);
                                }, child: const Text('Delete Account'))
                              ],
                            ));}, child: const Text('Delete Account', style: TextStyle(color: Colors.white, fontSize: 16),))
                          ],
                          ),
                        ),
                      ),
                      ),
                      ]
                    ),
                  ),
              ],
            ),
          )
        ]
      ),
    ),
  );
}

Widget paymentBuild(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12,
            alignment: Alignment.topCenter,
        ),
        const SizedBox(
            width: 10
        ),
      ],
    ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
    body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Ziique_back_grey.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 580,
            height: MediaQuery.of(context).size.height - 56,
            color: Colors.black26.withOpacity(1),

            child:
            Row(
              children: [
                kIsWeb ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                Expanded(
                  child: ListView(
                    children: [
                    Container(
                      color: const Color.fromARGB(255, 57, 54, 54),
                      child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 370,
                        child: Column(
                        children: [
                          Text(beatuser!.firstname, style: const TextStyle(color: Colors.white, fontSize: 24),),
                          const SizedBox(
                            height: 100,
                          ),
                          const Text('Add a credit card', style: TextStyle(color: Colors.white, fontSize: 24),),
                          Container(
                            width: 250,
                            height: 100,
                            color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Visa Credit Card', style: TextStyle(fontSize: 22, color: Colors.white),),
                                Text('Ends in 5847', style: TextStyle(fontSize: 22, color: Colors.white),),
                                Text('06/25', style: TextStyle(fontSize: 22, color: Colors.white),),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: (){}, 
                            child: 
                              const Text('Add Card', 
                                style: TextStyle(decoration: TextDecoration.underline,fontSize: 24, color: Colors.white),)),
                          const SizedBox(
                            height: 584,
                          ),
                        ],
                      ),
                      )
                      
                    )
                    ),
                    ],
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
  Widget notificationsBuild(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
              width: 10
          ),
        ],
      ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Ziique_back_grey.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 580,
              height: MediaQuery.of(context).size.height - 56,
              color: Colors.black26.withOpacity(1),

              child:
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    ],
                  ),
                  Container(
                    color: const Color.fromARGB(255, 57, 54, 54),
                    child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 370,
                          child: Row(children: [
                          const Text('Friend Requests', style: TextStyle(fontSize: 18, color: Colors.white), ),
                          Switch(value: light, activeColor: Colors.blue, onChanged: (bool value){setState(() {light = value;});}),
                        ],),),
                        SizedBox(
                          width: 269,
                          child: Row(children: [
                          const Text('General', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Switch(value: light2, activeColor: Colors.blue, onChanged: (bool value){setState(() {light2 = value;});}),
                        ],),),
                        
                        SizedBox(
                          width: 269,
                          child: Row(children: [
                          const Text('Updates', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Switch(value: light3, activeColor: Colors.blue, onChanged: (bool value){setState(() {light3 = value;});}),
                        ],),),
                        
                      ],
                    ),
                  )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
    Widget securityBuild(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12,
            alignment: Alignment.topCenter,
            ),
            const SizedBox(
                width: 10
            ),
          ],
        ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Ziique_back_grey.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 580,
                height: MediaQuery.of(context).size.height - 56,
                color: Colors.black26.withOpacity(1),

                child:
                Row(
                  children: [
                    kIsWeb ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                      Expanded(
                        child: ListView(
                          children: [
                          Container(
                            color: const Color.fromARGB(255, 57, 54, 54),
                            child: Padding(
                            padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 220,
                                    width: 350,
                                    child: CustomCredentialsChange(
                                      emailOrPassword: 'Email', 
                                    ),
                                  ),
                                  SizedBox(
                                    height: 220,
                                    width: 350,
                                    child: CustomCredentialsChange(
                                      emailOrPassword: 'Password', 
                                    ),
                                  ),
                                  SizedBox(
                                    height: 433,
                                  )
                              ],
                            ),
                          ),
                          ),
                          ]
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    Widget friendBuild(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12,
            alignment: Alignment.topCenter,
            ),
            const SizedBox(
                width: 10
            ),
          ],
        ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Ziique_back_grey.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 580,
                height: MediaQuery.of(context).size.height - 56,
                color: Colors.black26.withOpacity(1),

                child:
                Row(
                  children: [
                    kIsWeb ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: [ 
                        Container(
                          color: const Color.fromARGB(255, 57, 54, 54),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 370,
                                  child: ListView(
                                    children: [
                                      TextFormField(
                                        style: const TextStyle(color: Colors.white),
                                        controller: addFriendController,
                                        decoration: const InputDecoration(
                                          hintText: "Insert Friendcode",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blueAccent),), 
                                              labelStyle: TextStyle(
                                                color: Colors.white), 
                                                hintStyle: TextStyle(
                                                  color: Colors.white)),
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                                        onPressed: (){
                                          List<String> friends = beatuser!.friends;
                                          friends.add(addFriendController.text);
                                          UserService().updateFriendList(friends);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPageMobile(context, initalScene: "Friends")));
                                        }, 
                                        child: const Text("Add Friend with code", 
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      !kIsWeb ? OutlinedButton(
                                        style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => CustomMobileScanner(context, user: beatuser!,)));
                                        },
                                        child: const Text("Scan QR-code", style: TextStyle(color: Colors.white,))) : const Text("")
                                          ],
                                        ),
                                      ),
                                  SizedBox(
                                    height: 723,
                                    width: 370,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        beatuser!.friends.isNotEmpty ? const Text("Your friends:") : const Text(""),
                                        CustomFriendListView(
                                          beatuser: beatuser
                                          ),
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
            )
          ],
        ),
      ),
    );
  }

}