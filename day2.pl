use strict;
use warnings;

my $filename = 'input_day2';
open(my $fh, '<', $filename) or die $!;

#my $triples = 0;
#my $doubles = 0;

chomp (my @lines = <$fh>);
close $fh;

for ( my $i = 0; $i < scalar @lines; $i++ ) {
#    my $counter = {};
#    foreach my $char ( split //, $lines[$i] ) { $counter->{$char}++ }
#    foreach my $j ( "a".."z" ) {
#        if ( exists $counter->{$j} and $counter->{$j} == 2 ) {
#            $doubles++;
#            last;
#        }
#    }
#
#    foreach my $j ( "a".."z" ) {
#        if ( exists $counter->{$j} and $counter->{$j} == 3 ) {
#            $triples++;
#            last;
#        }
#    }

    my $line = $lines[$i];
    for ( my $j = 0; $j < (length $line) - 1; $j++ ) {
        my $regex = $line;
        substr($regex, $j, 1) = ".";
        for ( my $k = $i + 1; $k < scalar @lines; $k++ ) {
            if ( $lines[$k] =~ m/$regex/ ) {
                $regex =~ tr/\.//d;
                print $regex."\n";
                last;
            }
        }
    }
}

#print $doubles * $triples."\n";


