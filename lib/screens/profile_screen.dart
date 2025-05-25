
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/like/bloc/liked_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(),
                    Text(
                      'My Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF2B3A55),
                      ),
                    ),
                    Icon(Icons.share, color: Color(0xFF2B3A55)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/user1.png'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Choirul Syafril',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B3A55),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text('Recipes', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '782',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text('Following', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '1.287',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text('Followers', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TabBar(
                indicatorColor: Color(0xFF00C851),
                labelColor: Color(0xFF2B3A55),
                unselectedLabelColor: Colors.grey,
                tabs: [Tab(text: 'Recipes'), Tab(text: 'Liked')],
              ),
              const Expanded(
                child: TabBarView(
                  children: [RecipeGridView(), LikedRecipesTab()],
                ),
              ),
            ],
          ),
        ),
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

class LikedRecipesTab extends StatelessWidget {
  const LikedRecipesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> allRecipes = [
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

    return BlocBuilder<LikedBloc, LikedState>( //BlocBuilder is monitoring whether this recipe has been liked or not.
      builder: (context, state) {
        final liked =
            allRecipes
                .where((r) => state.likedTitles.contains(r['title']))
                .toList();
//If the user clicks on the icon, a LikeRecipe or UnlikeRecipe is sent depending on the situation.
        if (liked.isEmpty) {
          return const Center(child: Text('No liked recipes yet.'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: liked.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final recipe = liked[index];
            return RecipeCard(
              imagePath: recipe['imagePath']!,
              title: recipe['title']!,
              subtitle: recipe['subtitle']!,
              userImage: recipe['userImage']!,
              userName: recipe['userName']!,
            );
          },
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
