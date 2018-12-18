use strict;
use warnings;

my $filename = 'input_day8';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my $test = processNode($lines[0]);

print $test."\n";

sub processNode {
    my $node = shift;

    my ( $numChild, $numMeta, $body ) = $node =~ m/(\d+) (\d+) (.*)/;

    my $sum = 0;

    for ( my $i = 0; $i < $numChild; $i++ ) {
        my $lowerSum;
        ( $lowerSum, $body ) = processNode( $body );
        $sum += $lowerSum;
    }

    for ( my $i = 0; $i < $numMeta; $i++ ) {
        my ( $metadata ) = $body =~ m/(\d+) /;
        $body =~ s/\d+ //;
        $sum += $metadata;
        print "$sum\n";
    }

    return ( $sum, $body );
}
