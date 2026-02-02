// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:built_collection/built_collection.dart';
// import 'package:ustahub/domain/models/product/product_model.dart';
// import 'package:ustahub/application/profile/profile_bloc.dart';
// import 'package:ustahub/application/category/category_bloc.dart';
// import 'package:collection/collection.dart';

// /// Optimized product management mixin with improved state handling and race condition prevention
// /// Immediate UI updates, debounced backend sync with proper validation
// mixin ProductManagementMixin<T extends StatefulWidget> on State<T> {
//   // Debounce timers for backend requests
//   Timer? _productDebounceTimer;
//   Timer? _informDebounceTimer;

//   // Debounce duration - increased to prevent rapid successive calls
//   static const Duration _debounceDuration = Duration(milliseconds: 800);

//   // Current pending states for debouncing with operation tracking
//   final Map<int, ProductModel> _pendingProductUpdates = {};
//   final Map<int, InformRes> _pendingInformUpdates = {};

//   // Operation tracking to prevent duplicate calls
//   final Set<int> _processingProducts = {};
//   final Set<int> _processingInforms = {};

//   @override
//   void dispose() {
//     _productDebounceTimer?.cancel();
//     _informDebounceTimer?.cancel();
//     _pendingProductUpdates.clear();
//     _pendingInformUpdates.clear();
//     _processingProducts.clear();
//     _processingInforms.clear();
//     super.dispose();
//   }

//   /// Increase product count - immediate UI update, debounced backend sync
//   void increaseProduct(ProductModel product) {
//     debugPrint('🔼 Increasing product ${product.id}');

//     if (product.id == null) {
//       debugPrint('❌ Product ID is null');
//       return;
//     }

//     // Prevent duplicate operations
//     if (_processingProducts.contains(product.id)) {
//       debugPrint('⚠️ Product ${product.id} is already being processed');
//       return;
//     }

//     final currentCount = _getCurrentProductCount(product);
//     final maxCount = product.availableQuantity ?? 999;

//     if (currentCount >= maxCount) {
//       debugPrint('❌ Cannot increase: limit reached ($maxCount)');
//       return;
//     }

//     final newCount = currentCount + 1;
//     final updatedProduct = product.rebuild((b) => b..count = newCount);

//     // Mark as processing
//     _processingProducts.add(product.id!);

//     // Immediate UI update with debounced backend sync in onLogicComplete
//     try {
//       // Fixed: isIncrease should be true for increase operations
//       final isIncrease = true;

//       context.read<ProfileBloc>().add(
//         ProfileEvent.addProduct(
//           product: updatedProduct,
//           isIncrease: isIncrease,
//           onLogicComplete: (draftList, totalAmount) {
//             debugPrint(
//               '✅ UI updated immediately: ${updatedProduct.id}, count: ${updatedProduct.count}',
//             );
//             // Debounced backend sync after UI update
//             _debouncedProductUpdate(updatedProduct);
//             // Remove from processing set
//             _processingProducts.remove(product.id);
//           },
//         ),
//       );
//     } catch (e) {
//       debugPrint('❌ Error updating product UI: $e');
//       _processingProducts.remove(product.id);
//     }
//   }

//   /// Decrease product count - immediate UI update, debounced backend sync
//   void decreaseProduct(ProductModel product) {
//     debugPrint('🔽 Decreasing product ${product.id}');

//     if (product.id == null) {
//       debugPrint('❌ Product ID is null');
//       return;
//     }

//     // Prevent duplicate operations
//     if (_processingProducts.contains(product.id)) {
//       debugPrint('⚠️ Product ${product.id} is already being processed');
//       return;
//     }

//     final currentCount = _getCurrentProductCount(product);

//     if (currentCount <= 0) {
//       debugPrint('❌ Cannot decrease: already at 0');
//       return;
//     }

//     final newCount = currentCount - 1;
//     final updatedProduct = product.rebuild((b) => b..count = newCount);

//     // Mark as processing
//     _processingProducts.add(product.id!);

//     // Immediate UI update with debounced backend sync in onLogicComplete
//     try {
//       // Fixed: isIncrease should be false for decrease operations
//       final isIncrease = false;

//       context.read<ProfileBloc>().add(
//         ProfileEvent.addProduct(
//           product: updatedProduct,
//           isIncrease: isIncrease,
//           onLogicComplete: (draftList, totalAmount) {
//             debugPrint(
//               '✅ UI updated immediately: ${updatedProduct.id}, count: ${updatedProduct.count}',
//             );
//             // Debounced backend sync after UI update
//             _debouncedProductUpdate(updatedProduct);
//             // Remove from processing set
//             _processingProducts.remove(product.id);
//           },
//         ),
//       );
//     } catch (e) {
//       debugPrint('❌ Error updating product UI: $e');
//       _processingProducts.remove(product.id);
//     }
//   }

//   /// Debounced backend sync for product with improved validation
//   void _debouncedProductUpdate(ProductModel product) {
//     if (product.id == null) return;

//     // Store pending update
//     _pendingProductUpdates[product.id!] = product;

