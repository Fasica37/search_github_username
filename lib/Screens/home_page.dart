import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_github_username/Providers/user_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  Map _userInfo = {};
  bool _isLoading = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
    });
    var provider = Provider.of<UserProvider>(context, listen: false);

    await provider.fetchUser(_searchController.text);
    _userInfo = provider.userInfo;
    setState(() {
      _isLoading = false;
    });
  }

  final _outlineInputBorder = const OutlineInputBorder();
  final _contentPadding =
      const EdgeInsets.symmetric(vertical: 0, horizontal: 10);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Container(
          // color: Colors.blueGrey[800],
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: size.width * 0.6,
                  child: TextFormField(
                    controller: _searchController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      contentPadding: _contentPadding,
                      border: _outlineInputBorder,
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.3,
                  child: ElevatedButton(
                    child: Text('Search'),
                    onPressed: _search,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (_searchController.text.isNotEmpty)
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: Image.network(_userInfo['avatar_url']),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        _userInfo['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Joined ${_userInfo['created_at']}')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _userInfo['login'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(_userInfo['bio'] == null
                                      ? 'This repo no bio'
                                      : _userInfo['bio']),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      color: Colors.grey,
                                      width: size.width * 0.7,
                                      height: size.height * 0.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Repos'),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                _userInfo['public_repos']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Followers'),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                _userInfo['followers']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Following'),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                _userInfo['following']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ]),
                      ),
                    ),
          ]),
        ),
      ),
    );
  }
}
