require 'test/unit'
require './lib/rrd'

class RrdTest < Test::Unit::TestCase

  def test_sanitize_nums
    assert_equal '123.3', RRD.sanitize("123.3#!@;;;", 'num')
    assert_equal '123', RRD.sanitize("123#!@;;;", 'num')
    assert_equal '500', RRD.sanitize("-500#!@;;;", 'num')
  end 
  
  def test_sanitize_alphanum
    assert_equal 'ABCEF123123', RRD.sanitize("ABCEF123123#!@;;;", 'alphanum')
    assert_equal 'ABCEF123123', RRD.sanitize("#%!#ABCEF123123#!@;;;", 'alphanum')
  end
  
  def test_sanitize_dstype
    assert_equal RuntimeError, RRD.sanitize("ABCEF123123#!@;;;", 'ds_type')
    assert_equal RuntimeError, RRD.sanitize("#%!#ABCEF123123#!@;;;", 'ds_type')
    assert_equal "GAUGE", RRD.sanitize("#%!#GAUGE#!@;;;", 'ds_type')
    assert_equal "COUNTER", RRD.sanitize("#%!#COUNTER#!@;;;", 'ds_type')    
    assert_equal "COUNTER", RRD.sanitize("COUNTER", 'ds_type')    
    assert_equal "GAUGE", RRD.sanitize("GAUGE", 'ds_type')    
  end
  
  def test_sanitize_rra_type
    assert_equal RuntimeError, RRD.sanitize("ABCEF123123#!@;;;", 'rra_type')
    assert_equal RuntimeError, RRD.sanitize("#%!#ABCEF123123#!@;;;", 'rra_type')
    assert_equal "AVERAGE", RRD.sanitize("#%!#AVERAGE#!@;;;", 'rra_type')
    assert_equal "MIN", RRD.sanitize("#%!#MIN#!@;;;", 'rra_type')    
    assert_equal "AVERAGE", RRD.sanitize("AVERAGE", 'rra_type')    
    assert_equal "MIN", RRD.sanitize("MIN", 'rra_type')
  end
  
  def test_sanitize_path
    assert_equal "/home/test.rrd", RRD.sanitize("/home/test.rrd;", 'path')
    assert_equal "/home/test.rrdkill 1kill 1", RRD.sanitize("/home/test.rrd`kill 1`;kill 1", 'path')
  end
  
  def test_sanitize_imagetype
    assert_equal RuntimeError, RRD.sanitize("SDFOISJFDOJ", 'imagetype')
    assert_equal RuntimeError, RRD.sanitize("!@#())l;", 'imagetype')
    assert_equal "PNG", RRD.sanitize("!@#PNG", 'imagetype')
    assert_equal "SVG", RRD.sanitize("!#09!0-SVG", 'imagetype')
    assert_equal "PNG", RRD.sanitize("PNG", 'imagetype')
    assert_equal "SVG", RRD.sanitize("SVG", 'imagetype')
  end
  
  def test_sanitize_rpn
    assert_equal RuntimeError, RRD.sanitize("ABCEF123123#!@;;;", 'rpn')
    assert_equal RuntimeError, RRD.sanitize("#%!#ABCEF123123#!@;;;", 'rpn')
    assert_equal "PRINT", RRD.sanitize("#%!#PRINT#!@;;;", 'rpn')
    assert_equal "GPRINT", RRD.sanitize("#%!#GPRINT#!@;;;", 'rpn')    
    assert_equal "PRINT", RRD.sanitize("PRINT", 'rpn')    
    assert_equal "GPRINT", RRD.sanitize("GPRINT", 'rpn')
  end
  
  def test_sanitize_color
    assert_equal RuntimeError, RRD.sanitize("ABCEF123123#!@;;;", 'color')
    assert_equal RuntimeError, RRD.sanitize("#%!#ABCEF123123#!@;;;", 'color')
    assert_equal "BACK", RRD.sanitize("#%!#BACK#!@;;;", 'color')
    assert_equal "CANVAS", RRD.sanitize("#%!#CANVAS#!@;;;", 'color')    
    assert_equal "BACK", RRD.sanitize("BACK", 'color')    
    assert_equal "CANVAS", RRD.sanitize("CANVAS", 'color')
  end
  
  
end
