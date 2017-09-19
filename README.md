# SnakeCoin
Haxe implementation of SnakeCoin.py

This is a port of
[snakecoin](https://gist.github.com/aunyks/47d157f8bc7d1829a729c2a6a919c173) to
Haxe. All credit to [@aunyks](https://github.com/aunyks) who wrote the original.

I'm working on this to learn more about what a blockchain is.

This branch uses nodejs and tink_web.  
Install hxnodejs and tink_web in the command prompt with
```
haxelib install hxnodejs
haxelib git tink_web https://github.com/haxetink/tink_web.git
```

After compiling the source, run SnakeCoin with
```
node bin/snakecoin.js
```

To create a transaction, direct your browser to  
http://localhost:5000/txion  
You'll see an input form for the transaction data.

Mine a block:  
http://localhost:5000/mine  

Get the list of all blocks:  
http://localhost:5000/blocks


