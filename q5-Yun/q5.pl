use strict;
use warnings;

my @cuisine = split /,/, "002,003,005,006,007,008,009,012,013,014,015,018,020,022,031,032,033,034,038,039,045,048,049,058,067,069,070,072,082,088,089,090,091,092,093,094,095,096,098,103,105,110,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,133,134,135,139,140,142,143,144,147,171,172,179,180,186,187,188,195,199,201,202,209,210,211,218,219,220,221,222,223,227,228,229,235,236,238,239,240,241,244,246,256";
my %cuisine_elements;
@cuisine_elements{@cuisine} = ();
my @price = split /,/, "161,162,163,164,165,166,167,168,169,170";
my %price_elements;
@price_elements{@price} = ();

my $dir = 'C:/Users/yhan/Documents/data';
my $out = 'C:/Users/yhan/Documents/CS773/q5/vegie_cuisinePrice.arff';
open(my $file, '>', $out) or die "Could not open file '$out' $!";
foreach my $fp (glob("$dir/*.txt")) {
	open my $fh, "<", $fp or die "can't read open '$fp'";
	while (<$fh>) {
		chomp;
		my $line = $_;
		my @features = split /[\s,\t]/, $_;
		my @rescui = grep exists $cuisine_elements{$_}, @features;
		if (length($rescui[0]) == 0) {$rescui[0] = '?'}
	 	my @respri = grep exists $price_elements{$_}, @features;
	 	if (length($respri[0]) == 0) {$respri[0] = '?'}
		if ($line =~ /243/) {
			printf $file "$rescui[0], $respri[0], Yes \n"
		} else {
			printf $file "$rescui[0], $respri[0], No \n"
		};

	}

	close $fh or die "can't read close";
}