package Test::Database::Moo;

use Carp;
use Class::C3::Componentised qw(ensure_class_loaded);
use Data::Dumper::Concise;
use Module::Find qw(findsubmod);
use MooX::Types::MooseLike::Base qw(ArrayRef);
use Moo;
extends 'Test::Roo';

use namespace::clean;

=head1 NAME

Test::Database::Moo - Test against multiple database backends using Test::Roo.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head2 available_drivers

Read-only. Returns an arrayref of available drivers. To discover all potential drivers see L</potential_drivers> and to find out why a specific driver is not available call C<requires> on the driver.

=cut

has available_drivers => (
    is => 'lazy',
    isa => ArrayRef,
);

sub _build_available_drivers {
    my $self = shift;
    my @available_drivers;
    foreach my $driver ( @{$self->potential_drivers} ) {
        eval "require $driver";
        if ( $driver->can("available") ) {
            push @available_drivers, $driver;
        }
    }
    return \@available_drivers;
}

=head2 potential_drivers

Read-only. Returns an arrayref of potential drivers.

=cut

has potential_drivers => (
    is => 'lazy',
    isa => ArrayRef,
);

sub _build_potential_drivers {
    my $self = shift;
    my @potential_drivers = findsubmod Test::Database::Moo::Driver;
    return \@potential_drivers;
};

=head1 METHODS

=head2 explain_missing_drivers

Explain why certain drivers are missing.

=cut

sub explain_missing_drivers {
    return "Not implemented";
}

=head1 AUTHOR

Peter Mottram (SysPete), C<< <peter at sysnix.com> >>

=head1 CONTRIBUTORS

=head1 BUGS

Probably lots at this stage of development.

=head1 SUPPORT

=head1 ACKNOWLEDGEMENTS

David Golden <dagolden@cpan.org> for his excellent L<Test::Roo> on which this distribution is based.

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Peter Mottram (SysPete).

This program is free software; you can redistribute under the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut

1;
