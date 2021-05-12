# -*- coding: utf-8 -*-
import os
from pathlib import Path

# -- Project information -----------------------------------------------------
exec(open("../project_common.py").read())


rst_prolog = ".. |xml| replace:: %s\n" % (project)

extensions.append('breathe');
extensions.append('exhale');

breathe_projects = {
  "doc_matlab": "_doxygen/"+"doc_matlab/xml-matlab",
}

breathe_default_project = "doc_matlab"

dir_path_matlab = os.path.dirname(os.path.realpath(__file__))+"../../../toolbox/lib"
dir_path_matlab = Path(dir_path_matlab).resolve()

doxygen_common_stdin = """
        EXTRACT_ALL         = YES
        SOURCE_BROWSER      = YES
        EXTRACT_STATIC      = YES
        HIDE_SCOPE_NAMES    = NO
        CALLER_GRAPH        = YES
        GRAPHICAL_HIERARCHY = YES
        HAVE_DOT            = YES
        QUIET               = NO
        GENERATE_TREEVIEW   = YES
        SHORT_NAMES         = YES
        IMAGE_PATH          = ../images

        XML_PROGRAMLISTING    = YES
        RECURSIVE             = NO
        FULL_PATH_NAMES       = YES
        ENABLE_PREPROCESSING  = YES
        MACRO_EXPANSION       = YES
        SKIP_FUNCTION_MACROS  = NO
        EXPAND_ONLY_PREDEF    = NO
        INHERIT_DOCS          = YES
        INLINE_INHERITED_MEMB = YES
        EXTRACT_PRIVATE       = YES
        PREDEFINED           += protected=private
        GENERATE_HTML         = NO
"""

doc_matlab = {
    'verboseBuild':          True,
    "rootFileName":          "root.rst",
    "createTreeView":        True,
    "exhaleExecutesDoxygen": True,
    "doxygenStripFromPath":  str(dir_path_matlab),
    "exhaleDoxygenStdin":   '''
        INPUT               = ../../src_matlab_interface
        PREDEFINED         += protected=private
        XML_OUTPUT          = xml-matlab
        FILE_PATTERNS       = GenericContainerMatlabInterface.*
'''+doxygen_common_stdin,
    "containmentFolder":    os.path.realpath('./api-matlab'),
    "rootFileTitle":        "MATLAB API",
}

exhale_projects_args = {
  "doc_matlab": doc_matlab
}

#cpp_index_common_prefix = ['GC_namespace::']

# If false, no module index is generated.
html_domain_indices = True

# If false, no index is generated.
html_use_index = True
