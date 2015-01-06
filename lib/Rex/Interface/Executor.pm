#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Interface::Executor;

use strict;
use warnings;

our $VERSION = '0.56.1'; # VERSION

use Data::Dumper;

sub create {
  my ( $class, $type ) = @_;

  unless ($type) {
    $type = "Default";
  }

  my $class_name = "Rex::Interface::Executor::$type";
  eval "use $class_name;";
  if ($@) { die("Error loading file interface $type.\n$@"); }

  return $class_name->new;

}

1;
