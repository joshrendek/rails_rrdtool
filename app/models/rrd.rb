class RRD
  def self.test
	puts "test"
  end

  def self.sanitize(string,type)
    # types are alphanum, num, graph, ds_type, rra_type, path
    str = ""
    if type == 'num' # 0-9 and . (accepted: 1.5, 10, 234)
       str = string.to_s.match( /[0-9.]+/ )[0]
    elsif type == 'alphanum' # alpha numeric only (accepted: abc123, abc, 123)
       str = string.to_s.match( /[a-zA-Z0-9]+/ )[0]
    elsif type == 'ds_type' # only DS types (accepted values are GAUGE, COUNTER, DERIVE, ABSOLUTE, and COMPUTE
       str = string.to_s.match( /(GAUGE|COUNTER|DERIVE|ABSOLUTE|COMPUTE)/ )[0]
    elsif type == 'rra_type' # only RRA types (accepted values are AVERAGE, MIN, MAX, LAST
       str = string.to_s.match( /(AVERAGE|MIN|MAX|LAST)/ )[0]
    elsif type == 'path' # sanitizes the PATH of the RRD db will match test.rrd and /path/test.rrd
       str = string.to_s.match("^(/|){1}(((/{1}\.{1})?[a-zA-Z0-9 ]+/?)+(\.{1}[a-zA-Z0-9]{2,4})?)$")
    end  

    if str.nil?
      raise "No match was returned when matching #{type}"
    else
      return str
    end
  end

  def self.create(path,params)
    # example usage:
    # RRD.create('/test.rrd', {:step => 300, :heartbeat => 600,
    # :ds => [  {:name => "test", :type => "GAUGE"}, {:name => "josh", :type => "GAUGE"} ]  ,
    # :xff => ".5", :rra => [ {:type => "max", :steps => 20, :rows => 1} ] })
    # first value is a path to the rrd db, the 2nd param is a hash of keys and values
    # :ds is an array containing hashes for each DataSource (DS) type in the db
    # :xff is the x files factor (see RRD website for more info on this), range is acceptable between 0 and 1
    # :rra is a array containing hashes with RRA types and corresponding values
	puts "Creating RRD graph"
    puts "Step: " + self.sanitize(params[:step], 'num')
    begin
      cmd = "rrdtool create #{self.sanitize(path, 'path')} --step #{self.sanitize(params[:step], 'num')} "

      for p in params[:ds]
        cmd <<  "DS:#{p[:name]}:#{self.sanitize(p[:type], 'ds_type')}:#{self.sanitize(params[:heartbeat], 'num')}:0:U "
      end

      xff = self.sanitize(params[:xff], 'num')
      for r in params[:rra]
        cmd << "RRA:#{r[:type].upcase}:#{xff}:#{self.sanitize(r[:steps], 'num')}:#{self.sanitize(r[:rows], 'num')}"
      end
    rescue RuntimeError => e
      puts "RRD failed to create: #{e}"
    else
      puts "Running RRD command"
      return cmd
    end
  end

  def self.update(path, params)
    # example usage:
    # RRD.update('/test/path.rrd', ["123", "456a", 1234])
    # first param is path to rrd db
    # 2nd param will return data string of 123:456:1234 (each value is sanitized, only numeric values accepted)
    # to be passed as the data values to be passed to the db
    # N specifies the current time (NOW)

    # sanitize the params
    sanitized = []
    params.collect { |p| sanitized << self.sanitize(p, 'num') }
    vals = sanitized.join(":")
    cmd = "rrdtool update #{self.sanitize(path, 'path')} N:#{vals}"
  end
end
