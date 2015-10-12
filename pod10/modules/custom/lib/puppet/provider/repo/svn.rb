require 'fileutils'

# Provider name: svn is a provider for Type: repo
Puppet::Type.type(:repo).provide(:svn) do
  desc "Provides Subversion support for the repo type"

# Define the commands that this provider will use.
# Puppet uses these commands to determine whether the
# provider is appropriate to use on the agent. If
# Puppet can't find these commands in the local path,
# it will disable the provider. Any resources using 
# this provider will fail, and Puppet will report an 
# error.
  commands :svncmd   => "svn"
  commands :svnadmin => "svnadmin"

# Define the create, destroy and exists? methods the 
# ensurable statement from our type definition expects
# to find in the provider.

# The create method ensures that our resource is
# created. It uses the svn command to check out a repo
# and specify the destination for the checkout.
  def create
    svncmd "checkout", resource[:name], resource[:path]
   #svncmd "checkout", resource[:source], resource[:path]
   #svncmd "checkout", <my_repo_src>, <send_my_repo_here>
  end

# The delete method ensures the deletion of the resource.
# In this case, dir and files specified by the 
# resource[:path] parameter.
  def destroy
    FileUtils.rm_rf resource[:path]
  end

# The exists? method checks to see if the resource exists.
# Its operation is closely linked to the ensure attribute.
# It creates the resource is ensure set to present and
# vice versa.
  def exists?
    File.directory? resource[:path]
  end
end

