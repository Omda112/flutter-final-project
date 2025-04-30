import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile_widget/options.dart';
import '../user_model.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserModel>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade500,
                  radius: 100,
                  child: userModel.user?.image == null
                      ? const Icon(Icons.person, size: 200, color: Colors.white38)
                      : ClipOval(
                    child: Image.file(
                      userModel.user!.image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _buildImageOptions(userModel),
                      );
                    },
                    icon: const Icon(Icons.camera_alt, size: 35, color: Colors.white38),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                const Text("Name", style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(userModel.user?.name ?? "Unknown", style: const TextStyle(fontSize: 20)),

                const SizedBox(height: 20),

                const Text("Email", style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(userModel.user?.bio ?? "No Email", style: const TextStyle(fontSize: 20)),

                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: () => userModel.logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOptions(UserModel userModel) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const Text("Profile", style: TextStyle(fontSize: 25)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Options(
                onPressed: () {
                  userModel.imageSelector(ImageSource.camera);
                  Navigator.pop(context);
                },
                title: "Camera",
                icon: Icons.camera_alt,
              ),
              Options(
                onPressed: () {
                  userModel.imageSelector(ImageSource.gallery);
                  Navigator.pop(context);
                },
                title: "Gallery",
                icon: Icons.image,
              ),
              if (userModel.user?.image != null)
                Options(
                  selectedImage: userModel.user?.image,
                  onPressed: () {
                    userModel.removeImage();
                    Navigator.pop(context);
                  },
                  title: "Delete",
                  icon: Icons.delete,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
