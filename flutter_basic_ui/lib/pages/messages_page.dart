import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic_ui/helpers.dart';
import 'package:flutter_basic_ui/models/models.dart';
import 'package:flutter_basic_ui/models/story_data.dart';
import 'package:flutter_basic_ui/screens/chat_screen.dart';
import 'package:flutter_basic_ui/theme.dart';
import 'package:flutter_basic_ui/widgets/avatar.dart';
import 'package:jiffy/jiffy.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(child: _Stories()),
      SliverList(delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
        final date = Helpers.randomDate();
        final Faker faker = Faker();
        return _MessageTitle(
            messageData: MessageData(
                senderName: faker.person.name(),
                message: faker.lorem.sentence(),
                messageDate: date,
                dateMessage: Jiffy(date).fromNow(),
                profilePicture: Helpers.randomPictureUrl()));
      }))
    ]);
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({Key? key, required this.messageData}) : super(key: key);
  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 9),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.profilePicture),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                  SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: AppColors.textFaded),
                      ))
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFaded,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textLigth,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Stories',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.textFaded),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: _StoryCard(
                          storyData: StoryData(
                              name: faker.person.name(),
                              url: Helpers.randomPictureUrl()),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({Key? key, required this.storyData, name}) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Avatar.medium(url: storyData.url),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                storyData.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.bold),
              ),
            )),
          )
        ]);
  }
}
