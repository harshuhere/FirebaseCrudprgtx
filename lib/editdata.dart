import 'package:flutter/material.dart';
import 'package:practicleapp/edittextwidget.dart';
import 'package:practicleapp/firebaseconnection.dart';
import 'package:practicleapp/main.dart';

class EditData extends StatefulWidget {
  EditData(
      {Key? key,
      required this.name,
      required this.mobile,
      required this.email,
      required this.cityname,
      required this.index})
      : super(key: key);
  String? name;
  String? mobile;
  String? email;
  String? cityname;
  String? index;
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _citynameController = TextEditingController();

  initialvalue() {
    _nameController.text = "${widget.name}";
    _mobileController.text = "${widget.mobile}";
    _emailController.text = "${widget.email}";
    _citynameController.text = "${widget.cityname}";
  }

  @override
  void initState() {
    super.initState();
    initialvalue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))),
              const Text(
                "Edit",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      EditText(
                        edttxtlable: "Name",
                        errorString: "*Enter name",
                        txtedtcntroller: _nameController,
                        txtinputtype: TextInputType.name,
                      ),
                      EditText(
                        edttxtlable: "Mobile",
                        errorString: "*Enter mobile",
                        txtedtcntroller: _mobileController,
                        txtinputtype: TextInputType.number,
                        length: 10,
                      ),
                      EditText(
                        edttxtlable: "Email",
                        errorString: "*Enter email",
                        txtedtcntroller: _emailController,
                        txtinputtype: TextInputType.emailAddress,
                      ),
                      EditText(
                        edttxtlable: "Cityname",
                        errorString: "*Enter cityname",
                        txtedtcntroller: _citynameController,
                        txtinputtype: TextInputType.name,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            editData();
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              color: Colors.amber[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Text(
                  "Need help ?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editData() {
    FirebaseConnection()
        .updateData(_nameController.text, _mobileController.text,
            _emailController.text, _citynameController.text, "${widget.index}")
        .whenComplete(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data Updated")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => HomePage()),
      );
    });
  }
}
