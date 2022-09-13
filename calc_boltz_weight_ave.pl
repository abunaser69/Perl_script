#!/usr/bin/perl -w

use strict;

if ($#ARGV != 1) {
 print "usage: script required two files\n";
 exit;
}

my $file1 = $ARGV[0];
my $file2 = $ARGV[1];

open (FILE1, "$file1" || die("Could not open 1st file!"));
open (FILE2,"$file2" || die("Could not open 2nd file!"));

my @lines1 = <FILE1>;
my $l1=@lines1;
my @lines2 = <FILE2>;
my $l2=@lines2;

if($l1 != $l2) { die("Number of data are not same on both files!");}

my $i=0;
my $l=$l1;
my $t=300.00 ;#kelvin
my $k=0.001985878 ;#cal/mol/k
my $KT=($k*$t);
my $au2kcal=627.50956;
my @lineR=();
my @lineRM=();
my @lineP=();
my @linePM=();
my @probN=();
my $probD=0.0;
my @diffE=();
my $ensA=0.0;
my $sum1=0.0;
my $sum2=0.0;
my $ave_sum=0.0;
my $ave_sum1=0.0;
my $ave_sum2=0.0;
my $sum_ave=0.0;
my $diff=0.0;
my $ave_eng=0.0;
my $norm=0.0;

for ($i=0;$i<$l;$i++){

chop($lines1[$i]);
chop($lines2[$i]);

#print "$lines1[$i]\n";

$sum1 += $lines1[$i];
$sum2 += $lines2[$i];

$lineR[$i] = ($lines1[$i]+322.0)*$au2kcal;

$lineRM[$i] = -1.0*($lineR[$i]/$KT);

#print "$lineR[$i]\n";
$lineP[$i]=($lines2[$i]+322.0)*$au2kcal;
#print "$lineP[$i]\n";
$diffE[$i] = -1.0*(($lineP[$i]-$lineR[$i])/$KT);
#print "$diffE[$i]\n";
$probN[$i] = exp($lineRM[$i]);
#print "$probN[$i]\n";
$probD += exp($lineRM[$i]);

#print "$probD\n";

}

for ($i=0;$i<$l;$i++){

#print "$diffE[$i]\n";

$ensA += exp($diffE[$i])*($probN[$i]/$probD);

$norm += ($probN[$i]/$probD);

}
#print "$norm";

$ave_sum1=$sum1/$l;
$ave_sum2=$sum2/$l;

$diff=($ave_sum2-$ave_sum1)*$au2kcal;

$ave_eng= -1.0*$KT*log($ensA);

print "Average energy (a.u.) in 1st input file ($file1)  = $ave_sum1\n";
print "Average energy (a.u.) in 2nd input file ($file2)  = $ave_sum2\n";
print "Average energy (Kcal) difference                  = $diff\n";
print "Average (weighted) barrier height (Kcal)          = $ave_eng\n";
print "Normalization test                                = $norm\n";
