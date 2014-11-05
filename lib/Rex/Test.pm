#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Test;
{
  $Rex::Test::VERSION = '0.54.3';
}

use Rex -base;
use Data::Dumper;
use Rex::Commands::Box;

task run => make {
  Rex::Logger::info("Running integration tests...");

  my @files;
  LOCAL {
    @files = grep { $_ =~ /\.t$/ } list_files 't';
  };

  for my $file (@files) {
    Rex::Logger::info("Running test: t/$file.");
    eval { do "t/$file"; 1; } or do { print "Error: $@"; };
  }
};

1;
