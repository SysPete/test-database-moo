#!perl

use Data::Dumper::Concise;
use Test::Database::Moo;
use Test::Deep;
use Test::More;

my $tdm = Test::Database::Moo->new;

cmp_deeply(
    $tdm->potential_drivers,
    bag(
        qw(
          Test::Database::Moo::Driver::MySQL
          Test::Database::Moo::Driver::PostgreSQL
          Test::Database::Moo::Driver::SQLite
          )
    ),
    "We have potential drivers"
);

diag Dumper($tdm->available_drivers);

done_testing;
