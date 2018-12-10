use strict;
use warnings;

use Data::Dumper;

sub main {
    my $minX = 10000;
    my $minY = 10000;
    my $maxX = -10000;
    my $maxY = -10000;

    my $counter = 0;

    my $filename = 'input_day6';
    open(my $fh, '<', $filename) or die $!;

    chomp (my @lines = <$fh>);
    close $fh;

    foreach my $line ( @lines ) {
        my ( $x, $y ) = $line =~ /(\d+), (\d+)/;

        $minX = $x < $minX ? $x : $minX;
        $maxX = $x > $maxX ? $x : $maxX;
        $minY = $y < $minY ? $y : $minY;
        $maxY = $y > $maxY ? $y : $maxY;
    }

    foreach my $x ( $minX..$maxX ) {
        foreach my $y ( $minY..$maxY ) {
            my $totalDistance = 0;
            foreach my $point ( @lines ) {
                my ( $pointX, $pointY ) = $point =~ /(\d+), (\d+)/;
                my $distance = manhattanDistance( $pointX, $pointY, $x, $y );
                $totalDistance += $distance;
            }
            if ( $totalDistance < 10000 ) {
                $counter++;
            }
        }
    }

    print "$counter\n";
}

sub manhattanDistance {
    my ( $x1, $y1, $x2, $y2 ) = @_;
    return abs($x1 - $x2) + abs($y1 - $y2);
}

main();

__END__
