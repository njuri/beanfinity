//
//  StoreItem.m
//  TapTester
//
//  Created by Juri on 06/14/14.
//


#import "StoreItem.h"
#import "MainScene.h"

@implementation StoreItem{
    CCLabelTTF *_nameLabel;
    CCLabelTTF *_priceLabel;
    CCLabelTTF *_countLabel;
}

-(void)loadItemWithName:(NSString*)name andPrice:(int)price andCount:(int)count{
    _price = price;
    _count = count;
    _name = name;
    _countLabel.string = [NSString stringWithFormat:@"%i",count];
    _priceLabel.string = [NSString stringWithFormat:@"%i",price];
    _nameLabel.string = name;
    //NSLog(@"Store item \"%@\" is loaded.",name);
}

-(void)tapOnImage{;
    MainScene *main = [[MainScene alloc] init];
    [main buyObject:self forPrice:_price];
}

-(void)changeCountLabel:(int)count{
    _countLabel.string = [NSString stringWithFormat:@"%i",count];
}

@end
