## Unlike other providers, ParsedFile providers are stored
## in a file called parsed.rb, located in the providers dir
## <modulename>/lib/puppet/shells/parsed.rb
##
## The file needs to be named parsed.rb to allow Puppet to
## load the appropriate ParsedFile support (unlike other
## providers, which need to be named for the provider itself.

require 'puppet/provider/parsedfile'

shells = "/etc/shells"

# Puppet::Type.type(:type_name).provider(:provider_name, 
#   :parent => provider_inherits_thisprovider, 
#   :default_target => shellsvar_definedabove,
#   filetype => :flat))
Puppet::Type.type(:shells).provider(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => shells, filetype => :flat) do

  desc "The shells provider that usese the ParsedFile class"

# Tell Puppet to ignore comments and blank lines
# text_line :line_type, :match => match_what_w_thistype?
  text_line :comment, :match => /^#/;
  text_line :blank, :match => /^\s*$/;

# Parse each line and divide into fields. In our case, one field --name.
# That is, the name of the shell we want to manage.
  record_line :parsed, :fields => %w{name}
end 
