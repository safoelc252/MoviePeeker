# MusicPeeker

## MVVM Architecture + ReactiveX
This project uses the MVVM architecture and the ReactiveX programming to take advantage of the following benefits:
- Testable compared to other known architecture (e.g. MVC, VIP, etc)
> Since the data and business logic(ViewModel) is separated with UI handling(View), it is easier to test than embedding everything in the UI handler.
- Cleaner code than conventional coding
> Again, because of function separation, the code is simpler to follow and clean to look at
- ReactiveX's sequencial programming handles end-to-end data handling in a single code block
> One of RxSwift/RxCocoa's awesome features is its ability to handle data and delegate handling of some UIKit elements (e.g. TableView, PickerViews, etc.) Rx's sequential handling also ensures the entire data-to-UI flow is handled well

