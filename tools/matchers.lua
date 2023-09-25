--clang queries for wxDC interface

local wxDC_method_matcher = 
[[ cxxMethodDecl(unless(cxxConstructorDecl()),ofClass(cxxRecordDecl(hasName("wxDC"))) ) ]]

local wxDC_draw_text_matcher =
[[ cxxMethodDecl(ofClass(cxxRecordDecl(hasName("wxDC"))), hasName("DrawText"), hasType(asString( "void (const wxString &, wxCoord, wxCoord)" )) ) ]]
