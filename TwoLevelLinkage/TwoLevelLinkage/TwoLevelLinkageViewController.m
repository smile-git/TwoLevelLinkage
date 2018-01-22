//
//  TwoLevelLinkageViewController.m
//  TwoLevelLinkage
//
//  Created by ZWX on 2018/1/11.
//  Copyright © 2018年 ZWX. All rights reserved.
//

#import "TwoLevelLinkageViewController.h"
#import "TwoLevelLinkageView.h"
#import "ItemManagerModel.h"
#import "LeftSideLinkageCell.h"
#import "RightSideLinkageCell.h"
#import "RightSideLinkageHeaderView.h"

@interface TwoLevelLinkageViewController ()

@property (nonatomic, strong) TwoLevelLinkageView *linkageView;
@property (nonatomic, strong) ItemManagerModel *itemModel;
@end

@implementation TwoLevelLinkageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildSubViews];
    
    [self reloadData];
}

- (void)buildSubViews {
    
    CGFloat leftSideWidth = 100.f;
    
    self.linkageView = [[TwoLevelLinkageView alloc] initWithFrame:self.view.bounds leftSideWidth:leftSideWidth];
    
    // ----- 注册两个tableView的cell和header
    [_linkageView registCellWithTableViews:^(UITableView *leftSideTableView, UITableView *rightSideTableView) {
        
        [leftSideTableView registerClass:[LeftSideLinkageCell class] forCellReuseIdentifier:@"LeftSideLinkageCell"];
        
        [rightSideTableView registerClass:[RightSideLinkageCell class] forCellReuseIdentifier:@"RightSideLinkageCell"];
        [rightSideTableView registerClass:[RightSideLinkageHeaderView class] forHeaderFooterViewReuseIdentifier:@"RightSideLinkageHeaderView"];
    }];
    
    [self.view addSubview:_linkageView];
}

- (void)reloadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                                 error:nil];
    
    self.itemModel = [[ItemManagerModel alloc] initWithDictionary:dictionary];
    [self.itemModel.data.categories removeObjectAtIndex:0];
    
    NSMutableArray <LeftLevelLinkageModel *>*leftModels = [NSMutableArray arrayWithCapacity:0];
    [self.itemModel.data.categories enumerateObjectsUsingBlock:^(CategoryModel * _Nonnull categoryModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray <RightLevelLinkageModel *>*rightModels = [NSMutableArray arrayWithCapacity:0];
        [categoryModel.subcategories enumerateObjectsUsingBlock:^(SubCategoryModel * _Nonnull subCategoryModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // ----- 创建联动右侧的model.
            RightLevelLinkageModel *rightModel = [[RightLevelLinkageModel alloc] init];
            rightModel.adapter = [RightSideLinkageCell fixedHeightTypeDataAdapterWithData:subCategoryModel];
            
            [rightModels addObject:rightModel];
        }];
        
        // ----- 创建联动左侧的model.
        LeftLevelLinkageModel *leftModel = [[LeftLevelLinkageModel alloc] init];
        leftModel.adapter = [LeftSideLinkageCell fixedHeightTypeDataAdapterWithData:categoryModel];
        // ----- 右侧model跟左侧model关联
        leftModel.subModels = rightModels;
        // ----- 右侧每个section都跟左侧的cell相关联
        leftModel.headerAdapter = [RightSideLinkageHeaderView fixedHeightTypeDataAdapterWithData:categoryModel];
        
        [leftModels addObject:leftModel];
    }];
    
    _linkageView.leftModels = leftModels;
    
    [_linkageView reloadData];
}
@end
