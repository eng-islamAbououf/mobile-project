import 'package:flutter/material.dart';
import 'package:mobile_project/componants/custom_app_bar.dart';
import 'package:mobile_project/provider/home_provider.dart';
import 'package:mobile_project/view/fav_screen.dart';
import 'package:mobile_project/view/profile_screen.dart';
import 'package:mobile_project/view/services_screen.dart';
import 'package:provider/provider.dart';

import 'add_service_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height  = MediaQuery.of(context).size.height;
    double width  = MediaQuery.of(context).size.width;
    var provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Sign_Up_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child : _ui(provider,height,context),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: height * 0.065,
          decoration: const BoxDecoration(
            color: Color(0xff47CEC7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home_outlined,color: Colors.white,),
                onPressed: () => provider.setIndex(0),
              ),
              IconButton(
                icon: const Icon(Icons.search,color: Colors.white,),
                onPressed: () => provider.setIndex(0),
              ),
              IconButton(
                icon: const Icon(Icons.add,color: Colors.white,),
                onPressed: () => provider.setIndex(1),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border,color: Colors.white,),
                onPressed: () => provider.setIndex(2),
              ),
              IconButton(
                icon: const Icon(Icons.person_2_outlined , color: Colors.white,),
                onPressed: () => provider.setIndex(3),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          onPressed: () {
            provider.setIndex(1);
          },
          backgroundColor: Color(0xffF2E8FD),
          elevation: 20.0,
          child: Icon(Icons.add , size: 40,color: Color(0xff47CEC7),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _ui(HomeProvider provider ,height,context){
    final _curWidget = [
      ServicesScreen(provider:provider,),
      AddServiceScreen(provider: provider),
      FavouriteScreen(provider: provider),
      ProfileScreen(),
    ];
    if(provider.loading) {
      return const Center(child: CircularProgressIndicator(),);
    }

    return Column(
      children: [
        CustomAppBar(height: height, title: "Services"),
        _curWidget[provider.index],
      ],
    );
  }
}
