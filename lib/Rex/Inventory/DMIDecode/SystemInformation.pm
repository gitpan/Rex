#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Inventory::DMIDecode::SystemInformation;

use strict;
use warnings;

our $VERSION = '0.56.1'; # VERSION

use Rex::Inventory::DMIDecode::Section;
use base qw(Rex::Inventory::DMIDecode::Section);

__PACKAGE__->section("System Information");

__PACKAGE__->has(
  [
    'Manufacturer', 'Product Name', 'UUID', 'SKU Number',
    'Family',       'Version',      'Serial Number',
  ]
);

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $that->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

1;

