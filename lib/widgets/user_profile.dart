import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _AvatarWidget(),
            SizedBox(height: 30,),
            _UserNameWidget(),
            SizedBox(height: 10,),
            _UserPhoneWidget(),
            SizedBox(height: 10,),
            _UserNickNameWidget()
          ],
        ),
      ),
    );
  }
}

class _UserNameWidget extends StatelessWidget {
  const _UserNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'alexander',
      style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w600
      ),
    );
  }
}

class _UserPhoneWidget extends StatelessWidget {
  const _UserPhoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '+7 (981) 816-22-45',
      style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w600
      ),
    );
  }
}

class _UserNickNameWidget extends StatelessWidget {
  const _UserNickNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '@alexandrobol',
      style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.w600
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 100,
        height: 100,
        child: Placeholder()
    );
  }
}