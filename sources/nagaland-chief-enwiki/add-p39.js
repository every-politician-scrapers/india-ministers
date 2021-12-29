module.exports = (id, startdate, enddate) => {
  qualifier = { }
  if(startdate) qualifier['P580'] = startdate
  if(enddate)   qualifier['P582'] = enddate

  return {
    id,
    claims: {
      P39: {
        value: 'Q55018648',
        qualifiers: qualifier,
        references: { P4656: 'https://en.wikipedia.org/wiki/List_of_chief_ministers_of_Nagaland' }
      }
    }
  }
}
