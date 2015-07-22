describe "Date", ->

  format = (options) ->
    new DashFormatters.Date(
      referenceDate: options.referenceDate
    ).format(options.date)

  describe "The date format with standard date input", ->

    it "returns the date for a date a few days in the past", ->
      formattedDate = format
        date: "2014-03-15T14:36:35.153+00:00"

      expect(formattedDate).toEqual("3/15/2014")

    it "is empty for an empty date", ->
      formattedDate = format
        date: null

      expect(formattedDate).toEqual("")

    it "is 'just now' for a date that occurred very recently", ->
      formattedDate = format
        referenceDate: "2014-03-15T14:36:35.000+00:00"
        date: "2014-03-15T14:36:25.001+00:00"

      expect(formattedDate).toEqual("Just now")

    it "is 'a few seconds ago' for a date that occurred recently", ->
      formattedDate = format
        referenceDate: "2014-03-15T14:36:35.000+00:00"
        date: "2014-03-15T14:36:25.000+00:00"

      expect(formattedDate).toEqual("A few seconds ago")

    it "is 'a few seconds ago' for a date at the top of the cutoff", ->
      formattedDate = format
        referenceDate: "2014-03-15T14:36:35.000+00:00"
        date: "2014-03-15T14:35:35.001+00:00"

      expect(formattedDate).toEqual("A few seconds ago")

    it "is '1 minute ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:22:35.050+00:00"
        date: "2016-04-25T15:20:55.050+00:00"

      expect(formattedDate).toEqual("1 minute ago")

    it "is '59 minutes ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:22:35.050+00:00"
        date: "2016-04-25T14:22:35.051+00:00"

      expect(formattedDate).toEqual("59 minutes ago")

    it "is '45 minutes ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: "2016-04-25T14:45:35.050+00:00"

      expect(formattedDate).toEqual("45 minutes ago")

    it "is '1 hour ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: "2016-04-25T14:30:35.050+00:00"

      expect(formattedDate).toEqual("1 hour ago")

    it "is '24 hours ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: "2016-04-24T15:30:35.051+00:00"

      expect(formattedDate).toEqual("23 hours ago")

    it "is '5 hours ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: "2016-04-25T10:30:35.050+00:00"

      expect(formattedDate).toEqual("5 hours ago")

    it "is '2 hours ago'", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: "2016-04-25T13:30:35.050+00:00"

      expect(formattedDate).toEqual("2 hours ago")

  describe "Using Date objects", ->

    it "formats the date when the date is a Date object", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: new window.Date("2016-04-25T13:30:35.050+00:00")

      expect(formattedDate).toEqual("2 hours ago")

    it "formats the date when the referenceDate is a Date object", ->
      formattedDate = format
        referenceDate: new window.Date("2016-04-25T15:30:35.050+00:00")
        date: "2016-04-21T13:30:35.050+00:00"

      expect(formattedDate).toEqual("4/21/2016")

  describe "The date format with non-standard input", ->

    it "is a full day ago", ->
      formattedDate = format
        referenceDate: "2012-04-25"
        date: "2012-04-24"

      expect(formattedDate).toEqual("4/24/2012")

    it "is 'just now' for a date in the future", ->
      formattedDate = format
        referenceDate: "2016-04-25T15:30:35.050+00:00"
        date: "2016-05-25T13:30:35.050+00:00"

      expect(formattedDate).toEqual("Just now")

    it "parses an ambiguous date", ->
      formattedDate = format
        date: "11/11/11"

      expect(formattedDate).toEqual("11/11/2011")

    it "returns nothing for a bad date", ->
      formattedDate = format
        date: "foobar"

      expect(formattedDate).toEqual("")
