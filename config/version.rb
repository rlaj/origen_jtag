# Best not to edit this by hand, it will be overwritten by the tag script
class JTAG_Application < RGen::Application

  # This is setup for timestamp versioning, to switch to semantic
  # comment this out and un-comment the code below
#  VERSION = 'sm_2013_06_25_04_54'

  # Semantic versioning:
  # These counters are required, you can initialize them to any values you want
  # IF ENABLING THIS MAKE SURE YOU ALSO SET config.semantically_version = true
  # WITHIN config/application.rb
  MAJOR = 0
  MINOR = 5
  BUGFIX = 0
  DEV = nil

  VERSION = "v" + [MAJOR, MINOR, BUGFIX].join(".") + (DEV ? ".dev#{DEV}" : '')

end
