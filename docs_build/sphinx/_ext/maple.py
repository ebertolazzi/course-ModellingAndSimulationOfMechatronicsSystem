# _ext/mylanglexer.py

from pygments.lexers import get_lexer_by_name  # refer LEXERS
from pygments.lexers._mapping import LEXERS
from pygments.lexers.math import MuPADLexer

#def role_maple(name, rawtext, text, lineno, inliner, options={}, content=[]):
#    return [rawtext], []

def setup(app):
    # choose one, both ok
    app.add_lexer('maple', MuPADLexer )
    #app.add_role('maple', role_maple )
