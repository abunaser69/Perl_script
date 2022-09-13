#!/usr/bin/perl
# This script is written by  Abu Naser
# Further modification of *.crd file is required
# as two letter elements name such as Pd need to be edited by sed for colum2
#

foreach $file (@ARGV) {
format1("$file");
}

sub format1{
($file) = @_;

open (FILE1,"$file" || die("Could not open file!"));

@lines = <FILE1>;
my $l=0;
$l=@lines-1;

open (FILE2,">>tinker1.xyz");
print FILE2 "$l Sript generated tinker coordinates for qmmm\n";
#$connect="connection.xyz";

my $i=0;

@m=splice(@lines,1,$l);
foreach $i (@m){
@b=split(' ', $i);

for($j=0;$j<$i;$j+=$l){

printf FILE2 ("%6s  %-4s %-4s %10.6f %10.6f %10.6f  %4s  %4s  %4s  %4s  %4s\n",  @b[$j+0], substr(@b[$j+1],0,1), @b[$j+1], @b[$j+2], @b[$j+3], @b[$j+4],@b[$j+5 .. $j+9]);

}
}
print FILE2 "END";

close (FILE2);
}

