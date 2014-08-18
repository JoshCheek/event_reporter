require 'minitest/autorun'
require 'minitest/pride'

# If we put the lib directory into the $LOAD_PATH,
# we can then load its files with `require`
#
# This line expands like this:
#    "/Users/josh/code/my_event_reporter/test/test_helper.rb/../../lib"
#    "/Users/josh/code/my_event_reporter/test/../lib"
#    "/Users/josh/code/my_event_reporter/lib"
lib_directory = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift lib_directory
require 'cli'
