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

my $clock = 0;
my $currentCharA = "";
my $currentCharB = "";
my $currentCharC = "";
my $currentCharD = "";
my $currentCharE = "";
my $timeLeftA = -1;
my $timeLeftB = -1;
my $timeLeftC = -1;
my $timeLeftD = -1;
my $timeLeftE = -1;
for ( $clock = 0; scalar keys %$totalNodes; $clock++ ) {
    if ( $timeLeftA == 0 ) {
        foreach my $dependsKey ( keys %$depends ) {
            delete $depends->{$dependsKey}{$currentCharA} if exists $depends->{$dependsKey}{$currentCharA};
        }

        delete $ordering->{$currentCharA};
        delete $totalNodes->{$currentCharA};

        $currentCharA = "";
        $timeLeftA = -1;
    }

    if ( $timeLeftB == 0 ) {
        foreach my $dependsKey ( keys %$depends ) {
            delete $depends->{$dependsKey}{$currentCharB} if exists $depends->{$dependsKey}{$currentCharB};
        }

        delete $ordering->{$currentCharB};
        delete $totalNodes->{$currentCharB};

        $currentCharB = "";
        $timeLeftB = -1;
    }

    if ( $timeLeftC == 0 ) {
        foreach my $dependsKey ( keys %$depends ) {
            delete $depends->{$dependsKey}{$currentCharC} if exists $depends->{$dependsKey}{$currentCharC};
        }

        delete $ordering->{$currentCharC};
        delete $totalNodes->{$currentCharC};

        $currentCharC = "";
        $timeLeftC = -1;
    }

    if ( $timeLeftD == 0 ) {
        foreach my $dependsKey ( keys %$depends ) {
            delete $depends->{$dependsKey}{$currentCharD} if exists $depends->{$dependsKey}{$currentCharD};
        }

        delete $ordering->{$currentCharD};
        delete $totalNodes->{$currentCharD};

        $currentCharD = "";
        $timeLeftD = -1;
    }

    if ( $timeLeftE == 0 ) {
        foreach my $dependsKey ( keys %$depends ) {
            delete $depends->{$dependsKey}{$currentCharE} if exists $depends->{$dependsKey}{$currentCharE};
        }

        delete $ordering->{$currentCharE};
        delete $totalNodes->{$currentCharE};

        $currentCharE = "";
        $timeLeftE = -1;
    }

    if ( $currentCharA eq "" ) {
        foreach my $key ( keys %$ordering ) {
            if ( ( not exists $depends->{$key} or not scalar keys %{ $depends->{$key} } ) and ( $currentCharA eq "" or ord $key < ord $currentCharA ) and $ordering->{$key} != 1 ) {
                $currentCharA = $key;
                $timeLeftA = ord($currentCharA) - ord("A") + 61;
            }
        }
        $ordering->{$currentCharA} = 1 if $currentCharA ne "";
        if ( not scalar keys %$ordering and $currentCharA eq "" and scalar keys %$totalNodes ) {
            # take a leftover node
            my @remainder;
            foreach my $node ( keys %$totalNodes ) {
                push @remainder, $node if ( exists $totalNodes->{$node} and $totalNodes->{$node} != 0 );
            }
            @remainder = sort @remainder;
            $currentCharA = pop @remainder if scalar @remainder;
            $timeLeftA = ord($currentCharA) - ord("A") + 61 if $currentCharA ne "";
        }
        $totalNodes->{$currentCharA} = 0 if $currentCharA ne "";
    }

    if ( $currentCharB eq "" ) {
        foreach my $key ( keys %$ordering ) {
            if ( ( not exists $depends->{$key} or not scalar keys %{ $depends->{$key} } ) and ( $currentCharB eq "" or ord $key < ord $currentCharB ) and $ordering->{$key} != 1 ) {
                $currentCharB = $key;
                $timeLeftB = ord($currentCharB) - ord("A") + 61;
            }
        }
        $ordering->{$currentCharB} = 1 if $currentCharB ne "";
        if ( not scalar keys %$ordering and $currentCharB eq "" and scalar keys %$totalNodes ) {
            # take a leftover node
            my @remainder;
            foreach my $node ( keys %$totalNodes ) {
                push @remainder, $node if ( exists $totalNodes->{$node} and $totalNodes->{$node} != 0 );
            }
            @remainder = sort @remainder;
            $currentCharB = pop @remainder if scalar @remainder;
            $timeLeftB = ord($currentCharB) - ord("A") + 61 if $currentCharB ne "";
        }
        $totalNodes->{$currentCharB} = 0 if $currentCharB ne "";
    }

    if ( $currentCharC eq "" ) {
        foreach my $key ( keys %$ordering ) {
            if ( ( not exists $depends->{$key} or not scalar keys %{ $depends->{$key} } ) and ( $currentCharC eq "" or ord $key < ord $currentCharC ) and $ordering->{$key} != 1 ) {
                $currentCharC = $key;
                $timeLeftC = ord($currentCharC) - ord("A") + 61;
            }
        }
        $ordering->{$currentCharC} = 1 if $currentCharC ne "";
        if ( not scalar keys %$ordering and $currentCharC eq "" and scalar keys %$totalNodes ) {
            # take a leftover node
            my @remainder;
            foreach my $node ( keys %$totalNodes ) {
                push @remainder, $node if ( exists $totalNodes->{$node} and $totalNodes->{$node} != 0 );
            }
            @remainder = sort @remainder;
            $currentCharC = pop @remainder if scalar @remainder;
            $timeLeftC = ord($currentCharC) - ord("A") + 61 if $currentCharC ne "";
        }
        $totalNodes->{$currentCharC} = 0 if $currentCharC ne "";
    }

    if ( $currentCharD eq "" ) {
        foreach my $key ( keys %$ordering ) {
            if ( ( not exists $depends->{$key} or not scalar keys %{ $depends->{$key} } ) and ( $currentCharD eq "" or ord $key < ord $currentCharD ) and $ordering->{$key} != 1 ) {
                $currentCharD = $key;
                $timeLeftD = ord($currentCharD) - ord("A") + 61;
            }
        }
        $ordering->{$currentCharD} = 1 if $currentCharD ne "";
        if ( not scalar keys %$ordering and $currentCharD eq "" and scalar keys %$totalNodes ) {
            # take a leftover node
            my @remainder;
            foreach my $node ( keys %$totalNodes ) {
                push @remainder, $node if ( exists $totalNodes->{$node} and $totalNodes->{$node} != 0 );
            }
            @remainder = sort @remainder;
            $currentCharD = pop @remainder if scalar @remainder;
            $timeLeftD = ord($currentCharD) - ord("A") + 61 if $currentCharD ne "";
        }
        $totalNodes->{$currentCharD} = 0 if $currentCharD ne "";
    }

    if ( $currentCharE eq "" ) {
        foreach my $key ( keys %$ordering ) {
            if ( ( not exists $depends->{$key} or not scalar keys %{ $depends->{$key} } ) and ( $currentCharE eq "" or ord $key < ord $currentCharE ) and $ordering->{$key} != 1 ) {
                $currentCharE = $key;
                $timeLeftE = ord($currentCharE) - ord("A") + 61;
            }
        }
        $ordering->{$currentCharE} = 1 if $currentCharE ne "";
        if ( not scalar keys %$ordering and $currentCharE eq "" and scalar keys %$totalNodes ) {
            # take a leftover node
            my @remainder;
            foreach my $node ( keys %$totalNodes ) {
                push @remainder, $node if ( exists $totalNodes->{$node} and $totalNodes->{$node} != 0 );
            }
            @remainder = sort @remainder;
            $currentCharE = pop @remainder if scalar @remainder;
            $timeLeftE = ord($currentCharE) - ord("A") + 61 if $currentCharE ne "";
        }
        $totalNodes->{$currentCharE} = 0 if $currentCharE ne "";
    }

    $timeLeftA-- if $timeLeftA > 0;
    $timeLeftB-- if $timeLeftB > 0;
    $timeLeftC-- if $timeLeftC > 0;
    $timeLeftD-- if $timeLeftD > 0;
    $timeLeftE-- if $timeLeftE > 0;

    print "1: $currentCharA - $timeLeftA s\t2: $currentCharB - $timeLeftB s\t3: $currentCharC - $timeLeftC s\t4: $currentCharD - $timeLeftD s\t5: $currentCharE - $timeLeftE s\n";
}

$clock--;
print "$clock\n";
