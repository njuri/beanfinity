//
//  Upgrade.m
//  Beanfinity
//
//  Created by Juri Noga on 23.06.14.
//
//

#import "Upgrade.h"
#import "StoreItem.h"
#import "MainScene.h"

@implementation Upgrade{
    CCButton * _button;
}

-(void)upgrade{
    MainScene *main = [[MainScene alloc] init];
    [main upgradeItem:_item forPrice:_price];
}

-(void)setItem:(StoreItem *)item{
    _item = item;
    [self setTitle:item.name];
}


-(void)setTitle:(NSString *)title{
    _button.title = @"+25% bps";
}

@end
