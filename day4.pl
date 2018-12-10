use strict;
use warnings;

my $counter = 0;
my $filename = 'input_day4';
open(my $fh, '<', $filename) or die $!;

chomp (my @lines = <$fh>);
my $i = 0;
close $fh;

my @sortedLines = sort @lines;

my $minutes = {};
my $sum = {};

my $currentID = -1;
my $minuteAsleep = -1;

foreach my $line ( @sortedLines ) {
    if ( my ( $hour, $minute, $id ) = $line =~ /(\d+):(\d+)] Guard \#(\d+)/ ) {
        $currentID = $id;
        if ( $hour > 0 ) {
            $hour = $minute = "00";
        }
    } elsif ( my ( $sleepMinute ) = $line =~ /:(\d+)] falls asleep/ ) {
        $minuteAsleep = $sleepMinute;
    } elsif ( my ( $wakeMinute ) = $line =~ /:(\d+)] wakes up/ ) {
        foreach my $tick ( $minuteAsleep..($wakeMinute - 1) ) {
            if ( exists $minutes->{$currentID}{$tick} ) {
                $minutes->{$currentID}{$tick}++;
            } else {
                $minutes->{$currentID}{$tick} = 1;
            }
        }

        my $timeAsleep = $wakeMinute - $minuteAsleep;
        if ( exists $sum->{$currentID} ) {
            $sum->{$currentID} += $timeAsleep;
        } else {
            $sum->{$currentID} = $timeAsleep;
        }
    }
}

#my $sleepyID = -1;
#my $maxSleep = -1;
#foreach my $key ( keys %$sum ) {
#    if ( $sum->{$key} > $maxSleep ) {
#        $sleepyID = $key;
#        $maxSleep = $sum->{$key};
#    }
#}

#my $sleepyMinute = -1;
#my $maxOccurrences = -1;
#foreach my $key ( keys %{ $minutes->{$sleepyID} } ) {
#    if ( exists $minutes->{$sleepyID}{$key} and $minutes->{$sleepyID}{$key} > $maxOccurrences ) {
#        $sleepyMinute = $key;
#        $maxOccurrences = $minutes->{$sleepyID}{$key};
#    }
#}

my $sleepyID = -1;
my $sleepyMinute = -1;
my $maxOccurrences = -1;
foreach my $key ( keys %$minutes ) {
    foreach my $tock ( keys %{ $minutes->{$key} } ) {
        if ( exists $minutes->{$key}{$tock} and $minutes->{$key}{$tock} > $maxOccurrences ) {
            $sleepyID = $key;
            $sleepyMinute = $tock;
            $maxOccurrences = $minutes->{$key}{$tock};
        }
    }
}

print $sleepyID * $sleepyMinute."\n";
