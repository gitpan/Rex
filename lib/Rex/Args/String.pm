#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Args::String;
{
  $Rex::Args::String::VERSION = '0.55.1';
}

use strict;
use warnings;

sub get {
  my ( $class, $name ) = @_;

  my $arg = shift @ARGV;
  return $arg;
}

1;
