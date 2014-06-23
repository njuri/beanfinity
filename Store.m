//
//  Store.m
//  Beanfinity
//
//  Created by Juri Noga on 20.06.14.
//
//

#import "Store.h"
#import "StoreItem.h"

@implementation Store{
    StoreItem *_leaves;
    StoreItem *_bagOfBeans;
}

-(void)didLoadFromCCB{
    _leaves.value = 0.1;
    [_leaves loadItemWithName:@"Coffee leaves" andPrice:15 andCount:0];
    _bagOfBeans.value = 1;
    [_bagOfBeans loadItemWithName:@"Bag of beans" andPrice:20 andCount:0];
}

@end
