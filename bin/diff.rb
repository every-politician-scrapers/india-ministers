#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'
require 'every_politician_scraper/scraper_data'
require 'pry'

# Standardise data
class Comparison < EveryPoliticianScraper::Comparison
  REMAP = {
  }.freeze

  CSV::Converters[:remap] = lambda { |val, field|
    return (REMAP[field.header] || {}).fetch(val, val) unless field.header == :name

    MemberList::Member::Name.new(
      full:     val.split(',', 2).reverse.join(' ').tidy,
      prefixes: %w[Shri Dr. Prof. Smt.],
    ).short
  }

  def wikidata_csv_options
    { converters: [:remap] }
  end

  def external_csv_options
    { converters: [:remap] }
  end
end

diff = Comparison.new('data/wikidata.csv', 'data/official.csv').diff
puts diff.sort_by { |r| [r.first.to_s, r[1].to_s] }.reverse.map(&:to_csv)
