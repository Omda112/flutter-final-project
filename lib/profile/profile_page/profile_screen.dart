import 'package:firstproject/user/user_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dark_theme/theme_provider.dart';
import '../profile_widget/options.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserViewModel>(context);

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
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Name", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _editFieldDialog(context, userModel, field: 'name'),
                    ),
                  ],
                ),
                Text(userModel.user?.name ?? "Unknown", style: const TextStyle(fontSize: 20)),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Email", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _editFieldDialog(context, userModel, field: 'email'),
                    ),
                  ],
                ),
                Text(userModel.user?.email ?? "No Email", style: const TextStyle(fontSize: 20)),

                const SizedBox(height: 20),

// 🌙 Dark Mode Toggle
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return SwitchListTile(
                      title: const Text("Dark Mode"),
                      value: themeProvider.themeMode == ThemeMode.dark,
                      onChanged: (value) => themeProvider.toggleTheme(value),
                    );
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () => userModel.logout(context),
                  icon: const Icon(Icons.logout , color: Colors.red,),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOptions(UserViewModel userViewModel) {
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
                  userViewModel.pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                title: "Camera",
                icon: Icons.camera_alt,
              ),
              Options(
                onPressed: () {
                  userViewModel.pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                title: "Gallery",
                icon: Icons.image,
              ),
              if (userViewModel.user?.image != null)
                Options(
                  selectedImage: userViewModel.user?.image,
                  onPressed: () {
                    userViewModel.removeImage();
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

  void _editFieldDialog(BuildContext context, UserViewModel userModel, {required String field}) {
    final TextEditingController controller = TextEditingController(
      text: field == 'name' ? userModel.user?.name : userModel.user?.email,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${field == 'name' ? 'Name' : 'Email'}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: field == 'name' ? 'Name' : 'Email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newValue = controller.text.trim();
              if (newValue.isNotEmpty) {
                if (field == 'name') {
                  userModel.updateName(newValue);
                } else {
                  userModel.updateEmail(newValue);
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
