class RRD
  def self.test
	puts "test"
  end
  def self.create(path,params)
	puts "Creating RRD graph"
    puts "Step: #{params[:step]}"

    cmd = "rrdtool create #{path} --step #{params[:step].to_i} "

    for p in params[:ds]
      cmd <<  "DS:#{p[:name]}:#{p[:type]}:#{params[:heartbeat]}:0:U "
    end

    xff = params[:xff]
    for r in params[:rra]
      cmd << "RRA:#{r[:type].upcase}:#{xff}:#{r[:steps]}:#{r[:rows]}"
    end
    
    puts cmd
  end
end

##!/bin/sh
#
#NOW=`date +%s`
#
#
#DBFILE=/home/servly/rrd/$1_cpu.rrd
#
#if [ -e "$DBFILE" ]
#then
#        echo "file exists: $DBFILE"
#else
#        rrdtool create $DBFILE --step 300 \
#                DS:user:GAUGE:600:0:U \
#                DS:idle:GAUGE:600:0:U \
#                RRA:AVERAGE:0.5:1:10080 \
#                RRA:MAX:0.5:60:1 \
#                RRA:MAX:0.5:180:1 \
#                RRA:MAX:0.5:360:1 \
#                RRA:MAX:0.5:720:1 \
#                RRA:MAX:0.5:1440:1 \
#                RRA:MAX:0.5:2880:1 \
#                RRA:MAX:0.5:4320:1 \
#                RRA:MAX:0.5:10080:1
#
#        echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE
#
#DBFILE=/home/servly/rrd/$1_disk.rrd
#
#if [ -e "$DBFILE" ]
#then
#        echo "file exists: $DBFILE"
#else
#        rrdtool create $DBFILE -s 300 \
#                DS:used:GAUGE:600:0:U \
#                DS:avail:GAUGE:600:0:U \
#                RRA:AVERAGE:0.5:1:10080 \
#                RRA:MIN:0.5:60:1 \
#                RRA:MAX:0.5:60:1 \
#                RRA:MIN:0.5:180:1 \
#                RRA:MAX:0.5:180:1 \
#                RRA:MIN:0.5:360:1 \
#                RRA:MAX:0.5:360:1 \
#                RRA:MIN:0.5:720:1 \
#                RRA:MAX:0.5:720:1 \
#                RRA:MIN:0.5:1440:1 \
#                RRA:MAX:0.5:1440:1 \
#                RRA:MIN:0.5:2880:1 \
#                RRA:MAX:0.5:2880:1 \
#                RRA:MIN:0.5:4320:1 \
#                RRA:MAX:0.5:4320:1 \
#                RRA:MIN:0.5:10080:1 \
#                RRA:MAX:0.5:10080:1
#
#        echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE
#
#DBFILE=/home/servly/rrd/$1_mem.rrd
#
#NOW=`date +%s`
#
#if [ -e "$DBFILE" ]
#then
#	echo "file exists: $DBFILE"
#else
#	rrdtool create $DBFILE -s 300 -b N \
#		DS:used:GAUGE:600:U:U \
#		DS:free:GAUGE:600:U:U \
#		DS:buffers:GAUGE:600:U:U \
#		DS:cached:GAUGE:600:U:U \
#		RRA:AVERAGE:0.5:1:10080 \
#		RRA:MAX:0.5:60:1 \
#		RRA:MAX:0.5:180:1 \
#		RRA:MAX:0.5:360:1 \
#		RRA:MAX:0.5:720:1 \
#		RRA:MAX:0.5:1440:1 \
#		RRA:MAX:0.5:2880:1 \
#		RRA:MAX:0.5:4320:1 \
#		RRA:MAX:0.5:10080:1
#
#	echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE
#
#DBFILE=/home/servly/rrd/$1_mem2.rrd
#
#NOW=`date +%s`
#
#
#
#if [ -e "$DBFILE" ]
#then
#        echo "file exists: $DBFILE"
#else
#        rrdtool create $DBFILE -s 300 -b N \
#                DS:realmemusage:GAUGE:600:U:U \
#                RRA:AVERAGE:0.5:1:10080 \
#                RRA:MIN:0.5:60:1 \
#                RRA:MAX:0.5:60:1 \
#                RRA:MIN:0.5:180:1 \
#                RRA:MAX:0.5:180:1 \
#                RRA:MIN:0.5:360:1 \
#                RRA:MAX:0.5:360:1 \
#                RRA:MIN:0.5:720:1 \
#                RRA:MAX:0.5:720:1 \
#                RRA:MIN:0.5:1440:1 \
#                RRA:MAX:0.5:1440:1 \
#                RRA:MIN:0.5:2880:1 \
#                RRA:MAX:0.5:2880:1 \
#                RRA:MIN:0.5:4320:1 \
#                RRA:MAX:0.5:4320:1 \
#                RRA:MIN:0.5:10080:1 \
#
#        echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE
#
#DBFILE=/home/servly/rrd/$1_net.rrd
#
#NOW=`date +%s`
#
#if [ -e "$DBFILE" ]
#then
#        echo "file exists: $DBFILE"
#else
#        rrdtool create $DBFILE -s 300 \
#                DS:in:COUNTER:600:U:U \
#                DS:out:COUNTER:600:U:U \
#                RRA:AVERAGE:0.5:1:4320  \
#                RRA:AVERAGE:0.5:60:72   \
#                RRA:AVERAGE:0.5:180:24  \
#                RRA:AVERAGE:0.5:360:12  \
#                RRA:AVERAGE:0.5:720:6   \
#                RRA:AVERAGE:0.5:1440:3  \
#                RRA:AVERAGE:0.5:2880:2  \
#                RRA:AVERAGE:0.5:4320:1  \
#                RRA:AVERAGE:0.5:10080:1 \
#                RRA:MAX:0.5:60:1 \
#                RRA:MAX:0.5:180:1 \
#                RRA:MAX:0.5:360:1 \
#                RRA:MAX:0.5:720:1 \
#                RRA:MAX:0.5:1440:1 \
#                RRA:MAX:0.5:2880:1 \
#                RRA:MAX:0.5:4320:1 \
#                RRA:MAX:0.5:10080:1
#        echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE
#
#DBFILE=/home/servly/rrd/$1_processes.rrd
#
#NOW=`date +%s`
#
#if [ -e "$DBFILE" ]
#then
#        echo "file exists: $DBFILE"
#else
#
#        rrdtool create $DBFILE --step 300 \
#                DS:processes:GAUGE:600:U:U \
#                RRA:AVERAGE:0.5:1:10080 \
#                RRA:MIN:0.5:60:1 \
#                RRA:MAX:0.5:60:1 \
#                RRA:MIN:0.5:180:1 \
#                RRA:MAX:0.5:180:1 \
#                RRA:MIN:0.5:360:1 \
#                RRA:MAX:0.5:360:1 \
#                RRA:MIN:0.5:720:1 \
#                RRA:MAX:0.5:720:1 \
#                RRA:MIN:0.5:1440:1 \
#                RRA:MAX:0.5:1440:1 \
#                RRA:MIN:0.5:2880:1 \
#                RRA:MAX:0.5:2880:1 \
#                RRA:MIN:0.5:4320:1 \
#                RRA:MAX:0.5:4320:1 \
#                RRA:MIN:0.5:10080:1 \
#                RRA:MAX:0.5:10080:1
#
#        echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE
#
#DBFILE=/home/servly/rrd/$1_load.rrd
#
#if [ -e "$DBFILE" ]
#then
#	echo "file exists: $DBFILE"
#else
#
#	rrdtool create $DBFILE --step 300 \
#		DS:load:GAUGE:600:U:U \
#        RRA:AVERAGE:0.5:1:10080 \
#		RRA:MAX:0.5:60:1 \
#		RRA:MIN:0.5:180:1 \
#       	RRA:MAX:0.5:180:1 \
#        RRA:MIN:0.5:360:1 \
#        RRA:MAX:0.5:360:1 \
#        RRA:MIN:0.5:720:1 \
#        RRA:MAX:0.5:720:1 \
#        RRA:MIN:0.5:1440:1 \
#        RRA:MAX:0.5:1440:1 \
#        RRA:MIN:0.5:2880:1 \
#        RRA:MAX:0.5:2880:1 \
#        RRA:MIN:0.5:4320:1 \
#        RRA:MAX:0.5:4320:1 \
#        RRA:MIN:0.5:10080:1 \
#        RRA:MAX:0.5:10080:1
#
#	echo "file created: $DBFILE"
#fi
#
#chmod 777 $DBFILE