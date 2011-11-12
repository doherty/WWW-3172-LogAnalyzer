package WWW::3172::LogAnalyzer::Parser;
use strict;
use warnings;
# ABSTRACT:
# VERSION

use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;
use autodie;
use Carp;
use Data::Printer alias => 'dump';

subtype 'Natural',
    as 'Int',
    where { $_ > 0 };

has 'file' => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

has 'debug' => (
    is      => 'rw',
    isa     => 'Natural',
);

has 'max' => (
    is      => 'ro',
    isa     => 'Natural',
    predicate => 'has_max',
);

has 'format' => (
    is  => 'ro',
    isa => 'RegexpRef',
    default => sub {
        # http://ita.ee.lbl.gov/html/contrib/Sask-HTTP.html
        # ftp://ita.ee.lbl.gov/traces/usask_access_log.gz
        # 202.32.92.47 - - [01/Jun/1995:00:00:59 -0600] "GET /~scottp/publish.html" 200 271
        qr/
            ^
            (?P<client>.+)
            \ -\ -\ \[(?P<timestamp>.+)\]
            \ "(?P<request>[^"]+)"
            \ (?P<status>\d\d\d)
            \ (?P<size>\d+)
            $
        /x
    },
);

has 'callback' => (
    is          => 'ro',
    isa         => 'CodeRef',
    required    => 1,
);

sub parse {
    my $self = shift;

    open my $log, '<', $self->file;
    while (<$log>) {
        chomp;
        if ( $_ =~ $self->format) {
            dump %+ if $self->debug;
            $self->callback->(%+);
        }
        else {
            warn "Unparseable log line: $_";
        }

        last if $self->has_max and $. >= $self->max;
    }
    close $log;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

