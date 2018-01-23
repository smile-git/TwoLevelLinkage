//
//  TwoLevelLinkageView.m
//  TwoLevelLinkage
//
//  Created by ZWX on 2018/1/11.
//  Copyright © 2018年 ZWX. All rights reserved.
//

#import "TwoLevelLinkageView.h"
#import "TwoLevelLinkageCell.h"
#import "CustomHeaderFooterView.h"


@interface TwoLevelLinkageView ()<UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_leftSideTableView;
    UITableView *_rightSideTableView;
    UIView      *_leftLineView;
}

@property (nonatomic, assign) CGFloat leftSideWidth;

@end

@implementation TwoLevelLinkageView

- (instancetype)initWithFrame:(CGRect)frame leftSideWidth:(CGFloat)leftSideWidth {
    
    if (self = [super initWithFrame:frame]) {
        
        self.leftSideWidth = leftSideWidth;
        
        [self buildSubview];
    }
    
    return self;
}

- (void)buildSubview {
    
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    // ----- 两个级联tableView初始化
    _leftSideTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _leftSideWidth, height) style:UITableViewStylePlain];
    _leftSideTableView.delegate   = self;
    _leftSideTableView.dataSource = self;
    _leftSideTableView.showsVerticalScrollIndicator  = NO;
    _leftSideTableView.separatorStyle                = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_leftSideTableView];
    
    _rightSideTableView = [[UITableView alloc] initWithFrame:CGRectMake(_leftSideWidth, 0, width - _leftSideWidth, height) style:UITableViewStylePlain];
    
    _rightSideTableView.delegate   = self;
    _rightSideTableView.dataSource = self;
    _rightSideTableView.showsVerticalScrollIndicator  = NO;
    _rightSideTableView.separatorStyle                = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_rightSideTableView];
    
    _leftLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.5, 100)];
    _leftLineView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [self addSubview:_leftLineView];
}

- (void)registCellWithLeftTableView:(void (^)(UITableView *leftSideTableView))leftSideTableViewBlock cellAndHeaderWithRightTableView:(void (^)(UITableView *rightSideTableView))rightSideTableViewBlock {
    
    if (leftSideTableViewBlock) {
        
        leftSideTableViewBlock(_leftSideTableView);
    }
    
    if (rightSideTableViewBlock) {
        
        rightSideTableViewBlock(_rightSideTableView);
    }
}

- (void)registCellWithTableViews:(void (^)(UITableView *leftSideTableView, UITableView *rightSideTableView))tableViewBlock {
    
    if (tableViewBlock) {
        
        tableViewBlock (_leftSideTableView, _rightSideTableView);
    }
}

- (void)reloadData {
    
    [_leftSideTableView reloadData];
    [_rightSideTableView reloadData];
}

#pragma mark - ---- Delegate Method ----
#pragma mark TableViewDeleagte & TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        return self.leftModels.count;
    
    } else {
        
        return self.leftModels[section].subModels.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual:_rightSideTableView]) {
        
        return self.leftModels.count;
        
    } else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = [self adapterWithTableView:tableView indexPath:indexPath];
    TwoLevelLinkageCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    
    cell.dataAdapter = adapter;
    cell.levelModel  = [self linkageModelWithTableView:tableView indexPath:indexPath];
    cell.data        = adapter.data;
    cell.indexPath   = indexPath;
    
    [cell loadContent];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_rightSideTableView]) {
        
        CellHeaderFooterDataAdapter *adapter = self.leftModels[section].headerAdapter;
        CustomHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:adapter.reusedIdentifier];
        
        headerView.adapter = adapter;
        headerView.data = adapter.data;
        headerView.section = section;
        
        [headerView loadContent];
        
        return headerView;
    
    } else {
        
        return nil;
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self adapterWithTableView:tableView indexPath:indexPath].cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_rightSideTableView]) {
        LeftLevelLinkageModel *leftModel = self.leftModels[section];
        CellHeaderFooterDataAdapter *adapter = leftModel.headerAdapter;
        CGFloat height = adapter.height;
        return height;
        
    } else {
        
        return 0;
    }
}

#pragma mark - ---- Whtiin The Method ----
- (CellDataAdapter *)adapterWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    CellDataAdapter *adapter = nil;
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    if ([tableView isEqual:_leftSideTableView]) {
        
        adapter = self.leftModels[row].adapter;
    
    } else {
        
        adapter = self.leftModels[section].subModels[row].adapter;
    }
    
    return adapter;
}

- (id)linkageModelWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    id data = nil;
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        data = self.leftModels[section];
        
    } else {
        
        data = self.leftModels[section].subModels[row];
    }
    
    return data;
}

@end
