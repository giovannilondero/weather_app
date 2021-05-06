- [App architecture](#app-architecture)

# App architecture

All the flutter's app code is contained in the lib/ folder.

## Application folder

The main logic of the app, glues together infrastructure and presentation, all controlled by the domain.

## Domain folder

The domain of the app; contains the models, the protocol (eventually), entities, value objects. Must not have any dependency from other parts of the app.

## Infrastructure folder

Contains the repositories, everything that should communicate with external entities (e.g. DB, storage, APIs).

## Presentation folder

Contains the actual widgets, everything that's visibile.
Here would things like router too, even though it's not present in this app.
