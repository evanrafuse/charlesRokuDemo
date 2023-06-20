This Project is for the demonstration and learning of how to use Charles with Roku apps. Before starting this you need Charles (obviously), nodeProxy, and you need to add a file to the assets folder with your computer's local IP and the API keys.

A couple quick settings: in Proxy> Proxy Settings have the Port set to 8888, support HTTP/2 and enable transparent HTTP proxying, and have macOS proxy off.



Rewrites:
For the rewrites example I used the CatFacts API. The project is sending an unsecured request to catfacts, HTTP. Charles has to be set to rewrite it to HTTPS. To do this, go to Tools>Rewrite.. and click Add. This is shown in the screenshot, Charles Rewrite.png. You can actually rewrite the body in this way, and it's a simple way to send back fake data. In Charles Rewrite 2.png, you can see a rewrite that sends back a JSON with changed data.



Map Local:
For this one we're actually going to map the response to a local file, and we'll be using the OpenWeather API. This is convenient for longer JSONs that can't be crammed in the rewrite. The first step is to enable SSL Proxying. in Charles go to Proxy>SSL Proxying Settings, and click Add on the Include side. In the dialog, add the url to proxy (in this case "api.openweathermap.org"). Leave the port field empty.

Next, go to Tools>Map Local and click Add. Enter the url in the Host field, and set the Protocol to HTTPS. Map to the fakeWeather.json file in this project.

Finally, you need to have a proxy server somewhere. I use Jean-Guy's nodeProxy solution, I only need to enter the project folder in terminal, "npm install", and "node Index.js".

Now if you click on "Weather" in the app you should get data for Vancouver instead of Halifax.



Map Remote:
This is similar but simpler because we're just redirecting really, no nodeProxy. Go to Tools>Map Remote and click Add. Currently the app is calling google, but we're going to redirect it to the agify API and guess how old I am. You can see the options used in Charles Map Remote.png, but by now you can probably guess what to put in.