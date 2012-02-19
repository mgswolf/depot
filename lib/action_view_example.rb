require "action_view"
require "action_view/helpers"
include ActionView::Helpers::DateHelper
puts distance_of_time_in_words_to_now(Time.parse("December 25"))