//     // Cancel existing timer
//     _productDebounceTimer?.cancel();

//     // Start new timer
//     _productDebounceTimer = Timer(_debounceDuration, () {
//       _performProductBackendSync();
//     });
//   }

//   /// Perform actual backend sync for products with improved error handling
//   void _performProductBackendSync() {
//     if (_pendingProductUpdates.isEmpty) return;

//     try {
//       // Get current state from ProfileBloc
//       final profileState = context.read<ProfileBloc>().state;
//       final currentDraftList = List<ProductModel>.from(profileState.draftList);

//       // Create a map of current products by ID for easy lookup
//       final Map<int, ProductModel> currentProductsMap = {
//         for (final product in currentDraftList)
//           if (product.id != null) product.id!: product,
//       };

//       // Merge current products with pending updates
//       for (final pendingProduct in _pendingProductUpdates.values) {
//         if (pendingProduct.id != null) {
//           currentProductsMap[pendingProduct.id!] = pendingProduct;
//         }
//       }

//       // Remove products with count 0
//       final List<ProductModel> allCartItems = currentProductsMap.values
//           .where((product) => (product.count ?? 0) > 0)
//           .toList();

//       final totalAmount = allCartItems.fold<double>(
//         0,
//         (sum, product) => sum + ((product.price ?? 0) * (product.count ?? 0)),
//       );

//       debugPrint(
//         '🚀 DEBOUNCED Backend sync: ${allCartItems.length} products (${_pendingProductUpdates.length} updated), total: $totalAmount',
//       );

//       // Only sync if there are actual changes
//       if (allCartItems.isNotEmpty || currentDraftList.isNotEmpty) {
//         context.read<ProfileBloc>().add(
//           ProfileEvent.createProduct(
//             request: OrderReq(
//               (b) => b
//                 ..totalAmount = totalAmount
//                 ..status = "draft"
//                 ..products = ListBuilder(allCartItems),
//             ),
//           ),
//         );

//         debugPrint('✅ ProfileBloc.createProduct called successfully');
//       } else {
//         debugPrint('ℹ️ No changes to sync');
//       }

//       // Clear pending updates
//       _pendingProductUpdates.clear();
//     } catch (e) {
//       debugPrint('❌ Error in debounced product backend sync: $e');
//       // Don't clear pending updates on error - they'll be retried
//     }
//   }

//   /// Get current product count from ProfileBloc with improved error handling
//   int _getCurrentProductCount(ProductModel product) {
//     try {
//       final profileState = context.read<ProfileBloc>().state;
//       final existingProduct = profileState.draftList.firstWhereOrNull(
//         (p) => p.id == product.id,
//       );
//       return existingProduct?.count ?? 0;
//     } catch (e) {
//       debugPrint('❌ Error getting product count: $e');
//       return 0;
//     }
//   }

//   /// Get current product count for UI display
//   int getProductCount(ProductModel product) {
//     return _getCurrentProductCount(product);
//   }

//   /// Increase inform count - immediate UI update, debounced backend sync
//   void increaseInform(ProductModel product) {
//     debugPrint('🔔 Increasing inform for product ${product.id}');

//     if (product.id == null) {
//       debugPrint('❌ Product ID is null');
//       return;
//     }

//     // Prevent duplicate operations
//     if (_processingInforms.contains(product.id)) {
//       debugPrint(
//         '⚠️ Inform for product ${product.id} is already being processed',
//       );
//       return;
//     }

//     final currentInform = _getCurrentInform(product);
//     final newCount = (currentInform?.count ?? 0) + 1;

//     final updatedInform = currentInform != null
//         ? currentInform.rebuild((b) => b..count = newCount)
//         : InformRes(
//             (b) => b
//               ..id = null
//               ..count = newCount
//               ..product.replace(product),
//           );

//     // Mark as processing
//     _processingInforms.add(product.id!);

//     // Immediate UI update with debounced backend sync in onLogicComplete
//     try {
//       context.read<CategoryBloc>().add(
//         CategoryEvent.addInform(
//           inform: updatedInform,
//           onLogicComplete: (informList) {
//             debugPrint(
//               '✅ Inform UI updated immediately: ${updatedInform.product?.id}, count: ${updatedInform.count}',
//             );
//             // Debounced backend sync after UI update
//             _debouncedInformUpdate(updatedInform, product);
//             // Remove from processing set
//             _processingInforms.remove(product.id);
//           },
//         ),
//       );
//     } catch (e) {
//       debugPrint('❌ Error updating inform UI: $e');
//       _processingInforms.remove(product.id);
//     }
//   }

//   /// Decrease inform count - immediate UI update, debounced backend sync
//   void decreaseInform(ProductModel product) {
//     debugPrint('🔔 Decreasing inform for product ${product.id}');

//     if (product.id == null) {
//       debugPrint('❌ Product ID is null');
//       return;
//     }

//     // Prevent duplicate operations
//     if (_processingInforms.contains(product.id)) {
//       debugPrint(
//         '⚠️ Inform for product ${product.id} is already being processed',
//       );
//       return;
//     }

