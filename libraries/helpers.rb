def get_expire_days(path)
  if File.exist?(path)
    cert = OpenSSL::X509::Certificate.new(File.read(path))
    return ((cert.not_after - Time.now) / 86_400).to_i
  else
    return -1
  end
end
