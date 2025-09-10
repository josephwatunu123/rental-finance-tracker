import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const List<String> settings =[
      'Profile',
      'About us',
      'Support',
      'Logout',
      'Delete Account'
    ];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Settings',style:theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold) ,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:List.generate(
              settings.length, (index){
            return settingsCard(
                theme: theme,
                title: settings[index],
                icon: Icons.build,
                subtitle: 'overview of test',
                height: size.height * 0.1
            );
          })
        ),
      ),

    );
  }

  Widget settingsCard({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required String subtitle,
    required double height,
    Color? iconColor,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.blueAccent),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        contentPadding: EdgeInsets.zero, // keeps it tight
      ),
    );
  }

}
