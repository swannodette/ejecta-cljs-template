## EjectaCLJS

Launch XCode and create a iOS Single View Application project. If you
named your project `ejecta-test` your application should be called
`EjectaTest`. From the root of your project it should go into a
directory called `ObjC`.

Initialize your project:

```shell
script/init
```

Open your project:

```
open ObjC/ProjectName/ProjectName.xcworkspace
```

Use the *File > Add Files ...* menu option to add the newly created
`App` directory containing `index.js` to your project.

Build the application (Command-R).

Start the REPL:

```shell
script/repl
```

At the REPL try the following series of interactions:

```shell
(def canvas (.getElementById js/document "canvas"))
(def ctx (.getContext canvas "2d"))
(set! (.-fillStyle ctx) "#ff0000")
(.fillRect ctx 50 50 100 100)
```

Troubleshooting
==============
If you run `script/init` and you get
`script/init: line 3: pod: command not found`, you need to
install CocoaPods: `brew install Caskroom/cask/cocoapods`.
