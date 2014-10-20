#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Inventory::DMIDecode::BaseBoard;
{
  $Rex::Inventory::DMIDecode::BaseBoard::VERSION = '0.55.0';
}

use strict;
use warnings;

use Rex::Inventory::DMIDecode::Section;
use base qw(Rex::Inventory::DMIDecode::Section);

__PACKAGE__->section("Base Board Information");

__PACKAGE__->has(
  [ 'Manufacturer', 'Serial Number', 'Version', 'Product Name', ] );

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $that->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

1;

