#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Portrait'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[no image name start end duration branch ref].freeze
    end

    def empty?
      itemLabel.to_s.empty? || itemLabel.include?("Vacant") || too_early?
    end

    # First part of name field is the rank
    def item
      name_cell.css('a/@wikidata').map(&:text)[1]
    end

    def itemLabel
      name_cell.css('a').map(&:text)[1]
    end

    def raw_end
      super.gsub('†', '')
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
