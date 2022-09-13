#!/usr/bin/perl -w

if ($#ARGV != 1) {
 print "usage: script required two files\n";
 exit;
}

$file1 = $ARGV[0];
$file2 = $ARGV[1];

open (FILE1, "$file1" || die("Could not open 1st file!"));
open (FILE2,"$file2" || die("Could not open 2nd file!"));

@lines1 = <FILE1>;
my $l1=@lines1;
@lines2 = <FILE2>;
my $l2=@lines2;

if($l1 != $l2) { die("Number of data are not same on both files!");}

my $l=$l1;
my $t=300 ;#kelvin
my $au2kcal=627.50956;
my $e=2.718281828459;
my $k=0.001985878 ;#kcal/mol/k 
my $j2kcal=0.000239; # Convert Joule to Cal
my $i=0.0;
my $sum=0.0;
my $sum1=0.0;
my $sum2=0.0;
my $ave_sum=0.0;
my $ave_sum1=0.0;
my $ave_sum2=0.0;
my $sum_ave=0.0;
my $diff=0.0;
my $ave_eng=0.0;
my $comb1=0.0;
my $comb2=0.0;
my $norm=0.0;
for ($i=0;$i<$l;$i++){
$sum1 += $lines1[$i];
$sum2 += $lines2[$i];
$comb1[$i] = ($lines2[$i]-$lines1[$i]);
$comb2[$i] = -1.0*$comb1[$i]*$au2kcal;
$sum += exp($comb2[$i]/($t*$k));
$sum_ave +=$comb2[$i]*exp($comb2[$i]/($t*$k));
}

for ($i=0;$i<$l;$i++){
$norm += (exp($comb2[$i]/($t*$k)))/($sum);}

$ave_sum1=$sum1/$l;
$ave_sum2=$sum2/$l;
$diff=($ave_sum2-$ave_sum1)*$au2kcal;
$ave_sum=$sum_ave/$sum;
$ave_eng=-1.0*$k*$t*log($ave_sum);

print "Average energy (a.u.) in 1st input file ($file1)  = $ave_sum1\n";
print "Average energy (a.u.) in 2nd input file ($file2)  = $ave_sum2\n";
print "Average energy (Kcal) difference                  = $diff\n";
print "Average (weighted) barrier height (Kcal)          = $ave_eng\n";
print "Normalization test                                = $norm\n";
