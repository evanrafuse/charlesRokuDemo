function init()

    ? "IN MAINSCENE: Initiating Main Secene"

    m.keys = ParseJson(ReadAsciiFile("pkg:/assets/keys.json"))
    m.top.observeFieldScoped("lastCall", "onCall")
    m.btnGroup = m.top.FindNode("btnGroup")
    m.btnGroup.buttons = ["Catfacts", "Weather", "Location", "Age"]
    m.btnGroup.observeFieldScoped("buttonSelected", "onButtonSelected")
    m.btnGroup.SetFocus(true)

end function

sub onButtonSelected(event)
    index = event.getData()
    btnPressed = m.btnGroup.buttons[index]
    m.top.lastCall = btnPressed
    ? "Button selected! "; btnPressed

    url = ""
    if btnPressed = "Catfacts"
        url = "http://catfact.ninja/fact"
    else if btnPressed = "Weather"
        ' url = "http://192.168.8.193/https://api.openweathermap.org/data/2.5/weather?q=Halifax,CA&appid=6b8afb74e995c5015cfcfb7d0796fca2&units=metric"
        url = "http://"+m.keys.localIp+"/https://api.openweathermap.org/data/2.5/weather?q=Halifax,CA&appid="+m.keys.openWeatherApiKey+"&units=metric"
    else if btnPressed = "Location"
        url = "https://api.ipgeolocation.io/ipgeo?apiKey="+m.keys.iPGeolocationApiKey
    else if btnPressed = "Age"
        url = "http://google.com"
    else
        ? "Button Pressed: "; btnPressed
    end if
    callApi(url)
end sub

sub callApi(url)
    ? "IN MAINSCENE: About to call API at -> "; url
    m.feed_task = createObject("roSGNode", "load_feed_task")
    m.feed_task.observeField("response", "onFeedResponse")
    m.feed_task.url = url
    m.feed_task.control = "RUN"
end sub

sub onFeedResponse(obj)
    response = obj.getData()
    m.responseData = parseJSON(response)
    ? "Response received: "; m.responseData
end sub

sub onCall()
    ? "lastCall changed!"
end sub