//
//  LPDCollectionViewModel+Private.h
//  Pods
//
//  Created by foxsofter on 16/12/4.
//
//

#import "LPDCollectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LPDCollectionViewModel ()

@property (nullable, nonatomic, weak) id<UIScrollViewDelegate> scrollViewDelegate;
@property (nonatomic, strong, readonly) id<UICollectionViewDelegate> delegate;
@property (nonatomic, strong, readonly) id<UICollectionViewDataSource> dataSource;

#pragma mark - data signal

@property (nullable, nonatomic, strong, readonly) RACSignal *reloadDataSignal;                   // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *scrollToItemAtIndexPathSignal;      // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *insertSectionsSignal;               // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *deleteSectionsSignal;               // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *replaceSectionsSignal;              // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *reloadSectionsSignal;               // 请勿订阅此信号

@property (nullable, nonatomic, strong, readonly) RACSignal *insertItemsAtIndexPathsSignal;  // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *deleteItemsAtIndexPathsSignal;  // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *replaceItemsAtIndexPathsSignal; // 请勿订阅此信号
@property (nullable, nonatomic, strong, readonly) RACSignal *reloadItemsAtIndexPathsSignal;  // 请勿订阅此信号

@end

NS_ASSUME_NONNULL_END
