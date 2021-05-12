DAE-Toolbox
===========

The *DAE-toolbox* is a small collection of *MAPLE* scripts
which shuold simplify the develop of DAE integrator.


Load script
-----------

In the *MAPLE* worksheet load the scripts

.. code-block:: maple

  read("{path}/DAE-toolbox.maplet");

where ``{path}`` is the relative or absolute path where
the script ``DAE-toolbox.maplet`` is located.

At this point you ca use a rseries of scripts which
hopefully simplify DAE manipulation.

.. raw:: html

  <style>
  #table-of-contents { line-height: 25%; padding: 0px 0px 30px 0px; border: 0; }
  </style>

.. contents:: Table of Contents
    :local:
    :depth: 3

DIFF
~~~~

Extends diff to works with function as derivation argument.
In practice if you try to differentiate

.. code-block:: maple

  > fun := sin(x(t));
  > diff(sin(x(t)),x(t));

you get an error because *MAPLE* expect a symbol
not a function as second argument.
However ``DIFF`` work

.. code-block:: maple

  > fun := sin(x(t));
  > DIFF(sin(x(t)),x(t));

    cos( x(t))

returning the correct answer.

JACOBIAN
~~~~~~~~

Do the same job as for ``DIFF`` but for map
or multivariate functions.
The syntax is

.. code-block:: maple

  > JACOBIAN(FUN,PARS);

where ``FUN`` is a list of expressions, a single expression
or a ``Vector`` type.
The map ``FUN`` is derived respect to ``PARS``
a list of parameters.
The parameters can be also functions.

.. code-block:: maple

  > FUN  := <x^2+y(t),y(t)*cos(x*y(t))>:
  > PARS := [x,y(t)]:
  > JACOBIAN(FUN,PARS);

           [       2 x                         1                ]
           [                                                    ]
           [     2                                              ]
           [-y(t)  sin(x y(t))  cos(x y(t)) - y(t) x sin(x y(t))]


Kernel_build
~~~~~~~~~~~~

Give a (possibly rectangular) matrix :math:`\mathbf{E}`
the routine compute two matrices  :math:`\mathbf{K}` and  :math:`\mathbf{L}`
such that

.. math::

   \begin{array}{rcl}
   \mathbf{K}\mathbf{E} &=& \mathbf{0} \\[0.5em]
   \mathbf{L}\mathbf{E} &=& \textrm{full rank} \\[0.5em]
   \mathbf{M} &=& \left(\begin{array}{c}
   \mathbf{L}\\ \mathbf{K}
   \end{array}\right), \qquad \textrm{non singular}
   \end{array}

The routine return also the rank of the matrix  :math:`\mathbf{E}`.
Usage exaple:

.. code-block:: maple

  > K, L, r := Kernel_build( E );

The algorithm use Gaussian elimination
so that :math:`\mathbf{E}` can contains symbolic
expressions.

DAE_separate_algebraic
~~~~~~~~~~~~~~~~~~~~~~

Given a DAE in the form

.. math::

  \mathbf{E}(\mathbf{x},t) \mathbf{x}' = \mathbf{g}(\mathbf{x},t)

using ``Kernel_build`` transform the DAE to

