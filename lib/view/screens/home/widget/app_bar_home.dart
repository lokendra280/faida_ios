import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../util/ui_assets.dart';
import '../../dashboard/widget/size_constants.dart';

class AppBarHome extends ConsumerWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showBottomWidget;

  const AppBarHome({
    this.showBottomWidget = false,
     this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: SC.mW),
        child: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SvgPicture.asset(
                  UIAssets.getSvg(
                    'burger_menu.svg',
                  ),
                ),
              );
            }
        ),
      ),
      leadingWidth: 30,
      centerTitle: true,
      title: title,
      actions: [
        IconButton(
          icon: SvgPicture.asset(UIAssets.getSvg('bell.svg')), //SvgPicture.asset(UIAssets.getSvg('bell.svg'))
          onPressed: () {
            //context.router.push(const NotificationRoute());
            // ref.watch(storeLocationProvider).showDialog(context);
          },
        ),
        // IconButton(
        //   icon: Icon(Icons.location_on_rounded, size: 20, 
        //   ), //SvgPicture.asset(UIAssets.getSvg('bell.svg'))
        //   onPressed: () {
        //     // context.router.push(const NotificationRoute());
        //     //ref.watch(storeLocationProvider).showDialog(context);
        //   },
        // ),
        //const AuthWidgetWrapper(child: CartCounterBag())
      ],
      bottom: showBottomWidget ? const _SearchBarContainer() : null,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

const _screenEdgePadding = SC.mH;

class _SearchBarContainer extends StatelessWidget
    implements PreferredSizeWidget {
  const _SearchBarContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.router.push(const SearchRoute());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: SC.lW, vertical: _screenEdgePadding),
        padding: const EdgeInsets.only(left: SC.lW),
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xfff2f2f2),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              UIAssets.getSvg('search.svg'),
              width: 15,
            ),
            SBC.sW,
            Text(
              'Search 200000+ products',
              style: Theme
                  .of(context)
                  .textTheme
                  .caption
                  .copyWith(color: const Color(0xffABA8A8)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}


