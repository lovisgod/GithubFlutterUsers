import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterusers/network/client.dart';
import 'package:flutterusers/network/user.dart';
import 'package:toast/toast.dart';
import 'package:flutterusers/screens/detail.dart';
import 'package:shimmer/shimmer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Map<int, Color> color =
{
50:Color.fromRGBO(47, 48, 53, 1),
100:Color.fromRGBO(47, 48, 53, 2),
200:Color.fromRGBO(47, 48, 53, 3),
300:Color.fromRGBO(47, 48, 53, 4),
400:Color.fromRGBO(47, 48, 53, 5),
500:Color.fromRGBO(47, 48, 53, 6),
600:Color.fromRGBO(47, 48, 53, 7),
700:Color.fromRGBO(47, 48, 53, 8),
800:Color.fromRGBO(47, 48, 53, 9),
900:Color.fromRGBO(47, 48, 53, 1),
};
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Users',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff2F3035, color),
      ),
      home: UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  UserListPage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserListPage> {
  int count = 0;
  List<User> data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Client().fetchUsers().then((value) {
      List<User>users = List<User>();
      for (var item in value) {
        users.add(item);
      }
      setState(() {
        this.isLoading = false;
        this.count = users.length;
        this.data = users;
      });
    }).catchError((onError) {
      Toast.show('A network error occured', context, 
       duration: Toast.LENGTH_SHORT,
       gravity:  Toast.BOTTOM,
       backgroundColor: Color(0xff3E64FF),
       textColor: Colors.white
      );
    });
  } 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Users"),
      ),
      body: Scaffold(
        body: this.isLoading ? ShimmerList() :  userListItems() 
      ),
    );
  }

   ListView userListItems() {
           return ListView.separated(
               separatorBuilder: (context, index) => Divider(
               color: Color(0xffE5E5E5),
             ),
             itemCount: count,
             itemBuilder: (BuildContext context, int position) {
           return ListTile(
            leading: CircleAvatar(
             radius: 20.0, 
             backgroundImage: NetworkImage(this.data[position].avatar_url),
           ), 
           trailing: GestureDetector(
             onTap: () { 
               navigateToDetails(this.data[position]);
                
               },
             child: Container(
                 width: 80.0,
                 height: 30.0,
                 padding: EdgeInsets.all(6.0),
                  alignment: Alignment(0.0, 0.0),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(width: 1.0, color: Color(0xff2F3035)
                  ),
                  ), 
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Text( 
                      "View Profile",
                      textDirection: TextDirection.ltr,
                       style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 10.0,)
                     ),
                        ImageIcon( 
                        AssetImage(
                         'images/github_logo.png',
                    ),
                      size: 10.0,
                      semanticLabel: 'github logo',
                ),
                     ]
                    )
                   )
                   ),
          title: Text(this.data[position].username),
          onTap: () {
            debugPrint("Tapped on " + this.data[position].url);
          },
         );
     },
    );
  }

     void navigateToDetails(User user) async {
       bool result = await Navigator.push(context, 
       MaterialPageRoute(builder: (context) =>Detail(user))
    );
    //  if(result ==true) {
    //    getData();
    //  }
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          print(time);

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 200;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
