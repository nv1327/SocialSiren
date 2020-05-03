# SocialSiren
A social distancing tool that alerts the app user whether they're in proximity of a sick person. Created using geolocation in Flutter, which livestreams GPS data to a Node.js server that uploads to MongoDB Atlas. It is a powerful application because it has the ability to instantly go cross-platform and everything is stored/backed up in the cloud.

Made for DistanceHacks from May 1-3, 2020. My first virtual hackathon!

![Logo](https://cdn.discordapp.com/attachments/705882043023622225/706219223252205639/unknown.png)


## Tools used:
- REST API with Node.js / Express
- Flutter
- MongoDB Atlas
- Figma


## Applications:
- To improve social distancing measures
- Provide awareness for disease spread
- User IDs are kept completely anonymous to prevent doxing/ostracision


## Improvements for the future:
- There is a lot of latency, especially for two apps. One of the major improvements we could make would be to only give the phone a warning when somebody is in proximity - in other words, they shouldn't be GET requesting the server every second, they should only be receiving data as a query when the server calculates a warning necessary. Server-side processing and the elimination of the "live-stream" aspect would help a lot, but it would be more complicated to implement and that's not the point of a hackathon in my opinion.
- Improve the Node.js Schema model to only PATCH/PUT the longitude and latitude rather than the entire user schema.
- Improve anonymity measures and use further encryption like bcryptjs if needed
- Ideally, we'd want to decentralize and let each phone communicate/find distances through Bluetooth since at scale doing all of those calculations would be impossible. Calculating people within proximity for thousands of users could very well be optimized but our current model is simply a demo concept and is not meant for any sort of production or testing. Another advantage of Bluetooth would be more accurate distances rather than long. and lat. GPS positions.


### Contributions
- Flutter: nv1327
- Node.js / Express: nv1327
- MongoDB Atlas: nv1327
- Graphic Design: RiverRipple
