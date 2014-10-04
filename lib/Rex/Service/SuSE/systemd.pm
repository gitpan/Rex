#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Service::SuSE::systemd;
{
  $Rex::Service::SuSE::systemd::VERSION = '0.54.3';
}

use strict;
use warnings;

use Rex::Commands::Run;
use Rex::Logger;
use Rex::Commands::Fs;

use Rex::Service::Redhat::systemd;
use base qw(Rex::Service::Redhat::systemd);

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $proto->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

1;
