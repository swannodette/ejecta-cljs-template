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
open Object/ProjectName/ProjectName.xcworkspace
```

Use the *File > Add Files ...* menu option to add the newly created
`App` directory containing `index.js` to your project.

Build the application (Command-R).

Start the REPL:

```shell
script/repl
```
