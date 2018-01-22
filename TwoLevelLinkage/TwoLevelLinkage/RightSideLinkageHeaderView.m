//
//  RightSideLinkageHeaderView.m
//  TwoLevelLinkage
//
//  Created by ZWX on 19/01/2018.
//  Copyright © 2018 ZWX. All rights reserved.
//

#import "RightSideLinkageHeaderView.h"
#import "CategoryModel.h"

@implementation RightSideLinkageHeaderView

- (void)setupHeaderFooterView {
    
    [super setupHeaderFooterView];
    
    self.textLabel.font      = [UIFont systemFontOfSize:11.f];
    self.textLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:.85f];
}

- (void)buildSubview {
    
    [super buildSubview];
}

- (void)loadContent {
    
    [super loadContent];
    
    CategoryModel *categoryModel = self.data;
    self.textLabel.text = categoryModel.name;
}

@end
