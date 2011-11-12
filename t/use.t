#!perl
use strict;
use warnings;
use Test::More;

use_ok('WWW::3172::LogAnalyzer');
use_ok('WWW::3172::LogAnalyzer::Parser');
my $parser = new_ok('WWW::3172::LogAnalyzer::Parser', [ file => 't/test.log', callback => sub{} ]);

done_testing;

