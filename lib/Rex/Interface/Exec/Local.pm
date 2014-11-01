#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Interface::Exec::Local;
{
  $Rex::Interface::Exec::Local::VERSION = '0.55.2';
}

use strict;
use warnings;

use Rex::Logger;
use Rex::Commands;

use Symbol 'gensym';
use IPC::Open3;

# Use 'parent' is recommended, but from Perl 5.10.1 its in core
use base 'Rex::Interface::Exec::Base';

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = {@_};

  bless( $self, $proto );

  return $self;
}

sub set_env {
  my ( $self, $env ) = @_;
  my $cmd = undef;

  die("Error: env must be a hash")
    if ( ref $env ne "HASH" );

  while ( my ( $k, $v ) = each(%$env) ) {
    $cmd .= "export $k='$v'; ";
  }
  $self->{env} = $cmd;
}

sub exec {
  my ( $self, $cmd, $path, $option ) = @_;

  my ( $out, $err, $pid );

  if ( exists $option->{cwd} ) {
    $cmd = "cd " . $option->{cwd} . " && $cmd";
  }

  if ( exists $option->{path} ) {
    $path = $option->{path};
  }

  if ( exists $option->{env} ) {
    $self->set_env( $option->{env} );
  }

  if ( exists $option->{format_cmd} ) {
    $option->{format_cmd} =~ s/{{CMD}}/$cmd/;
    $cmd = $option->{format_cmd};
  }

  Rex::Commands::profiler()->start("exec: $cmd");
  if ( $^O !~ m/^MSWin/ ) {
    if ($path) { $path = "PATH=$path" }
    $path ||= "";

    my $new_cmd = "LC_ALL=C $cmd";
    if ($path) {
      $new_cmd = "export $path ; $new_cmd";
    }

    if ( $self->{env} ) {
      $new_cmd = $self->{env} . " $new_cmd";
    }

    if ( Rex::Config->get_source_global_profile ) {
      $new_cmd = ". /etc/profile >/dev/null 2>&1; $new_cmd";
    }

    $cmd = $new_cmd;
  }

  Rex::Logger::debug("Executing: $cmd");

  my ( $writer, $reader, $error );
  $error = gensym;

  if ( Rex::Config->get_no_tty ) {
    $pid = open3( $writer, $reader, $error, $cmd );

    while ( my $output = <$reader> ) {
      $out .= $output;
      $self->execute_line_based_operation( $output, $option )
        && goto END_OPEN3;
    }

    while ( my $errout = <$error> ) {
      $err .= $errout;
      $self->execute_line_based_operation( $errout, $option )
        && goto END_OPEN3;
    }
  END_OPEN3:
    waitpid( $pid, 0 ) or die($!);
  }
  else {
    $pid = open( my $fh, "$cmd 2>&1 |" ) or die($!);
    while (<$fh>) {
      $out .= $_;
      $self->execute_line_based_operation( $_, $option )
        && do { kill( 'KILL', $pid ); last };
    }
    waitpid( $pid, 0 ) or die($!);

  }

  $? >>= 8;

  Rex::Logger::debug($out) if ($out);
  if ($err) {
    Rex::Logger::debug("========= ERR ============");
    Rex::Logger::debug($err);
    Rex::Logger::debug("========= ERR ============");
  }

  Rex::Commands::profiler()->end("exec: $cmd");

  if (wantarray) { return ( $out, $err ); }

  return $out;
}

1;
