use strict;
use warnings;

my $filename = 'input_day10';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my $points = [];
my $grid = {};

my $maxX = -1;
my $maxY = -1;
my $minX = 1;
my $minY = 1;

my $sumX = 0;
my $sumY = 0;
my $avgX = 0;
my $avgY = 0;

for ( my $i = 0; $i < scalar @lines; $i++ ) {
    my ( $x, $y, $dX, $dY ) = $lines[$i] =~ m/position=\< ?(-?\d+),  ?(-?\d+)\> velocity=\< ?(-?\d+),  ?(-?\d+)\>/;
    $points->[$i] = { 
        X => $x,
        Y => $y,
        dX => $dX,
        dY => $dY,
    };
    $grid->{$x}{$y} = 1;
    $maxX = $x if $x > $maxX;
    $maxY = $y if $y > $maxY;
    $minX = $x if $x < $minX;
    $minY = $y if $y < $minY;

    $sumX += $x;
    $sumY += $y;
}

$avgX = int($sumX / ( scalar @lines ));
$avgY = int($sumY / ( scalar @lines ));

my $limit = 10085;
my $counter = 0;
while ( $counter < $limit ) {
    print "$counter\n";
    $counter++;
    for ( my $i = -50 + $avgY; $i < 50 + $avgY; $i++ ) {
        my $result = "";
        for ( my $j = -100 + $avgX; $j < 100 + $avgX; $j++ ) {
            if ( exists $grid->{$j}{$i} and $grid->{$j}{$i} >= 1 ) {
                $result .= "#";
            } else {
                $result .= ".";
            }
        }
        print "$result\n";
    }

    $sumX = 0;
    $sumY = 0;
    $avgX = 0;
    $avgY = 0;

    for ( my $i = 0; $i < scalar @$points; $i++ ) {
        my $point = $points->[$i];
        my $x = $point->{X};
        my $y = $point->{Y};
        my $dX = $point->{dX};
        my $dY = $point->{dY};

        if ( $grid->{$x}{$y} == 1 ) {
            delete $grid->{$x}{$y};
        } else {
            $grid->{$x}{$y}--;
        }

        $point->{X} += $dX;
        $point->{Y} += $dY;

        $x = $point->{X};
        $y = $point->{Y};

        if ( exists $grid->{$x}{$y} ) {
            $grid->{$x}{$y}++;
        } else {
            $grid->{$x}{$y} = 1;
        }


        $maxX = $x if $x > $maxX;
        $maxY = $y if $y > $maxY;
        $minX = $x if $x < $minX;
        $minY = $y if $y < $minY;

        $sumX += $x;
        $sumY += $y;
    }

    $avgX = int($sumX / ( scalar @lines ));
    $avgY = int($sumY / ( scalar @lines ));

    #sleep 1;
}
