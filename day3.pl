use strict;
use warnings;

use Data::Dumper;

my $filename = 'input_day3';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my $array = [];
for my $i ( 0..999 ) {
    $array->[$i] = [];
}

#foreach my $line ( @lines ) {
#    my @tokens = split / /, $line;
#
#    my @position = split /,/, $tokens[2];
#    my $xPos = $position[0];
#    my $yPos = $position[1];
#    $yPos =~ tr/\://d;
#
#    my @size = split /x/, $tokens[3];
#    my $xSize = $size[0];
#    my $ySize = $size[1];
#
#    my $xMax = $xPos + $xSize - 1;
#    my $yMax = $yPos + $ySize - 1;
#
#    foreach my $x ( $xPos..$xMax ) {
#        foreach my $y ( $yPos..$yMax ) {
#            if ( exists $array->[$x][$y] ) {
#                $array->[$x][$y]++;
#            } else {
#                $array->[$x][$y] = 1;
#            }
#        }
#    }
#}
#
#my $counter = 0;
#
#for ( my $i = 0; $i < scalar @$array; $i++ ) {
#    for ( my $j = 0; $j < scalar @$array; $j++ ) {
#        if ( exists $array->[$i][$j] and $array->[$i][$j] > 1 ) {
#            $counter++;
#        }
#    }
#}
#
#print $counter."\n";

my $overlaps = {};

foreach my $line ( @lines ) {
    my @tokens = split / /, $line;

    my $id = $tokens[0];
    $id =~ tr/\#//d;
    $overlaps->{$id} = 0;

    my @position = split /,/, $tokens[2];
    my $xPos = $position[0];
    my $yPos = $position[1];
    $yPos =~ tr/\://d;

    my @size = split /x/, $tokens[3];
    my $xSize = $size[0];
    my $ySize = $size[1];

    my $xMax = $xPos + $xSize - 1;
    my $yMax = $yPos + $ySize - 1;

    foreach my $x ( $xPos..$xMax ) {
        foreach my $y ( $yPos..$yMax ) {
            if ( exists $array->[$x][$y] ) {
                $overlaps->{$id} = 1;
                $overlaps->{$array->[$x][$y]} = 1;
            } else {
                $array->[$x][$y] = $id;
            }
        }
    }
}

print Dumper $overlaps;

foreach my $key (keys %$overlaps) {
    if ( not $overlaps->{$key} ) {
        print $key."\n";
        last;
    }
}
