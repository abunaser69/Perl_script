#!/usr/bin/perl

foreach $file (@ARGV) {
format1("$file");
}

sub format1{
($file) = @_;
open (FILE1,"$file");
local $/= undef;  #$/ = ''  # read in more whole paragraph, not just one line undef $/;  for whole file  
@content = <FILE1>;
my $i=0;
my $j=0;
my $k=0;
foreach $i(@content){
@ary=split(' ',$i);
my $k=@ary;
for ($j=0; $j<$k; $j+=5){
#print "active @ary[$j .. $j+4]\n";
}
for ($j=0; $j<$k; $j++){
print "    @ary[$j]         x  y  z\n";
