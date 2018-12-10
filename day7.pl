use strict;
use warnings;

use Data::Dumper;

my $filename = 'input_day7';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
close $fh;

my $ordering = {};
my $depends = {};
my $totalNodes = {};

foreach my $line ( @lines ) {
    my ( $before, $after ) = $line =~ /Step ([A-Z]) must be finished before step ([A-Z]) can begin./;
    if ( exists $ordering->{$before} ) {
        $ordering->{$before}{$after} = 1;
    } else {
        $ordering->{$before} = { $after => 1 };
    }
    if ( exists $depends->{$after} ) {
        $depends->{$after}{$before} = 1;
    } else {
        $depends->{$after} = { $before => 1 };
    }
    
    $totalNodes->{$after} = 1 if not exists $totalNodes->{$after};
    $totalNodes->{$before} = 1 if not exists $totalNodes->{$before};
}

my $result = "";
while ( scalar keys %$ordering ) {
    my $nextChar = "";
    foreach my $key ( keys %$ordering ) {
        if ( ( not exists $depends->{$key} or not scalar keys %{ $depends->{$key} } ) and ( $nextChar eq "" or ord $key < ord $nextChar ) ) {
            $nextChar = $key;
        }
    }

    foreach my $dependsKey ( keys %$depends ) {
        delete $depends->{$dependsKey}{$nextChar} if exists $depends->{$dependsKey}{$nextChar};
    }

    #print Dumper $ordering;
    delete $ordering->{$nextChar};
    #print Dumper $ordering;

    $result .= $nextChar;
    delete $totalNodes->{$nextChar};
}

if ( scalar keys %$totalNodes ) {
    my @remainder = keys %$totalNodes;
    @remainder = sort @remainder;
    foreach my $element ( @remainder ) {
        $result .= $element;
    }
}

print "$result\n";
