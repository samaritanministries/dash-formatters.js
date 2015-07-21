describe "Date", ->

  format = (options) ->
    new DashFormatters.Date(
      referenceDateAsString: options.referenceDateAsString
    ).format(options.dateAsString)

  describe "The date format with standard date input", ->

    it "returns the date for a date a few days in the past", ->
      formattedDate = format
        dateAsString: "2014-03-15T14:36:35.153+00:00"

      expect(formattedDate).toEqual("3/15/2014")

    it "is empty for an empty date", ->
      formattedDate = format
        dateAsString: null

      expect(formattedDate).toEqual("")

    it "is 'just now' for a date that occurred very recently", ->
      formattedDate = format
        referenceDateAsString: "2014-03-15T14:36:35.000+00:00"
        dateAsString: "2014-03-15T14:36:25.001+00:00"

      expect(formattedDate).toEqual("Just now")

    it "is 'a few seconds ago' for a date that occurred recently", ->
      formattedDate = format
        referenceDateAsString: "2014-03-15T14:36:35.000+00:00"
        dateAsString: "2014-03-15T14:36:25.000+00:00"

      expect(formattedDate).toEqual("A few seconds ago")

    it "is 'a few seconds ago' for a date at the top of the cutoff", ->
      formattedDate = format
        referenceDateAsString: "2014-03-15T14:36:35.000+00:00"
        dateAsString: "2014-03-15T14:35:35.001+00:00"

      expect(formattedDate).toEqual("A few seconds ago")

    it "is '1 minute ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:22:35.050+00:00"
        dateAsString: "2016-04-25T15:20:55.050+00:00"

      expect(formattedDate).toEqual("1 minute ago")

    it "is '59 minutes ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:22:35.050+00:00"
        dateAsString: "2016-04-25T14:22:35.051+00:00"

      expect(formattedDate).toEqual("59 minutes ago")

    it "is '45 minutes ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:30:35.050+00:00"
        dateAsString: "2016-04-25T14:45:35.050+00:00"

      expect(formattedDate).toEqual("45 minutes ago")

    it "is '1 hour ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:30:35.050+00:00"
        dateAsString: "2016-04-25T14:30:35.050+00:00"

      expect(formattedDate).toEqual("1 hour ago")

    it "is '24 hours ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:30:35.050+00:00"
        dateAsString: "2016-04-24T15:30:35.051+00:00"

      expect(formattedDate).toEqual("23 hours ago")

    it "is '5 hours ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:30:35.050+00:00"
        dateAsString: "2016-04-25T10:30:35.050+00:00"

      expect(formattedDate).toEqual("5 hours ago")

    it "is '2 hours ago'", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:30:35.050+00:00"
        dateAsString: "2016-04-25T13:30:35.050+00:00"

      expect(formattedDate).toEqual("2 hours ago")

  describe "The date format with non-standard input", ->

    it "is a full day ago", ->
      formattedDate = format
        referenceDateAsString: "2012-04-25"
        dateAsString: "2012-04-24"

      expect(formattedDate).toEqual("4/24/2012")

    it "is 'just now' for a date in the future", ->
      formattedDate = format
        referenceDateAsString: "2016-04-25T15:30:35.050+00:00"
        dateAsString: "2016-05-25T13:30:35.050+00:00"

      expect(formattedDate).toEqual("Just now")

    it "returns nothing for a bad date", ->
      formattedDate = format
        dateAsString: "foobar"

      expect(formattedDate).toEqual("")
