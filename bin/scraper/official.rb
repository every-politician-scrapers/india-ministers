#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.views-field-title').text.tidy
    end

    def position
      return 'Prime Minister' if level == 'Prime Minister'

      noko.css('.views-field-field-ministries li').map(&:text).map(&:tidy).join('|').gsub('Ministry', 'Minister').split('|')
    end

    def level
      noko.xpath('preceding::h2[1]').text.tidy
    end
  end

  class Members
    def member_items
      super.select { |mem| ['Prime Minister', 'Cabinet Ministers'].include? mem.level }
    end

    def member_container
      noko.css('.view-union-council-of-ministers td')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
