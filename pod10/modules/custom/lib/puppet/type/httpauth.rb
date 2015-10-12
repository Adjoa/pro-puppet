## In the httpauth type we're managing a number of attributes,
## principally the user, password and, password file. We also
## provide some associated info like the realm (an HTTP Digest 
## Auth. value) and the mechanism we're going to use, Basic or
## Digest.
Puppet::Type.newtype(:httpauth) do
  @doc = "Manage HTTP Basic or Digest password files.
	 httpauth {'user':
	   ensure    => present,
	   file      => '/path/to/password/file',
	   password  => 'password',
	   mechanism => basic,
	 }"

# Define operation of the ensure attribute.
  ensurable do
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present #if ensure attr. not specifed in resource
  end	

# Define parameters.
  newparam(:name) do
    desc "The name of the user to be managed."
    isnamevar
  end

  newparam(:file) do
    desc "The HTTP password file to be managed. It's created if non-existent."
  end

  newparam(:password) do
    desc "The password in plaintext"
  end

  newparam(:realm) do
    desc "The realm defaults to nil, mainly used for Digest authentication"
    default "nil"
  end

  newparam(:mechanism) do
    desc "The authentication mechanism to use, basic | digest. Default: basic."
    newvalues(:basic, :digest) #specify acceptable values for param/ property
    defaultto :basic
  end

# Ensure a password is alwasys specified.
  validate do
    raise Puppet::Error, "You must specify a password for the user." 
  unless
    @parameters.include?(:password)
  end
end
