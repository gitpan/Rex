#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Args::Integer;

use strict;
use warnings;

our $VERSION = '0.56.1'; # VERSION

use Rex::Logger;

sub get {
  my ( $class, $name ) = @_;

  my $arg = shift @ARGV;

  if ( $arg =~ m/^\d+$/ ) {
    return $arg;
  }

  Rex::Logger::debug("Invalid argument for $name");

  return undef;
}

1;
