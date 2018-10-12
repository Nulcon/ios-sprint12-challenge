//
//  PokemonDetailViewController.m
//  ios-sprint12-challenge
//
//  Created by Conner on 10/12/18.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "PokemonDetailViewController.h"

static void *pokemonContext = &pokemonContext;

@interface PokemonDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *pokemonSpriteImageView;
@property (strong, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;
@end

@implementation PokemonDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViews];
    if ([self pokemon]) {
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionNew context:pokemonContext];
        [self.pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionNew context:pokemonContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == pokemonContext) {
        if ([keyPath isEqualToString:@"sprite"]) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprite]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self pokemonSpriteImageView] setImage:image];
            });
        }
        if ([keyPath isEqualToString:@"abilities"]) {
            NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.pokemon.abilities.count; i++) {
                NSString *ability = self.pokemon.abilities[i][@"ability"][@"name"];
                [abilitiesArray addObject:ability];
            }
            NSString *abilities = [abilitiesArray componentsJoinedByString:@", "];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self pokemonAbilitiesLabel] setText:abilities];
                [[self pokemonIdLabel] setText:[NSString stringWithFormat:@"%@", self.pokemon.identifier]];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateViews {
    if ([self pokemon]) {
        NSString *pokemonName = [[self pokemon] name];
        [[self pokemonNameLabel] setText:pokemonName];
    }
}
@end
