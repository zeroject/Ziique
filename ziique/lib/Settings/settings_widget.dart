import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/CustomWidgets/custom_change_credentials.dart';
import 'package:ziique/models/fire_user.dart';
import '../FireService/fire_user_service.dart';
import '../models/user.dart' as beat_user;
import '../models/fire_user.dart' as fire_user;

String scene = "Account";
String friendcode = '1234';
beat_user.User? beatuser;


const snackBar = SnackBar(content: Text('Code has been copied!'));


class SettingsPageDesktop extends StatelessWidget {
  const SettingsPageDesktop({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class SettingsPageMobile extends StatefulWidget {
    const SettingsPageMobile(BuildContext context, {super.key});

  @override
  State<SettingsPageMobile> createState() => _SettingsPageMobileState();
}

class _SettingsPageMobileState extends State<SettingsPageMobile> {
  bool light = true;
  bool light2 = true;
  bool light3 = true;
  fire_user.User fireuser = FirebaseAuth.instance.currentUser!;
  final Future<beat_user.User?> userquery = Future(() => UserService().getUser(FirebaseAuth.instance.currentUser!.uid));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userquery,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(
                child: CircularProgressIndicator(),
              );
          } else{
            beatuser = snapshot.data;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (scene.contains('Account')) {
                return build1(context);
              } else if(scene.contains('Payment')){
                return build2(context);
              } else if(scene.contains('Notifications')){
                return build3(context);
              }else if(scene.contains('Security')){
                return build4(context);
              }else if(scene.contains('Friends')){
                return build5(context);
              }
              return build1(context);

            });
          }
        }
      ),
    );
  }



Widget build1(BuildContext context){

  return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
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
                  Padding(
                    padding: const EdgeInsets.all(84.0),
                    child: Column(
                      children: [
                        Text(beatuser!.firstname, style: const TextStyle(color: Colors.white, fontSize: 24),),
                        Text(fireuser.email.toString(), style: const TextStyle(color: Colors.white, fontSize: 24),),
                        TextButton(onPressed: (){}, child: const Text('Change Email', style: TextStyle(decoration: TextDecoration.underline,fontSize: 24, color: Colors.blue),)),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('Your Friend Code:', style: TextStyle(color: Colors.white, fontSize: 14),),
                        Text(friendcode, style: const TextStyle(color: Colors.white, fontSize: 24, backgroundColor: Colors.grey),),
                        OutlinedButton(onPressed: (){
                          Clipboard.setData(ClipboardData(text: friendcode))
                          .then((value){ScaffoldMessenger
                          .of(context)
                          .showSnackBar(snackBar);});
                          }, 
                          child: const Text('Copy', style: TextStyle(color: Colors.white, fontSize: 24),))
                      ],
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

Widget build2(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
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
                Padding(
                  padding: const EdgeInsets.all(84.0),
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Visa Credit Card', style: TextStyle(fontSize: 22, color: Colors.white),),
                            Text('Ends in 5847', style: TextStyle(fontSize: 22, color: Colors.white),),
                            Text('06/25', style: TextStyle(fontSize: 22, color: Colors.white),),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(onPressed: (){}, child: const Text('Add Card', style: TextStyle(decoration: TextDecoration.underline,fontSize: 24, color: Colors.white),))
                    ],
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
  Widget build3(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text('Friend Request Notifications', style: TextStyle(fontSize: 18, color: Colors.white), ),
                          Switch(value: light, activeColor: Colors.blue, onChanged: (bool value){setState(() {light = value;});}),
                        ],),
                        Row(children: [
                          const Text('General Notifications', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Switch(value: light2, activeColor: Colors.blue, onChanged: (bool value){setState(() {light2 = value;});}),
                        ],),
                        Row(children: [
                          const Text('Notifications About Updates', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Switch(value: light3, activeColor: Colors.blue, onChanged: (bool value){setState(() {light3 = value;});}),
                        ],),
                      ],
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
    Widget build4(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState((){});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                      Container(
                        color: const Color.fromARGB(255, 57, 54, 54),
                        child: Padding(
                        padding: EdgeInsets.all(81),
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 220,
                              width: 269,
                              child: CustomCredentialsChange(
                                emailOrPassword: 'Email', 
                              ),
                            ),
                            SizedBox(
                              height: 220,
                              width: 269,
                              child: CustomCredentialsChange(
                                emailOrPassword: 'Password', 
                              ),
                            )
                          ],
                        ),
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
    Widget build5(BuildContext context){
      
      return Scaffold(
        appBar: AppBar(title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
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
                    Padding(
                      padding: const EdgeInsets.all(84.0),
                      child: SizedBox(
                        height: 700,
                        width: 250,
                        child: SingleChildScrollView(
                          child: FirestoreListView(
                          query: UserService().getFriends(beatuser!.friends),
                          shrinkWrap: true,
                          errorBuilder: (context, error, stackTrace){
                            return const Text("Error");
                          },
                          itemBuilder: (context, snapshot) { 
                            beat_user.User friend = snapshot.data();
                            return Column(
                              children: [
                                ExpansionTile(
                                  textColor: const Color.fromARGB(255, 0, 0, 0),
                                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                  collapsedBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  collapsedShape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  title: Text(
                                    "${friend.firstname} ${friend.lastname}",
                                    style: const TextStyle(fontSize: 20)),
                                children: [
                                  const ListTile(
                                    title: Text("A Description")
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OutlinedButton(onPressed: (){
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text("WARNING", style: TextStyle(
                                                  color: Color.fromARGB(255, 255, 60, 60)
                                                ),),
                                                content: const Text(
                                                    "You are about to remove one of your friends. Are you sure this is what you wanted?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Cancel")),
                                                  TextButton(
                                                      onPressed: () {
                                                        List<String> tempList = beatuser!.friends;
                                                        tempList.remove(friend.uid);
                                                        UserService().updateUser(
                                                          beat_user.User(
                                                          uid: FirebaseAuth.instance.currentUser!.uid, 
                                                          firstname: beatuser!.firstname, 
                                                          lastname: beatuser!.lastname, 
                                                          friends: tempList)
                                                        );
                                                      },
                                                      child: const Text("Yes"))
                                                ],
                                        ));
                                      }, 
                                      child: const Text("Remove Friend"))
                                    ],
                                  )
                                ],
                            ),
                              const SizedBox(
                                height: 5,
                            )
                              ],
                            ); 
                            }
                          ),
                        ),
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}