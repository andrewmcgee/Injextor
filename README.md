# Injextor

## Introduction

A simple way to handle dependency injection using property wrappers. It is available as a Swift Package or as a CocoaPod.

## Install

### Swift Package

Injextor can be added to an Xcode project as a swift package. Using the regular Xcode tool, search for the following URL:

https://github.com/andrewmcgee/Injextor

### Cocoapods

Injextor can be added to a project as a pod by adding the following to your `Podfile` under the correct target:

```
pod 'Injextor', '~> 0.3.0'
```

and then running the following command in your terminal:

```
pod install
```

## Background

Objects depend on other objects (dependencies). Often these are stored as instance properties. Rather than having the parent object initiaize its own dependencies, it is good practice to inject them from the outside. This package/pod provides a simple strategy to achieve this.

In sum, all dependecies must first be registered with a revolver. Objects can then have stored properies for any registered dependency (attributed by special property wrappers). Then when an object uses a dependency, the object (indirectly, through the property wrapper) asks the resolver to resolve an instance of the dependency and it is ready for use. Depending on the property wrapper used, these dependencies can be resolved as unique instances or shared singletons (classes only).

## Usage

There are two default resolvers provided. A `UniqueResolver` handles unique dependencies, whilst a `SingletonResolver` handles shared singletons.
For simplicity there is also a `Resolvers` singleton class, which stores default instances of the above as properties - one for unique dependencies and the other for singletons. (Please note: These can be overridden if you wish, or you can store you own `ResolverType` values in a place of your own choosing.)

The easiest way to register dependencies is to use the `Resolvers` class to register dependencies as follows:

```
Resolvers.shared.unique.register { Dependency() }
Resolvers.shared.singletons.register { SingletonDependency() }
```

Alternatively, if you are abstracting types behind protocols then remember to add `as <DependencyProtocol>`:

```
Resolvers.shared.unique.register { Dependency() as DependencyProtocol }
Resolvers.shared.singletons.register { SingletonDependency() as SingletonDependencyProtocol }
```

Now you can use these dependencies throughout the app using specially defined property wrapper attributes (where the values are initialised automatically with the previously registered values):

```
class SomeType {
    
    @Dependency var uniqueDependency: DependencyType
    @SingletonDependency var singletonDependency: Singleton<SingletonDependencyType>
    
}
```

Please note: Although unique and singleton dependencies are both registered in the same way, when they are accessed as dependencies singletons are automatically wrapped in the generic `Singleton` class. You can access the singleton value as follows:

```
singletonDependency.value
```

This difference provides the added benefit of being able to use both reference and value types as singletons.

If you want to use alternative `ResolverType` values from those owned by the `Resolvers` singleton class, then you can inject them into the property wrappers as follows:

```
@Dependency(resolver: someResolver) var uniqueDependency: DependencyType
```
