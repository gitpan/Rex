#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:

package Rex::Config;

use strict;
use warnings;

use Rex::Logger;

use vars qw($user $password $timeout $password_auth $public_key $private_key $parallelism $log_filename $log_facility);

sub set_user {
   my $class = shift;
   $user = shift;
}

sub set_password {
   my $class = shift;
   $password = shift;
}

sub get_user {
   my $class = shift;
   if($user) {
      return $user;
   }

   return $ENV{"USER"};
}

sub get_password {
   my $class = shift;
   return $password;
}

sub set_timeout {
   my $class = shift;
   $timeout = shift;
}

sub get_timeout {
   my $class = shift;
   return $timeout || 2;
}

sub set_password_auth {
   my $class = shift;
   $password_auth = shift || 1;
}

sub get_password_auth {
   return $password_auth;
}

sub set_public_key {
   my $class = shift;
   $public_key = shift;
}

sub get_public_key {
   if($public_key) {
      return $public_key;
   }

   return $ENV{'HOME'} . '/.ssh/id_rsa.pub';
}

sub set_private_key {
   my $class = shift;
   $private_key = shift;
}

sub get_private_key {
   if($private_key) {
      return $private_key;
   }

   return $ENV{'HOME'} . '/.ssh/id_rsa';
}

sub set_parallelism {
   my $class = shift;
   $parallelism = $_[0];
}

sub get_parallelism {
   my $class = shift;
   return $parallelism || 1;
}

sub set_log_filename {
   my $class = shift;
   $log_filename = shift;
}

sub get_log_filename {
   my $class = shift;
   return $log_filename;
}

sub set_log_facility {
   my $class = shift;
   $log_facility = shift;
}

sub get_log_facility {
   my $class = shift;
   return $log_facility;
}


1;
