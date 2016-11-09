## Quickstart

```bash
git clone https://github.com/polytypic/elm-reactive-dom-with-lensed-state-toy.git
cd elm-reactive-dom-with-lensed-state-toy.git
elm-reactor
```

```bash
open http://localhost:8000/Main.elm
```

## WTF?

This is a **_toy_** example meant to illustrate how one can create composable
components using reactive dom and lensed state.  This is absolutely not a
serious implementation of the approach.

In the Elm architecture every component consists of several parts such as
`model`, `view`, `update`, `subscriptions` and `init`.  When you create
components that use other components, you need to manually compose each of those
parts separately.  You need to write a `view` function that calls the `view`
functions of child components and an `update` function that similarly calls the
`update` functions of child components and so on.  This means that one needs to
write quite a bit of boilerplate code to "compose" components.  Indeed, Elm
components are only composable by brute-force.

Now, with approach illustrated in this repository, each component essentially
consists only of a single function.

Instead of returning just VDOM, the single function returns "reactive" VDOM that
can automatically update when the underlying state changes.

State is represented in the form of reactive variables that can be read and
written and embedded into the reactive VDOM.  Component functions can take any
number of reactive variables as parameters.

This way most of the boilerplate required in the Elm architecture simply
vanishes.

Now, this is a **_toy_** implementation only meant to illustrate the way
components roughly look like with this approach.  Instead of using reactive
variables, this example simply uses lenses.  There are several more serious
implementations of this basic approach in various languages,
including
[JavaScript](https://github.com/calmm-js/documentation/blob/master/introduction-to-calmm.md) and
[F#](http://intellifactory.github.io/websharper.ui.next.samples/#home), that
have actually been used in production to write non-trivial applications.  This
shit works.
