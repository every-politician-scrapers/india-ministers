#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  # decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Lieutenant Governors'
  end

  # TODO: make this easier to override
  def holder_entries
    noko.xpath("//h2[.//span[contains(.,'#{header_column}')]][last()]//following-sibling::ol//li[a]")
  end

  class Officeholder < OfficeholderBase
    def combo_date?
      true
    end

    def raw_combo_date
      noko.xpath('text()').text.split(',').reject { |txt| txt.include? 'acting' }.last.tidy
    end

    def name_cell
      noko.css('a')
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
