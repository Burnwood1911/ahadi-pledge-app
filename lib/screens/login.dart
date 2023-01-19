import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/community_controller.dart';
import 'package:ahadi_pledge/models/community.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return authController.obx(
        (state) => DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(180.0), // here th
                  child: AppBar(
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "Ahadi",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[400]),
                                  children: const [
                                TextSpan(
                                    text: "Pledge",
                                    style: TextStyle(color: Colors.red))
                              ]))
                        ],
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
                        children: [_SignUpPage(authController)],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        onLoading: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Theme.of(context).primaryColor],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          ),
        ));
  }
}

class _SignUpPage extends StatefulWidget {
  const _SignUpPage(this.authController) : super();

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

  final TextEditingController placeOfBirth = TextEditingController();

  final TextEditingController marriageDate = TextEditingController();
  final TextEditingController partnerName = TextEditingController();
  final TextEditingController placeOfMarriage = TextEditingController();
  final TextEditingController oldUsharika = TextEditingController();
  final TextEditingController fellowshipName = TextEditingController();
  final TextEditingController neighborMsharikaName = TextEditingController();
  final TextEditingController neighborMsharikaPhone = TextEditingController();
  final TextEditingController deaconName = TextEditingController();
  final TextEditingController deaconPhone = TextEditingController();
  final TextEditingController placeOfWork = TextEditingController();
  final TextEditingController proffession = TextEditingController();
  final TextEditingController baptizationDate = TextEditingController();
  final TextEditingController kipaimaraDate = TextEditingController();

  String? selectedGender;
  bool passwordVisible = false;
  int martialStatus = 0;
  int marriageType = 0;
  int occupationStatus = 0;

  bool canVolunterr = false;
  bool baptized = false;
  bool kipaimara = false;
  bool sacramentiMezaYaBwana = false;

