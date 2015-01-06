#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Interface::Executor::Base;

use strict;
use warnings;

our $VERSION = '0.56.1'; # VERSION

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $proto->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

sub exec { die("Should be implemented by interface class."); }

sub set_task {
  my ( $self, $task ) = @_;
  $self->{task} = $task;
}

1;
