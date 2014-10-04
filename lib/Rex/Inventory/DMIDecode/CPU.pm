#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Inventory::DMIDecode::CPU;
{
  $Rex::Inventory::DMIDecode::CPU::VERSION = '0.54.3';
}

use strict;
use warnings;

use Rex::Inventory::DMIDecode::Section;
use base qw(Rex::Inventory::DMIDecode::Section);

__PACKAGE__->section("Processor Information");

__PACKAGE__->has(
  [
    'Max Speed', 'Serial Number', 'Family',  'Core Enabled',
    'Version',   'Status',        'Upgrade', 'Thread Count',
  ],
  1
);    # is_array 1

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $that->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

sub num_cores {
  my ($self) = @_;
  return $self->get_core_enabled;
}

sub get_socket_type {
  my ($self) = @_;
  return $self->get_upgrade;
}

1;

