function init()
    m.feedbackLbl = m.top.FindNode("feedbackLbl")
    m.top.observeFieldScoped("response", "parseResponse")
end function

sub parseResponse()
    ? "Here's the response: " m.top.response
    response = m.top.response
    if invalid <> response.fact
        m.feedbackLbl.text = response.fact
    else if invalid <> response.weather
        m.feedbackLbl.text = "Weather for: " + response.name + " is " + response.weather[0].main
    else if invalid <> response.city
        m.feedbackLbl.text = "Current location is: " + response.city + ", " + response.state_prov + ", " + response.country_name
    else if invalid <> response.age
        m.feedbackLbl.text = response.name + " is " + Str(response.age) + " years old"
    end if
end sub