import 'package:azedpolls/notifiers/auth_notifier.dart';
import 'package:azedpolls/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../circular_indicator.dart';
import '../custom_popup.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isLoading = false;

  void toggleSpinner() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularIndicator(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
            child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: ListTile.divideTiles(
              color: Color(0xFFdc8c97),
              context: context,
              tiles: [
                SizedBox(height: 30),
                ComponentSettings(
                  autoTrailing: true,
                  title: 'Edit Profile',
                  onPressed: () => Navigator.pushNamed(context, '/EditProfile'),
                ),
                SizedBox(height: 30),
                ComponentSettings(
                  title: 'About AzedPolls',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "About AzedPolls",
                            descriptions:
                                "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                            text: "Okey",
                          );
                        });
                  },
                ),
                ComponentSettings(
                  title: 'Contact Us',
                ),
                ComponentSettings(
                  title: 'Share with a Friend',
                ),
                SizedBox(height: 30),
                ComponentSettings(
                  title: 'Log Out',
                  onPressed: () async {
                    toggleSpinner();
                    try {
                      await logout(authNotifier);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/Splash', (route) => false);
                    } catch (error) {
                      print(error);
                    }
                    toggleSpinner();
                  },
                ),
              ]).toList(),
        )),
      ),
    );
  }
}

class ComponentSettings extends StatelessWidget {
  const ComponentSettings({
    Key? key,
    this.autoTrailing = false,
    this.title,
    this.onPressed,
  }) : super(key: key);
  final String? title;
  final bool? autoTrailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      tileColor: Color(0xFFffd6da),
      leading: Text(
        title!,
        style: TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
      ),
      trailing: autoTrailing == true
          ? Icon(
              FontAwesomeIcons.angleRight,
              size: 32,
            )
          : null,
    );
  }
}
