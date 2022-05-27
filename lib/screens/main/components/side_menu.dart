import 'package:admin/shared/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/shared/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin/models/menu_model.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          Consumer<MenuController>(
            builder: (context, menuController, child) =>
                DrawerListTile(listOfModel: menuController.menuModelList),
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.listOfModel,
    // required this.press,
  }) : super(key: key);

  final List<MenuModel> listOfModel;
  //final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    List<Widget> _list_of_listTile = [];
    for (int i = 0; i < listOfModel.length; i++)
      _list_of_listTile.add(InkWell(
        // hoverColor: Colors.grey.withOpacity(0.3),
        child: Container(
          color: listOfModel[i].isselected!
              ? Colors.grey.withOpacity(0.3)
              : secondaryColor,
          child: ListTile(
            selected: true,
            selectedColor: Colors.grey.shade400,
            onTap: () {
              context.read<MenuController>().onChangeSelectedMenu(i);
              print(listOfModel[i].title.toString() +
                  " - " +
                  listOfModel[i].isselected.toString());
              if (Responsive.isMobile(context) || Responsive.isTablet(context))
                Navigator.pop(context);
            },
            horizontalTitleGap: 0.0,
            leading: SvgPicture.asset(
              listOfModel[i].svgSrc!,
              color: Colors.white54,
              height: 16,
            ),
            title: Text(
              listOfModel[i].title!,
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ));
    return Column(
      children: [..._list_of_listTile],
    );
  }
}
