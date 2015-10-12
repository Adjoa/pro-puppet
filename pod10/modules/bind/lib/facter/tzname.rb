Facter.add("tzname") do
  confine :osfamily => :debian
  setcode do
    File.readlines("/etc/timezone").to_a.last
  end
end
