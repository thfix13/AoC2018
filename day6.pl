use strict;
use warnings;

use Data::Dumper;

sub main {
    my $points = [];
    my $pointCount = 0;
    my $closestPoint = {};
    my $closestDistance = {};
    my $area = [];
    my $badPoints = {};

    my $minX = 10000;
    my $minY = 10000;
    my $maxX = -10000;
    my $maxY = -10000;

    my $filename = 'input_day6';
    open(my $fh, '<', $filename) or die $!;

    chomp (my @lines = <$fh>);
    close $fh;

    foreach my $line ( @lines ) {
        my ( $x, $y ) = $line =~ /(\d+), (\d+)/;
        $points->[$pointCount] = [ $x, $y ];
        $pointCount++;

        $minX = $x < $minX ? $x : $minX;
        $maxX = $x > $maxX ? $x : $maxX;
        $minY = $y < $minY ? $y : $minY;
        $maxY = $y > $maxY ? $y : $maxY;
    }

    foreach my $x ( $minX..$maxX ) {
        foreach my $y ( $minY..$maxY ) {
            my $minDistance = 1000000;
            my $minPoint = {};
            for ( my $i = 0; $i < scalar @{ $points }; $i++ ) {
                my $distance = manhattanDistance( $x, $y, $points->[$i][0], $points->[$i][1] );
                if ( $distance < $minDistance ) {
                    $minDistance = $distance;
                    $minPoint = $i;
                } elsif ( $distance == $minDistance ) {
                    $minDistance = $distance;
                    $minPoint = -1;
                }
            }
            unless ( $minPoint == -1 ) {
                $closestPoint->{$x}{$y} = $minPoint;
                $closestDistance->{$x}{$y} = $minDistance;
                if ( exists $area->[$minPoint] ) {
                    $area->[$minPoint]++;
                } else {
                    $area->[$minPoint] = 1;
                }
            }
            if ( $x == $minX or $x == $maxX or $y == $minY or $y == $maxY ) {
                $badPoints->{$minPoint} = 1;
            }
        }
    }

    my $maxArea = -1;
    for ( my $i = 0; $i < scalar @$area; $i++ ) {
        if ( not exists $badPoints->{$i} and exists $area->[$i] and $area->[$i] > $maxArea ) {
            $maxArea = $area->[$i];
        }
    }

    print "$maxArea\n";
}

sub manhattanDistance {
    my ( $x1, $y1, $x2, $y2 ) = @_;
    return abs($x1 - $x2) + abs($y1 - $y2);
}

main();

__END__
