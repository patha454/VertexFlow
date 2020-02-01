/**
 * `matrix.d` provides a matrix class.
 *
 * The `Matrix` class is used to implement most
 * mathematical operations on vertices.
 *
 * Author: H Paterson.
 * Date: 01/02/2020.
 * Licence: Boost Software Licence 1.0.
 */


module matrix;


/**
 * The `Matrix` struct templates generates an *rows* by 
 * *columns* * matrix which stores elements of type *T*.
 */
struct Matrix(T, size_t rows, size_t columns)
{

    /**
     * `elements` stores the elements of the matrix.
     */
    private T[][] elements;

    /**
     * Construct a new matrix from an array describing its
     * elements.
     *
     * Params:
     *  elements    =   The contents of the matrix.
     */
    this(T[rows][columns] elements)
    {
        this.elements = elements;
    }

    /// Construction
    unittest
    {
        immutable Matrix!(int, 1, 3) vector3 = Matrix!(int, 1, 3)([[3, 2, 1]]);
        immutable auto matrix32 = Matrix!(byte, 3, 2)([[5, 1], [2, 5], [2, 3]]);
        assert(vector3[0] == [3, 2, 1]);
        assert(matrix32[2][1] == 3);
    }

}