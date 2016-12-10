//
//  LPDCollectionView.m
//  LPDMvvmKit
//
//  Created by foxsofter on 16/2/22.
//  Copyright © 2016年 eleme. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LPDCollectionView.h"
#import "LPDCollectionViewModel+Private.h"
#import "LPDCollectionSectionViewModel+Private.h"

@interface LPDCollectionView ()

@property (nullable, nonatomic, weak, readwrite) __kindof id<LPDCollectionViewModelProtocol> viewModel;

@end

@implementation LPDCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithFrame:frame collectionViewLayout:layout];
  if (self) {
    self.backgroundColor = [UIColor colorWithRed:0.9214 green:0.9206 blue:0.9458 alpha:1.0];
  }
  return self;
}

- (void)bindingTo:(__kindof id<LPDCollectionViewModelProtocol>)viewModel {
  NSParameterAssert(viewModel);

  self.viewModel = viewModel;

  @weakify(self);
  [[[self rac_signalForSelector:@selector(didMoveToSuperview)] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
    @strongify(self);
    
    LPDCollectionViewModel *collectionViewModel = self.viewModel;
    super.delegate = collectionViewModel.delegate;
    super.dataSource = collectionViewModel.dataSource;

    [[[collectionViewModel.reloadDataSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
      deliverOnMainThread] subscribeNext:^(id x) {
          @strongify(self);
          [self reloadData];
        }];

    [[[collectionViewModel.insertSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
     deliverOnMainThread] subscribeNext:^(NSIndexSet *indexSet) {
          @strongify(self);
          [self insertSections:indexSet];
        }];

      [[[collectionViewModel.deleteSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
        deliverOnMainThread] subscribeNext:^(NSIndexSet *indexSet) {
          @strongify(self);
          [self deleteSections:indexSet];
        }];

      [[[collectionViewModel.replaceSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
        deliverOnMainThread] subscribeNext:^(NSArray<NSIndexPath *> *indexPaths) {
          @strongify(self);
        [self performBatchUpdates:^{
          [self deleteItemsAtIndexPaths:indexPaths];
          [self insertItemsAtIndexPaths:indexPaths];
        } completion:nil];
        }];

      [[[collectionViewModel.reloadSectionsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
        deliverOnMainThread] subscribeNext:^(NSIndexSet *indexSet) {
          @strongify(self);
          [self reloadSections:indexSet];
        }];

      [[[collectionViewModel.insertItemsAtIndexPathsSignal takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
        deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        if (tuple.second) {
          [self performBatchUpdates:^{
            [self insertSections:tuple.second];
            [self insertItemsAtIndexPaths:tuple.first];
          } completion:nil];
        } else {
          [self insertItemsAtIndexPaths:tuple.first];
        }
      }];

      [[[collectionViewModel.deleteItemsAtIndexPathsSignal
        takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
        deliverOnMainThread] subscribeNext:^(NSArray<NSIndexPath *> *indexPaths) {
          @strongify(self);
          [self deleteItemsAtIndexPaths:indexPaths];
        }];

      [[[collectionViewModel.replaceItemsAtIndexPathsSignal
        takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]] deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self performBatchUpdates:^{
          if (tuple.third) {
            [self insertSections:tuple.third];
            [self insertItemsAtIndexPaths:tuple.second];
          } else {
            [self deleteItemsAtIndexPaths:tuple.first];
            [self insertItemsAtIndexPaths:tuple.second];
          }
        } completion:nil];
      }];

      [[[collectionViewModel.reloadItemsAtIndexPathsSignal
        takeUntil:[self rac_signalForSelector:@selector(removeFromSuperview)]]
        deliverOnMainThread] subscribeNext:^(NSArray<NSIndexPath *> *indexPaths) {
          @strongify(self);
          [self reloadItemsAtIndexPaths:indexPaths];
        }];
    }];
}

@end
