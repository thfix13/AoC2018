use strict;
use warnings;

my $filename = 'input_day5';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my $line = $lines[0];

my $hash = {};

foreach my $char ( "a".."z" ) {
    my $polymer = $line;
    $polymer =~ s/$char//gi;
    while ( $polymer =~ m/aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz/ ) {
        $polymer =~ s/aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz//;
    }
    print scalar(split //, $polymer)."\n";

    $hash->{$char} = scalar(split //, $polymer);
}

my $minSize = 100000;
my $charToDelete;
foreach my $key ( keys %$hash ) {
    if ( exists $hash->{$key} and $hash->{$key} < $minSize ) {
        $charToDelete = $key;
        $minSize = $hash->{$key};
    }
}

print "$minSize\n";

