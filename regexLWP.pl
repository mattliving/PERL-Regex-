#!/usr/bin/perl -W
use LWP::UserAgent;
use HTTP::Request::Common qw(POST);
use HTTP::Request::Common qw(GET);

# Define new user agent
$ua = LWP::UserAgent->new;

#my $tempFile = "tempFile.txt";
$htmlTag = qr/(\<\/?[^\>]+\>)/;
$num_args = $#ARGV + 1;
if ($num_args < 2 || $num_args > 5) {
	print "error: enter climbing grades in the form '5A|5B' followed by one - four url(s)";
}
else {
	#@urls = ("", "", "", "");
	$skill = $ARGV[0];
	foreach $argnum (1 .. $#ARGV) {
		# Request object
		$req = POST $ARGV[$argnum], [];
		# Make the request
		$res = $ua->request($req, $tempFile);
		open (FILE, "tempFile.txt") or die "error opening temp file: $!";
		#open $outFile, '>', 'de pakhuys climbing routes.txt' or die "error writing to file: $!";
		# Check response
		if ($res->is_success) {
			while (<FILE>) {
				if (m/((?:[A-Z|a-z]\d+)|(?:\d+\.))(.*)($skill)&nbsp;(?:$htmlTag*)\s*(.*$)/i) {
					print $1, $2, $3, " - " , $5, "\n";
					#print $outFile $1, $2, $3, " - " , $5, "\n\n";
				}
			}
		} else {
		    print $res->status_line . "\n";
		}
	}
}	

close FILE;
#close $outFile;