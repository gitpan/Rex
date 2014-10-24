#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:

package Rex::Service;

use strict;
use warnings;

use Rex::Config;
use Rex::Commands::Run;
use Rex::Commands::Gather;
use Rex::Hardware;
use Rex::Hardware::Host;
use Rex::Logger;

my %SERVICE_PROVIDER;
sub register_service_provider {
   my ($class, $service_name, $service_class) = @_;
   $SERVICE_PROVIDER{"\L$service_name"} = $service_class;
   return 1;
}
sub get {

   my $host = Rex::Hardware::Host->get();

   if(is_redhat()) {
      $host->{"operatingsystem"} = "Redhat";
   }

   my $class = "Rex::Service::" . $host->{"operatingsystem"};

   if(is_redhat() && can_run("systemctl")) {
      $class = "Rex::Service::Redhat::systemd";
   }

   if(is_suse() && can_run("systemctl")) {
      $class = "Rex::Service::SuSE::systemd";
   }

   if(is_alt() && can_run("systemctl")) {
      $class = "Rex::Service::ALT::systemd";
   }

   my $provider_for = Rex::Config->get("service_provider") || {};
   my $provider;

   if(ref($provider_for) && exists $provider_for->{$host->{"operatingsystem"}}) {
      $provider = $provider_for->{$host->{"operatingsystem"}};
      $class .= "::\L$provider";
   }
   elsif(exists $SERVICE_PROVIDER{$provider_for}) {
      $class = $SERVICE_PROVIDER{$provider_for};
   }

   Rex::Logger::debug("service using class: $class");
   eval "use $class";

   if($@) {
   
      Rex::Logger::info("OS (" . $host->{"operatingsystem"} . ") not supported");
      exit 1;
   
   }

   return $class->new;

}

1;
