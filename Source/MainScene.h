//
//  MainScene.h
//  TapTester
//
//  Created by Juri on 06/14/14.
//


#import "CCNode.h"
@class StoreItem;

@interface MainScene : CCNode

-(void)buyObject:(StoreItem*)item forPrice:(int)price;
-(void)upgradeItem:(StoreItem*)item forPrice:(double)price;

@end
