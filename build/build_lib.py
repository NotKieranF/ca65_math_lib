#!/usr/bin/env python3
import os

LIBRARY_NAME = "math.lib"

ASSEMBLY_EXTENSIONS = [".asm", ".s"]
object_files = []

os.chdir("..")

# Empty tmp directory
for root, dirs, files in os.walk("tmp"):
	for name in files:
		os.remove(os.path.join(root, name))

# Empty out directory
for root, dirs, files in os.walk("out"):
	for name in files:
		os.remove(os.path.join(root, name))

# Walk through src directory and assemble all source files
for root, dirs, files in os.walk("src"):
	for file in files:
		name, ext = os.path.splitext(file)
		if ext in ASSEMBLY_EXTENSIONS:
			source_file = os.path.join(root, file)
			output_file = os.path.join("tmp", name + ".o")
			os.system(f"ca65 {source_file} -g -o {output_file}")
			object_files.append(output_file)

# Combine object files into a single library file
os.system(f"ar65 r {os.path.join('out', LIBRARY_NAME)} {' '.join(object_files)}")

input("")