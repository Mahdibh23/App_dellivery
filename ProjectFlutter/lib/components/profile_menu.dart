import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '/models/User.dart';

class ProfileMenu extends StatefulWidget {
  final String text;
  final String icon;
  final User? user;
  final VoidCallback? press;

  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.user,
    this.press,
  }) : super(key: key);

  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  bool _isDropdownVisible = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: kPrimaryColor,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color(0xFFF5F6F9),
            ),
            onPressed: widget.press ?? _toggleDropdown,
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  color: kPrimaryColor,
                  width: 22,
                ),
                const SizedBox(width: 20),
                Expanded(child: Text(widget.text)),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        if (_isDropdownVisible && widget.user != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${widget.user!.name}'),
                Text('Email: ${widget.user!.email}'),
              ],
            ),
          ),
      ],
    );
  }
}
