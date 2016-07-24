use strict;
use warnings;

my $features = 'C:/Users/yhan/Documents/CS773/q6/features.txt';
open(my $featurefile, '<', $features) or die "Could not open file!";
my %feature;
while (<$featurefile>) {
	my $line = $_;
	my ($i, $j) = split(/\t/, $line);
	$feature{$i} = $j;
	#print "$i is $feature{$i}\n";
	}


my @countries;
my $country = 'C:/Users/yhan/Documents/CS773/q6/countries.txt';
open(my $file, '<', $country) or die "Could not open file!";
while(<$file>) {
	chomp;
	my $line = $_;
	push(@countries, $line);
	#print $_;
	}
#my %country_elements;
#@country_elements{@countries} = ();

my $countrys = "African Afro-Eurasian ...";
my $total = 0;
my $geo = 0;

my $dir = 'C:/Users/yhan/Documents/data';
foreach my $fp (glob("$dir/*.txt")) {
	open my $fh, "<", $fp or die "can't read open '$fp'";
	while (<$fh>) {
		chomp;
		my $line = $_;
		$total = $total + 1;
		my $flag = 0;
		my @resfeatures = split /[\s,\t]/, $_;
		foreach my $ele (@resfeatures)
		{
		if(exists $feature{$ele}){
			my $cty = $feature{$ele};
			$cty =~ tr/A-Za-z//cd;
			if ($countrys =~ /$cty/)
			{
			$flag = 1
			#print $feature{$ele};
			}

		#print $feature{$ele};
		}
	        }
		$geo = $geo + $flag;
		}
close $fh or die "can't read close";
}

print "$total, $geo \n";