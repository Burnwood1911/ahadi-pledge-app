// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_new
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/community_controller.dart';
import 'package:ahadi_pledge/models/community.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreenWidget();
  }
}

class AuthScreenWidget extends StatefulWidget {
  const AuthScreenWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return AuthScreenWidgetState();
  }
}

class AuthScreenWidgetState extends State<AuthScreenWidget> {
  final AuthController authController = Get.find<AuthController>();
  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => authController.isLoading.value
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotatePulse,
                  colors: [Colors.blue],
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  pathBackgroundColor: Colors.white),
            ),
          )
        : DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(160.0), // here th

                child: AppBar(
                  flexibleSpace: Image.asset(
                    "assets/logo.png",
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(
                        icon: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                          icon: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.black),
                      )),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Colors.white,
                child: TabBarView(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[_SignUpPage(communityController)],
                    ),
                    ListView(children: <Widget>[_SignInPage()]),
                  ],
                ),
              ),
            ),
          ));
  }
}

class _SignUpPage extends StatefulWidget {
  const _SignUpPage(this.communityController) : super();

  final CommunityController communityController;

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<_SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController birth = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? selectedGender;
  AuthController authController = Get.find();

  var passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    selectedGender = "MALE";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: fname,
                  decoration:
                      InputDecoration(labelText: "First Name", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: mname,
                  decoration:
                      InputDecoration(labelText: "Middle Name", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: lname,
                  decoration:
                      InputDecoration(labelText: "Last Name", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(labelText: "Phone", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "email", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      labelText: "password",
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        color: Colors.blue,
                      )),
                ),
              ),
              widget.communityController.juimuiyas.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Community",
                            style: GoogleFonts.poppins(),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: widget.communityController.juimuiyas[0].name,
                            items: widget.communityController.juimuiyas
                                .toList()
                                .map((CommunityElement value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(
                                  value.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget.communityController.selectedJumuiyaId
                                        .value =
                                    widget.communityController.juimuiyas
                                        .firstWhere(
                                            (item) => item.name == value)
                                        .id;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: GoogleFonts.poppins(),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: selectedGender,
                      items: ["MALE", "FEMALE"].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: birth,
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Birth Date" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        birth.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: new MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.blue,
                  onPressed: () => {
                    authController.register(
                        fname.text,
                        mname.text,
                        lname.text,
                        phone.text,
                        _emailController.text,
                        _passwordController.text,
                        selectedGender!,
                        birth.text,
                        widget.communityController.selectedJumuiyaId.value)
                  },
                  textColor: Colors.white,
                  child: Text("Register"),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    fname.dispose();
    mname.dispose();
    lname.dispose();
    phone.dispose();
    birth.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _SignInPage extends StatefulWidget {
  const _SignInPage() : super();

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<_SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthController authController = Get.find();

  var passwordVisible = false;

  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 30.0),
            child: TextFormField(
              controller: _loginController,
              decoration: InputDecoration(labelText: "login", filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                  labelText: "password",
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    color: Colors.blue,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: new MaterialButton(
              minWidth: double.infinity,
              color: Colors.blue,
              onPressed: () {
                authController.login(
                    _loginController.text, _passwordController.text);
              },
              textColor: Colors.white,
              child: Text("Log In"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
