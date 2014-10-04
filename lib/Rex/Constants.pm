#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:

package Rex::Constants;
{
  $Rex::Constants::VERSION = '0.54.3';
}

use strict;
use warnings;

require Rex::Exporter;
use base qw(Rex::Exporter);
use vars qw(@EXPORT);

@EXPORT = qw(present absent latest running started stopped);

sub present { return "present"; }
sub absent  { return "absent"; }
sub latest  { return "latest"; }
sub running { return "running"; }
sub started { return "started"; }
sub stopped { return "stopped"; }

1;
