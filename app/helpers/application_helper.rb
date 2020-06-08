# frozen_string_literal: true

module ApplicationHelper
  def highlight_relevant(text)
    text.to_s.gsub(/("location"=>\[.*?\])/) { "<mark class=\"has-background-success\">#{$&}</mark>" }.gsub(/("set-cookie"=>\[.*?\])/) { "<mark class=\"has-background-warning\">#{$&}</mark>" }
  end
end
