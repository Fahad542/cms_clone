
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:premier_cms/Database.dart';
import 'package:premier_cms/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LocalOrders extends StatefulWidget {
  const LocalOrders({Key? key}) : super(key: key);

  @override
  State<LocalOrders> createState() => _LocalOrdersState();
}

class _LocalOrdersState extends State<LocalOrders> {

  var getComplain;
  bool dataBool=false;
  bool backEnable = true;
  final TextStyle shopNameStyle = TextStyle(
    color: Colors.blue, // Set the color of the shop name text
  );

  getData()async{
    getComplain = await DBProvider.db.getAllClientsComplain();
    if(getComplain!=null&&getComplain.length!=0){
      setState((){
        dataBool= true;
      });
    }
    print(getComplain.length.toString());
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
    getData();
  }

  Future<bool?> _onBackPressed() async {
    if(backEnable==true){
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height =MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                SizedBox(height: _height * 0.02,),
                Container(
                  height: _height * 0.07,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      const Center(
                        child: Text("Complain List", style: TextStyle(
                            color: Color(0xff3E4684), fontWeight: FontWeight.w600,
                            fontSize: 25
                        ),),
                      ),
                    ],
                  ),
                ),
                dataBool == false ? Container(
                  height: _height * 0.7,
                  width: _width,
                  child: Center(
                    child: Text("No Complains"),
                  ),
                ) :
                Expanded(
            //   physics: AlwaysScrollableScrollPhysics(),
                    child:
                       Stack(
                         children:[
                           ListView.builder(
                                shrinkWrap: true,
                             scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Container(
                                     // height: _height * 0.2,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: _width * 0.03),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff3E4684).withOpacity(0.3), // Shadow color and opacity
                                            spreadRadius: 2,  // Spread radius
                                            blurRadius: 5,    // Blur radius
                                            offset: Offset(0, 3), // Shadow position, positive value moves the shadow below the box
                                          ),
                                        ],// Adjust opacity as needed
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0), // Add padding between each Text widget
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Shop Name: ',
                                                          style:  TextStyle(
                                                              color: Color(0xff3E4684),
                                                              fontWeight: FontWeight.bold

                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: '${getComplain[index].ShopName.toString()}',
                                                          style: TextStyle(
                                                            color: Colors.black, // Change color as needed
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                   await DBProvider.db.deleteClient(int.parse(getComplain[index].id.toString()));
                                                   setState(() {
                                                     getComplain.removeAt(index);
                                                     Fluttertoast.showToast(
                                                       msg: "Complain is Successfully Deleted",
                                                       toastLength: Toast.LENGTH_SHORT,
                                                       gravity: ToastGravity.BOTTOM,
                                                       backgroundColor: Colors.green,
                                                       textColor: Colors.white,
                                                       fontSize: 16.0,
                                                     );
                                                   }
                                                   );
                                                  },
                                                    child:
                                                    Icon(Icons.delete, color: Colors.red)
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0), // Add padding between each Text widget
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Reasons: ',
                                                      style:  TextStyle(
                                                          color: Color(0xff3E4684),
                                                          fontWeight: FontWeight.bold
                                                        // Change color as needed
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '${getComplain[index].Reason.toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black, // Change color as needed
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0), // Add padding between each Text widget
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Product Name: ',
                                                      style:  TextStyle(
                                                          color: Color(0xff3E4684),
                                                          fontWeight: FontWeight.bold
                                                        // Change color as needed
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '${getComplain[index].ProductName.toString()}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0), // Add padding between each Text widget
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Address: ',
                                                      style: TextStyle(
                                                        color: Color(0xff3E4684),
                                                        fontWeight: FontWeight.bold
                                                        // Change color as needed
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '${getComplain[index].Address.toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: getComplain.length),
                            // SizedBox(height: _height * 0.02,),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: dataBool == false ? Container() : Container(
                      width: _width * 0.7,
                      height: _height * 0.06,
                      decoration: const BoxDecoration(
                          color: Color(0xff3E4684),
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      child:
                      TextButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var userName = prefs.getString('loginusername');
                          if (userName != null) { // Check if the username is not null
                            showDialogue(context);
                            setState(() {
                              backEnable = false;
                            });
                            bool result = await InternetConnectionChecker().hasConnection;
                            if (result == true) {
                              for (var i = 0; i < getComplain.length; i++) {
                                var data = await Api.UploadComplain(
                                    getComplain[i].EmployeeName.toString(),
                                    getComplain[i].EmployeeCode.toString(),
                                    getComplain[i].EmployeeNumber.toString(),
                                    getComplain[i].EmployeeNumberApi.toString(),
                                    getComplain[i].Address.toString(),
                                    getComplain[i].ProductName.toString(),
                                    getComplain[i].BranchName.toString(),
                                    getComplain[i].Reason.toString(),
                                    getComplain[i].EmployeeRemarks.toString(),
                                    userName.toString(),
                                    getComplain[i].ShopName.toString(),
                                    getComplain[i].code,
                                );
                                if (data == true) {
                                  await DBProvider.db
                                      .deleteClient(int.parse(getComplain[i].id.toString()));
                                }
                              }

                              setState(() {
                                dataBool = false;
                              });
                              Navigator.pop(context);
                            } else {
                              await Flushbar(
                                title: 'No Connection',
                                message:
                                'Please make sure you are connected to the internet',
                                duration: Duration(seconds: 3),
                              ).show(context);
                              Navigator.pop(context);
                            }
                          } else {
                            // Handle the case when the username is null
                            // You may want to show a message or navigate to the login screen
                            Fluttertoast.showToast(
                              msg: 'Username is null.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                        child: const Text("Sync Complain", style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: _height * 0.04,)
                       ]),
                      ),
                    

                  
                
              //  SizedBox(height: _height * 0.02,),
// Spacer(),
//                 dataBool == false ? Container() : Container(
//                   width: _width * 0.7,
//                   height: _height * 0.05,
//                   decoration: const BoxDecoration(
//                       color: Color(0xff3E4684),
//                       borderRadius: BorderRadius.all(Radius.circular(10))
//                   ),
//                   child:
//                   TextButton(
//                     onPressed: () async {
//                       SharedPreferences prefs = await SharedPreferences.getInstance();
//                       var userName = prefs.getString('loginusername');
// print(userName);
//                       if (userName != null) { // Check if the username is not null
//                         showDialogue(context);
//                         setState(() {
//                           backEnable = false;
//                         });
//                         bool result = await InternetConnectionChecker().hasConnection;
//                         if (result == true) {
//                           for (var i = 0; i < getComplain.length; i++) {
//                             var data = await Api.UploadComplain(
//                                 getComplain[i].EmployeeName.toString(),
//                                 getComplain[i].EmployeeCode.toString(),
//                                 getComplain[i].EmployeeNumber.toString(),
//                                 getComplain[i].EmployeeNumberApi.toString(),
//                                 getComplain[i].Address.toString(),
//                                 getComplain[i].ProductName.toString(),
//                                 getComplain[i].BranchName.toString(),
//                                 getComplain[i].Reason.toString(),
//                                 getComplain[i].EmployeeRemarks.toString(),
//                                 userName.toString(),
//                                 getComplain[i].ShopName.toString(),
//                                 getComplain[i].code,
//                             );
//                             if (data == true) {
//                               await DBProvider.db
//                                   .deleteClient(int.parse(getComplain[i].id.toString()));
//                             }
//                           }
//
//                           setState(() {
//                             dataBool = false;
//                           });
//                           Navigator.pop(context);
//                         } else {
//                           await Flushbar(
//                             title: 'No Connection',
//                             message:
//                             'Please make sure you are connected to the internet',
//                             duration: Duration(seconds: 3),
//                           ).show(context);
//                           Navigator.pop(context);
//                         }
//                       } else {
//                         // Handle the case when the username is null
//                         // You may want to show a message or navigate to the login screen
//                         Fluttertoast.showToast(
//                           msg: 'Username is null.',
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           backgroundColor: Colors.green,
//                           textColor: Colors.white,
//                           fontSize: 16.0,
//                         );
//                       }
//                     },
//                     child: const Text("Sync Complain", style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25
//                     ),),
//                   ),
//                 ),
//                 SizedBox(height: _height * 0.04,)
              ],
            ),
          ),

        ),

    );
  }
}
