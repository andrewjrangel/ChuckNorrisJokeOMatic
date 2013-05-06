//
//  ChuckViewController.h
//  ChuckNorrisJokeOMatic
//
//  Created by Ventura Rangel on 5/1/13.
//  Copyright (c) 2013 Antifragile Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChuckViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *jokeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *chuckImageView;
@property (strong, nonatomic) NSArray *jokes;
@property (strong, nonatomic) NSArray *jokeArray;

@property (strong, nonatomic) NSArray *commonWordsArray;
@property (strong, nonatomic) NSMutableArray *commonWAMutable;
@property (strong, nonatomic) NSMutableArray *jokeAMutable;

@property (strong, nonatomic) NSString *joke;
@property (strong, nonatomic) NSString *commonWords;
@property (strong, nonatomic) NSString *randomWord;

@property (strong, nonatomic) UISwipeGestureRecognizer *oneFingerSwipeLeft;

- (IBAction)nextJokeButton:(id)sender;
-(void)getArrays;

@end
