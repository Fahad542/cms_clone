import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:premier_cms/Database.dart';
import 'package:premier_cms/components/texffeild_Icon.dart';
import 'package:premier_cms/model/branch_drop.dart';
import 'package:premier_cms/model/branch_name.dart';
import 'package:premier_cms/model/product_drop.dart';
import 'package:premier_cms/model/reason_drop.dart';
import 'package:premier_cms/screens/dashboard.dart';
import 'package:premier_cms/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin  {
  AnimationController? controller;
  Animation? animation;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var email;
  var password;
  var getReason;
  var getProduct;
  var getBranch;
  var getBranchName;
  final List<DropdownMenuItem> reasonItems = [];
  final List<DropdownMenuItem> productItems = [];
  final List<DropdownMenuItem> branchItems = [];
  final List<DropdownMenuItem> branchnameItems = [];
  getData()async{
    getReason = await Api.listReason();
    getProduct = await Api.listProduct();
    getBranch = await Api.listBranch();
    getBranchName = await Api.listbranchname();
    print(getBranch.toString()+"bxkqbkxhbqkxqkbx");
    print(getProduct.toString()+"bxxnqonxnaisbhjbakjbxka");
    print(getReason.toString()+"bxxnqaxardxadxagfcafcafachavbbhjbjhbonxnaisbhjbakjbxka");
    print(getBranchName.toString());

    for (var j = 0; j < getBranch["Branch_Hierarchy_Master"].length; j++) {
      DBProvider.db.newClientBranch(Branch(id:int.parse(getBranch["Branch_Hierarchy_Master"][j]["id"].toString()),
          BranchName:getBranch["Branch_Hierarchy_Master"][j]["branchname"].toString() ));
      setState(() {
        branchItems.add(DropdownMenuItem(
          child: Text(getBranch["Branch_Hierarchy_Master"][j].toString()),
          value: getBranch["Branch_Hierarchy_Master"][j]["branchname"].toString(),
        ));
      });
    }
    print(branchItems.length.toString()+"jwjkwjsnnsnsnsnsnssnsnsnsnss");
    for (var j = 0; j < getBranchName['response']["data"].length; j++) {
      DBProvider.db.newClientBranchName(Branchname(id:int.parse(getBranchName['response']["data"][j]["branch_code"].toString()),
          branchname:getBranchName['response']["data"][j]["branch_name"].toString() ));
      setState(() {
        branchnameItems.add(DropdownMenuItem(
          child: Text(getBranchName['response']["data"][j].toString()),
          value: getBranchName['response']["data"][j]["branch_name"].toString(),
        ));
      });
    }
    print("branchnameItems: ${branchnameItems.length.toString()}");
    for (var i = 0; i < getProduct["Product_Hierarchy_Master"].length; i++) {
      DBProvider.db.newClientProduct(Product(id:int.parse(getProduct["Product_Hierarchy_Master"][i]["id"].toString()),
          ProductName:getProduct["Product_Hierarchy_Master"][i]["productname"].toString() ));
      setState(() {
        productItems.add(DropdownMenuItem(
          child: Text(getProduct["Product_Hierarchy_Master"][i]["productname"].toString()),
          value: getProduct["Product_Hierarchy_Master"][i]["productname"].toString(),
        ));
      });
    }
    print(productItems.length.toString()+"ckjbwsihcbkwjcnkwjnckwjnw");

    for (var k = 0; k < getReason["Reasons_Hierarchy_Master"].length; k++) {
      DBProvider.db.newClient(Reason(id:int.parse(getReason["Reasons_Hierarchy_Master"][k]["id"].toString()),
          ReasonName:getReason["Reasons_Hierarchy_Master"][k]["reasons"].toString()  ));
      setState(() {
        reasonItems.add(DropdownMenuItem(
          child: Text(getReason["Reasons_Hierarchy_Master"][k]["reasons"].toString()),
          value: getReason["Reasons_Hierarchy_Master"][k]["reasons"].toString(),
        ));
      });
    }
    print(reasonItems.length.toString()+"jcbwcnwncwjncw");

  }

  showDialogue(context) {
    return showDialog(
        context: context,
        barrierColor: Colors.white54,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white24,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller?.forward();
    controller?.addListener(() {
      setState(() {});
      print(animation?.value);
    });
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height =MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: _height*0.3,
            // color: const Color(0xff77787b),
           // color: const Color(0xff3E4684),
            padding: EdgeInsets.all(25),
            child: Center(
              child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/Premier-Logo.png')
              // Image.asset("assets/images/logo.png"),
            )
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: 0.9,
            builder: (context, controller)=> ClipRRect(
              borderRadius:const  BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Color(0xff3E4684)
                  // color: Color(0xff77787b) ,
                ),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    // padding: EdgeInsets.only(top: 10),
                    // controller: controller,
                    children: [
                      SizedBox(height: _height*0.1,),
                      TextFormCont(
                        feildController: emailController,
                        onchangeFunc: (){
                        },
                        labeltitle: "Email",
                        iconName: Icons.account_circle_rounded,
                        paddingBorders: 20,
                        obsecureBool: false,
                      ),
                      SizedBox(height: _height*0.0,),
                      TextFormCont(
                        labeltitle: "Password",
                        onchangeFunc: (){

                        },
                        feildController: passController,
                        obsecureBool: true,
                        iconName: Icons.account_circle_rounded,
                        paddingBorders: 20,
                      ),
                      SizedBox(height: _height*0.03,),
                      Container(
                        width: _width*0.5,
                        height: _height*0.05,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                           // color: Color(0xff3E4684)
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: TextButton(
                          onPressed: ()async{
                            FocusScope.of(context).unfocus();
                            showDialogue(context);
                            bool result = await InternetConnectionChecker().hasConnection;
                            if(result==true){
                              var i = await Api.Login(emailController.text.toString(),passController.text.toString());
                              Map jsonData =
                              json.decode(i) as Map;
                              print(jsonData.toString());
                              if(jsonData["LoginMsg"]=="Login Successfull"){
                                await getData();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('loginusername',jsonData['userName'].toString());
                                prefs.setString("loginedUserid",jsonData['userId'].toString());
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>const  DashBoard()
                                    ),
                                        (route) => false
                                );
                              } else if(jsonData["LoginMsg"]=="Incorrect Credentials"){
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Login Failed"),
                                      content: Text(
                                          jsonData['LoginMsg']
                                              .toString()),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if(jsonData==null){
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Login Failed"),
                                      content:const  Text("Please Check Your Connection"),
                                      actions: [
                                        TextButton(
                                          child: const Text("OK"),
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else{
                              Navigator.pop(context);
                              await Flushbar(
                                title: 'No Connection',
                                message:
                                'Please make sure your are connected to internet',
                                duration: Duration(seconds: 3),
                              ).show(context);
                            }

                          },
                          child:const  Text("LOGIN",style: TextStyle(
                              color: Color(0xff3E4684),
                              fontSize: 18
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

          ),

        ],
      ),
    );
  }
}