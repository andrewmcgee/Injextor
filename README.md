# Injextor

## Introduction

A simple way to handle dependency injection using property wrappers. It is available as a Swift Package or as a CocoaPod.

## Install

### Swift Package

Injextor can be added to an Xcode project as a swift package. Using the regular Xcode tool, search for the following URL:

https://github.com/andrewmcgee/Injextor

### Cocoapods

Injextor can be added to a project as a pod by adding the folloing to your `Podfile` under the correct target:

```
pod 'Injextor', '~> 0.1.0'
```

and then running the following command in yout terminal:

```
pod install
```

## Usage

To use dependencies they must first me registered with a resolver (`ResolverType`), usually when the application launches.

The `Resolvers` singleton class stores 2 x default `ResolverType` values as properties (one for unique dependencies and the other for singletons). 
(Please note: These can be overridden if you you wish, or you can store you own `ResolverType` values in a place of your own choosing.)

Use the `ResolverType` values belonging to the `Resolvers` class to register dependencies:

```
Resolvers.shared.unique.register(Dependency())
Resolvers.shared.singletons.register(SingletonDependency())
```

Alternatively, if you are abstracting types behind protocols then remember to add `as DependencyType`:

```
Resolvers.shared.unique.register(Dependency() as DependencyType)
Resolvers.shared.singletons.register(SingletonDependency() as SingletonDependencyType)
```

Now you can use these dependencies throughout the app (where the values are initialised automatically with the previously registered values):

```
class SomeType {
    
    @Dependency var uniqueDependency: DependencyType
    @SingletonDependency var singletonDependency: SingletonDependencyType
    
}

```
(Please note: If you want to use alternative `ResolverType` values from those `Resolvers`, then you can inject them into the property wrappers as follows:

```
@Dependency(resolver: someResolver) var uniqueDependency: DependencyType
```
