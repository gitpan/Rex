#
# (c) Nathan Abu <aloha2004@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Output::Base;
$Rex::Output::Base::VERSION = '0.52.1';
sub write { die "Must be implemented by inheriting class" }
sub add   { die "Must be implemented by inheriting class" }
sub error { die "Must be implemented by inheriting class" }

1;