## Types have two kinds of values --properties and parameters.
## Properties "do things". They tell us how providers work.
## Below we've defined the property ensure by using the
## ensurable statement. 
##
## Parameters are variables and contain information relevant
## to configuring the resource the type manages.
##
## The repo type manages version control systems (VCS). It 
## allows the user to create, manage and delete VCS repos.

Puppet::Type.newtype(:repo) do
  @doc = "Manage repos"
  ensurable	# tells Puppet to expect three methods:
		# create, destroy and exists?

  # The source parameter with tell the repo type where to go
  # to retrieve, clone, or check out our source repository.
  newparam(:source) do
    desc "The repo source"

  # The validate hook is normally used to check the parameter
  # for appropriateness; here, we're using it to take a guess
  # at what provider to use.  
  #
  # In addition to the validate hook, Puppet also has the 
  # munge hook, which you can use to adjust the value of the
  # parameter rather than validate it before passing it to 
  # the provider. 
    validate do |value|
      if value =~ /^git/
        resource[:provider] = :git
      else
        resource[:provider] = :svn
      end
    end

  # the isnamevar method makes this variable, the source 
  # variable, the "name" variable for this type ie, name
  # of the resource
    isnamevar
  end

  # The path parameter specifies where the repo type should put
  # the cloned/checked out repository.
  newparam(:path) do
    desc "Destination path"
   
    validate do |value|
      unless value =~ /^\/[a-z0-9]+/
        raise ArgumentError, "%s is not a valid file path" % value
      end
    end
  end
end
