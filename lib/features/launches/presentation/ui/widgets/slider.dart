import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/data/repository/models/rocket_entity.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_cubit.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_state.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({required this.rockets, super.key});

  final List<RocketEntity> rockets;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LaunchesCubit>();
    return Column(
      spacing: 16,
      children: [
        CarouselSlider.builder(
          itemCount: rockets.length,
          carouselController: cubit.carouselController,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = rockets[index].flickrImages.isNotEmpty
                ? rockets[index].flickrImages.first
                : '';
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.78,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => cubit.onRocketSelected(index),
          ),
        ),
        SizedBox(
          height: 10,
          child: BlocBuilder<LaunchesCubit, LaunchesState>(
            builder: (context, state) {
              final activeDotIndex = state.currentImageIndex % 4;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isActive = activeDotIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 9,
                      width: 9,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: isActive ? Colors.white : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
