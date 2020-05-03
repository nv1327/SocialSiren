# SocialSiren
A social distancing tool that alerts the app user when they're in proximity of a sick person. Created using geolocation in Flutter, which livestreams GPS data to a Node.js server that uploads to MongoDB Atlas. It is a powerful application because it has the ability to instantly go cross-platform and everything is stored/backed up in the cloud.

Made for DistanceHacks from May 1-3, 2020 with no prior knowledge of REST APIs. My first virtual hackathon!

![Logo](https://cdn.discordapp.com/attachments/705882043023622225/706219223252205639/unknown.png)


## Tools Used:
- REST API with Node.js / Express
- Flutter
- MongoDB Atlas
- Figma


## Applications:
- To improve social distancing measures
- Provide awareness for disease spread
- User IDs are kept completely anonymous to prevent doxing/ostracision and no names are stored online


## Improvements For The Future:
- There is a lot of latency, especially for just two user apps. One of the major improvements we could make would be to only give the phone a warning when somebody is in proximity - in other words, they shouldn't be GET requesting the server every second, they should only be receiving data as a query when the server calculates a warning necessary. Server-side processing and the elimination of the "live-stream" aspect would help a lot, but it would be more complicated to implement and that's not the point of a hackathon in my opinion.
- Put the Node.js server on a DigitalOcean Droplet and give it more RAM/CPU. Also increase RAM/CPU for my MongoDB cluster.
- Improve the Node.js Schema model to only PATCH/PUT the longitude and latitude rather than the entire user schema.
- Improve anonymity measures and use further encryption like bcryptjs if needed
- Ideally, we'd want to decentralize and let each phone communicate/find distances through Bluetooth since at scale doing all of those calculations would be impossible. Calculating people within proximity for thousands of users could very well be optimized but our current model is simply a demo concept and is not meant for any sort of production or testing. Another advantage of Bluetooth would be more accurate distances rather than long. and lat. GPS positions.


## How To Use:
- Install Flutter and all of the necessary packages for it ("pub get" the things I have in my pubspec.yaml).
- Install Node.js and all of the necessary packages for it including npm (also check my package.json for npm packages to install)
- Create a MongoDB Atlas account and put the connection url in the index.js file in the server folder. Substitute it for "process.env.DB_CONNECT."
- Run the server and confirm it works by sending a GET request to "localhost:7000/api/"
- Then run both iOS and Android emulators in Android Studio or a platform of your choosing (You need a MacBook to run both on the same machine).
- Make sure their coordinates are kind of close, and try out the "Sick" and "Healthy" tabs. It should display a warning on the other person's phone if they're near a sick person.
- If you can, please fix my way of PATCH, GET, and calling functions every 1 second. I don't like the latency but that also might just be because I have a server and two emulators running on my local machine.
- Also, please make my server more efficient if possible, and break up that big Dart file I have for my frontend.

## Thoughts:
- To be quite honest, Firebase would have been much easier to implement in this case since all I would need to do is to drag and drop a .json file in and run the emulator once. Plus they already livestream their data and it's optimized for my type of project. However, that's not the point. It's about learning and it's about the challenge of constructing your own custom REST API in a limited time frame. Using Firebase won't help you build your own full-scale web/mobile app in the future, so why use it now? I also wanted to use MongoDB Atlas because it's pretty awesome and they were offering a prize for it.

### Contributions
- Flutter: nv1327
- Node.js / Express: nv1327
- MongoDB Atlas: nv1327
- Graphic Design: RiverRipple
