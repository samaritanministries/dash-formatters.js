namespace("DashFormatters")

class DashFormatters.Date

  constructor: (@options={}) ->
    @referenceDate = moment(@options.referenceDateAsString)

  format: (dateAsString) ->
    date = moment(dateAsString)
    if date.isValid()
      @formatDateWithDuration(date, @durationBetweenReferenceDate(dateAsString))
    else
      ""

  formatDateWithDuration: (date, duration)->
    if duration.asSeconds() < 10
      "Just now"
    else if duration.asMinutes() < 1
      "A few seconds ago"
    else if duration.asHours() < 1
      @minutesAgoMessage(duration)
    else if duration.asDays() < 1
      @hoursAgoMessage(duration)
    else
      date.format("M/DD/YYYY")

  minutesAgoMessage: (duration) ->
    numberOfMinutes = Math.floor(duration.asMinutes())
    switch numberOfMinutes
      when 1 then "1 minute ago"
      else "#{numberOfMinutes} minutes ago"

  hoursAgoMessage: (duration) ->
    numberOfHours = Math.floor(duration.asHours())
    switch numberOfHours
      when 1 then "1 hour ago"
      else "#{numberOfHours} hours ago"

  durationBetweenReferenceDate: (dateAsString) ->
    moment.duration(@referenceDate.diff(dateAsString))
