#!/usr/bin/env perl

use strict;
use warnings;

use DBI;

if(scalar(@ARGV) != 3) {
   print "Usage: $0 <db-file> <template-name> <template-file>\n";
   exit 1;
}

my $DB = $ARGV[0];
my $template_name = $ARGV[1];
my $template_file = $ARGV[2];

if(! -f $DB) {
   print "Please create the db-file first.\n";
   print "CREATE TABLE templates (id integer primary key autoincrement not null, name varchar(255) not null, template text);\n";
   exit 2;
}



my $dbh = DBI->connect("dbi:SQLite:dbname=$DB", "", "");

my $template_string = eval { local(@ARGV, $/) = ($template_file); <>; };

my $sth = $dbh->prepare("INSERT INTO templates (name, template) VALUES(?,?)");
$sth->bind_param(1, $template_name);
$sth->bind_param(2, $template_string);

$sth->execute;

print "[+] Template added.\n";

