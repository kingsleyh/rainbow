# Rainbow

Pretty ANSI Colors for your terminal output.

![logo]
(https://raw.githubusercontent.com/kingsleyh/rainbow/master/.README/rainbow_logo.png)

## Install

using DUB:

```
  	"dependencies": {
          "rainbow":"~master"
	}
```

## Supported Platforms

* OSX
* Unix

Windows support coming soon (maybe)

## Usage

There are 3 items supported:

* foreground color
* background color
* effects

```
import net.masterthought.rainbow.r;
import std.stdio;

void main(){
  writeln("Hello".rainbow.white.onCyan, " World!".rainbow.cyan.onWhite);
}

```
produces:

![hello world]
(https://raw.githubusercontent.com/kingsleyh/rainbow/master/.README/rainbow_hw.png)

### short cuts

You can use .colorName for foreground and .onColorName for background e.g.

```
 writeln("Hello".rainbow.red.onWhite);
````

You can use effects in the same way

```
  writeln("Hello".rainbow.green.onBlack.underlined.blink);
```

### long hand

There are 3 methods you can call:

* fg(FgColor color)
* bg(BgColor color)
* ef(Effect effect)

```
  writeln(R.bow(" Hello ").fg(FgColor.green).bg(BgColor.c221).ef(Effect.underlined));
```

### Basic colors (foreground and background)

Colours are all on either the FgColor enum or the BgColor enum:

```
 FgColor.red
 BgColor.cyan
```
You can also use any of the colors from 0 to 255 (if supported on your system)

```
FgColor.c99
BgColor.c208
```

It's easy with shortcuts:

```
  writeln("hello".rainbow.c33.onC45);
```

note the upcased C when using the on notation.

The following basic colors are supported for foreground and background:

* original
* black
* red
* green
* yellow
* blue
* magenta
* cyan
* lightGray
* darkGray
* lightRed
* lightGreen
* lightYellow
* lightBlue
* lightMagenta
* lightCyan
* white

### Effects

The following effects are supported:

* bold
* dim
* underlined
* blink
* inverted
* hidden

## References

Read this site to understand which colors and effects are available:

[http://misc.flogisoft.com/bash/tip_colors_and_formatting](http://misc.flogisoft.com/bash/tip_colors_and_formatting)
