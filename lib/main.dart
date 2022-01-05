import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practicleapp/adddata.dart';
import 'package:practicleapp/editdata.dart';
import 'package:practicleapp/firebaseconnection.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List datalist = [];

  @override
  void initState() {
    super.initState();
    fetchdataList();
  }

  fetchdataList() async {
    dynamic result = await FirebaseConnection().getData();

    if (result == null) {
      print("Unable to fetch data");
    } else {
      setState(() {
        datalist = result;
      });
      print("---------->>>>>>>>>>>>>>$datalist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: datalist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(15),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage("asset/icon.png"),
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 28,
                                child: IconButton(
                                  onPressed: () {
                                    FirebaseConnection()
                                        .deleteData(datalist[index]['index'])
                                        .whenComplete(() {
                                      fetchdataList();
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Data Deleted")));
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                  iconSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 28,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => EditData(
                                                name: datalist[index]['name'],
                                                mobile: datalist[index]
                                                    ['mobile'],
                                                email: datalist[index]['email'],
                                                cityname: datalist[index]
                                                    ['cityname'],
                                                index: "$index",
                                              )),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                  iconSize: 25,
                                ),
                              )
                            ],
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                datalist[index]['name'],
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                datalist[index]['mobile'],
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                datalist[index]['email'],
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                datalist[index]['cityname'],
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[200],
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => AddData(
                      index: datalist.length.toString(),
                    )),
          );
        },
        child: const Text(
          "+",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}
