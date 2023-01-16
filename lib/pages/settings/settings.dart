import 'package:flutter/material.dart';
import 'package:hot_live/provider/settings_provider.dart';
import 'package:provider/provider.dart';

import 'about.dart';
import 'check_update.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsProvider settings = Provider.of<SettingsProvider>(context);

  void showThemeModeSelectorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Theme Mode'),
          children: SettingsProvider.themeModes.keys.map<Widget>((name) {
            return RadioListTile<String>(
              activeColor: settings.themeColor,
              groupValue: settings.themeModeName,
              value: name,
              title: Text(name),
              onChanged: (value) {
                settings.changeThemeMode(value!);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        );
      },
    );
  }

  void showThemeColorSelectorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Change Theme'),
          children: SettingsProvider.themeColors.keys.map<Widget>((name) {
            final color = SettingsProvider.themeColors[name];
            return RadioListTile<String>(
              activeColor: settings.themeColor,
              groupValue: settings.themeColorName,
              value: name,
              title: Text(name, style: TextStyle(color: color)),
              onChanged: (value) {
                settings.changeThemeColor(value!);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        );
      },
    );
  }

  void showBilibliCookieSetDialog() {
    final cookie = settings.bilibiliCustomCookie;
    final controller = TextEditingController(text: cookie);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bilibili Cookie'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            child: const Text("Cancle"),
          ),
          TextButton(
            onPressed: () {
              settings.bilibiliCustomCookie = controller.text;
              return Navigator.pop(context);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          const SectionTitle(title: 'General'),
          ListTile(
            title: const Text('Change Theme Color'),
            subtitle: const Text('Change the theme color of the app'),
            leading: const Icon(Icons.color_lens, size: 32),
            onTap: showThemeColorSelectorDialog,
          ),
          ListTile(
            title: const Text('Change Theme Mode'),
            subtitle: const Text('Change the theme mode of the app'),
            leading: const Icon(Icons.dark_mode_rounded, size: 32),
            onTap: showThemeModeSelectorDialog,
          ),
          ListTile(
            title: const Text('Change Language'),
            subtitle: const Text('Change the language of the app [x]'),
            leading: const Icon(Icons.translate_rounded, size: 32),
            onTap: () {},
          ),
          const SectionTitle(title: 'Custom'),
          SwitchListTile(
            title: const Text('Enable auto check update'),
            subtitle: const Text(
                'Enable check update when enter into app, if you want check update everytime'),
            value: settings.enbaleAutoCheckUpdate,
            onChanged: (bool value) {
              settings.enbaleAutoCheckUpdate = value;
            },
          ),
          ListTile(
            title: const Text('Enable custom bilibili cookie'),
            subtitle: const Text(
              'Because bilibili search need cookie vaildation, you can enable custom cookie for bilibili',
            ),
            onTap: showBilibliCookieSetDialog,
          ),
          const SectionTitle(title: 'About'),
          const CheckUpdate(),
          const About(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
