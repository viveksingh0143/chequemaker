# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ChequeMaker::Application.initialize!

Time::DATE_FORMATS[:cheque_date] = "%d%m%Y"
