require 'open-uri'

module IpFinder
  class Ip
    def self.find ip
      ''.tap do |s|
        url = "http://ip.taobao.com/service/getIpInfo.php?ip=#{ip}"
        d = JSON.parse(open(url).read)['data']
        s << d['country']
      end
    end
  end
end