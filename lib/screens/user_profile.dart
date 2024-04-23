
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premier_cms/Database.dart';
import 'package:premier_cms/screens/home_page.dart';
import 'package:premier_cms/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
String pending='';
String total='';
double percentageAchieved=0.0;
  var name;
  var ApiData;
  bool dataBool = false;
  getData()async{
    SharedPreferences prefs =
    await SharedPreferences
        .getInstance();
    name = prefs.getString('loginusername');
    ApiData = await Api.profileData(name.toString());
    if(ApiData!=null){
      setState((){
        dataBool = true;
      });
    }
  }


  void initState() {
    getData();
  }
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
     // backgroundColor: Color(0xff3E4684).withOpacity(0.4),
      body: SafeArea(
        child: dataBool == false
            ? Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(child: CircularProgressIndicator(color: Color(0xff3E4684
          ),)),
        )


            :
        Column(
          children: [

            SingleChildScrollView(
                  child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Color(0xff3E4684),

                            fontSize: _width * 0.06, // Example: 5% of the screen width
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(""),
                            ElevatedButton(
                              onPressed: () async {
                                DBProvider.db.deleteAllReason();
                                DBProvider.db.deleteAllBranch();
                                DBProvider.db.deleteAllComplain();
                                DBProvider.db.deleteAllPRoduct();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                      (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // Set the background color to red
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                ),
                              ),
                              child: Text(
                                "SIGN OUT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: _height * 0.03),
                    Stack(
                      children: [
                        Container(
                          height: _height * 0.19,
                          width: _width * 0.9,
                          margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:  Color(0xff3E4684),
                            borderRadius: BorderRadius.circular(_width * 0.05),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: _width * 0.003,
                                blurRadius: _width * 0.008,
                                offset: Offset(0, _width * 0.01),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(_width * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Username : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _width * 0.05,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      name.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _width * 0.05,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: _height * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Complains Achievement ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white, fontSize: _width * 0.04, fontWeight: FontWeight.bold),
                                    ),

                                  ],
                                ),
                                SizedBox(height: _height * 0.009),
                                Row(
                                  children: [
                                    MyStyledProgressIndicator(value: ApiData["closedComplains"] / ApiData["totalComplains"] * 100),
                                    Spacer(),


                                    Image(
                                      image: AssetImage('assets/images/growth.png', ),
                                      height: 20,
                                      width: 10,
                                      color: Colors.white,
                                    ),
                                     SizedBox(width: 5,),
                                    Text("${(ApiData["closedComplains"] / ApiData["totalComplains"] * 100).round()}%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: _width * 0.03)),
                                  ],
                                ),
                                SizedBox(height: 5,),

                                Text("${(ApiData["closedComplains"] / ApiData["totalComplains"] * 100).round()}% of the complains have been resolved",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: _width * 0.03)),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 9,
                          left: _width * 0.675, // Adjust this value based on your layout
                          child: Container(
                            height: _width * 0.20, // Example: 15% of the screen width
                            width: _width * 0.20,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white), // White border
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: _width * 0.01,
                                  blurRadius: _width * 0.02,
                                  offset: Offset(0, _width * 0.02),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/dummy_avatar.png",
                                height: _width * 0.15,
                                width: _width * 0.20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),


                    SizedBox(height: _height * 0.03),

                    Text( textAlign: TextAlign.center,"Complains Details",
                      style: TextStyle( color: const Color(0xff3E4684), fontWeight: FontWeight.bold, fontSize: 19),),

                    SizedBox(height: _height * 0.02),
                    Container(
                      height: _height * 0.29,
                      width: _width * 0.9,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_width * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: _width * 0.003,
                            blurRadius: _width * 0.008,
                            offset: Offset(0, _width * 0.01),
                          ),
                        ],
                      ),
                      child:
                      Column(
                        children: [
                          Expanded(
                            child: Reusable(
                              containerColor: Colors.red,
                              imagePath: 'assets/images/total.png',
                              labelText: 'Total Complains',
                              labelColor: Colors.red,
                              valueText: ApiData["totalComplains"].toString(),
                              valueColor: Colors.red,
                            ),
                          ),
                          Divider(), // Divider between the first and second Reusable widget
                          Expanded(
                            child: Reusable(
                              containerColor: Colors.blue,
                              imagePath: 'assets/images/cl.png',
                              labelText: 'Closed Complains',
                              labelColor: Colors.blue,
                              valueText: ApiData["closedComplains"].toString(),
                              valueColor: Colors.blue,
                            ),
                          ),
                          Divider(), // Divider between the second and third Reusable widget
                          Expanded(
                            child: Reusable(
                              containerColor: Colors.green,
                              imagePath: 'assets/images/pending.png',
                              labelText: 'Pendings Complains',
                              labelColor: Colors.green,
                              valueText: ApiData["pendingComplains"].toString(),
                              valueColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                      SizedBox(height: 20,),




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
class MyContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  MyContainer({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 90,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
class Reusable extends StatefulWidget {
  final Color containerColor;
  final String imagePath;
  final String labelText;
  final Color labelColor;
  final String valueText;
  final Color valueColor;

  const Reusable({
    Key? key,
    required this.containerColor,
    required this.imagePath,
    required this.labelText,
    required this.labelColor,
    required this.valueText,
    required this.valueColor,
  }) : super(key: key);

  @override
  State<Reusable> createState() => _ReusableState();
}

class _ReusableState extends State<Reusable> {
  Color getShadowColor(Color containerColor) {
    // Calculate the shadow color based on the container color
    // You can customize this logic as per your design requirements
    return containerColor.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 45,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.containerColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: getShadowColor(widget.containerColor),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 15),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle
                    .of(context)
                    .style,
                children: [
                  TextSpan(
                    text: widget.labelText,
                    style: TextStyle(
                      color: widget.labelColor,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' \n ${widget.valueText}',
                    style: TextStyle(
                      color: widget.valueColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}








    //   Container(
    //     height: double.infinity,
    //     width: double.infinity,
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           top: _height*0.03,
    //           right: _width*0.03,
    //
    //           child: Material(
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               elevation: 2,
    //               child: Container(
    //                 height: _height*0.2,
    //                 width: _width*0.5,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     color: Colors.white
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     SizedBox(height: _height*0.05,),
    //                     Padding(
    //                       padding:  EdgeInsets.only(right: _width*0.2),
    //                       child: Container(
    //                         width: _height*0.3,
    //                         height: _height*0.08,
    //                         alignment: Alignment.centerLeft,
    //                         decoration: BoxDecoration(
    //                           color: Colors.white,
    //                           image:  const DecorationImage(
    //                             image: AssetImage("assets/images/dummy_avatar.png"),
    //                             fit: BoxFit.contain,
    //                           ),
    //                           border: Border.all(
    //                             color: const Color(0xFF928F83),
    //                           ),
    //                           shape: BoxShape.circle,
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: _height*0.01,),
    //                     Container(
    //                       padding: EdgeInsets.only(left: _width*0.07),
    //                       alignment: Alignment.centerLeft,
    //                       child: Text(
    //                         name.toString(),
    //                         style: const TextStyle(
    //                           color: Colors.black87,
    //                           fontWeight: FontWeight.w600,
    //                           fontSize: 25.0,
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               )),
    //         ),
    //         Positioned(
    //           top: _height*0.1,
    //           left: _width*0.03,
    //           child: Material(
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               elevation: 2,
    //               child: Container(
    //                 height: _height*0.18,
    //                 width: _width*0.42,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     color: const Color(0xff73b54a)
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     SizedBox(height: _height*0.05,),
    //                     Container(
    //                       alignment: Alignment.center,
    //                       child: Text("Total Complains",style: TextStyle(
    //                           color: Colors.white,fontWeight:FontWeight.w700,fontSize:20
    //                       ),),
    //                     ),
    //                     SizedBox(height: _height*0.02,),
    //                     Container(
    //                       alignment: Alignment.center,
    //                       child: Text(ApiData["totalComplains"].toString(),style: TextStyle(
    //                           color: Colors.white,fontSize:25,fontWeight: FontWeight.w500
    //                       ),),
    //                     )
    //                   ],
    //                 ),
    //               )),
    //         ),
    //         Positioned(
    //           top: _height*0.3,
    //           left: _width*0.03,
    //           // right: _width*0.03,
    //           child: Material(
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               elevation: 2,
    //               child: Container(
    //                 padding: EdgeInsets.only(left: 10,right: 5),
    //                 height: _height*0.1,
    //                 width: _width*0.42,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     color: Colors.white
    //                 ),
    //                 alignment: Alignment.center,
    //                 child: Text("Closed Complains " + ApiData["closedComplains"].toString()
    //                     ,style: TextStyle(
    //                         color: Colors.black,fontWeight:FontWeight.w500,fontSize:20
    //                     )),
    //               )),
    //         ),
    //         Positioned(
    //           top: _height*0.25,
    //           // left: _width*0.03,
    //           right: _width*0.03,
    //           child: Material(
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               elevation: 2,
    //               child: Container(
    //                 height: _height*0.15,
    //                 width: _width*0.5,
    //                 padding: EdgeInsets.only(left: 10,right: 5),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     color: const Color(0xff73b54a)
    //                 ),
    //                 alignment: Alignment.center,
    //                 child: Text("pending Complains " + ApiData["pendingComplains"].toString()
    //                     ,style: TextStyle(
    //                         color: Colors.white,fontWeight:FontWeight.w500,fontSize:20
    //                     )),
    //               )),
    //         ),
    //         Positioned(
    //           top: _height*0.42,
    //           left: _width*0.03,
    //           right: _width*0.03,
    //           child: Material(
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               elevation: 2,
    //               child: Container(
    //                 padding: EdgeInsets.only(left: 10,right: 5),
    //                 height: _height*0.13,
    //                 // width: _width*0.42,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     color: const Color(0xff73b54a)
    //                 ),
    //                 alignment: Alignment.center,
    //                 child: TextButton(
    //                   onPressed: ()async{
    //                     DBProvider.db.deleteAllReason();
    //                     DBProvider.db.deleteAllBranch();
    //                     DBProvider.db.deleteAllComplain();
    //                     DBProvider.db.deleteAllPRoduct();
    //                     SharedPreferences prefs = await SharedPreferences.getInstance();
    //                     await prefs.clear();
    //                     Navigator.pushAndRemoveUntil(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context)=>  MyHomePage()
    //                         ),
    //                             (route) => false
    //                     );
    //                   },
    //                   child: Text("SignOut"
    //                       ,style: TextStyle(
    //                           color: Colors.white,fontWeight:FontWeight.w500,fontSize:35
    //                       )),
    //                 ),
    //               )),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
class MyStyledProgressIndicator extends StatelessWidget {
  final double value;

  MyStyledProgressIndicator({required this.value});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    // Scale the value from 0-100 to 0.0-1.0
    double scaledValue = this.value / 100.0;

    return Container(
      height: 4.0,
      width: _width * 0.6, // Adjust the width based on screen width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0), // Adjust the border radius
        color: Colors.grey[300],
      ),
      child: LinearProgressIndicator(
        value: scaledValue,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }

}

