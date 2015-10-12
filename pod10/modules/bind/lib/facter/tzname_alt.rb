Facter.add("tzname") do
  setcode do
    if Facter.value(:osfamily) == 'Debian'
      File.readlines("/etc/timezone").to_a.last
    else
      tz = Time.new.zone
    end
  end
end
