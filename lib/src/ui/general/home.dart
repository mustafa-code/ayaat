import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/fragment/main_page.dart';
import 'package:flutter_app/src/ui/fragment/new_email.dart';
import 'package:flutter_app/src/ui/fragment/profile.dart';
import 'package:flutter_app/src/widgets/drawer_item.dart';
import 'package:flutter_app/src/widgets/drawer_user.dart';

enum HomeStatus {inbox, sent, favorite, important, saved, videos}
extension HomeStatusExtension on HomeStatus {
  String get text {
    switch (this) {
      case HomeStatus.inbox:
        return "Inbox";
      case HomeStatus.sent:
        return "Sent";
      case HomeStatus.favorite:
        return "Favorite";
      case HomeStatus.important:
        return "Important";
      case HomeStatus.saved:
        return "Saved";
      case HomeStatus.videos:
        return "Videos";
    }
  }
}

class Home extends StatefulWidget {
  final HomeStatus? homeStatus;
  const Home({Key? key, this.homeStatus}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 2;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeStatus homeStatus = HomeStatus.inbox;

  @override
  void initState() {
    super.initState();
    if(widget.homeStatus != null){
      homeStatus = widget.homeStatus!;
    }
  }

  changeStatus(HomeStatus homeStatus){
    setState(() {
      this.homeStatus = homeStatus;
    });
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Image(
                      image: AssetImage("assets/icons/icon_side_window.png"),
                      width: 24,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.grey),
              Column(
                children: [
                  DrawerItem(
                    label: "Favorite",
                    image: "assets/icons/icon_favorite.png",
                    onTap: () {
                      changeStatus(HomeStatus.favorite);
                    },
                  ),
                  DrawerItem(
                    label: "Important",
                    image: "assets/icons/icon_important.png",
                    onTap: () {
                      changeStatus(HomeStatus.important);
                    },
                  ),
                  DrawerItem(
                    label: "Inbox",
                    image: "assets/icons/icon_messages.png",
                    onTap: () {
                      changeStatus(HomeStatus.inbox);
                    },
                  ),
                  DrawerItem(
                    label: "Sent",
                    image: "assets/icons/icon_sent.png",
                    onTap: () {
                      changeStatus(HomeStatus.sent);
                    },
                  ),
                  DrawerItem(
                    label: "Saved files",
                    image: "assets/icons/icon_saved.png",
                    onTap: () {
                      changeStatus(HomeStatus.saved);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "People",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16),
                    DrawerUser(
                      name: "Yosra",
                      image: "assets/images/person.png",
                    ),
                    SizedBox(height: 8),
                    DrawerUser(
                      name: "Teacher",
                      image: "assets/images/person_2.png",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: [
          Container(),
          const NewEmail(),
          MainPage(
            homeStatus: homeStatus,
            onOpenDrawer: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          const Profile(),
          Container(),
        ][selectedIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.blue,
              // primaryColor: Colors.red,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "Search",
                  icon: getIcon("assets/icons/icon_search.png"),
                ),
                BottomNavigationBarItem(
                  label: "Add",
                  icon: getIcon("assets/icons/icon_plus.png"),
                ),
                BottomNavigationBarItem(
                  label: "Home",
                  icon: getIcon("assets/icons/icon_home.png"),
                ),
                BottomNavigationBarItem(
                  label: "Profile",
                  icon: getIcon("assets/icons/icon_person.png"),
                ),
                BottomNavigationBarItem(
                  label: "Saved",
                  icon: getIcon("assets/icons/icon_important.png"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getIcon(String image){
    return Image(
      image: AssetImage(image),
      width: 24,
    );
  }
}
