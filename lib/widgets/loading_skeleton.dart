import 'package:flutter/material.dart';

/// 🎨 Skeleton Loader للمنتجات
class ProductSkeleton extends StatefulWidget {
  const ProductSkeleton({Key? key}) : super(key: key);

  @override
  State<ProductSkeleton> createState() => _ProductSkeletonState();
}

class _ProductSkeletonState extends State<ProductSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Skeleton
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Colors.grey.shade200,
              ),
              child: _buildShimmer(),
            ),
          ),
          // Content Skeleton
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Skeleton
                  _buildShimmerLine(width: double.infinity, height: 14),
                  const SizedBox(height: 8),
                  _buildShimmerLine(width: 150, height: 12),
                  const Spacer(),
                  // Rating Skeleton
                  _buildShimmerLine(width: 100, height: 12),
                  const SizedBox(height: 8),
                  // Price Skeleton
                  _buildShimmerLine(width: 80, height: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 0.8).animate(_animationController),
      child: Container(
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildShimmerLine({required double width, required double height}) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 0.8).animate(_animationController),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// 🎨 Product Skeleton Grid
class ProductSkeletonGrid extends StatelessWidget {
  final int itemCount;

  const ProductSkeletonGrid({
    Key? key,
    this.itemCount = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ProductSkeleton(),
    );
  }
}
