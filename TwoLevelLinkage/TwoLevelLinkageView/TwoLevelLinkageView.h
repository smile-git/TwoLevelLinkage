//
//  TwoLevelLinkageView.h
//  TwoLevelLinkage
//
//  Created by ZWX on 2018/1/11.
//  Copyright © 2018年 ZWX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftLevelLinkageModel.h"

typedef void(^RegistCellWithTableViewBlock)(UITableView *leftSideTableView, UITableView *rightSideTableView);

@interface TwoLevelLinkageView : UIView

@property (nonatomic, strong) NSArray <LeftLevelLinkageModel *>*leftModels;

/**
 init method

 @param frame frame
 @param leftSideWidth leftTableView's width
 @return TwoLevelLinkageView
 */
- (instancetype)initWithFrame:(CGRect)frame leftSideWidth:(CGFloat)leftSideWidth;


/**
 注册两个级联TableView的cell和HdaderView

 @param leftSideTableViewBlock leftSideTableViewBlock description
 @param rightSideTableViewBlock rightSideTableViewBlock description
 */
- (void)registCellWithLeftTableView:(void (^)(UITableView *leftSideTableView))leftSideTableViewBlock cellAndHeaderWithRightTableView:(void (^)(UITableView *rightSideTableView))rightSideTableViewBlock;

/**
 注册两个级联TableView的cell和HdaderView

 @param tableViewBlock TableViewBlock description
 */
- (void)registCellWithTableViews:(RegistCellWithTableViewBlock)tableViewBlock;

/**
 刷新数据
 */
- (void)reloadData;

/**
 初始化左侧tableView选中第几行

 @param row row
 */
- (void)leftTableViewCellMakeSelectedAtRow:(NSInteger)row;

@end
