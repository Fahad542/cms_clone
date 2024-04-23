


import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:premier_cms/Database.dart';
import 'package:premier_cms/components/form_feild.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:premier_cms/services.dart';

import '../model/customer_check.dart';

class FormPage extends StatefulWidget {

  @override
  State<FormPage> createState() => _FormPageState();
}
class GlobalValues {
  static String customerPhoneapi = '';
}

class _FormPageState extends State<FormPage> {
  List<String> items = ["FMCG","Pharma"];
  String selectedItem = "Pharma";
  TextEditingController employeeCode = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController shopeName = TextEditingController();
  TextEditingController customerNumber = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController address = TextEditingController();
  String customerPhone='';
  bool verify=false;
  String selectedProduct = '';
  String selectedReason = '';
  String selectedBrand = '';
  String selectedBrandName = '';
  String selectedBrandNameid = '';
  @override
  var getReason;
  var getProduct;
  var getBranch;
  var getBranchName;
  String? code;
  final List<DropdownMenuItem> reasonItems = [];
  final List<DropdownMenuItem> productItems = [];
  final List<DropdownMenuItem> branchItems = [];
  final List<DropdownMenuItem> branchnameItems = [];
  // DBProvider db = DBProvider();

  void refresh() async {
    setState(()  {

      verify=false;
      employeeName.clear();
      customerNumber.clear();
      remarks.text = '';
      address.text='';
      selectedBrandName='';
      branchnameItems.clear();
      branchItems.clear();
      productItems.clear();
      reasonItems.clear();
      selectedBrandNameid = '';
      selectedProduct = '';
      selectedReason == null;
      selectedBrand = '';
      shopeName.text = '';
      employeeCode.text='';
      selectedItem="Pharma";


      // Add any other fields you want to reset here
    });
    await getData();


  }




  void refreshoncat() async {
    setState(()  {

      verify=false;
      employeeName.clear();
      customerNumber.clear();
      remarks.text = '';
      address.text='';
      selectedBrandName='';
      branchnameItems.clear();
      branchItems.clear();
      productItems.clear();
      reasonItems.clear();
      selectedBrandNameid = '';
      selectedProduct = '';
      selectedReason == null;
      selectedBrand = '';
      shopeName.text = '';
      employeeCode.text='';



      // Add any other fields you want to reset here
    });
    await getData();


  }

  getData()async{
    getReason = await DBProvider.db.getAllClients();
    getProduct = await DBProvider.db.getAllClientsProduct();
    getBranch = await DBProvider.db.getAllClientsBranch();
    getBranchName = await DBProvider.db.getAllClientsBranchName();
    print(getBranch.toString()+"bxkqbkxhbqkxqkbx");
    print(getProduct.toString()+"bxxnqonxnaisbhjbakjbxka");
    print(getReason.toString()+"bxxnqaxardxadxagfcafcafachavbbhjbjhbonxnaisbhjbakjbxka");
    print(getBranchName.toString());
    for (var j = 0; j < getBranch.length; j++) {
      setState(() {
        branchItems.add(DropdownMenuItem(
          child: Text(getBranch[j].BranchName.toString()),
          value: getBranch[j].BranchName.toString(),
        ));
      });
    }
    for (var i = 0; i < getProduct.length; i++) {
      setState(() {
        productItems.add(DropdownMenuItem(
          child: Text(getProduct[i].ProductName.toString()),
          value: getProduct[i].ProductName.toString(),
        ));
      });
    }
    for (var k = 0; k < getReason.length; k++) {
      setState(() {
        reasonItems.add(DropdownMenuItem(
          child: Text(getReason[k].ReasonName.toString()),
          value: getReason[k].ReasonName.toString(),
        ));
      });
    }
    for (var k = 0; k < getBranchName.length; k++) {
      setState(() {
        branchnameItems.add(DropdownMenuItem(
          child: Text("${selectedBrandName}"),
          value:"${getBranchName[k].id} - ${getBranchName[k].branchname}",
        ));
      });

    }
  }

  void initState() {
  //refresh();
    getData();
  }

