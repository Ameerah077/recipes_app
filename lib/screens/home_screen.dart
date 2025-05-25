import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/like/bloc/liked_bloc.dart';

import 'upload_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTabContent(),
    const UploadScreen(),
    const Center(child: Text('Scan')),
    const Center(child: Text('Notifications')),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00C851),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      CategoryTab(text: 'All', isActive: true),
                      SizedBox(width: 12),
                      CategoryTab(text: 'Food'),
                      SizedBox(width: 12),
                      CategoryTab(text: 'Drink'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const TabBar(
                    indicatorColor: Color(0xFF00C851),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [Tab(text: 'Left'), Tab(text: 'Right')],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [RecipeGridView(), RecipeGridView()]),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String text;
  final bool isActive;

  const CategoryTab({super.key, required this.text, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00C851) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: isActive ? Colors.white : Colors.black),
      ),
    );
  }
}

class RecipeGridView extends StatelessWidget {
  const RecipeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recipes = [
      {
        'title': 'Pancake',
        'subtitle': 'Food • >60 mins',
        'imagePath': 'assets/images/food_pancake.jpg',
        'userImage': 'assets/images/user1.png',
        'userName': 'Calum Lewis',
      },
      {
        'title': 'Salad',
        'subtitle': 'Food • >60 mins',
        'imagePath': 'assets/images/food_salad.jpg',
        'userImage': 'assets/images/user2.png',
        'userName': 'Elif Sonas',
      },
      {
        'title': 'Special 1',
        'subtitle': 'Food • >60 mins',
        'imagePath': 'assets/images/food1.jpg',
        'userImage': 'assets/images/user3.png',
        'userName': 'Elena Shelby',
      },
      {
        'title': 'Special 2',
        'subtitle': 'Food • >60 mins',
        'imagePath': 'assets/images/food2.jpg',
        'userImage': 'assets/images/user4.png',
        'userName': 'John Priyadi',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          imagePath: recipe['imagePath']!,
          title: recipe['title']!,
          subtitle: recipe['subtitle']!,
          userImage: recipe['userImage']!,
          userName: recipe['userName']!,
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String userImage;
  final String userName;

  const RecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.userImage,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              const SizedBox(width: 12),
              CircleAvatar(radius: 16, backgroundImage: AssetImage(userImage)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      imagePath,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: BlocBuilder<LikedBloc, LikedState>(
                      builder: (context, state) {
                        final isLiked = state.likedTitles.contains(title);
                        return GestureDetector(
                          onTap: () {
                            if (isLiked) {
                              context.read<LikedBloc>().add(
                                UnlikeRecipe(title),
                              );
                            } else {
                              context.read<LikedBloc>().add(LikeRecipe(title));
                            }
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
