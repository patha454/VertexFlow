/**
 * `vector3.d` provides a template for 3-Vector.
 *
 * The 3-Vector is intended to be the backbone of the `Node` data structure,
 * but would not often be used directly because the 3-Vector only provides
 * position information and mathematical operations, and not any metadata.
 *
 * Author: H Paterson.
 * Date: 27/01/20.
 * Licence: Boost Software Licence 1.0.
 */


module vector3;


/**
 * `Vector3` provides a custom precision structure for a vector in cartesian
 * 3-space.
 */
struct Vector3(T)
{
    /** The *x* position of the vector. */
    private T _x;

    /** The *y* position of the vector. */
    private T _y;

    /** The *z* position of the vector. */
    private T _z;

    /**
     * Constructs a new vector from three co-ordinates.
     * 
     * The Vector3 can only be manipulated by Vector3's arithmetic operations
     * after construction. The Vector3`s `x`, `y`, and `z` values are read
     * only outside of the strut. This helps prevent the vector entering an
     * inconsistent state, or being moved accidentally. This arrangement also
     * discourages programmers from (re)-writing their own vector operations
     * which may introduce bugs or redundancy.
     *
     * Params:
     *  x =    *x* position.
     *  y =    *y* position.
     *  z =    *z* position.
     */
    this(T x, T y, T z)
    {
        this._x = x;
        this._y = y;
        this._z = z;
    }

    /** `x` provides property access to the *x* position. */
    @property public T x() { return this._x; }

    /** `y` provides property access to the *y* position. */
    @property public T y() { return this._y; }

    /** `z` provides property access to the *z* position. */
    @property public T z() { return this._z; }
}
