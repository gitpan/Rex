#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Cron::Linux;
{
  $Rex::Cron::Linux::VERSION = '0.55.3';
}

use strict;
use warnings;

use Rex::Cron::Base;
use base qw(Rex::Cron::Base);

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $proto->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

1;
