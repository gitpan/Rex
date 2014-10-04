use strict;
use warnings;

use Test::More tests => 5;
use Data::Dumper;

use_ok 'Rex::Pkg::Base';

my $pkg = Rex::Pkg::Base->new;

my @plist1 = (
  { name => 'vim', version => '1.0' },
  { name => 'mc',  version => '2.0' },
  { name => 'rex', version => '0.51.0' },
);

my @plist2 = (
  { name => 'vim',       version => '1.0' },
  { name => 'rex',       version => '0.52.0' },
  { name => 'libssh2-1', version => '0.32.1' },
);

my @mods = $pkg->diff_package_list( \@plist1, \@plist2 );

my $found_vim = grep { $_->{name} eq "vim" } @mods;
ok( $found_vim == 0, "vim was not modified" );

my ($found_rex) = grep { $_->{name} eq "rex" } @mods;
ok( $found_rex->{action} eq "updated", "rex was updated" );

my ($found_libssh2) = grep { $_->{name} eq "libssh2-1" } @mods;
ok( $found_libssh2->{action} eq "installed", "libssh2-1 was installed" );

my ($found_mc) = grep { $_->{name} eq "mc" } @mods;
ok( $found_mc->{action} eq "removed", "mc was removed" );

1;
