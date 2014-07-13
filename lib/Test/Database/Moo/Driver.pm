package Test::Database::Moo::Driver;

use Module::Find;
use Test::Roo::Role;

requires qw(_build_database _build_dbd_version);

=head1 NAME

Role::Database

=head1 DESCRIPTION

Role consumed by all database drivers roles such as SQLite and Pg to provide common functionality.

=head1 ATTRIBUTES

=head2 available_drivers

Returns the available drivers
=cut

has available_drivers => (
    is => 'lazy',
);

sub _build_available_drivers => (
    my $self = shift;

    # TODO
);

=head2 database

The database object. We expect a database driver role to supply the builder.

=cut

has database => (
    is      => 'lazy',
    clearer => 1,
);

=head2 dbd_version

DBD::Foo version string. We expect a database-specific role to supply the builder. Expected value is something along the lines of:

  DBD::Foo 0.345

=cut

has dbd_version => (
    is => 'lazy',
);

=head2 schema_class

Defaults to C<DBI>. This is the class on which we call C<< ->connect >> so for L<DBIx::Class> this is your schema class, for example:

  MyApp::Schema

=cut

has schema_class => (
    is => 'ro',
    default => 'DBI',
);

=head2 schema

Our connected and deployed schema. Can be used with L<DBIx::Class> but obviously unused with pure L<DBI>.

=cut;

has schema => (
    is => 'lazy',
    clearer => 1,
);

sub _build_schema {
    my $self = shift;

    my $schema_class = $self->schema_class;
    eval "require $schema_class"
      or die "failed to require $schema_class: $@";

    my $schema =  $schema_class->connect( $self->connect_info )
      or die "failed to connect to ";
    $schema->deploy;
    return $schema;
}

=head1 MODIFIERS

=head2 before setup

Add diag showing DBD version info.

=cut

before setup => sub {
    my $self = shift;
    diag "Testing with " . $self->dbd_version;
};

1;
