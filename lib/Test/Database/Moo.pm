package Test::Database::Moo;

use Module::Find qw(findsubmod);
use Moo;
extends 'Test::Roo';

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

=cut

has available_drivers => (
    is => 'lazy',
);

sub _build_available_drivers {
    my $self = shift;
    my @possible_

}

=head2 potential_drivers

Potential drivers that might be available depending on availability of other modules.

=cut

has potential_drivers => (
    is => 'lazy',
);

=head1 METHODS

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
