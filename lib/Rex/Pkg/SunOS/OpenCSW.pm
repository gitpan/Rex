#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Pkg::SunOS::OpenCSW;
{
  $Rex::Pkg::SunOS::OpenCSW::VERSION = '0.55.1';
}

use strict;
use warnings;

use Rex::Commands::Run;
use Rex::Helper::Run;
use Rex::Commands::File;
use Rex::Pkg::SunOS;

use base qw(Rex::Pkg::SunOS);

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $proto->SUPER::new(@_);

  bless( $self, $proto );

  $self->{commands} = {
    install           => $self->_pkgutil() . ' --yes -i %s',
    install_version   => $self->_pkgutil() . ' --yes -i %s',
    remove            => $self->_pkgutil() . ' --yes -r %s',
    update_package_db => $self->_pkgutil() . " -U",
  };

  return $self;
}

sub _pkgutil {
  return "/opt/csw/bin/pkgutil";
}

1;
