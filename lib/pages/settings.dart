import 'package:flutter/material.dart';
import 'package:ice_live_viewer/provider/theme_provider.dart';
import 'package:ice_live_viewer/utils/storage.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
          const SectionTitle(
            title: 'General',
          ),
          ListTile(
            title: const Text('Change Theme Color'),
            subtitle: const Text('Change the theme color of the app'),
            leading: const Icon(Icons.color_lens, size: 32),
            onTap: () {
              Provider.of<AppThemeProvider>(context, listen: false)
                  .showThemeColorSelectorDialog(context);
            },
          ),
          ListTile(
            title: const Text('Change Theme Mode'),
            subtitle: const Text('Change the theme mode of the app'),
            leading: const Icon(Icons.dark_mode_rounded, size: 32),
            onTap: () {
              Provider.of<AppThemeProvider>(context, listen: false)
                  .showThemeModeSelectorDialog(context);
            },
          ),
          ListTile(
            title: const Text('Change Language'),
            subtitle: const Text('Change the language of the app [x]'),
            leading: const Icon(Icons.translate_rounded, size: 32),
            onTap: () {},
          ),
          const SwitchTile(
            title: 'Use custom resolution for Huya',
            subtitle:
                'Use custom resolution for Huya, if you want to use a custom resolution for Huya, you should enable this option',
            settingKey: 'use_custom_resolution_for_huya',
          ),
          const SectionTitle(
            title: 'Others',
          ),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('About our hotlive app'),
            leading: const Icon(Icons.info_outline_rounded, size: 32),
            onTap: () {
              showAboutDialog(context: context);
            },
          ),
          ListTile(
            title: const Text('Check Update'),
            subtitle: const Text('version 0.9.0'),
            leading: const Icon(Icons.update_rounded, size: 32),
            onTap: () {
              showAboutDialog(context: context);
            },
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline2),
    );
  }
}

class SwitchTile extends StatefulWidget {
  const SwitchTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.settingKey,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String settingKey;

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool? _toggled = false;

  @override
  void initState() {
    getSwitchPref(widget.settingKey).then((value) {
      _toggled = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        value: _toggled!,
        activeColor: Provider.of<AppThemeProvider>(context).themeColor,
        onChanged: (bool value) {
          switchPref(widget.settingKey);
          setState(() {
            _toggled = value;
          });
        });
  }
}
