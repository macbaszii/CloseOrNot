//
//  ParsingData.m
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/3/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ParsingData.h"
#import "ParseSiteAppDelegate.h"

#define kName @"name"
#define kOpen @"openTime"
#define kClose @"closeTime"
#define kAlter @"alterNames"
#define kID @"objectId"

@implementation ParsingData
@synthesize delegate = _delegate;

- (NSManagedObjectContext *)managedObjectContext{
    ParseSiteAppDelegate *appDelegate = (ParseSiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

- (void)setupParseService{
    [Parse setApplicationId:@"NluQYucXgItZdnUbxkUUztDk6jTUCVeDdIljjqMh" clientKey:@"tqyOKsFN4ajGKgfPFHsMKFzhMhCpSFZLyURHXqlT"];
}

- (void)insertDataWithName:(NSString *)_name alterName:(NSString *)_alter openTime:(NSString *)_open closeTime:(NSString *)_close notes:(NSString *)_notes andObjectId:(NSString *)_id{
    Places *placesEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Places" inManagedObjectContext:self.managedObjectContext];
    
    placesEntity.objectId = _id;
    placesEntity.name = _name;
    placesEntity.openTime = _open;
    placesEntity.closeTime = _close;
    placesEntity.alterNames = _alter;
    placesEntity.notes = _notes;
    [self.managedObjectContext save:nil];
}

- (void)getFromWebService{
    PFQuery *query = [PFQuery queryWithClassName:@"ThisIsData"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Places" inManagedObjectContext:self.managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:entity];
            
            NSArray *allInCoreData = [self.managedObjectContext executeFetchRequest:request error:nil];
            
            for(PFObject *item in objects){
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.objectId == %@",item.objectId];
                NSArray *filtered = [allInCoreData filteredArrayUsingPredicate:predicate];
                
                if (!filtered.count) {
                    [self insertDataWithName:[item objectForKey:kName] alterName:[item objectForKey:kAlter] openTime:[item objectForKey:kOpen] closeTime:[item objectForKey:kClose] notes:[[item objectForKey:@"Notes"] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] andObjectId:item.objectId];
                }else{
                    Places *toUpdate = [filtered objectAtIndex:0];
                    toUpdate.objectId = item.objectId;
                    toUpdate.name = [item objectForKey:kName];
                    toUpdate.openTime = [item objectForKey:kOpen];
                    toUpdate.closeTime = [item objectForKey:kClose];
                    toUpdate.alterNames = [item objectForKey:kAlter];
                    toUpdate.notes = [[item objectForKey:@"Notes"] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
                    
                    [self.managedObjectContext save:nil];
                }
            }
            
            for (Places *data in allInCoreData){
                BOOL exist = NO;
                for(PFObject *wsData in objects){
                    if (data.objectId == wsData.objectId) {
                        exist = YES;
                        break;
                    }
                }
                
                if (!exist) {
                    [self.managedObjectContext deleteObject:data];
                    [self.managedObjectContext save:nil];
                }
            }
            
            [self.delegate paringDataDidFinished:self];
        }else{
            NSLog(@"Error %@",[error userInfo]);
        }
    }];
}

- (NSArray *)fetchPlacesData{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Places" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:kName ascending:NO];
    [request setEntity:entity];
    [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    
    NSArray *placesTMP = [self.managedObjectContext executeFetchRequest:request error:nil];
    return placesTMP;
}



@end
