const fs = require('fs');
let rawmeta = fs.readFileSync('meta.json');
let meta = JSON.parse(rawmeta);

module.exports = function () {
  return `SELECT DISTINCT ?state ?stateLabel ?position ?positionLabel ?person ?personLabel ?start ?abolished
         (STRAFTER(STR(?held), '/statement/') AS ?psid)
  WHERE {
    ?position wdt:P279+ wd:Q3537705 .
    OPTIONAL { ?position wdt:P1001 ?state }

    OPTIONAL {
      ?person wdt:P31 wd:Q5 ; p:P39 ?held .
      ?held ps:P39 ?position ; pq:P580 ?start .
      FILTER NOT EXISTS { ?held pq:P582 ?end }
    }

    SERVICE wikibase:label { bd:serviceParam wikibase:language "en".  }
  }
  ORDER BY ?stateLabel ?start`
}
