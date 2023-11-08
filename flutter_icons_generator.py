import os
import re

# Relatively to "lib"
dartIconsPath = 'presentation/icons'

iconsDirectory = 'assets/icons/'

# Change string to lowerCamelCase
def to_camel(word):

    x = re.split(r'[-_\s]', word)
    result = ''

    for i in range(len(x)):
        if i == 0:
            result += x[i]
            continue
        else:
            result += x[i].title()
            continue

    return result

# Change string to to_snake_case
def to_snake_case(name):
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    name = re.sub('__([A-Z])', r'_\1', name)
    name = re.sub('([a-z0-9])([A-Z])', r'\1_\2', name)
    return name.lower()

# Rename assets and check special characters
def rename_files():
    for filename in os.listdir("./" + iconsDirectory):
        regex = r'[^A-Za-z0-9_-]+'
        matches = re.finditer(regex, filename.replace('.', ''))
        for matchNum, match in enumerate(matches, start=1):
            print('Error!', filename,
                  'contains special characters! please rename this file.')
            exit()

        src = "./" + iconsDirectory + filename
        des = "./" + iconsDirectory + to_snake_case(filename.replace(".svg", ""))
        os.rename(src, des + ".svg")
        continue


# Return string from SVG icon
def svg_string(src):
    with open(src, 'r') as file:
        data = file.read().replace('\n', '')
        return data


# Return dart code as string
def dart_code(class_name, svg_string):
    code = """import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_icon.dart';

// THIS FILE IS AUTO-GENERATED by flutter_icons_generator.py

class AppIcon%s extends StatelessWidget implements AppIcon {
  final double? height;
  final double? width;
  final Color? color;

  static const _svgString = '''
	%s
    ''';

  const AppIcon%s({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _svgString,
      color: color,
      height: height,
      width: width,
    );
  }
}

    """ % (class_name, svg_string, class_name)
    return code

# Generate dart files
def gen_files():
    directory = './' + iconsDirectory
    for filename in os.listdir(directory):
        var_name = filename.replace('.svg', '')
        svg_code = svg_string(directory + '/' + str(filename))
        dart_str = dart_code(var_name.title().replace('_', ''), svg_code)
        gen_single_file(var_name, dart_str)
        continue


# Create a single dart file
def gen_single_file(filename, code):
    libDirectory = './lib/' + dartIconsPath
    f = open(libDirectory + '/app_icon_' + filename + '.dart', "w")
    f.write(code)
    f.close()

# Uppercase first char in string
def uppercase_first_char(str):
    return str[0].upper() + str[1:]


# Generate Markdown (list of icons)
def gen_markdown():
  assetDirectory = "./" + iconsDirectory
  f1 = open("../list_icons.md", "w")
  f1.write("".join("# List of Icons") + "\n\n")
  f1.write("".join("| Icon name  | Preview  | Code |") + "\n")
  f1.write("".join("|---|---|---|") + "\n")
  for filename in os.listdir(assetDirectory):
    var_name = filename.replace('.svg', '')
    line = "| " + 'icon_' + var_name + " | "
    line += '<p align="center"><img width="50" loading="lazy" src="icons/' + str(filename) + '"></p> | '
    line +=  "`import 'package:rate_club/" + dartIconsPath + 'icon_' + var_name + ".dart';`<br>"
    line += '`AppIcon' + var_name.title().replace('_', '') +  "(), `|"  + "\n"
    f1.write("".join(line))
    continue

  f1.close()



rename_files()
print('Rename SVG Icons to lowerCamelCase - Done!')
print('Generating Dart files - Please wait...')
gen_files()
print('Generating Dart files - Done!')
gen_markdown()
print('Generating list_icons.md - Done!')