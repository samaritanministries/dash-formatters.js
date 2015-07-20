describe "Foo", ->

  it "exists", ->
    foo = new DashFormatters.Foo()
    expect(foo.helloWorld()).toEqual("Hello World")
