#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Virtualization::VBox::option;
{
  $Rex::Virtualization::VBox::option::VERSION = '0.54.3';
}

use strict;
use warnings;

use Rex::Logger;
use Rex::Helper::Run;

my $FUNC_MAP = {
  max_memory => "memory",
  memory     => "memory",
};

sub execute {
  my ( $class, $arg1, %opt ) = @_;

  unless ($arg1) {
    die("You have to define the vm name!");
  }

  my $dom = $arg1;
  Rex::Logger::debug("setting some options for: $dom");

  for my $opt ( keys %opt ) {
    my $val = $opt{$opt};

    my $func;
    unless ( exists $FUNC_MAP->{$opt} ) {
      Rex::Logger::debug("$opt unknown. using as option for VBoxManage.");
      $func = $opt;
    }
    else {
      $func = $FUNC_MAP->{$opt};
    }

    i_run "VBoxManage modifyvm \"$dom\" --$func \"$val\"";
    if ( $? != 0 ) {
      Rex::Logger::info( "Error setting $opt to $val on $dom ($@)", "warn" );
    }

  }

}

1;

