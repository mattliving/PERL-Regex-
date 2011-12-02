#!/usr/bin/perl -W
use strict;
use LWP::Simple;

my $inFile = $ARGV[0];
my $skill = $ARGV[1];
my $url = $ARGV[2];
my $list;
my $htmlTag = qr/(\<\/?[^\>]+\>)/;
#my $url = 'http://www.climb.co.za/wiki/index.php/De_Pakhuys';
my $content = get $url or die "Unable to get page: $!";

open my $outFile, '>', 'de pakhuys climbing routes.txt' or die "error writing to file: $!";
open FILE,($inFile) or die "error opening file: $!";
while (<FILE>) {
	if (m/((?:[A-Z|a-z]\d+)|(?:\d+\.))(.*)($skill)&nbsp;(?:$htmlTag*)\s*(.*$)/i) {
		print $1, $2, $3, " - " , $5, "\n";
		print $outFile $1, $2, $3, " - " , $5, "\n\n";
	}
}
close FILE;
close $outFile;
