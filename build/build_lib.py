#!/usr/bin/env python3
import os

LIBRARY_NAME = "math"

ASSEMBLY_EXTENSIONS = [".asm", ".s"]
source_files = []

# Empty tmp directory
for root, dirs, files in os.walk("tmp"):
	for name in files:
		os.remove(os.path.join(root, name))

# Empty out directory
for root, dirs, files in os.walk("out"):
	for name in files:
		os.remove(os.path.join(root, name))

# Walk through src directory and compile a list of tuples containing the details of all the source files
for root, dirs, files in os.walk("src"):
	for file in files:
		name, ext = os.path.splitext(file)
		if ext in ASSEMBLY_EXTENSIONS:
			source_files.append((root, name, ext))

# Assemble and archive each individual source file
for source in source_files:
	input_file = os.path.join(source[0], source[1] + source[2])
	output_file = os.path.join("tmp", source[1] + ".o")
	os.system(f"ca65 {input_file} -g -o {output_file}")
	os.system(f"ar65 r {os.path.join('out', LIBRARY_NAME + '.lib')} {output_file}")

# Create a header file
with open(os.path.join("out", LIBRARY_NAME + ".h"), "w") as header:
	header.write(f".IFNDEF {LIBRARY_NAME.upper()}_H\n")
	header.write(f"{LIBRARY_NAME.upper()}_H = 1\n")
	header.write(f".SCOPE {LIBRARY_NAME}\n")

	for source in source_files:
		header.write("\n")
		with open(os.path.join(source[0], source[1] + source[2]), "r") as source_file:
			for line in source_file:
				if line == "; #end-header\n":
					break
				header.write(line)

	header.write("\n.ENDSCOPE")
	header.write("\n.ENDIF")