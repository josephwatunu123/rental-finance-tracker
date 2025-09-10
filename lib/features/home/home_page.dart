import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Dashboard',style:theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,color: Colors.white) ,),
        centerTitle: false,
        actions: [
          Icon(CupertinoIcons.bell_fill),
          const SizedBox(width: 15),
          Icon(CupertinoIcons.person_alt_circle_fill),
        ],
        actionsPadding: EdgeInsets.only(right: 15),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            userGreetings(theme: theme),
            Expanded(
              child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                children: List.generate(4,
                    (index){
                      return statsContainer(
                          height: size.height * 0.10,
                          width: size.width * 0.22
                      );
                    }
                ),

              ),
            )
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
          child: const Icon(Icons.add),
        ),
    );
  }
  
  Widget userGreetings(
  {
    required ThemeData theme,
}
      ){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Text(
            "Good Evening, Jayder. Today's Overview",
            style: theme.textTheme.bodySmall,),
          Text(
              "10th September 2025",
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget statsContainer({
    required double height,
    required double width
}){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 0.5,
          color: Colors.grey
        )
      ),
    );
  }
}
