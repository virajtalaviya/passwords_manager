import 'package:flutter/material.dart';
import 'package:password_save/crud_operation.dart';
import 'package:password_save/set_company_password.dart';
import 'package:password_save/show_password_screen.dart';
import 'package:password_save/update_password.dart';

class PasswordList extends StatefulWidget {
  const PasswordList({Key? key}) : super(key: key);

  @override
  State<PasswordList> createState() => _PasswordListState();
}

class _PasswordListState extends State<PasswordList> {
  DataBaseManager dataBaseManagerHelper = DataBaseManager();
  List<PasswordClass> dataList = [];
  bool listIsEmpty = false;

  getData() {
    dataList = [];
    dataBaseManagerHelper.getData().then((value) {
      for (int i = 0; i < value.length; i++) {
        dataList.add(
          PasswordClass(
            company: value[i].company,
            password: value[i].password,
          ),
        );
      }
      if (value.isEmpty) {
        setState(() {
          listIsEmpty = true;
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBaseManagerHelper.init().then((value) {
      if (value == 1) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password List"),
        actions: [
          IconButton(
            onPressed: () async {
              final data = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SetCompanyPassword(),
                ),
              );
              if (data == "Refresh") {
                getData();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: dataList.isEmpty
            ? listIsEmpty
                ? const Center(child: Text("No data found"))
                : const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowPasswordScreen(
                              company: dataList[index].company ?? "",
                              passController: TextEditingController(
                                text: dataList[index].password,
                              ),
                            ),
                          ),
                        );
                      },
                      title: Text(
                        dataList[index].company ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                final data = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdatePassword(
                                      company: dataList[index].company!,
                                      password: dataList[index].password!,
                                    ),
                                  ),
                                );
                                if (data == "Refresh") {
                                  getData();
                                }
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                dataBaseManagerHelper
                                    .deletePassword(dataList[index].company!);
                                getData();
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
