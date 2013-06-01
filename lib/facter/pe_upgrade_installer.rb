# Fact: pe_upgrade_installer
#
# Purpose: provide the PE installer package name
#
# Resolution: Provide the worst implementation of fizz buzz ever

Facter.add(:pe_upgrade_codename) do
  confine :osfamily => %w[Debian Redhat Suse Solaris AIX]

  setcode do
    case Facter.value(:osfamily)
    when 'RedHat'
      'el'
    when 'Suse'
      'sles'
    when 'Debian'
      Facter.value(:operatingsystem).downcase
    when 'Solaris', 'AIX'
      Facter.value(:osfamily).downcase
    end
  end
end

Facter.add(:pe_upgrade_installer) do

  confine :osfamily => %w[Debian Redhat Suse Solaris AIX]

  setcode do
    codename = Facter.value(:pe_upgrade_codename)
    arch     = Facter.value(:architecture)
    release  = Facter.value(:operatingsystemrelease)

    "puppet-enterprise-:version-#{codename}-#{release}-#{arch}"
  end
end

Facter.add(:pe_upgrade_installer) do
  confine :kernel => 'windows'
  setcode { 'puppet-enterprise-:version' }
end