  List<int> selectedSubs = [];

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    selectedGender = "MALE";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => communityController.juimuiyas.isNotEmpty
        ? Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: fname,
                      decoration: const InputDecoration(
                          labelText: "First Name", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: mname,
                      decoration: const InputDecoration(
                          labelText: "Middle Name", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: lname,
                      decoration: const InputDecoration(
                          labelText: "Last Name", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
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
                            color: Theme.of(context).primaryColor,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                communityController.juimuiyas.isNotEmpty
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
                              value: communityController.juimuiyas[0].name,
                              items: communityController.juimuiyas
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
                                  communityController.selectedJumuiyaId.value =
                                      communityController.juimuiyas
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.empty_fields_error_text.tr();
                      }
                      return null;
                    },

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
                  child: TextFormField(
                      controller: placeOfBirth,
                      decoration: const InputDecoration(
                          labelText: "Place of Birth", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Martial Status",
                        style: GoogleFonts.poppins(),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: [
                          "Maried",
                          "Single",
                          "Widowed",
                          "DIvorced"
                        ][martialStatus],
                        items: ["Maried", "Single", "Widowed", "DIvorced"]
                            .map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          var options = [
                            "Maried",
                            "Single",
                            "Widowed",
                            "DIvorced"
                          ];
                          setState(() {
                            martialStatus = options
                                .indexWhere((element) => element == value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                martialStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Marriage Type",
                              style: GoogleFonts.poppins(),
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: [
                                "Christian",
                                "Other",
                              ][marriageType],
                              items: ["Christian", "Other"].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                var options = ["Christian", "Other"];
                                setState(() {
                                  marriageType = options.indexWhere(
                                      (element) => element == value);
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                martialStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                          controller: marriageDate,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Marriage Date" //label text of field
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.empty_fields_error_text.tr();
                            }
                            return null;
                          },

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
                                marriageDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                martialStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                            controller: partnerName,
                            decoration: const InputDecoration(
                                labelText: "Partner Name", filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.empty_fields_error_text.tr();
                              }
                              return null;
                            }),
                      )
                    : const SizedBox.shrink(),
                martialStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                            controller: placeOfMarriage,
                            decoration: const InputDecoration(
                                labelText: "Place of Marriage", filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.empty_fields_error_text.tr();
                              }
                              return null;
                            }),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: oldUsharika,
                      decoration: const InputDecoration(
                          labelText: "Usharika Wa Zamani", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: fellowshipName,
                      decoration: const InputDecoration(
                          labelText: "Fellowship Name", filled: true),
                      validator: (value) {
                        // if (value!.isEmpty) {
                        //   return LocaleKeys.empty_fields_error_text.tr();
                        // }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: deaconName,
                      decoration: const InputDecoration(
                          labelText: "Deacon Name", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: deaconPhone,
                      decoration: const InputDecoration(
                          labelText: "Deacon Phone", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: neighborMsharikaName,
                      decoration: const InputDecoration(
                          labelText: "Jina Msharika Jirani", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                      controller: neighborMsharikaPhone,
                      decoration: const InputDecoration(
                          labelText: "Simu Msharika Jirani", filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.empty_fields_error_text.tr();
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Occupation",
                        style: GoogleFonts.poppins(),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: [
                          "Employed",
                          "Unemployed",
                          "Student",
                        ][occupationStatus],
                        items: [
                          "Employed",
                          "Unemployed",
                          "Student",
                        ].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          var options = [
                            "Employed",
                            "Unemployed",
                            "Student",
                          ];
                          setState(() {
                            occupationStatus = options
                                .indexWhere((element) => element == value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                occupationStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                            controller: placeOfWork,
                            decoration: const InputDecoration(
                                labelText: "Place of Work", filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.empty_fields_error_text.tr();
                              }
                              return null;
                            }),
                      )
                    : const SizedBox.shrink(),
                occupationStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                            controller: proffession,
                            decoration: const InputDecoration(
                                labelText: "Proffession", filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.empty_fields_error_text.tr();
                              }
                              return null;
                            }),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ungependa Kujitolea"),
                      Switch(
                          value: canVolunterr,
                          onChanged: ((value) {
                            setState(() {
                              canVolunterr = value;
                            });
                          }))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Unashiriki sacramenti ya meza wa bwana"),
                      Switch(
                          value: sacramentiMezaYaBwana,
                          onChanged: ((value) {
                            setState(() {
                              sacramentiMezaYaBwana = value;
                            });
                          }))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Umebatizwa?"),
                      Switch(
                          value: baptized,
                          onChanged: ((value) {
                            setState(() {
                              baptized = value;
                            });
                          }))
                    ],
                  ),
                ),
                baptized == true
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                          controller: baptizationDate,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Baptization Date" //label text of field
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.empty_fields_error_text.tr();
                            }
                            return null;
                          },

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
                                baptizationDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Kipaimara?"),
                      Switch(
                          value: kipaimara,
                          onChanged: ((value) {
                            setState(() {
                              kipaimara = value;
                            });
                          }))
                    ],
                  ),
                ),
                kipaimara == true
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0),
                        child: TextFormField(
                          controller: kipaimaraDate,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Kipaimara Date" //label text of field
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.empty_fields_error_text.tr();
                            }
                            return null;
                          },

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
                                kipaimaraDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: Column(
                    children: [
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: const Text("Chagua Huduma Za Kanisa"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                //Here we will build the content of the dialog
                                return AlertDialog(
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Wrap(
                                          children: communityController
                                              .subscriptions
                                              .map((item) {
                                        return Container(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ChoiceChip(
                                                selectedColor: Colors.blue[300],
                                                label: Text(item.name),
                                                selected: selectedSubs
                                                    .contains(item.id),
                                                onSelected: (selected) {
                                                  setState(() {
                                                    if (selectedSubs
                                                        .contains(item.id)) {
                                                      selectedSubs
                                                          .remove(item.id);
                                                    } else {
                                                      selectedSubs.add(item.id);
                                                    }
                                                  });
                                                }));
                                      }).toList());
                                    },
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      minWidth: double.infinity,
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      child: const Text("Submit"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.authController.register(
                            fname: fname.text,
                            mname: mname.text,
                            lname: lname.text,
                            phone: phone.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            selectedGender: selectedGender!,
                            birth: birth.text,
                            jumuiyaId:
                                communityController.selectedJumuiyaId.value,
                            martialStatus: martialStatus,
                            marriageType: marriageType,
                            occupationStatus: occupationStatus,
                            canVolunterr: canVolunterr,
                            baptized: baptized,
                            kipaimara: kipaimara,
                            sacramentiMezaYaBwana: sacramentiMezaYaBwana,
                            placeOfBirth: placeOfBirth.text,
                            marriageDate: marriageDate.text,
                            partnerName: partnerName.text,
                            placeOfMarriage: placeOfMarriage.text,
                            oldUsharika: oldUsharika.text,
                            fellowshipName: fellowshipName.text,
                            neighborMsharikaName: neighborMsharikaName.text,
                            neighborMsharikaPhone: neighborMsharikaPhone.text,
                            deaconName: deaconName.text,
                            deaconPhone: deaconPhone.text,
                            placeOfWork: placeOfWork.text,
                            proffession: proffession.text,
                            baptizationDate: baptizationDate.text,
                            kipaimaraDate: kipaimaraDate.text,
                            selectedSubs: selectedSubs);

                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.failed_fetch_communities_text.tr()),
                ElevatedButton(
                    onPressed: () {
                      communityController.getJumuiyas();
                      communityController.getSubscriptions();
                    },
                    child: Text(LocaleKeys.try_again_text.tr()))
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.empty_fields_error_text.tr();
                  }
                  return null;
                }),
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
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.empty_fields_error_text.tr();
                  }
                  return null;
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: MaterialButton(
              minWidth: double.infinity,
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.authController
                      .login(_loginController.text, _passwordController.text);

                  _formKey.currentState!.reset();
                }
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
