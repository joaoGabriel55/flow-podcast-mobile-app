import 'package:flowpdc_app/app/shared/utils/flow_creators.dart';
import 'package:flowpdc_app/app/widgets/podcast_creators_nav_drawer/nav_drawer_title.dart';
import 'package:flowpdc_app/app/widgets/podcast_creators_nav_drawer/podcast_creator_link.dart';
import 'package:flutter/material.dart';

class PodcastCreatorsNavDrawer extends StatelessWidget {
  final Function onClickCreator;

  const PodcastCreatorsNavDrawer({
    Key key,
    this.onClickCreator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).size.height / 28;

    return Container(
      color: Colors.black87,
      padding: EdgeInsets.only(top: paddingTop),
      child: ListView(
        children: [
          NavDrawerTitle(),
          PodcastCreatorLink(
            creatorName: FLOW_CREATORS[VENUS_PODCAST]["name"],
            creatorParam: VENUS_PODCAST,
            creatorLogoPath: FLOW_CREATORS[VENUS_PODCAST]["imageUrl"],
            onClickLink: (value) {
              this.onClickCreator(value);
            },
          ),
          PodcastCreatorLink(
            creatorName: FLOW_CREATORS[ENXUGA_GELO_PODCAST]["name"],
            creatorParam: ENXUGA_GELO_PODCAST,
            creatorLogoPath: FLOW_CREATORS[ENXUGA_GELO_PODCAST]["imageUrl"],
            onClickLink: (value) {
              this.onClickCreator(value);
            },
          ),
        ],
      ),
    );
  }
}
