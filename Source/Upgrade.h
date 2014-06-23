//
//  Upgrade.h
//  Beanfinity
//
//  Created by Juri Noga on 23.06.14.
//
//

#import "CCNode.h"
@class StoreItem;

@interface Upgrade : CCNode

@property (nonatomic) StoreItem* item;
@property double price;

-(void)setItem:(StoreItem *)item;

@end
