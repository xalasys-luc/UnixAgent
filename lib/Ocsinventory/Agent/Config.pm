package Ocsinventory::Agent::Config;

sub get {
  my $file = shift;
  my $config;

  if (!$file || !-f $file) {
    $file = '/etc/ocsinventory-agent/ocsinventory-agent.cfg';
    if (!-f $file) {
      $file = $ENV{HOME}.'/ocsinventory-agent/ocsinventory-agent.cfg';
      return {} if (! -f $file);
    }
  }

  $config->{configfile} = $file;

  open (CONFIG, "<".$file) or return {};

  foreach (<CONFIG>) {
    s/#.+//;
    if (/(\w+)\s*=\s*(\w+)/) {
      $config->{$1} = $2;
    }
  }
  close CONFIG;
  return $config;
}

1;