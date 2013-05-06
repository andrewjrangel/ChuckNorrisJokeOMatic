//
//  ChuckViewController.m
//  ChuckNorrisJokeOMatic
//
//  Created by Ventura Rangel on 5/1/13.
//  Copyright (c) 2013 Antifragile Development. All rights reserved.
//

#import "ChuckViewController.h"
#import "AFNetworking.h"
#define flickrAPIKey @"f6e31bbae44c003b1bac4901609eac71"
@interface ChuckViewController ()
@end
@implementation ChuckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    self.oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft:)];
    
    self.oneFingerSwipeLeft.numberOfTouchesRequired = 1;
    
    [self.oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:self.oneFingerSwipeLeft];
}

- (void)screenSwipedLeft:(UIGestureRecognizer *)recognizer

{
    
    [self nextJokeButton:self];
    
}

-(void)getArrays{
    self.commonWords = @"the be to of and a in that have I it for not on with he as you do at this but his by from they we say her she or an will my one all would there their what so up out if about who get which go me when make can like time no just him know take person into year your good some could them see other than then now look only come its over think also back after use two how our work first well way even new want because any these give day most us Chuck Norris is has any originally each The him knows against he'd period are There such gets it's They they doesn't wear often No no it ever Total when been works";
    
    self.commonWordsArray = [self.commonWords componentsSeparatedByString:@" "];
    self.commonWAMutable = [[NSMutableArray alloc] initWithArray:self.commonWordsArray];
   // NSLog(@"%@",self.commonWAMutable);
    
}

- (IBAction)nextJokeButton:(id)sender {
    NSString *jokeString = [NSString stringWithFormat:@"http://api.icndb.com/jokes/random"];
    NSURL *url = [NSURL URLWithString:jokeString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //
        
        
        NSString *jokeValue = [[JSON valueForKey:@"value"] valueForKey:@"joke"];
        self.joke = [jokeValue stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        UIFont *font = [UIFont fontWithName:@"Go 2 Old Western" size:32];
        self.jokeLabel.text = self.joke;
        self.jokeLabel.font = font;
        self.jokeLabel.textColor = [UIColor brownColor];
        self.jokeLabel.shadowColor = [UIColor grayColor];
        self.jokeLabel.shadowOffset = CGSizeMake(-1.0, 1.0);
        
        [self getArrays];
        [self getSearch];
        [self imageSearch];
        
                
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error");
    }];
    [operation start];
}

-(void)getSearch{
    self.jokeArray = [self.joke componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" ,/-"]];
    self.jokeAMutable = [[NSMutableArray alloc] initWithArray:self.jokeArray];
    //NSLog(@"%@", self.jokeArray);
    
    [self.jokeAMutable removeObjectsInArray:self.commonWAMutable];
    NSLog(@"Reduced Joke: %@", self.jokeAMutable);
    int myIndex = arc4random_uniform(self.jokeAMutable.count);
    self.randomWord = [self.jokeAMutable objectAtIndex:myIndex];
    NSLog(@"Random Word is: %@",self.randomWord);
   
    
}

-(void)imageSearch{
    
    
    
    NSString *imageString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=1&size=m&format=json&nojsoncallback=1",flickrAPIKey, self.randomWord];
    NSURL *url = [NSURL URLWithString:imageString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *results = JSON;
        NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
        for (NSDictionary *photo in photos){
      //  NSString *title = [photo objectForKey:@"title"];
            NSString *photoURLString =
            [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
             [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
             [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        NSLog(@"photoURLString: %@", photoURLString);
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:photoURLString]];
        self.chuckImageView.image = [UIImage imageWithData:imageData];
        }
        
        

        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error");
    }];
    [operation start];
    
}
@end
