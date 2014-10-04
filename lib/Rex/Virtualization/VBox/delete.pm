#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Virtualization::VBox::delete;
{
  $Rex::Virtualization::VBox::delete::VERSION = '0.54.3';
}

use strict;
use warnings;

use Rex::Logger;
use Rex::Helper::Run;

sub execute {
  my ( $class, $arg1 ) = @_;

  unless ($arg1) {
    die("You have to define the vm name!");
  }

  my $dom = $arg1;
  Rex::Logger::debug("deleting domain: $dom");

  unless ($dom) {
    die("VM $dom not found.");
  }

  i_run "VBoxManage unregistervm \"$dom\" --delete";
  if ( $? != 0 ) {
    die("Error destroying vm $dom");
  }

}

1;

