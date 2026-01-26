// Grid Font Demo
// Demonstrates loading and saving fonts from/to grid-based sprite sheets.

import "bmfFonts"

clear
print "=== Grid Font Loading and Saving Demo ==="
print

// Example 1: Load a font from a grid image using a string mapping
print "Example 1: Load font with string mapping ""32-126"""
print "------------------------------------------------------"
// Uncomment and adjust the path to your grid image:
// f1 = bmfFonts.Font.loadFromGrid("/path/to/grid.png", 8, 8, "32-126", 2)
// if f1 then
//     print "Loaded " + f1.chars.len + " characters"
//     print "Font metrics: lineHeight=" + f1.lineHeight + ", baseline=" + f1.sizeUnder
//     f1.print "Hello World!", 100, 400
// end if
print "(Commented out - adjust path to your grid image)"
print

// Example 2: Load using a list of character codes
print "Example 2: Load font with list mapping"
print "------------------------------------------------------"
// Create a list of character codes (A-Z, a-z, 0-9)
// charList = []
// for i in range(65, 90); charList.push i; end for  // A-Z
// for i in range(97, 122); charList.push i; end for  // a-z
// for i in range(48, 57); charList.push i; end for  // 0-9
// f2 = bmfFonts.Font.loadFromGrid("/path/to/grid.png", 16, 16, charList, 4)
// if f2 then
//     print "Loaded " + f2.chars.len + " characters"
// end if
print "(Commented out - adjust path to your grid image)"
print

// Example 3: Load with skip directives
print "Example 3: Load font with skip directives"
print "------------------------------------------------------"
// This demonstrates skipping cells in the grid
// f3 = bmfFonts.Font.loadFromGrid("/path/to/grid.png", 8, 8, 
//   "32-126,skip 10,160-180", 2)
print "Example mapping: ""32-126,skip 10,160-180"""
print "This loads chars 32-126, skips 10 cells, then loads 160-180"
print

// Example 4: Test parseCharString function
print "Example 4: Test parseCharString function"
print "------------------------------------------------------"
testStrings = [
	"32-35",
	"65,66,skip,68",
	"32-35,skip 2,40",
	"0-127",
	"17-21,27,32-127,skip 3,139"
]

for testStr in testStrings
	result = bmfFonts.parseCharString(testStr)
	print "  """ + testStr + """ ->"
	// Show first 10 values
	display = "    ["
	for i in range(0, min(9, result.len - 1))
		if i > 0 then display = display + ", "
		if result[i] == null then
			display = display + "null"
		else
			display = display + result[i]
		end if
	end for
	if result.len > 10 then display = display + ", ..."
	display = display + "]  (length: " + result.len + ")"
	print display
end for
print

// Example 5: Save an existing font to grid format
print "Example 5: Save existing font to grid"
print "------------------------------------------------------"
print "Load an existing font and save it as a grid:"
print

// Load an existing BMF font
fontPath = "../fonts/minimicro-mono-12.bmf"
if file.exists(fontPath) then
	f = bmfFonts.Font.load(fontPath)
	if f then
		print "Loaded " + fontPath
		print "  Characters: " + f.chars.len
		print "  Line height: " + f.lineHeight
		
		// Save as grid
		outputPath = "/tmp/test_grid.png"
		f.saveAsGrid outputPath, 16
		print
		print "Saved to grid format at " + outputPath
		print "  Also created " + outputPath[:outputPath.lastIndexOf(".")] + ".txt with metadata"
	else
		print "Failed to load " + fontPath
	end if
else
	print "Font file not found: " + fontPath
	print "(Adjust the path to point to an existing .bmf file)"
end if
print

// Example 6: Round-trip test
print "Example 6: Round-trip test"
print "------------------------------------------------------"
print "Test loading a font, saving to grid, and loading back:"
print

if file.exists(fontPath) then
	// Load original
	original = bmfFonts.Font.load(fontPath)
	
	if original then
		// Save as grid
		gridPath = "/tmp/roundtrip_grid.png"
		original.saveAsGrid gridPath, 16
		
		// Get the metadata for reloading
		gridData = original.imageAsGrid(16)
		
		// Load from grid
		reloaded = bmfFonts.Font.loadFromGrid(gridPath, 
			gridData.cellWidth, gridData.cellHeight, 
			gridData.charString, gridData.baseline)
		
		if reloaded then
			print "Round-trip successful!"
			print "  Original chars: " + original.chars.len
			print "  Reloaded chars: " + reloaded.chars.len
			print "  Match: " + (original.chars.len == reloaded.chars.len)
		else
			print "Failed to reload from grid"
		end if
	end if
else
	print "(Skipped - font file not found)"
end if
print

print "=== Demo Complete ==="
print
print "To use with your own grid images:"
print "1. Adjust the image paths in the examples above"
print "2. Set the correct cellWidth and cellHeight for your grid"
print "3. Specify the baseline (pixels from bottom of cell)"
print "4. Provide character mapping as a string or list"
print
print "For the attached example image (8x8 cells, 256 chars):"
print "  f = bmfFonts.Font.loadFromGrid(""grid.png"", 8, 8, ""0-255"", 1)"
