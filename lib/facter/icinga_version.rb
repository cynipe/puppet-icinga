def get_redhat_icinga_version
  version = Facter::Util::Resolution.exec('yum info icinga |grep "^Version"')
  if match = /^Version\s*:\s*(\d+\.\d+\.\d+)$/.match(version)
    match[1]
  else
    nil
  end
end

Facter.add("icinga_version") do
  setcode do
    case Facter.value('osfamily')
      when 'RedHat'
        get_redhat_icinga_version()
      else
        nil
    end
  end
end

