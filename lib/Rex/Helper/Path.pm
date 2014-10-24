#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Helper::Path;

use strict;
use warnings;

use File::Basename qw(dirname);
require Exporter;

use base qw(Exporter);
use vars qw(@EXPORT);

@EXPORT = qw(get_file_path);

#
# CALL: get_file_path("foo.txt", caller());
# RETURNS: module file
#
sub get_file_path {
   my ($file_name, $caller_package, $caller_file) = @_;

   if(! $caller_package) {
      ($caller_package, $caller_file) = caller();
   }

   # check if a file in $BASE overwrites the module file
   if(-f $file_name) {
      return $file_name;
   }

   my $module_path = Rex::get_module_path($caller_package);
   if($module_path) {
      $file_name = "$module_path/$file_name";
   }
   else {
      $file_name = dirname($caller_file) . "/" . $file_name;
   }

   return $file_name;
}

1;
