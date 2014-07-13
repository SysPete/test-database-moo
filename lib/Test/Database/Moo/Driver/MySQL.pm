package Test::Database::Moo::Driver::MySQL;

use MooX::Types::MooseLike::Base qw(Bool ArrayRef);
use Moo;
#with 'Test::Database::Moo::Driver';

has available => (
    is => 'lazy',
    isa => Bool,
);

sub _build_available {
    my $self = shift;
    return 1;
}

has requires => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [qw( DateTime::Format::MySQL DBD::mysql Test::mysqld )] },
);

has missing => (
    is => 'lazy',
    isa => ArrayRef,
);

sub _build_missing {
    my $self = shift;

    my @missing;
    foreach my $mod ( @{$self->requires} ) {
    }
    return \@missing;
}

eval "use DateTime::Format::MySQL";
#plan skip_all => "DateTime::Format::MySQL required" if $@;

eval "use DBD::mysql";
#plan skip_all => "DBD::mysql required" if $@;

eval "use Test::mysqld";
#plan skip_all => "Test::mysqld required" if $@;

sub _build_database {
    my $self = shift;
    no warnings 'once'; # prevent: "Test::mysqld::errstr" used only once
    my $mysqld = Test::mysqld->new( my_cnf => { 'skip-networking' => '' } )
      or die $Test::mysqld::errstr;
    return $mysqld;
}

sub _build_dbd_version {
    return "DBD::mysql $DBD::mysql::VERSION";
}

sub connect_info {
    my $self = shift;
    return $self->database->dsn( dbname => 'test' );
}

1;
