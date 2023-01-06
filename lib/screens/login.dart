import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/community_controller.dart';
import 'package:ahadi_pledge/models/community.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    return authController.obx(
        (state) => DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(160.0), // here th
                  child: AppBar(
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/logo-two.png",
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          icon: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Tab(
                            icon: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black),
                        )),
                      ],
                    ),
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  child: TabBarView(
                    children: [
                      ListView(children: [_SignInPage(authController)]),
                      ListView(
                        children: [
                          _SignUpPage(communityController, authController)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        onLoading: const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Colors.black],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          ),
        ));
  }
}

class _SignUpPage extends StatefulWidget {
  const _SignUpPage(this.communityController, this.authController) : super();

  final CommunityController communityController;
  final AuthController authController;

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
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
  bool passwordVisible = false;

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
                  decoration: const InputDecoration(
                      labelText: "First Name", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: mname,
                  decoration: const InputDecoration(
                      labelText: "Middle Name", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: lname,
                  decoration: const InputDecoration(
                      labelText: "Last Name", filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                      errorText: widget.authController.phoneError.value,
                      labelText: "Phone",
                      filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      errorText: widget.authController.emailError.value,
                      labelText: "Email",
                      filled: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      errorText: widget.authController.passwordError.value,
                      labelText: "Password",
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
                        color: Colors.black,
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
                                  style: const TextStyle(color: Colors.black),
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
                  : const SizedBox.shrink(),
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
                            style: const TextStyle(color: Colors.black),
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
                  decoration: const InputDecoration(
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
                child: MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () => {
                    widget.authController.register(
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
                  child: const Text("Register"),
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
  const _SignInPage(this.authController) : super();

  final AuthController authController;

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<_SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              decoration:
                  const InputDecoration(labelText: "Login", filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                  labelText: "Password",
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
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                widget.authController
                    .login(_loginController.text, _passwordController.text);
              },
              child: const Text("Log In"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
