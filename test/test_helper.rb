$: << File.join(File.dirname(__FILE__), '..', 'lib')
$: << File.dirname(__FILE__)
 
require 'rubygems'
require 'test/unit'
require 'activerecord'
require 'shoulda'
require 'kitsune'
ActiveRecord::Base.extend(Kitsune::ActiveRecord)
require 'schema'
begin; require 'redgreen'; rescue LoadError; end