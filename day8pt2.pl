use strict;
use warnings;

use Data::Dumper;

my $filename = 'input_day8';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my ( $test, $nada ) = processNode($lines[0]);

print $test."\n";

sub processNode {
    my $node = shift;

    my ( $numChild, $numMeta, $body ) = $node =~ m/(\d+) (\d+) (.*)/;

    my $childValues = [];
    my $value = 0;

    if ( $numChild > 0 ) {
        for ( my $i = 0; $i < $numChild; $i++ ) {
            my $lowerValue;
            ( $lowerValue, $body ) = processNode( $body );
            @$childValues[$i + 1] = $lowerValue;
        }

        for ( my $i = 0; $i < $numMeta; $i++ ) {
            my ( $metadata ) = $body =~ m/(\d+) /;
            $body =~ s/\d+ //;
            if ( $metadata <= $numChild ) {
                $value += $$childValues[$metadata];
            }
        }
    } else {
        for ( my $i = 0; $i < $numMeta; $i++ ) {
            my ( $metadata ) = $body =~ m/(\d+) /;
            $body =~ s/\d+ //;
            $value += $metadata;
        }
    }

    return ( $value, $body );
}
