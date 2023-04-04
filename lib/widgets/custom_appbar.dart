import 'package:flutter/material.dart';
import 'package:hotel_finder/pages/home_page.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool back;
  const CustomAppBar({Key? key, this.title = '', this.back = false})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.amber[800],
      title: Text(title,
          style: const TextStyle(fontSize: 27.0, color: Colors.black)),
      centerTitle: true,
      leading: back
          ? IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 35.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
      )
          : IconButton(
                icon: const Icon(
                Icons.home,
                color: Colors.black,
                size: 35.0,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomePage()));
                },
      )
    );
  }
}