use strict;
use warnings;

my $filename = 'input_day9';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my ( $players, $lastMarble ) = $lines[0] =~ m/(\d+) players; last marble is worth (\d+) points/;
playGame($players, $lastMarble);

sub playGame {
    my $players = shift;
    my $lastMarble = shift;

    # TODO

    print "Number of players: $players\tLast marble: $lastMarble\n";
}
