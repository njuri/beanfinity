//
//  MainScene.m
//  TapTester
//
//  Created by Juri on 06/14/14.
//

#import "MainScene.h"
#import "StoreItem.h"
#import "Store.h"

@implementation MainScene{
    CCLabelTTF *_counterLabel;
    CCLabelTTF *_beansPerSecLabel;
    CCLabelTTF *_storeText;
    CCLabelTTF *_messageLabel;
    
    CCNode *_storeNode;
    CCNode *_leavesNode;
    CCNode *_bagNode;
    CCNodeColor *_storeDim;
    
    CCScrollView *_scroll;
    
    Store *_storeMain;
}

double totalBeans;
double average;
NSString *myMessage=@"";
BOOL updateMessage = NO;
BOOL storeOpen = NO;
NSMutableArray *storeContent;

-(void)didLoadFromCCB{
    self.userInteractionEnabled = TRUE;
    //Timers
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateAverage) userInfo:Nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(updateMessage) userInfo:Nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateTotal) userInfo:Nil repeats:YES];
    
    //Add items to store
    storeContent = [[NSMutableArray alloc]init];
    
    _storeNode.position = CGPointMake(_storeNode.position.x,_storeNode.position.y-.235);
    _messageLabel.string = myMessage;
    _storeDim.opacity = 0;
}

-(void)tap{
    totalBeans++;
    if (average==0) {
        _counterLabel.string = [NSString stringWithFormat:@"%.0f",totalBeans];
    }
    else{
        _counterLabel.string = [NSString stringWithFormat:@"%.1f",totalBeans];
    }
}

-(void)updateAverage{
    if (average>0) {
        if(fmod(average, 1)==0){
            _beansPerSecLabel.string = [NSString stringWithFormat:@"%.0f bps",average];
        }
        else if(fmod(average*10, 1)==0){
            _beansPerSecLabel.string = [NSString stringWithFormat:@"%.1f bps",average];
        }
        else if(fmod(average*100, 1)==0){
            _beansPerSecLabel.string = [NSString stringWithFormat:@"%.2f bps",average];
        }
        else{
            _beansPerSecLabel.string = [NSString stringWithFormat:@"%.3f bps",average];
        }
    }
}


-(void)buyObject:(StoreItem *)item forPrice:(int)price{
    updateMessage = YES;
    if(totalBeans>=price){
        totalBeans -= price;
        average+=item.value;
        myMessage = [NSString stringWithFormat:@"Bought %@ for %.0f beans.",item.name,item.price];
        [item loadItemWithName:item.name andPrice:item.price+5 andCount:item.count+1];
    }
    else{
        int difference = price-totalBeans;
        if (difference>1) {
            myMessage = [NSString stringWithFormat:@"Can't buy %@, need %i beans.",item.name,difference];
        }
        else{
            myMessage = [NSString stringWithFormat:@"Can't buy %@, need one bean.",item.name];
        }
    }
    
}

-(void)updateMessage{
    if(updateMessage){
        _messageLabel.opacity = 0;
        _messageLabel.string=myMessage;
        [_messageLabel runAction:[CCActionSequence actions:
                                  [CCActionFadeTo actionWithDuration:.3 opacity:1],
                                  [CCActionDelay actionWithDuration:.7],
                                  [CCActionFadeTo actionWithDuration:.3 opacity:0],nil]];
        updateMessage=NO;
    }
}

-(void)storeButtonClick{
    if(!storeOpen){
        id action = [CCActionMoveTo actionWithDuration:.3
                                    position:CGPointMake(_storeNode.position.x,_storeNode.position.y+.235)];
        id action3 = [CCActionMoveTo actionWithDuration:1
                                              position:CGPointMake(_storeNode.position.x,_storeNode.position.y+.35)];
        id action4 = [CCActionMoveTo actionWithDuration:1
                                              position:CGPointMake(_storeNode.position.x,_storeNode.position.y-.35)];
        id action2 = [CCActionMoveTo actionWithDuration:.3
                                              position:CGPointMake(_scroll.position.x,_scroll.position.y-.38)];
        [_storeNode runAction:[CCActionEaseIn actionWithAction:action rate:3]];
        [_storeNode runAction:[CCActionEaseIn actionWithAction:action3 rate:3]];
        [_storeNode runAction:[CCActionEaseIn actionWithAction:action4 rate:3]];
        [_scroll runAction:[CCActionEaseIn actionWithAction:action2 rate:3]];
        [_storeDim runAction:[CCActionFadeTo actionWithDuration:.3 opacity:0.1]];
        [_storeText runAction:[CCActionFadeTo actionWithDuration:.3 opacity:0]];
        [self moveItem:_bagNode up:YES];
        [self moveItem:_leavesNode up:YES];
        storeOpen = YES;
    }
    else{
        id action = [CCActionMoveTo actionWithDuration:.4
                                              position:CGPointMake(_storeNode.position.x,_storeNode.position.y-.235)];
        id action2 = [CCActionMoveTo actionWithDuration:.4
                                               position:CGPointMake(_scroll.position.x,_scroll.position.y+.38)];
        [_scroll runAction:[CCActionEaseIn actionWithAction:action2 rate:3]];
        [_storeNode runAction:[CCActionEaseIn actionWithAction:action rate:2]];
        [_storeDim runAction:[CCActionFadeTo actionWithDuration:.4 opacity:0]];
        [_storeText runAction:[CCActionFadeTo actionWithDuration:.3 opacity:1]];
        [self moveItem:_bagNode up:NO];
        [self moveItem:_leavesNode up:NO];
        storeOpen = NO;
    }
}

-(void)moveItem:(CCNode *)node up:(BOOL)up{
    if(up){
        [node runAction:[CCActionSequence actions:
                         [CCActionDelay actionWithDuration:.01],
                         [CCActionEaseIn actionWithAction:
                          [CCActionMoveTo actionWithDuration:.3
                                                    position:CGPointMake(node.position.x,node.position.y+60)] rate:3], nil]];
    }
    else{
        [node runAction:[CCActionSequence actions:
                         [CCActionDelay actionWithDuration:.01],
                         [CCActionEaseIn actionWithAction:
                          [CCActionMoveTo actionWithDuration:.3
                                                    position:CGPointMake(node.position.x,node.position.y-60)] rate:3], nil]];
    }
}

-(void)updateTotal{
    if (average>0) {
        double small = average/10;
        totalBeans +=small;
        double rem = fmod(totalBeans, 1);
        if (rem==0) {
            _counterLabel.string = [NSString stringWithFormat:@"%.0f",totalBeans];
        }
        else{
            _counterLabel.string = [NSString stringWithFormat:@"%.1f",totalBeans];
        }
    }
}

-(void)upgradeItem:(StoreItem*)item forPrice:(double)price{
    updateMessage = YES;
    if (item.count>0 && totalBeans>=price) {
        totalBeans -= price;
        average -= item.value*item.count;
        double bonus = item.value * 0.25;
        average += (item.value+bonus)*item.count;
        [self updateAverage];
        myMessage = [NSString stringWithFormat:@"Now %@ give 25%% more beans!",item.name];
    }
    else{
        myMessage = [NSString stringWithFormat:@"Can't buy upgrade for %@.",item.name];
    }
}

@end
