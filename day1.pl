use strict;
use warnings;

use Data::Dumper;

my $counter = 0;
my $filename = 'input';
open(my $fh, '<', $filename) or die $!;

my $hash = { 
    0 => 1,
 };

chomp (my @lines = <$fh>);
my $i = 0;
close $fh;

while ( 1 ) {
    $lines[$i] =~ s/\+//;
    print "$i\n";
    print "$lines[$i]\n";
    $counter += $lines[$i];
    print "$counter\n";

    if ( exists $hash->{$counter} and $hash->{$counter} == 1 ) {
        die $counter;
    } else {
        $hash->{$counter} = 1;
    }

    $i++;
    if ($i >= scalar @lines) {
        $i -= scalar @lines;
    }
}
