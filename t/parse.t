#!perl
use strict;
use warnings;
use Test::More;
use WWW::3172::LogAnalyzer::Parser;

my @is;

my $parser = WWW::3172::LogAnalyzer::Parser->new(
    file        => 't/test.log',
#    debug       => 1,
    callback    => sub {
        my %matches = @_;
        push @is, \%matches;
    }
);

$parser->parse;

my @ought = (
          {
            'client' => '202.32.92.47',
            'request' => 'GET /~scottp/publish.html',
            'timestamp' => '01/Jun/1995:00:00:59 -0600',
            'status' => '200',
            'size' => '271'
          },
          {
            'client' => 'ix-or7-27.ix.netcom.com',
            'request' => 'GET /~ladd/ostriches.html',
            'timestamp' => '01/Jun/1995:00:02:51 -0600',
            'status' => '200',
            'size' => '205908'
          },
          {
            'client' => 'ram0.huji.ac.il',
            'request' => 'GET /~scottp/publish.html',
            'timestamp' => '01/Jun/1995:00:05:44 -0600',
            'status' => '200',
            'size' => '271'
          },
          {
            'client' => 'eagle40.sasknet.sk.ca',
            'request' => 'GET /~lowey/',
            'timestamp' => '01/Jun/1995:00:08:06 -0600',
            'status' => '200',
            'size' => '1116'
          },
          {
            'client' => 'eagle40.sasknet.sk.ca',
            'request' => 'GET /~lowey/kevin.gif',
            'timestamp' => '01/Jun/1995:00:08:19 -0600',
            'status' => '200',
            'size' => '49649'
          },
          {
            'client' => 'cdc8g5.cdc.polimi.it',
            'request' => 'GET /~friesend/tolkien/rootpage.html',
            'timestamp' => '01/Jun/1995:00:11:03 -0600',
            'status' => '200',
            'size' => '461'
          },
          {
            'client' => 'freenet2.carleton.ca',
            'request' => 'GET /~scottp/free.html',
            'timestamp' => '01/Jun/1995:00:16:54 -0600',
            'status' => '200',
            'size' => '5759'
          },
          {
            'client' => 'red.weeg.uiowa.edu',
            'request' => 'GET /~friesend/tolkien/rootpage.html',
            'timestamp' => '01/Jun/1995:00:18:14 -0600',
            'status' => '200',
            'size' => '461'
          },
          {
            'client' => 'interchg.ubc.ca',
            'request' => 'GET /~lowey/encyclopedia/index.html',
            'timestamp' => '01/Jun/1995:00:23:53 -0600',
            'status' => '200',
            'size' => '2460'
          },
          {
            'client' => 'interchg.ubc.ca',
            'request' => 'GET /~lowey/encyclopedia/help.html',
            'timestamp' => '01/Jun/1995:00:24:17 -0600',
            'status' => '200',
            'size' => '2570'
          }
        );

is_deeply \@is, \@ought;
done_testing;

