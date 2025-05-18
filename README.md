# Polarity_Puzzle_Elixir

The polarity puzzle requires you to place domino shaped bar magnets on a board in such a way that certain row and column constraints are satisfied. This is best demonstrated with a visual example. The empty board is shown on the left, and the solved board is on the right:

![Image](https://github.com/user-attachments/assets/42cc15a4-438d-485a-a45c-0072632507a3)

On the left, the orientation of the dark gray rectangles indicates the orientation of the magnet that can be placed there.

Numbers placed along the top and left side of the board indicate the precise number of positive poles that must be placed in that column or row. Similarly, numbers along the bottom and right side of the board indicate the precise number of negative poles that must be placed in that column or row.

If a position along any side of the board does not contain a number, then there is no requirement for that particular polarity in that row or column. In the example above, the left side of the board does not contain any numbers in the bottom three rows. This means that for those rows, we can place as many positive poles as we want. This applies to the left and top for positive poles, and to the right and bottom for negative poles.

One final constraint is that when placing magnets, positive poles cannot be vertically or horizontally adjacent. The same is true of negative poles. This one is intuitive, as it mirrors the behavior of real magnets.

Additional Notes:
- Any number of magnets may be placed, and any number of tiles may be left empty, as long as the constraints are met. The solved board above contains 10 magnets, and five tiles were left empty.
- Some boards may have multiple solutions.
