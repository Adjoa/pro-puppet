# Puppet continas an existing function called sha1
# that generates a SHA1 hash value from a provided 
# string. This is an updated function to support 
# SHA512 instead.
# newfunction_method(func_name, type, documentation)
Puppet::Parser::Functions::newfunction(:sha512, :type => :rvalue, :doc => "Returns a SHA1 hash value from a provided string.") do |args|
  require 'digest/sha1'
  Digest::SHA512.hexdigest(args[0])
end
