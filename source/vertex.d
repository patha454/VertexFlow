/**
* `vertex.d` provides the `Vertex` class, which represents a point in 3-Space.
*
* Nodes are the fundamental data structure in VertexFlow, holding position data
* for all points, vertices, intersections, etc... which make up a map.
*
* Author: H Paterson.
* Date: 27/01/2020.
* Licence: Boost Software Licence 1.0.
*/


module vertex;


import vector3;


/**
 * VertexFlow is unit and datum agnostic. A position is meanly a point in
 * 3-space, expressed in some arbitrary units. Specific datums and units
 * can be introduced by transforming vertices in a pipeline during import
 * or export.
 *
 * Each dimension of a position is currently a signed 64 bit integer.
 *
 * Positions are integers to avoid the precision decay associated with floating
 * point numbers.
 *
 * Integers do limit the scale of the map. A 64 bit integer provides a range
 * of +- 9.2E18 in each dimension. 
 *
 * Assuming the fundamental unit was assumed to be the millimeter, this give
 * each dimension the ability to represent a space 18.45 trillion Km on each
 * axis, at a precision of 1mm. This should be sufficient for most purposes.
 * The user is free to use a different fundamental unit if they need a different
 * area-precision trade off.
 */
alias Position = Vector3!long;


/**
 * `Vertex` is the fundamental data structure in VertexFlow. A `Vertex`
 * represents a point in Cartesian 3-Space, and contains some additional
 * metadata for handling the vertex internally.
 *
 * A `Vertex` might represent a spot height point, or the intersection of the
 * lines, splines, and polygons which make up map data.
 */
class Vertex
{

    /** `position` represents the location of the vertex in space. */
    private Position position;
}