# Movies App

This is a sample movie app based on TheMovieDB API implementing the viper architecture.

The following topics were covered:

- Modules implementations based on protocols
- Comunication between layers were made through plain delegates for sake of simplicity (no RxSwift) except on the networking side
- Unit testing coverage on viper modules

Minimal dependencies used in the project for easier implementation and to avoid some boilerplate/repetitive code:

- Alamofire
- RxSwift
- SnapKit
- Kingfisher