  Widget build(BuildContext context) {
    double _height =MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return
      Scaffold( body:

      SafeArea(
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              SizedBox(
                height: _height*0.02,
              ),
              Container(
                height: _height*0.07,
                width: double.infinity,
                // alignment: Alignment.center,
                child: Stack(
                  children: [
                    Center(
                      child: Text("Add New Complain",style: TextStyle(
                          color: Color(0xff3E4684),fontWeight: FontWeight.w600,
                          fontSize: 25
                      ),),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: selectedItem=="Pharma",
                child: branchnameItems.length==0?Container():Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width*0.03),
                  child:
                  CustomSearchableDropDown(
                    items: branchnameItems,
                    label: selectedBrandName==''?'Branch List':"$selectedBrandName",
                    enabled: !verify,
                    // labelStyle:  const TextStyle(
                    //     color: Color(0xff73b54a),
                    //     fontSize: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: const Color(0xff3E4684)
                        )
                    ),
                    prefixIcon: const  Padding(
                      padding:  EdgeInsets.all(0.0),
                      child: Icon(Icons.search),
                    ),
                    dropDownMenuItems: branchnameItems.map((item) {
                      return item.value;
                    }).toList(),
                    onChanged: (value){
                      FocusScope.of(context).unfocus();
                      print(value);
                      if(value!=null)
                      {
                        setState(() {
                          selectedBrandName = value.value.toString();
                          print(selectedBrandName);
                          RegExp regex = RegExp(r'^(\d+) - (.+)$');

                          // Use firstMatch to get the matched groups
                          Match? match = regex.firstMatch(selectedBrandName);
                         code = match?.group(1);
                          print(code);

                        });

                      }
                      else{
                        selectedBrandName=value;

                      }
                    },
                  ),
                ),
              ),
              Visibility(
                visible: selectedItem=="FMCG",
                child: branchnameItems.length==0?Container():Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width*0.03),
                  child:
                  CustomSearchableDropDown(
                    items: branchnameItems,
                    label: selectedBrandName==''?'Branch List':"$selectedBrandName",
                   // enabled: !verify,
                    // labelStyle:  const TextStyle(
                    //     color: Color(0xff73b54a),
                    //     fontSize: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: const Color(0xff3E4684)
                        )
                    ),
                    prefixIcon: const  Padding(
                      padding:  EdgeInsets.all(0.0),
                      child: Icon(Icons.search),
                    ),
                    dropDownMenuItems: branchnameItems.map((item) {
                      return item.value;
                    }).toList(),
                    onChanged: (value){
                      FocusScope.of(context).unfocus();
                      print(value);
                      if(value!=null)
                      {
                        setState(() {
                          selectedBrandName = value.value.toString();
                          print(selectedBrandName);
                          RegExp regex = RegExp(r'^(\d+) - (.+)$');

                          // Use firstMatch to get the matched groups
                          Match? match = regex.firstMatch(selectedBrandName);
                          code = match?.group(1);
                          print(code);

                        });

                      }
                      else{
                        selectedBrandName=value;

                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Visibility(
                visible: selectedItem=="Pharma",
                child: FormFeild(   width: _width, hint: "ENTER CUSTOMER CODE",controller: employeeCode, obsecureBool: false, enable: !verify,
                    lenghtMax: 1,type: TextInputType.number,),
              ),
              Visibility(
                visible: selectedItem=="FMCG",
                child: FormFeild(   width: _width, hint: "ENTER CUSTOMER CODE",controller: employeeCode, obsecureBool: false,
                  lenghtMax: 1,type: TextInputType.number,),
              ),


SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color:  Color(0xff3E4684),
                          width: 1.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton<String>(
                        value: selectedItem,
                        onChanged: (newValue) {
                          setState(() {
                            selectedItem = newValue!;
                            print(selectedItem);
                            refreshoncat();
                          });
                        },
                        items: items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          );
                        }).toList(),
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        underline: SizedBox(), // Remove default underline
                      ),
                    ),
                  ],
                ),
              ),




              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

