// Quick test of grid font functionality
import "bmfFonts"

print "Testing parseCharString function..."
print

// Test 1: Simple range
result1 = bmfFonts.parseCharString("32-35")
print "Test 1: ""32-35"""
print "  Expected: [32, 33, 34, 35]"
print "  Got: " + result1
print "  Pass: " + (result1 == [32, 33, 34, 35])
print

// Test 2: With skip
result2 = bmfFonts.parseCharString("65,66,skip,68")
print "Test 2: ""65,66,skip,68"""
print "  Expected: [65, 66, null, 68]"
print "  Got: " + result2
print "  Pass: " + (result2 == [65, 66, null, 68])
print

// Test 3: Skip multiple
result3 = bmfFonts.parseCharString("32-35,skip 2,40")
print "Test 3: ""32-35,skip 2,40"""
print "  Expected: [32, 33, 34, 35, null, null, 40]"
print "  Got: " + result3
expected3 = [32, 33, 34, 35, null, null, 40]
match = true
if result3.len != expected3.len then 
	match = false
else
	for i in result3.indexes
		if result3[i] != expected3[i] then match = false
	end for
end if
print "  Pass: " + match
print

// Test 4: Complex range
result4 = bmfFonts.parseCharString("0-2,5,8-10")
print "Test 4: ""0-2,5,8-10"""
print "  Expected: [0, 1, 2, 5, 8, 9, 10]"
print "  Got: " + result4
print "  Pass: " + (result4 == [0, 1, 2, 5, 8, 9, 10])
print

print "All parseCharString tests complete!"
print

// Test loading an existing font and using imageAsGrid
print "Testing imageAsGrid on existing font..."
fontPath = "../fonts/minimicro-mono-12.bmf"
if file.exists(fontPath) then
	f = bmfFonts.Font.load(fontPath)
	if f then
		print "Loaded: " + fontPath
		print "  Characters: " + f.chars.len
		
		gridData = f.imageAsGrid(16)
		if gridData then
			print "Generated grid:"
			print "  Image size: " + gridData.image.width + "x" + gridData.image.height
			print "  Cell size: " + gridData.cellWidth + "x" + gridData.cellHeight
			print "  Columns: " + gridData.columns
			print "  Baseline: " + gridData.baseline
			print "  Char string: " + gridData.charString[:50] + "..."
			print "Success!"
		else
			print "Failed to generate grid"
		end if
	end if
else
	print "Font not found (that's OK for this test)"
end if

print
print "Basic tests complete!"
