package rectangles

// Count counts the number of rectangles in an ASCII diagram
func Count(diagram []string) int {
	if len(diagram) == 0 {
		return 0
	}

	rows := len(diagram)
	if rows == 0 {
		return 0
	}

	cols := len(diagram[0])
	if cols == 0 {
		return 0
	}

	// Find all potential corners ('+' characters)
	corners := make([][]int, 0)
	for r := 0; r < rows; r++ {
		if len(diagram[r]) != cols {
			continue // Skip malformed rows
		}
		for c := 0; c < cols; c++ {
			if diagram[r][c] == '+' {
				corners = append(corners, []int{r, c})
			}
		}
	}

	count := 0

	// Check all pairs of corners to see if they form valid rectangles
	for i := 0; i < len(corners); i++ {
		for j := i + 1; j < len(corners); j++ {
			r1, c1 := corners[i][0], corners[i][1]
			r2, c2 := corners[j][0], corners[j][1]

			// Ensure we have proper rectangle orientation (top-left to bottom-right)
			if r1 > r2 || c1 > c2 || (r1 == r2 && c1 == c2) {
				continue
			}

			// Skip if it's just a line (not a rectangle)
			if r1 == r2 || c1 == c2 {
				continue
			}

			// Check if this forms a valid rectangle
			if isValidRectangle(diagram, r1, c1, r2, c2) {
				count++
			}
		}
	}

	return count
}

// isValidRectangle checks if the four corners form a valid rectangle with complete sides
func isValidRectangle(diagram []string, r1, c1, r2, c2 int) bool {
	// Check that all four corners exist
	if diagram[r1][c1] != '+' || diagram[r1][c2] != '+' ||
		diagram[r2][c1] != '+' || diagram[r2][c2] != '+' {
		return false
	}

	// Check top horizontal edge
	for c := c1 + 1; c < c2; c++ {
		if diagram[r1][c] != '-' && diagram[r1][c] != '+' {
			return false
		}
	}

	// Check bottom horizontal edge
	for c := c1 + 1; c < c2; c++ {
		if diagram[r2][c] != '-' && diagram[r2][c] != '+' {
			return false
		}
	}

	// Check left vertical edge
	for r := r1 + 1; r < r2; r++ {
		if diagram[r][c1] != '|' && diagram[r][c1] != '+' {
			return false
		}
	}

	// Check right vertical edge
	for r := r1 + 1; r < r2; r++ {
		if diagram[r][c2] != '|' && diagram[r][c2] != '+' {
			return false
		}
	}

	return true
}