.. math::

  \left\{\begin{array}{rcl}
  \mathbf{E}_1(\mathbf{x},t) \mathbf{x}' &=& \mathbf{g}_1(\mathbf{x},t) \\[1em]
  \mathbf{0} &=& \mathbf{g}_2(\mathbf{x},t)
  \end{array}\right.

separating the algebraic part into :math:`\mathbf{g}_2(\mathbf{x},t)`.
Usage:

.. code-block::

  > E1, G1, G2, r := DAE_separate_algebraic( E, G ): # r = rank or E

Notice that the routine return also the rank
of the matrix :math:`\mathbf{E}`.

There is also a function `DAE_separate_algebraic_bis`
which do the same job when the DAE is passed as a list
of differential equations.
In this case you must also pass the list of
differential variables to transform (internally)
to the form :math:`\mathbf{E}(\mathbf{x},t) \mathbf{x}' = \mathbf{g}(\mathbf{x},t)`

.. code-block::

  > E1, G1, G2, r := DAE_separate_algebraic_bis( EQNS, DVARS ): # r = rank or E

DAE_make_semi_explicit
~~~~~~~~~~~~~~~~~~~~~~

Given DAE passed as a list of differential equations
build a new DAE in semi explicit form.
The user musty pass

- A list the the DAE system
- A list with the variables (functions) of the DAE

.. code-block::

  > ODE, DVARS, AVARS, ALG := DAE_make_semi_explicit( DAE, vars )

After the reduction you have

- ``ODE``    the ODE part :math:`x' = f(x,y)` of the DAE
- ``DVARS``  the list of function that appers as derivative :math:`x(t)`
- ``AVARS``  the list of function that DO NOT appers as derivative :math:`y(t)`
- ``ALG``    the algebraic part  :math:`0 = g(x,y)`  of the DAE

In the process of semi-explicit formation some new variable
may be created. Moreover ``ALG`` part can contain
trivial equations that can be manually solved by the user.

For exmaple the Pendulum DAE

.. math::

  \left\{
  \begin{array}{l}
  x' = u \\
  y' = v \\
  u' + \lambda x = 0 \\
  v' + \lambda y = -mg \\
  x^2+y^2=1
  \end{array}
  \right.

is transformed to

*ODE*:

.. math::

  \left\{
  \begin{array}{l}
  x' = u \\
  y' = v \\
  u' = \dot{u} \\
  u' = \dot{v}
  \end{array}
  \right.

*ALG*

.. math::

  \left\{
  \begin{array}{l}
  \dot{u} + \lambda x = 0 \\
  \dot{v} + \lambda y + mg = 0 \\
  x^2+y^2-1 = 0
  \end{array}
  \right.

*DVARS*

.. math::

  [ x(t), y(t), u(t), v(t) ]


*AVARS*

.. math::

  [ \dot{u}(t), \dot{v}(t), \lambda(t) ]

For a non trivial usare of ``DAE_make_semi_explicit``
lokk at :file:`DAE-toolbox-usare-2.mw`

DAE_reduce_index_by_1
~~~~~~~~~~~~~~~~~~~~~

Given a DAE in the form (you che put in this form using ``DAE_separate_algebraic``)

.. math::

  \left\{\begin{array}{rcl}
  \mathbf{E}_1(\mathbf{x},t) \mathbf{x}' &=& \mathbf{g}_1(\mathbf{x},t) \\[1em]
  \mathbf{0} &=& \mathbf{a}_1(\mathbf{x},t)
  \end{array}\right.

Tranform to a new one

.. math::

  \left\{\begin{array}{rcl}
  \mathbf{E}_2(\mathbf{x},t) \mathbf{x}' &=& \mathbf{g}_2(\mathbf{x},t) \\[1em]
  \mathbf{0} &=& \mathbf{a}_2(\mathbf{x},t)
  \end{array}\right.

That has index reduced by one.
The command usage is the following

.. code-block:: maple

  > E2, G2, A2, r := DAE_reduce_index_by_1( E1, G1, A1, Dvars );

where

  - E1 is the matrix :math:`\mathbf{E}_1(\mathbf{x},t)`
  - G1 is the vector :math:`\mathbf{g}_1(\mathbf{x},t)`
  - A1 is the vector :math:`\mathbf{a}_1(\mathbf{x},t)` of the algebraic constraints
  - Dvars is the list of the differential variable :math:`\mathbf{x}'(t)`

and

  - E2 is the matrix :math:`\mathbf{E}_2(\mathbf{x},t)`
  - G2 is the vector :math:`\mathbf{g}_2(\mathbf{x},t)`
  - A2 is the vector :math:`\mathbf{a}_2(\mathbf{x},t)` of the NEW algebraic constraints
  - r the rank of the output matrix  :math:`\mathbf{E}_2(\mathbf{x},t)`

If the reduced DAE is an ODE ``A2`` is empty and ``r``
is equal to the number of equations.

Library has also the functions:

- DAE_reduce_index_by_1_full( E, G, Dvars )
  Do not need to previously separate algebraic part, is
  done internally.

- DAE_reduce_index_by_1_full2proc( EQS, Dvars )
  Do not need to put in the form `E x' = G`
  is done internally.

DAE3_get_ODE_and_invariants
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Given an index-3 DAE of the form

.. math::

  \mathrm{DAE}:
  \left\{
  \begin{array}{l}
  \mathbf{q}' = \mathbf{v} \\[0.5em]
  \mathbf{M}(\mathbf{q},\mathbf{v},t) \mathbf{v}' +
  \mathbf{\Phi}_q(\mathbf{q},t)^T\boldsymbol{\lambda} = \mathbf{f}(\mathbf{q},\mathbf{v},t) \\[0.5em]
  \mathbf{\Phi}(\mathbf{q},t) = \mathbf{0}
  \end{array}
  \right.

Trasform to semi-explicit DAE

.. math::

  \mathrm{ODE}: \left\{
  \begin{array}{l}
  \mathbf{q}' = \mathbf{v} \\[0.5em]
  \mathbf{v}' = \dot{\mathbf{v}}
  \end{array}
  \right.
  \qquad
  \mathrm{ALG}:
  \left\{
  \begin{array}{l}
  \mathbf{M}(\mathbf{q},\mathbf{v},t) \dot{\mathbf{v}} +
  \mathbf{\Phi}_q(\mathbf{q},t)^T\boldsymbol{\lambda} = \mathbf{f}(\mathbf{q},\mathbf{v},t) \\[0.5em]
  \mathbf{\Phi}(\mathbf{q},t) = \mathbf{0}
  \end{array}
  \right.

Then build first and second derivative of the constraints
:math:`\mathbf{\Phi}(\mathbf{q},t)`:

.. math::

  \mathbf{a}(\mathbf{q},\mathbf{v},t)=\dfrac{\mathrm{d}}{\mathrm{d}t}\mathbf{\Phi}(\mathbf{q},t) =
  \mathbf{\Phi}_q(\mathbf{q},t)\mathbf{v}+
  \mathbf{\Phi}_t(\mathbf{q},t)

and

.. math::

  \dfrac{\mathrm{d}}{\mathrm{d}t}\mathbf{a}(\mathbf{q},\mathbf{v},t)=
  \mathbf{\Phi}_q(\mathbf{q},t)\dot{\mathbf{v}}-\mathbf{b}(\mathbf{q},\mathbf{v},t)

where

.. math::

  \mathbf{b}(\mathbf{q},\mathbf{v},t) = -\dfrac{\mathrm{d}}{\mathrm{d}t}\mathbf{a}(\mathbf{q},\mathbf{v},t)|_{\mathbf{v}=\mathrm{fixed}}

*USAGE:*

.. code-block::

  res := DAE3_get_ODE_and_invariants( Mass, Phi, f, qvars, vvars, lvars )

where

.. list-table:: Parameter correspondence
  :width:  90%
  :widths: 25 75

  * - ``Mass``
    - :math:`\mathbf{M}(\mathbf{q},\mathrm{v},t)`
  * - ``Phi``
    - :math:`\mathbf{\Phi}(\mathbf{q},t)`
  * - ``f``
    - :math:`\mathbf{\Phi}(\mathbf{q},t)`
  * - ``qvars``
    - :math:`\mathbf{q}=[q_1(t),q_2(t),\ldots,q_n(t)]`
  * - ``vvars``
    - :math:`\mathbf{v}=[v_1(t),v_2(t),\ldots,v_n(t)]`
  * - ``lvars``
    - :math:`\boldsymbol{\lambda}=[\lambda_1(t),\ldots,\lambda_m(t)]`

the result ``res`` is a maple table that contains

.. list-table:: Table contents
  :width: 90%
  :widths: 25 75

  * - ``res["PVARS"]``
    - The position states :math:`[q_1(t),q_2(t),\ldots,q_n(t)]`
  * - ``res["VVARS"]``
    - The velocity states :math:`[v_1(t),v_2(t),\ldots,v_n(t)]`
  * - ``res["LVARS"]``
    - The Lagrange multipliers :math:`[\lambda_1(t),\lambda_2(t),\ldots,\lambda_m(t)]`
  * - ``res["VDOT"]``
    - The added algebraic states  :math:`[\dot{v}_1(t),\dot{v}_2(t),\ldots,\dot{v}_n(t)]`
  * - ``res["ODE_RHS"]``
    - The r.h.s for the ODE part (complete)
  * - ``res["ODE_POS"]``
    - The r.h.s for the ODE part: position equations
  * - ``res["ODE_VEL"]``
    - The r.h.s for the ODE part: velocity equations
  * - ``res["Phi_P"]``
    - Partial derivative of the constraints :math:`\mathbf{\Phi}_q(\mathbf{q},t)`
  * - ``res["A"]``
    - :math:`\mathbf{a}(\mathbf{q},\mathbf{v},t)=\mathbf{\Phi}_q(\mathbf{q},t)\dot{\mathbf{v}}-\mathbf{b}(\mathbf{q},\mathbf{v},t)`
  * - ``res["A_rhs"]``
    - :math:`-\mathbf{\Phi}_t(\mathbf{q},t)`
  * - ``res["b"]``
    - :math:`\mathbf{b}(\mathbf{q},\mathbf{v},t)`
  * - ``res["bigVAR"]``
    - :math:`[\dot{v}_1(t),\dot{v}_2(t),\ldots,\dot{v}_n(t),\lambda_1(t),\lambda_2(t),\ldots,\lambda_m(t)]`,
  * - ``res["bigM"]``
    - :math:`\left[\begin{array}{cc}\mathbf{M}(\mathbf{q},\mathbf{v},t) & \mathbf{\Phi}_q(\mathbf{q},t)^T \\ \mathbf{\Phi}_q(\mathbf{q},t) & \mathbf{0}\end{array}\right]`
  * - ``res["bigRHS"]``
    - :math:`\left[\begin{array}{c}\mathbf{f}(\mathbf{q},\mathbf{v},t) \\ \mathbf{b}(\mathbf{q},\mathbf{v},t)\end{array}\right]`

DAE3_get_ODE_and_invariants_full
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The extended version of the call ``DAE3_get_ODE_and_invariants``

.. code-block::

  res := DAE3_get_ODE_and_invariants_full( Mass, Phi, f, qvars, vvars, lvars )

return the same table of ``DAE3_get_ODE_and_invariants``
with in addition

.. list-table:: Table contents
  :width: 90%
  :widths: 25 75

  * - ``res["bigETA"]``
    - :math:`\boldsymbol{\eta}(\mathbf{q},\mathbf{v},\boldsymbol{\mu},t)=\mathbf{M}(\mathbf{q},\mathbf{v},t)\boldsymbol{\mu}` where
      :math:`\boldsymbol{\mu}=[\mu_1,\mu_2,\ldots,\mu_n]^T`
  * - ``res["JbigETA"]``
    - :math:`[\boldsymbol{\eta}_{\mathbf{q}}(\mathbf{q},\mathbf{v},\boldsymbol{\mu},t),\boldsymbol{\eta}_{\mathbf{v}}(\mathbf{q},\mathbf{v},\boldsymbol{\mu},t)]`
  * - ``res["JbigRHS"]``
    - :math:`\left[\begin{array}{cc}\mathbf{f}_{\mathbf{q}}(\mathbf{q},\mathbf{v},t) & \mathbf{f}_{\mathbf{v}}(\mathbf{q},\mathbf{v},t)  \\ \mathbf{b}_{\mathbf{q}}(\mathbf{q},\mathbf{v},t) & \mathbf{b}_{\mathbf{v}}(\mathbf{q},\mathbf{v},t) \end{array}\right]`

F_TO_MATLAB
~~~~~~~~~~~

JF_TO_MATLAB
~~~~~~~~~~~~

.. include:: author.rst