Text(''),

                    Spacer(),

                    SizedBox(width: 10,),


                    Visibility(
                      visible: selectedItem=="Pharma",
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            if(selectedBrandName.isEmpty){
                              Fluttertoast.showToast(
                                msg: 'Please Select Branch Name',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                            }
                            if(employeeCode.text.isEmpty){
                              Fluttertoast.showToast(
                                msg: 'Please Enter Customer Code',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                            }



                            else{

                              print(employeeCode.text);
                              String branchCode = selectedBrandName.split(' - ')[0];

                              print('Branch Code: $branchCode');
                              Api api=new Api();


                              CustomerResponse customerResponse = await api.fetchCustomerData(employeeCode.text, branchCode);
                              if(branchCode.isNotEmpty && selectedBrandName.isNotEmpty && customerResponse.status=='200' ){
                                setState(() {
                                  verify=true;
                                });

                                Fluttertoast.showToast(
                                  msg: 'Customer is Verified',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                employeeName.text = customerResponse.customerName;
                                customerNumber.text = customerResponse.customerPhone;
                                customerPhone= customerResponse.customerPhone;

                                address.text = customerResponse.customerAddress;
                                remarks.text = '';}
                              else{
                                Fluttertoast.showToast(
                                  msg: 'Invalid Customer',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );

                              }

                       {

                              }


                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary:  Color(0xff3E4684), // Change this to the desired color
                          ),
                          child: Text("Verify Customer"),
                        ),
                      ),
                    ),

// ... remaining code ...



                    SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          refresh();
                          setState(() {

                            Fluttertoast.showToast(
                              msg: 'Reset Changes',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FormPage()));
                          });

                        },
                        child:

                        Image.asset("assets/images/refresh.png", height: 35, width: 35,)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    SizedBox(height: _height * 0.01),
                    Text("CUSTOMER NAME", style: TextStyle(fontSize: 14,   color: const Color(0xff3E4684), fontWeight: FontWeight.w500)),
                    SizedBox(height: 5,),
                    FormFeild(
                      width: _width,
                      hint: "Enter Customer Name",
                      controller: shopeName,
                      obsecureBool: false,
                      lenghtMax: 1,
                      type: TextInputType.text,
                    ),

                    SizedBox(height: _height * 0.01),
                    Text("SHOP NAME", style: TextStyle(fontSize: 14,  color: const Color(0xff3E4684), fontWeight: FontWeight.w500)),
                    SizedBox(height: 5,),
                    FormFeild(
                      width: _width,
                      hint: "Enter Shop Name",
                      controller: employeeName,
                      obsecureBool: false,
                      lenghtMax: 1,
                      type: TextInputType.text,
                    ),

                    SizedBox(height: _height * 0.01),
                    Text("CUSTOMER NUMBER", style: TextStyle(fontSize: 14,  color: const Color(0xff3E4684), fontWeight: FontWeight.w500)),
                    SizedBox(height: 5,),
                   //if(customerNumber.text.length== 11)
                     FormFeild(
                       width: _width,
                       hint: "Enter Customer Number",
                       controller: customerNumber,
                       obsecureBool: false,
                       lenghtMax: 1,
                       type: TextInputType.number,
                     ),

                    SizedBox(height: _height * 0.01),
                    Text("ADDRESS", style: TextStyle(fontSize: 14,  color: const Color(0xff3E4684), fontWeight: FontWeight.w500)),
                    SizedBox(height: 5,),
                    FormFeild(
                      width: _width,
                      hint: "Enter Address",
                      controller: address,
                      obsecureBool: false,
                      lenghtMax: 2,
                      type: TextInputType.text,
                    ),

                    SizedBox(height: _height * 0.01),
                    Text("REMARKS", style: TextStyle(fontSize: 14,  color: const Color(0xff3E4684), fontWeight: FontWeight.w500)),
                    SizedBox(height: 5,),
                    FormFeild(
                      width: _width,
                      hint: "Enter Remarks",
                      obsecureBool: false,
                      lenghtMax: 8,
                      controller: remarks,
                      type: TextInputType.text,
                    ),

                    SizedBox(height: _height * 0.02),
                    // ... Other widgets ...
                  ],
                ),
              ),

              Container(
                height:_height*0.07,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("PRODUCT DETAILS",style: TextStyle(
                    color: Color(0xff3E4684),fontWeight: FontWeight.w600,
                    fontSize: 25
                ),),
              ),
              productItems.length==0?Container():Padding(
                padding: EdgeInsets.symmetric(horizontal: _width*0.03),
                child: CustomSearchableDropDown(
                  items: productItems,
                  label: 'Products Name',
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: const Color(0xff3E4684)
                      )
                  ),
                  prefixIcon: const  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: productItems.map((item) {
                    return item.value;
                  }).toList(),
                  onChanged: (value){
                    FocusScope.of(context).unfocus();
                    print(value.toString());
                    if(value!=null)
                    {
                      selectedProduct = value.value.toString();
                    }
                    else{
                      selectedProduct="";
                    }
                  },
                ),
              ),
              SizedBox(height: _height*0.02,),
              branchItems.length==0?Container():Padding(
                padding: EdgeInsets.symmetric(horizontal: _width*0.03),
                child: CustomSearchableDropDown(
                  items: branchItems,
                  label: 'Branch Name',
                  // labelStyle:  const TextStyle(
                  //     color: Color(0xff73b54a),
                  //     fontSize: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: const Color(0xff3E4684)
                      )
                  ),
                  prefixIcon: const  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: branchItems.map((item) {
                    return item.value;
                  }).toList(),
                  onChanged: (value){
                    FocusScope.of(context).unfocus();
                    print(value);
                    if(value!=null)
                    {
                      selectedBrand = value.value.toString();
                    }
                    else{
                      selectedBrand=value;

                    }
                  },
                ),
              ),
              SizedBox(height: _height*0.02,),
              reasonItems.length==0?Container():Padding(
                padding: EdgeInsets.symmetric(horizontal: _width*0.03),
                child: CustomSearchableDropDown(
                  items: reasonItems,
                  label: 'Reasons',
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: const Color(0xff3E4684)
                      )
                  ),
                  prefixIcon: const  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: reasonItems.map((item) {
                    return item.value;
                  }).toList(),
                  onChanged: (value){
                    FocusScope.of(context).unfocus();
                    print(value.toString());
                    if(value!=null)
                    {
                      selectedReason = value.value.toString();
                    }
                    else{
                      selectedReason== null;
                    }
                  },
                ),
              ),
              SizedBox(height: _height*0.02,),
              Container(
                width: _width*0.7,
                height: _height*0.06,

                decoration: const BoxDecoration(
                    color: Color(0xff3E4684),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: TextButton(


                  onPressed: () async {

                    if (selectedItem == "FMCG") {
                      // Set verify to true for SMCG
                      setState(() {
                        verify = true;
                      });
                    }

                    if (verify) {

                      FocusScope.of(context).unfocus();
                      // print(selectedBrand);

                      if (selectedBrand == '' || shopeName.text == '' || selectedProduct == '' || selectedReason == '' ||
                          employeeCode.text == '' || employeeName.text == '' || customerNumber.text == '' ||
                          remarks.text == '' || address.text == '') {
                        await Flushbar(
                          title: '',
                          message: 'Please Fill all Fields',
                          duration: Duration(seconds: 3),
                        ).show(context);
                      } else {
                        await DBProvider.db.complainRawInsert(
                          employeeName.text.toString(), employeeCode.text.toString(), shopeName.text.toString(),
                          customerNumber.text.toString(), customerPhone, remarks.text.toString(), selectedProduct.toString(),
                          selectedBrand.toString(), selectedReason.toString(),address.text.toString().replaceAll(RegExp(r'[^\w\s]+'), ''),code.toString()
                        );
                        DBProvider.db.getAllClientsComplain();
                        print(code.toString());
                        await Flushbar(
                          title: '',
                          message: 'Complain Added',
                          duration: Duration(seconds: 3),
                        ).show(context);
                      }
                    } else {
                      // Handle the case when verify is false
                      await Flushbar(
                        title: '',
                        message: 'Invalid Customer',
                        duration: Duration(seconds: 3),
                      ).show(context);
                      // You can add more code here as needed
                    }
                  },
                  child: const Text(
                    "Add Complain",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),


              ),
              SizedBox(height: _height*0.04,)
            ],
          ),
        ),
      ),
    ));
  }
}