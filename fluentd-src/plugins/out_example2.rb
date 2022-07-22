
class Fluent::UdpStreamOutput < Fluent::Output
  Fluent::Plugin.register_output('example2', self)

  config_param :host,   :string,  :default => '127.0.0.1'
  config_param :port,   :integer, :default => 25000

  def start
    super
    @sock = UDPSocket.open
    @sockaddr = Socket.pack_sockaddr_in(@port, @host)
  end

  def udp_send(tag, time, record)
    msg = [tag, time, record].to_msgpack
    @sock.send(msg, 0, @sockaddr)
  end

  def emit(tag, es, chain)
    es.each do |time, record|
      udp_send(tag, time, record)
      log.info "OK"
    end

    chain.next
  end
end


