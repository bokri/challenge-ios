# iOS Challenge

## Screenshots

#### Success State in Light and Dark Appearances

![Alt text](/Screenshots/1.png?raw=true "Light Success")

![Alt text](/Screenshots/2.png?raw=true "Dark Success")

#### Loading State in Light and Dark Appearances with a Lottie animation

![Alt text](/Screenshots/3.png?raw=true "Light Loading")

![Alt text](/Screenshots/4.png?raw=true "Dark Loading")

#### Error State in Light and Dark Appearances with a Lottie animation

![Alt text](/Screenshots/5.png?raw=true "Light Error")

![Alt text](/Screenshots/6.png?raw=true "Dark Error")

#### Splash Screen

![Alt text](/Screenshots/7.png?raw=true "Splash Screen")

## Coding Test

#### *Brief*

We would like you to recreate the bank list in a brand new iOandS Swift project.

API Bank List Endpoint Documentation link : **https://docs.bridgeapi.io/v2018-06-15/reference#list-banks**  
Please use the following API url: **https://sync.bankin.com/banks**  
API client id: *Will be given*  
API client secret: *Will be given*  

When running, the application should list all banks, separated by countries. We would appreciate to see the current user local country section on top. You’re completely free to design your model based on API JSON data.

The code must be well architectured, and use some clean code best practice.  Regarding the design, you are free to do it however you want to. Don’t worry about the final execution, the most important is too check how you’re thinking and how you dive into new project. Keep in mind your best naming practices.

We are not really found of 100% coverage but well-written and well-placed unit tests would be really appreciated.

The exercise is not timed but please don't spend more than few hours on.  

Once you're done, please send your **entire project/workspace folder** to the given email with the following syntax: **<firstname_lastname_ios_challenge>**. Feel free to add any notes, explanations or/and feedback.  

I'm available to the same mail adress for any questions or encountered issues. **Don't hesitate**.  

#### *Bonus*

The application can run offline which means all remote fetched data are saved locally.

#### *Technologies*

We don’t force to use any specific technology, framework or library but here are listed used one by layer:

- Dependency Management -> Cocoapods
- Networking -> AFNetworking/Alamofire
- UI -> Autolayout and programmatic NSLayoutConstraint
- Persistence -> CoreData, UserDefault, SAMKeychain