//     final currentInform = _getCurrentInform(product);
//     final currentCount = currentInform?.count ?? 0;

//     if (currentCount <= 0) {
//       debugPrint('❌ Cannot decrease inform: already at 0');
//       return;
//     }

//     final newCount = currentCount - 1;

//     // Mark as processing
//     _processingInforms.add(product.id!);

//     // If count goes to 0, delete immediately instead of updating
//     if (newCount <= 0 && currentInform?.id != null) {
//       debugPrint('🗑️ Deleting inform immediately: count went to 0');
//       context.read<CategoryBloc>().add(
//         CategoryEvent.deleteInform(id: currentInform!.id!),
//       );
//       _processingInforms.remove(product.id);
//       return;
//     }

//     final updatedInform = currentInform!.rebuild((b) => b..count = newCount);

//     // Immediate UI update with debounced backend sync in onLogicComplete
//     try {
//       context.read<CategoryBloc>().add(
//         CategoryEvent.addInform(
//           inform: updatedInform,
//           onLogicComplete: (informList) {
//             debugPrint(
//               '✅ Inform UI updated immediately: ${updatedInform.product?.id}, count: ${updatedInform.count}',
//             );
//             // Debounced backend sync after UI update
//             _debouncedInformUpdate(updatedInform, product);
//             // Remove from processing set
//             _processingInforms.remove(product.id);
//           },
//         ),
//       );
//     } catch (e) {
//       debugPrint('❌ Error updating inform UI: $e');
//       _processingInforms.remove(product.id);
//     }
//   }

//   /// Debounced backend sync for inform with improved validation
//   void _debouncedInformUpdate(InformRes inform, ProductModel product) {
//     if (product.id == null) return;

//     // Store pending update
//     _pendingInformUpdates[product.id!] = inform;

//     // Cancel existing timer
//     _informDebounceTimer?.cancel();

//     // Start new timer
//     _informDebounceTimer = Timer(_debounceDuration, () {
//       _performInformBackendSync();
//     });
//   }

//   /// Perform actual backend sync for informs with improved error handling
//   void _performInformBackendSync() {
//     if (_pendingInformUpdates.isEmpty) return;

//     try {
//       // Only process the pending updates, not all informs
//       final List<InformRes> informsToUpdate = [];
//       final List<InformRes> informsToDelete = [];

//       // Process only the pending updates
//       for (final pendingInform in _pendingInformUpdates.values) {
//         if (pendingInform.product?.id != null) {
//           if ((pendingInform.count ?? 0) <= 0) {
//             informsToDelete.add(pendingInform);
//           } else {
//             informsToUpdate.add(pendingInform);
//           }
//         }
//       }

//       debugPrint(
//         '🚀 DEBOUNCED Inform backend sync for ONLY pending updates: ${informsToUpdate.length} to update, ${informsToDelete.length} to delete',
//       );

//       // Process deletions first
//       for (final inform in informsToDelete) {
//         if (inform.id != null && inform.id! > 0) {
//           context.read<CategoryBloc>().add(
//             CategoryEvent.deleteInform(id: inform.id!),
//           );
//           debugPrint(
//             '🗑️ Deleting inform ${inform.id} for product ${inform.product?.id}',
//           );
//         }
//       }

//       // Process updates - only for the items that were actually changed
//       for (final inform in informsToUpdate) {
//         if (inform.product?.id != null) {
//           final request = InformModel(
//             (b) => b
//               ..product = inform.product!.id
//               ..count = inform.count,
//           );

//           context.read<CategoryBloc>().add(
//             CategoryEvent.informCreate(
//               request: request,
//               onDone: () {
//                 debugPrint(
//                   '✅ CategoryBloc.informCreate called successfully for product ${inform.product?.id}',
//                 );
//                 // Refresh inform list if it's a new inform
//                 if (inform.id == null) {
//                   context.read<CategoryBloc>().add(
//                     const CategoryEvent.getInformList(),
//                   );
//                 }
//               },
//             ),
//           );
//         }
//       }

//       // Clear pending updates
//       _pendingInformUpdates.clear();
//     } catch (e) {
//       debugPrint('❌ Error in debounced inform backend sync: $e');
//       // Don't clear pending updates on error - they'll be retried
//     }
//   }

//   /// Get current inform for product with improved error handling
//   InformRes? _getCurrentInform(ProductModel product) {
//     try {
//       final categoryState = context.read<CategoryBloc>().state;
//       return categoryState.informList.firstWhereOrNull(
//         (inform) => inform.product?.id == product.id,
//       );
//     } catch (e) {
//       debugPrint('❌ Error getting inform: $e');
//       return null;
//     }
//   }

//   /// Get current inform count for UI display
//   int getInformCount(ProductModel product) {
//     final inform = _getCurrentInform(product);
//     return inform?.count ?? 0;
//   }

//   /// Get inform object for UI
//   InformRes? getInform(ProductModel product) {
//     return _getCurrentInform(product);
//   }
// }
