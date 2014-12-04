def lib_default_gateway
  File.open('/proc/net/route').read_nonblock(4096).each_line do |l|
    next if l =~ /^if.+/i
    entry = l.split("\t")[1,2].map! {|i| [i].pack('H*') }
    if entry[0].unpack('C4').inject(:+).zero?
      return entry[1].unpack('C4').reverse.join('.')
    end
  end
end
