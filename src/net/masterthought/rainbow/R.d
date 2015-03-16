module net.masterthought.rainbow.r;

import std.array;
import std.conv;
import std.stdio;
import std.string;
import std.range;
import std.algorithm;

R rainbow(string s){
  return R.bow(s);
}

enum Effect{
	bold = "1",
	dim = "2",
	underlined = "4",
	blink = "5",
	inverted = "7",
	hidden = "8"
}

private static genColorEnums(string colorType){
	string[] colorList;
	colorList ~= "enum " ~ colorType ~ "{";
	if(colorType == "FgColor"){
		colorList ~= "original = \"39\",
	black = \"30\",
	red = \"31\",
	green = \"32\",
	yellow = \"33\",
	blue = \"34\",
	magenta = \"35\",
	cyan = \"36\",
	lightGray = \"37\",
	darkGray = \"90\",
	lightRed = \"91\",
	lightGreen = \"92\",
	lightYellow = \"93\",
	lightBlue = \"94\",
	lightMagenta = \"95\",
	lightCyan = \"96\",
	white = \"97\",";
	foreach(color ; iota(0,257)){
      colorList ~= "c" ~ to!string(color) ~ " = " ~ "\"38;5;" ~ to!string(color) ~ "\",";
	}
	} else {
		colorList ~= "original = \"49\",
	black = \"40\",
	red = \"41\",
	green = \"42\",
	yellow = \"43\",
	blue = \"44\",
	magenta = \"45\",
	cyan = \"46\",
	lightGray = \"47\",
	darkGray = \"100\",
	lightRed = \"101\",
	lightGreen = \"102\",
	lightYellow = \"103\",
	lightBlue = \"104\",
	lightMagenta = \"105\",
	lightCyan = \"106\",
	white = \"107\",";
	foreach(color ; iota(0,257)){
      colorList ~= "c" ~ to!string(color) ~ " = " ~ "\"48;5;" ~ to!string(color) ~ "\",";
	}
	}
	colorList ~= "}";
	return colorList.join("");
}

mixin(genColorEnums("FgColor"));
mixin(genColorEnums("BgColor"));

class R{

private string content;
private string[] codes = ["\033["];

this(string content){
  this.content = content;
}

// makes .red and .onRed etc...
private static genColors(string colorType){
     string[] colorList;
	 foreach(color ; [__traits(allMembers, FgColor)]){
	  string methName = colorType == "FgColor" ? color : "on" ~ to!string(color[0]).capitalize() ~ to!string(color[1..$]);
      colorList ~= "@property public R " ~ methName ~ "(){ codes ~= " ~ colorType ~ "." ~ color ~ " ; codes ~= \";\" ; return this;}";
    }
    return colorList.join("");
}

// makes .blink effects etc
private static genEffects(){
     string[] effectList;
	 foreach(effect ; [__traits(allMembers, Effect)]){
      effectList ~= "@property public R " ~ effect ~ "(){ codes ~= Effect." ~ effect ~ " ; codes ~= \";\" ; return this;}";
    }
    return effectList.join("");
}

mixin(genColors("FgColor"));
mixin(genColors("BgColor"));
mixin(genEffects());

public static R bow(string content){
	return new R(content);
}

 public R fg(FgColor color){
   codes ~= color;
   codes ~= ";";
   return this;
 }

  public R bg(BgColor color){
  codes ~= color;
  codes ~= ";";
   return this;
 }

  public R ef(Effect effect){
  codes ~= effect;
  codes ~= ";";
   return this;
 }

  override public string toString(){
  	if(codes[$-1] == ";"){
  		codes.popBack;
  	}
 	codes ~= "m" ~ content ~ "\033[0m";
 	//writeln(codes);
    return codes.join("");
 }

 string opBinary(string op)(R rhs)
{
    static if (op == "~"){
     return this.toString() ~ rhs.toString();
    }
    else static assert(0, "Operator "~op~" not implemented");
}

 string opBinaryRight(string op)(string lhs)
{
    static if (op == "~"){
     return lhs ~ this.toString();
    }
    else static assert(0, "Operator "~op~" not implemented");
}

public void logo(){
  writeln("");
  writeln(R.bow("╦═╗").red.onBlack, R.bow("╔═╗").c208.onBlack, R.bow("╦").c221.onBlack, R.bow("╔╗╔").green.onBlack, R.bow("╔╗").cyan.onBlack, R.bow(" ╔═╗").c57.onBlack, R.bow("╦ ╦").c99.onBlack);
  writeln(R.bow("╠╦╝").red.onBlack,R.bow("╠═╣").c208.onBlack, R.bow("║").c221.onBlack, R.bow("║║║").green.onBlack, R.bow("╠╩╗").cyan.onBlack, R.bow("║ ║").c57.onBlack, R.bow("║║║").c99.onBlack);
  writeln(R.bow("╩╚═").red.onBlack,R.bow("╩ ╩").c208.onBlack, R.bow("╩").c221.onBlack, R.bow("╝╚╝").green.onBlack, R.bow("╚═╝").cyan.onBlack, R.bow("╚═╝").c57.onBlack,R.bow("╚╩╝").c99.onBlack);
  writeln("");
}

}

