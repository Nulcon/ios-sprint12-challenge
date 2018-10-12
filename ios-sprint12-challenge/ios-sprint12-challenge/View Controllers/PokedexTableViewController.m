//
//  PokedexTableViewController.m
//  ios-sprint12-challenge
//
//  Created by Conner on 10/12/18.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "PokemonDetailViewController.h"
#import "CGAPokemon.h"
#import "ios_sprint12_challenge-Swift.h"

@interface PokedexTableViewController ()
@property (nonatomic, strong) NSArray<CGAPokemon *> *pokemon;
@end

@implementation PokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PokemonAPI *pokemonAPI = [PokemonAPI shared];
    [pokemonAPI fetchAllPokemonWithCompletion:^(NSArray<CGAPokemon *> *pokemon, NSError *error) {
        self.pokemon = pokemon;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    CGAPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokemonDetailViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[PokemonDetailViewController class]]) {
        NSIndexPath *index = [[self tableView] indexPathForSelectedRow];
        CGAPokemon *pokemon = [[self pokemon] objectAtIndex:[index row]];
        PokemonAPI *pokemonAPI = [PokemonAPI shared];
        [pokemonAPI fillInDetailsFor:pokemon];
        [vc setPokemon:pokemon];
    }
}

- (void)setPokemon:(NSArray<CGAPokemon *> *)pokemon {
    if (pokemon != _pokemon) {
        _pokemon = [pokemon copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    }
}

@end
