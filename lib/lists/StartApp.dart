import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

class StartApp extends StatefulWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  _StartAppState createState() => _StartAppState();
}

var MainTitle = "Учеба"; // заголовок AppBar

class _StartAppState extends State<StartApp> {
  String userInput = "";
  String? errorMessage = null; // для обозначения ошибки в поле вода
  bool statusComlete =
      false; // переменная для обозначения состояния выполненных задач
  bool statusFavorite =
      false; // переменная для обозначения состояния избранных задач
  List<Note> listView = []; // полный список
  List<Note> displayedListView = []; // список который отображается на экране

  final String assetName = 'assets/todolist.svg';
  final String assetBackName = 'assets/todolist_background.svg';

  @override
  void initState() {
    super.initState();
    displayedListView = listView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(MainTitle),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onPress(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        statusComlete
                            ? Icons.check_circle_outline
                            : Icons.check_circle,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(statusComlete
                          ? 'Показать выполненные'
                          : 'Скрыть выполненные'),
                    )
                  ]),
                  value: 0),
              PopupMenuItem<int>(
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(
                      statusFavorite ? Icons.star_outline : Icons.star,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                        statusFavorite ? 'Все задачи' : 'Только Избранные'),
                  )
                ]),
                value: 1,
              ),
              PopupMenuItem<int>(
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text('Удалить выполненные'),
                  )
                ]),
                value: 2,
              ),
              PopupMenuItem<int>(
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text('Редактировать ветку'),
                  )
                ]),
                value: 3,
              ),
            ],
          ),
        ],
      ),
      body: displayedListView.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/todolist_background.svg",
                    ),
                    SvgPicture.asset(
                      "assets/todolist.svg",
                    ),
                  ],
                ),
                Text(
                  "На данный \n момент задачи \n отсутствуют",
                  style: TextStyle(
                    color: Color(0xFF400063),
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ))
          : ListView.builder(
              itemCount: displayedListView.length,
              itemBuilder: (BuildContext context, int index) {
                back(alignment) {
                  return Container(
                    color: Colors.red,
                    alignment: alignment,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                  );
                }

                return Dismissible(
                  key: Key(displayedListView[index].TEXT),
                  background: back(Alignment.centerLeft),
                  secondaryBackground: back(Alignment.centerRight),
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                      color: Colors.white,
                      child: Row(children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Checkbox(
                                shape: CircleBorder(),
                                value: displayedListView[index].complete,
                                onChanged: (value) {
                                  setState(() {
                                    displayedListView[index].complete =
                                        !displayedListView[index].complete;
                                    UpdateDisplayListByConditions();
                                  });
                                })),
                        Expanded(
                          flex: 6,
                          child: ListTile(
                            title: Text(displayedListView[index].TEXT),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(
                                    displayedListView[index].favorite
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.yellow),
                                onPressed: () => setState(() => {
                                      displayedListView[index].favorite =
                                          !displayedListView[index].favorite,
                                      if (statusFavorite)
                                        UpdateDisplayListByConditions()
                                    })))
                      ])),
                  onDismissed: (direction) {
                    listView.removeWhere(
                        (element) => element.id == displayedListView[index].id);
                    UpdateDisplayListByConditions();
                  },
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var tmp2 = false;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text('Введите задачу'),
                    content: TextField(
                      onChanged: (String value) {
                        setState(() {
                          userInput = value;
                        });
                      },
                      decoration: InputDecoration(
                        errorText: errorMessage,
                        hintText: "Введите название задачи",
                        counterText: '${userInput.length.toString()}/40',
                        counterStyle: TextStyle(
                            color: tmp2 ? Colors.red : Colors.black38),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            errorMessage = null;
                            setState(() {
                              Navigator.of(context).pop();
                            });
                            userInput = "";
                          },
                          child: Text('Отмена')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (userInput.isEmpty) {
                                errorMessage = "Название не может быть пустым";
                                tmp2 = false;
                              } else if (userInput.length <= 40) {
                                errorMessage = null;
                                listView.add(Note(userInput, false, false));
                                Navigator.of(context).pop();
                                userInput = "";
                                UpdateDisplayListByConditions();
                                this.setState(() {});
                                tmp2 = false;
                              } else {
                                tmp2 = true;
                                errorMessage = "Слишком длинное название";
                              }
                            });
                          },
                          child: Text('Ок')),
                    ],
                  );
                });
              });
        },
        child: const Text('+',
            style: TextStyle(color: Colors.deepPurple, fontSize: 30)),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  void onPress(BuildContext context, int item) {
    switch (item) {
      case 0: // 'Скрыть выполненные'
        statusComlete = !statusComlete;
        UpdateDisplayListByConditions();
        //setState(() {});
        break;
      case 1: // 'Только Избранные'
        //statusFavorite? statusView = "all" : statusView = "favorite";
        statusFavorite = !statusFavorite;
        UpdateDisplayListByConditions();
        //setState(() {});
        break;
      case 2: // 'Удалить выполненные'
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Text('Подтвердите удаление'),
                  content: Text(
                      "Удалить выполненные задачи? Это действие необратимо."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Отмена')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            deleteCompleted();
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Подтвердить')),
                  ],
                );
              });
            });

        break;
      case 3: // 'Редактировать ветку'
        userInput = MainTitle;
        var tmp = TextEditingController();
        var tmp2 = false;
        tmp.text = MainTitle;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Text('Введите задачу'),
                  content: TextField(
                    controller: tmp,
                    onChanged: (String value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                    decoration: InputDecoration(
                      errorText: errorMessage,
                      hintText: "Введите название ветки",
                      counterText: '${userInput.length.toString()}/40',
                      counterStyle:
                          TextStyle(color: tmp2 ? Colors.red : Colors.black38),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          errorMessage = null;
                          setState(() {
                            Navigator.of(context).pop();
                          });
                          userInput = "";
                          tmp2 = false;
                        },
                        child: Text('Отмена')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (userInput.isEmpty) {
                              errorMessage = "Название не может быть пустым";
                              tmp2 = false;
                            } else if (userInput.length <= 40) {
                              errorMessage = null;
                              MainTitle = userInput;
                              Navigator.of(context).pop();
                              userInput = "";
                              this.setState(() {});
                              tmp2 = false;
                            } else {
                              tmp2 = true;
                              errorMessage = "Слишком длинное название";
                            }
                          });
                        },
                        child: Text('Ок')),
                  ],
                );
              });
            });
    }
  }

  void deleteCompleted() {
    for (int i = 0; i < listView.length; i++) {
      if (listView[i].complete) {
        listView.removeAt(i);
        i--;
      }
    }
    UpdateDisplayListByConditions();
    //setState(() {});
  }

  void UpdateDisplayListByConditions() {
    displayedListView = listView;
    if (statusFavorite)
      displayedListView = displayedListView
          .where((element) => element.favorite == true)
          .toList();
    if (statusComlete)
      displayedListView = displayedListView
          .where((element) => element.complete == false)
          .toList();
    setState(() => {});
  }
}

class Note {
  final id = const Uuid().v4();
  String TEXT = "";
  bool favorite = false;
  bool complete = false;

  Note(String name, bool box, bool fav) {
    TEXT = name;
    favorite = fav;
    complete = box;
  }
}
