Facter.add(:osrelease) do
  confine :osrelease => %w{Centos Fedora oel ovs RedHat MeeGo}
  setcode do
    case Facter.value(:operatingsystem)
    when "CentOS", "RedHat"
      releasefile = "/etc/redhat-release"
    when "Fedora"
      releasefile = "/etc/fedora-release"
    when "MeeGo"
      releasefile = "/etc/meego-release"
    when "OEL", "ovs"
      releasefile = "/etc/ovs-release"
    end
    File::open(releasefile, "r") do |f|
      line = f.readline.chomp
      if line =~ /\(Rawhide\)$/
        "Rawhide"
      elsif line =~ /release (\d[\d.]*)/
        $1
      end
    end
  end
end
