#!/usr/bin/perl

foreach $file (@ARGV) {
format1("$file");
}

sub format1{
($file) = @_;

open (FILE1,"$file" || die("Could not open file!"));

@lines = <FILE1>;
my $l=0;
$l=@lines-1;

#open (FILE2,">>tinker.xyz");
print "$l Sript generated tinker coordinates\n";
#$connect="connection.xyz";

my $i=0;

@m=splice(@lines,1,$l);
foreach $i (@m){
@b=split(' ', $i);

for($j=0;$j<$i;$j+=$l){

printf ("%3d   %2s   % 1.6f   % 1.6f   % 1.6f\n", @b[$j+0], @b[$j+1], @b[$j+2], @b[$j+3], @b[$j+4]);
}
}
#close (FILE2);
}
