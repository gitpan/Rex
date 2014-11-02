#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Virtualization::LibVirt::clone;
{
  $Rex::Virtualization::LibVirt::clone::VERSION = '0.55.3';
}

use strict;
use warnings;

use Rex::Logger;
use Rex::Commands::Run;
use Rex::Helper::Run;

use XML::Simple;

use Data::Dumper;

sub execute {
  my ( $class, $vmname, $newname ) = @_;

  unless ($vmname) {
    die("You have to define the vm name!");
  }

  unless ($newname) {
    die("You have to define the new vm name!");
  }

  i_run
    "/usr/bin/virt-clone --connect qemu:///system -o '$vmname' -n '$newname' --auto-clone";
}

1;
