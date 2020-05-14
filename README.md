# RWReview

I decided  to submit for review part of project I’m working on now. It has been written on `Swift`. Also I have chosen to make UI using `SwiftUI` framework and `MVVM` as architecture pattern. In repo you can find 2 scenes (`Employees` and `AddEmployee`), networking part and unit-tests.

Why I have chosen this part of project? The reason is I use a lot of technics (both standard and hand-maded) and patterns which I use in other projects. That’s why I want you to check if I do this in right way, if I use proper patterns in the necessary places. Perhaps, there is something I can do in a simpler way. I’m not completely confident about some solutions, that’s why I would like to receive review from you in order to fix some mistakes and not to repeat them  on other projects.

As I’m not a native speaker I have a lack of confidence in naming.

Below I would like to tell you in more detail about what I do and what I use and what kind of feedback I would like to get.
I divide my topic into 4 parts:

## Networking

Here are `Environment`, `Endpoint`, `RepositoryProvider`, `WebRepository`, `MemoryRepository`, `WebRepositoryError`.

`Environment` is a wrapper around `Alamofire` which enables to choose one of 3 types: `Mock`, `Development`, `Production`.

Types `Development` and `Production` are almost identical, the only difference is `baseURL`.

Type `Mock` I use when I don’t have access to the Internet, when server is not reachable  or it is not launched yet. Availability of such type is very helpful when iOS and Backend development are being done simultaneously and helps to avoid blockers.
`RepositoryProvider` has inner protocol where methods for the implementation of `WebRepository` and `MemoryRepository` are described. Also code that defines which repository to provide depending on the selected `Environment` type. If `Development` or `Production` type is chosen then `WebRepository` ( in which there will be calls of real requests and return of real data) will be provided . If `Mock` is chosen then `MemoryRepository` will be provided in which requests are faked and prepared in advanced data will return. Server response  parsing is done in the models with the help of 3party `SwiftyJSON`. Server errors processing is done in `WebRepositoryError`.

I would like to know what do you think about this implementation of Networking? I think I used here `Repository` and `DependencyInversion` patterns. Is it true, does I make it in proper way. Is it good strategy to handle networking errors as I do it in `WebRepositoryError` and parse JSON in model init?

## Employees scene

On this scene I fetch the employees list from the server and split it into 2 parts ( active employees and dismissed employees)
UI part is implemented in `EmployeesView` class (and in additional `EmployeesListRow` and `EmployeesSectionHeader` classes). Business logic is implemented in `EmployeesViewModel`.
In `EmployeesView` you can find technic which I named `emptyDataView`. This view is shown when employees array is empty.
I have implemented it using `Factory` pattern to avoid duplicate init code of this view in every scene where I need it. I would like to know your opinion about this part.

## AddEmployee scene

This is a scene where user can create new employee. User needs to fill text fields, pass validation and send data to server. I decided to skip UI part (nothing interesting there, just stack of text fields) . All validations are implemented in the `Validator` class. I create `EmoployeeEncodableModel` object with filled data, this oblect implement `Encodable` protocol and send it to the server as json. I cannot use old `Employee` class, because I need to send data to server with another structure, than I receive from server. Is it any way I can use the same model for sending and receiving data? If there is no, how should I name them.

When I receive success from server I call `employeeCreated` method from `AddEmployeeDelegate` to notify `Employees` scene that a new employee has been created.

Here I would like to know your thoughts about my implementation of `Validator` and about naming of delegate methods.

## Testing

Could you please take a look on how I write tests and create test doubles?

For example, I have created `PhoneNumberKitProtocol` only because `PhoneNumberKit` is `final` class and I can’t inherit from it to make test double.
Without testing, creating of this protocol doesn’t have any sense. Is it ok?



I hope this text  will help you easier to understand the code I’ve submitted for review and give you more understanding what kind of feedback I’m looking for.


Thank you in advance and happy homestaying 😁
