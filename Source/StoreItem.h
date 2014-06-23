//
//  StoreItem.h
//  TapTester
//
//  Created by Juri on 06/14/14.
//

#import "CCNode.h"

@interface StoreItem : CCNode

@property double value;
@property double price;
@property double count;
@property (nonatomic) NSString* name;

-(void)loadItemWithName:(NSString*)name andPrice:(int)price andCount:(int)count;

@end
