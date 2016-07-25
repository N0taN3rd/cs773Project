use strict;  
use warnings;

my @europe;
my $european = 'C:/Users/yhan/Documents/CS773/q6/european.txt';
open(my $file5, '<', $european) or die "Could not open file!";
while(<$file5>) {
	chomp;
	my $line5 = $_;
	push(@europe, $line5);
	#print $_;
	}
my $europeans = join(" ", @europe);

my $features = 'C:/Users/yhan/Documents/CS773/q6/features.txt';
open(my $featurefile, '<', $features) or die "Could not open file!";
my %feature;
while (<$featurefile>) {
	my $line = $_;
	my ($i, $j) = split(/\t/, $line);
	$feature{$i} = $j;
	#print "$i is $feature{$i}\n";
	}
	#open (my $out, '>', 'C:/Users/yhan/Documents/CS773/q7/city.txt');
my $atmosphere = '"An Historic Spot","An Out Of The Way Find","Authentic","Buffet Dining","Business Scene","Cafe/Garden Dining",    "Classic Hotel Dining",    "Creative",    "Credit cards are not accepted",    "Excellent Decor",    "Excellent Food",    "Excellent Service",    "Extraordinary Decor",    "Extraordinary Food",    "Extraordinary Service",    "Fabulous Views",    "Fabulous Wine Lists",    "Fair Decor",    "Fair Food",    "Fair Service",    "Focus on Dessert",    "For the Young and Young at Heart",    "Good Decor",    "Good Food",    "Good Out of Town Business",    "Good Service",    "Good for Younger Kids",    "Great for People Watching",    "Health Conscious Menus",    "Hip Place To Be",    "Little Known But Well Liked",    "Near-perfect Decor",    "Near-perfect Food",    "Near-perfect Service",    "Need To Dress",    "No Liquor Served",    "No Reservations",    "No Smoking Allowed",    "Old World Cafe Charm",    "On the Beach",    "Parking/Valet",    "People Keep Coming Back",    "Place for Singles",    "Poor Decor",    "Pub Feel",    "Quiet for Conversation",    "Quirky",    "Relaxed Senior Scene",    "Romantic",    "Singles Scene",    "Tourist Appeal",    "Up and Coming",    "Very Busy - Reservations a Must",    "Warm spots by the fire",    "Wheelchair Access"';
$atmosphere =~ s/[\#@~!&*()\[\];.:?^`\\\/]+//g;
#printf $out $atmosphere;
my $occasion = '"Game",    "After Hours Dining",    "Catering for Special Events",    "Dancing",    "Delivery Available",    "Dining After the Theater",    "Dining Outdoors",    "Early Dining",    "Entertainment",    "Fine for Dining Alone",    "Great Place to Meet for a Drink",    "Happy Hour",    "Late Night Menu",    "Long Drive",    "Margaritas",    "Menus in Braille",    "Open for Breakfast",    "Open on Mondays",    "Open on Sundays",    "Other Quick Food",    "Parties and Occasions",    "Picnics",    "Pre-theater Dining",    "Private Parties",    "Private Rooms Available",    "Prix Fixe Menus",    "See the Game",    "Short Drive",    "Special Brunch Menu",    "Takeout Available",    "Walk",    "Weekend Brunch",    "Weekend Dining",    "Weekend Jazz Brunch",    "Weekend Lunch"';
$occasion =~ s/[\#@~!&*()\[\];.:?^`\\\/]+//g;
#printf $out $occasion;
my $price = '"$15-$30", "$30-$50", "below $15", "over $50"';
$price =~ s/[\#@~!\$&*()\[\];.:?^`\\\/]+//g;
#printf $out $price;
my $style = '"A","Southern","Southwestern","Southeast Asian","International","Southern Comfort","Deli","Kosher",    "Afghanistan",    "Argentinean","Eclectic",    "Continental","Bakeries",    "Belgian",    "Brasserie",    "Cab",   "Cafe/Espresso Bars",    "Cafeterias",    "Californian",    "Carry in Wine and Beer","Caviar",    "Central",    "Coffee Houses",    "Coffee Shops",    "Coffeehouses",    "Czech",    "Diners",    "Down-Home",    "Eastern European",    "Egyptian",    "English",    "Fast Food",    "Fondue",    "Franco-Russian",    "Frankfurters",    "French-Japanese",    "Grills",    "Guatemalan",    "Hamburgers",    "Health Food",    "High Tea",    "Jewish",    "Latin",    "Lithuanian",    "Middle Eastern",    "N",    "Nicaraguan",    "Noodle Houses",    "Noodle Shops",    "Omelettes",    "Oyster Bars",    "Pancakes",    "Pastries",    "Pastry Shops",    "Pizza",    "Pizzerias",    "Po Boys",    "Power Brokers",    "Roumanian",    "Russian",    "Salvadoran",    "Scottish",    "Soul Food",    "Soulfood" ,    "Steakhouses",    "Swiss-French",    "Tacos",    "Traditional",    "Ukrainian",    "Ukranian",    "Venezuelan",    "Yogurt Bar",    "Yugoslavian"';
$style =~  s/[\#@~!&*()\[\];.:?^`\\\/]+//g;
#printf $out $style;

my $dir = 'C:/Users/yhan/Documents/CS773/q7/data';
#open (my $out, '>', 'C:/Users/yhan/Documents/CS773/q7/europeCity2.arff');
foreach my $fp (glob("$dir/*.txt")) {
	open my $fh, "<", $fp or die "can't read open '$fp'";
	#print $fp;
	my $city = (split '\/', $fp)[-1];
	$city = substr($city, 0, -4);
	#printf $out "\"$city\",";
	open (my $out, '>', "C:/Users/yhan/Documents/CS773/q8/res/$city.txt");
	
	while (<$fh>) {
	chomp;
	my $line = $_;
	my @res = split /[\s,\t]/, $line;
	my $resatom = '?';
	my $resocc = '?';
	my $resprice = '?';
	my $ressty = '?';
	my $resf;
	print $out "\"$res[0]\",";
	foreach my $ele (@res) {
		
		
		if (exists $feature{$ele} ) { 
			
			$resf = $feature{$ele};
			chomp ($resf); 
			$resf =~  s/[\#@~!\$&*()\[\];.:?^`\\\/]+//g;
			#print $resprice; 
			if($price =~ /$resf/) {
				$resprice = $resf;
				
				}
			elsif ($style =~ /$resf/) {
				$ressty = $resf;
				
				}
				
			elsif ($atmosphere =~ /$resf/) {
				$resatom = $resf;
				
				}
			elsif ($occasion =~ /$resf/){
				$resocc = $resf;
				
				}
			
		}
		}
	#print "\"$city\"\n";
	#printf $out "\"$res[0]\",\"$resatom\",\"$ressty\",\"$resprice\",\"$resocc\",\"$city\"\n";
	
	}


}


