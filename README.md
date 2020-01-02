# documentation-as-code
This repository contains samples on how to include documentation in your code repositories. It's linked to my talk on the same subject and can be freely used as inspiration. But please know that although this way of working works for me, it's always a matter of style and preference. 

## Prerequisites
For the reStructuredText samples to work, you'll need to install Python and use pip (the Python installer) to install Sphynx.

```
pip install sphynx
```

For converting Markdown to reST, you can use pandoc: 

```
choco install pandoc
```

Adding in diagram support using plantUML: 

```
choco install plantuml --version 1.2019.11.20191021
choco install graphviz
```

Compiling the documentation can then be done by calling the PowerShell script: 

```
./build-docs.ps1
```

And magic will occur. If it doesn't though, feel free to leave an issue in the [Issues](https://github.com/jsiegmund/documentation-as-code/issues) section. 
