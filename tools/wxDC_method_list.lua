-- clang results for the wxDC methods

local wxDC_methods = {
    { name = 'wxDC::CopyAttributes',        type = 'void (const wxDC &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxDC &)' },
    { name = 'wxDC::~wxDC',                 type = 'void (void) noexcept',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(void) noexcept' },
    { name = 'wxDC::GetImpl',               type = 'wxDCImpl *(void)',                                                                                                                     pointer_type =
    'wxDCImpl *(class wxDC::*)(void)' },
    { name = 'wxDC::GetImpl',               type = 'const wxDCImpl *(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxDCImpl *(class wxDC::*)(void) const' },
    { name = 'wxDC::GetWindow',             type = 'wxWindow *(void) const',
                                                                                                                                                                                               pointer_type =
        'wxWindow *(class wxDC::*)(void) const' },
    { name = 'wxDC::GetHandle',             type = 'void *(void) const',                                                                                                                   pointer_type =
    'void *(class wxDC::*)(void) const' },
    { name = 'wxDC::IsOk',                  type = '_Bool (void) const',                                                                                                                   pointer_type =
    '_Bool (class wxDC::*)(void) const' },
    { name = 'wxDC::CanDrawBitmap',         type = '_Bool (void) const',                                                                                                                   pointer_type =
    '_Bool (class wxDC::*)(void) const' },
    { name = 'wxDC::CanGetTextExtent',      type = '_Bool (void) const',                                                                                                                   pointer_type =
    '_Bool (class wxDC::*)(void) const' },
    { name = 'wxDC::GetSize',               type = 'void (int *, int *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(int *, int *) const' },
    { name = 'wxDC::GetSize',               type = 'wxSize (void) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(void) const' },
    { name = 'wxDC::GetSizeMM',             type = 'void (int *, int *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(int *, int *) const' },
    { name = 'wxDC::GetSizeMM',             type = 'wxSize (void) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(void) const' },
    { name = 'wxDC::GetDepth',              type = 'int (void) const',                                                                                                                     pointer_type =
    'int (class wxDC::*)(void) const' },
    { name = 'wxDC::GetPPI',                type = 'wxSize (void) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(void) const' },
    { name = 'wxDC::GetResolution',         type = 'int (void) const',                                                                                                                     pointer_type =
    'int (class wxDC::*)(void) const' },
    { name = 'wxDC::GetContentScaleFactor', type = 'double (void) const',
                                                                                                                                                                                               pointer_type =
        'double (class wxDC::*)(void) const' },
    { name = 'wxDC::FromDIP',               type = 'wxSize (const wxSize &) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(const wxSize &) const' },
    { name = 'wxDC::FromDIP',               type = 'wxPoint (const wxPoint &) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(const wxPoint &) const' },
    { name = 'wxDC::FromDIP',               type = 'int (int) const',                                                                                                                      pointer_type =
    'int (class wxDC::*)(int) const' },
    { name = 'wxDC::ToDIP',                 type = 'wxSize (const wxSize &) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(const wxSize &) const' },
    { name = 'wxDC::ToDIP',                 type = 'wxPoint (const wxPoint &) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(const wxPoint &) const' },
    { name = 'wxDC::ToDIP',                 type = 'int (int) const',                                                                                                                      pointer_type =
    'int (class wxDC::*)(int) const' },
    { name = 'wxDC::SetLayoutDirection',    type = 'void (wxLayoutDirection)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxLayoutDirection)' },
    { name = 'wxDC::GetLayoutDirection',    type = 'wxLayoutDirection (void) const',
                                                                                                                                                                                               pointer_type =
        'wxLayoutDirection (class wxDC::*)(void) const' },
    { name = 'wxDC::StartDoc',              type = '_Bool (const wxString &)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxString &)' },
    { name = 'wxDC::EndDoc',                type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::StartPage',             type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::EndPage',               type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::CalcBoundingBox',       type = 'void (wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord)' },
    { name = 'wxDC::ResetBoundingBox',      type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::MinX',                  type = 'wxCoord (void) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(void) const' },
    { name = 'wxDC::MaxX',                  type = 'wxCoord (void) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(void) const' },
    { name = 'wxDC::MinY',                  type = 'wxCoord (void) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(void) const' },
    { name = 'wxDC::MaxY',                  type = 'wxCoord (void) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(void) const' },
    { name = 'wxDC::SetFont',               type = 'void (const wxFont &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxFont &)' },
    { name = 'wxDC::GetFont',               type = 'const wxFont &(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxFont &(class wxDC::*)(void) const' },
    { name = 'wxDC::SetPen',                type = 'void (const wxPen &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPen &)' },
    { name = 'wxDC::GetPen',                type = 'const wxPen &(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxPen &(class wxDC::*)(void) const' },
    { name = 'wxDC::SetBrush',              type = 'void (const wxBrush &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxBrush &)' },
    { name = 'wxDC::GetBrush',              type = 'const wxBrush &(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxBrush &(class wxDC::*)(void) const' },
    { name = 'wxDC::SetBackground',         type = 'void (const wxBrush &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxBrush &)' },
    { name = 'wxDC::GetBackground',         type = 'const wxBrush &(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxBrush &(class wxDC::*)(void) const' },
    { name = 'wxDC::SetBackgroundMode',     type = 'void (int)',                                                                                                                           pointer_type =
    'void (class wxDC::*)(int)' },
    { name = 'wxDC::GetBackgroundMode',     type = 'int (void) const',                                                                                                                     pointer_type =
    'int (class wxDC::*)(void) const' },
    { name = 'wxDC::SetTextForeground',     type = 'void (const wxColour &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxColour &)' },
    { name = 'wxDC::GetTextForeground',     type = 'const wxColour &(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxColour &(class wxDC::*)(void) const' },
    { name = 'wxDC::SetTextBackground',     type = 'void (const wxColour &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxColour &)' },
    { name = 'wxDC::GetTextBackground',     type = 'const wxColour &(void) const',
                                                                                                                                                                                               pointer_type =
        'const wxColour &(class wxDC::*)(void) const' },
    { name = 'wxDC::SetPalette',            type = 'void (const wxPalette &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPalette &)' },
    { name = 'wxDC::SetLogicalFunction',    type = 'void (wxRasterOperationMode)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxRasterOperationMode)' },
    { name = 'wxDC::GetLogicalFunction',    type = 'wxRasterOperationMode (void) const',
                                                                                                                                                                                               pointer_type =
        'wxRasterOperationMode (class wxDC::*)(void) const' },
    { name = 'wxDC::GetCharHeight',         type = 'wxCoord (void) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(void) const' },
    { name = 'wxDC::GetCharWidth',          type = 'wxCoord (void) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(void) const' },
    { name = 'wxDC::GetFontMetrics',        type = 'wxFontMetrics (void) const',
                                                                                                                                                                                               pointer_type =
        'wxFontMetrics (class wxDC::*)(void) const' },
    { name = 'wxDC::GetTextExtent',
                                                type =
        'void (const wxString &, wxCoord *, wxCoord *, wxCoord *, wxCoord *, const wxFont *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, wxCoord *, wxCoord *, wxCoord *, wxCoord *, const wxFont *) const' },
    { name = 'wxDC::GetTextExtent',         type = 'wxSize (const wxString &) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(const wxString &) const' },
    { name = 'wxDC::GetMultiLineTextExtent',
                                                type =
        'void (const wxString &, wxCoord *, wxCoord *, wxCoord *, const wxFont *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, wxCoord *, wxCoord *, wxCoord *, const wxFont *) const' },
    { name = 'wxDC::GetMultiLineTextExtent', type = 'wxSize (const wxString &) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(const wxString &) const' },
    { name = 'wxDC::GetPartialTextExtents', type = '_Bool (const wxString &, wxArrayInt &) const',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxString &, wxArrayInt &) const' },
    { name = 'wxDC::Clear',                 type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::SetClippingRegion',     type = 'void (wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::SetClippingRegion',     type = 'void (const wxPoint &, const wxSize &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxSize &)' },
    { name = 'wxDC::SetClippingRegion',     type = 'void (const wxRect &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &)' },
    { name = 'wxDC::SetDeviceClippingRegion', type = 'void (const wxRegion &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRegion &)' },
    { name = 'wxDC::SetClippingRegion',     type = 'void (const wxRegion &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRegion &)' },
    { name = 'wxDC::DestroyClippingRegion', type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::GetClippingBox',        type = '_Bool (wxCoord *, wxCoord *, wxCoord *, wxCoord *) const',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(wxCoord *, wxCoord *, wxCoord *, wxCoord *) const' },
    { name = 'wxDC::GetClippingBox',        type = '_Bool (wxRect &) const',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(wxRect &) const' },
    { name = 'wxDC::DeviceToLogicalX',      type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::DeviceToLogicalY',      type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::DeviceToLogicalXRel',   type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::DeviceToLogicalYRel',   type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::DeviceToLogical',       type = 'wxPoint (const wxPoint &) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(const wxPoint &) const' },
    { name = 'wxDC::DeviceToLogical',       type = 'wxPoint (wxCoord, wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(wxCoord, wxCoord) const' },
    { name = 'wxDC::DeviceToLogicalRel',    type = 'wxSize (const wxSize &) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(const wxSize &) const' },
    { name = 'wxDC::DeviceToLogicalRel',    type = 'wxSize (int, int) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(int, int) const' },
    { name = 'wxDC::LogicalToDeviceX',      type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::LogicalToDeviceY',      type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::LogicalToDeviceXRel',   type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::LogicalToDeviceYRel',   type = 'wxCoord (wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxCoord (class wxDC::*)(wxCoord) const' },
    { name = 'wxDC::LogicalToDevice',       type = 'wxPoint (const wxPoint &) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(const wxPoint &) const' },
    { name = 'wxDC::LogicalToDevice',       type = 'wxPoint (wxCoord, wxCoord) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(wxCoord, wxCoord) const' },
    { name = 'wxDC::LogicalToDeviceRel',    type = 'wxSize (const wxSize &) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(const wxSize &) const' },
    { name = 'wxDC::LogicalToDeviceRel',    type = 'wxSize (int, int) const',
                                                                                                                                                                                               pointer_type =
        'wxSize (class wxDC::*)(int, int) const' },
    { name = 'wxDC::SetMapMode',            type = 'void (wxMappingMode)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxMappingMode)' },
    { name = 'wxDC::GetMapMode',            type = 'wxMappingMode (void) const',
                                                                                                                                                                                               pointer_type =
        'wxMappingMode (class wxDC::*)(void) const' },
    { name = 'wxDC::SetUserScale',          type = 'void (double, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(double, double)' },
    { name = 'wxDC::GetUserScale',          type = 'void (double *, double *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(double *, double *) const' },
    { name = 'wxDC::SetLogicalScale',       type = 'void (double, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(double, double)' },
    { name = 'wxDC::GetLogicalScale',       type = 'void (double *, double *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(double *, double *) const' },
    { name = 'wxDC::SetLogicalOrigin',      type = 'void (wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord)' },
    { name = 'wxDC::GetLogicalOrigin',      type = 'void (wxCoord *, wxCoord *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord *, wxCoord *) const' },
    { name = 'wxDC::GetLogicalOrigin',      type = 'wxPoint (void) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(void) const' },
    { name = 'wxDC::SetDeviceOrigin',       type = 'void (wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord)' },
    { name = 'wxDC::GetDeviceOrigin',       type = 'void (wxCoord *, wxCoord *) const',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord *, wxCoord *) const' },
    { name = 'wxDC::GetDeviceOrigin',       type = 'wxPoint (void) const',
                                                                                                                                                                                               pointer_type =
        'wxPoint (class wxDC::*)(void) const' },
    { name = 'wxDC::SetAxisOrientation',    type = 'void (_Bool, _Bool)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(_Bool, _Bool)' },
    { name = 'wxDC::CanUseTransformMatrix', type = '_Bool (void) const',                                                                                                                   pointer_type =
    '_Bool (class wxDC::*)(void) const' },
    { name = 'wxDC::SetTransformMatrix',    type = '_Bool (const wxAffineMatrix2D &)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxAffineMatrix2D &)' },
    { name = 'wxDC::GetTransformMatrix',    type = 'wxAffineMatrix2D (void) const',
                                                                                                                                                                                               pointer_type =
        'wxAffineMatrix2D (class wxDC::*)(void) const' },
    { name = 'wxDC::ResetTransformMatrix',  type = 'void (void)',                                                                                                                          pointer_type =
    'void (class wxDC::*)(void)' },
    { name = 'wxDC::SetDeviceLocalOrigin',  type = 'void (wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord)' },
    { name = 'wxDC::FloodFill',             type = '_Bool (wxCoord, wxCoord, const wxColour &, wxFloodFillStyle)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(wxCoord, wxCoord, const wxColour &, wxFloodFillStyle)' },
    { name = 'wxDC::FloodFill',             type = '_Bool (const wxPoint &, const wxColour &, wxFloodFillStyle)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxPoint &, const wxColour &, wxFloodFillStyle)' },
    { name = 'wxDC::GradientFillConcentric', type = 'void (const wxRect &, const wxColour &, const wxColour &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &, const wxColour &, const wxColour &)' },
    { name = 'wxDC::GradientFillConcentric',
                                                type =
        'void (const wxRect &, const wxColour &, const wxColour &, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &, const wxColour &, const wxColour &, const wxPoint &)' },
    { name = 'wxDC::GradientFillLinear',    type =
    'void (const wxRect &, const wxColour &, const wxColour &, wxDirection)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &, const wxColour &, const wxColour &, wxDirection)' },
    { name = 'wxDC::GetPixel',              type = '_Bool (wxCoord, wxCoord, wxColour *) const',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(wxCoord, wxCoord, wxColour *) const' },
    { name = 'wxDC::GetPixel',              type = '_Bool (const wxPoint &, wxColour *) const',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxPoint &, wxColour *) const' },
    { name = 'wxDC::DrawLine',              type = 'void (wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawLine',              type = 'void (const wxPoint &, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxPoint &)' },
    { name = 'wxDC::CrossHair',             type = 'void (wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord)' },
    { name = 'wxDC::CrossHair',             type = 'void (const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &)' },
    { name = 'wxDC::DrawArc',               type = 'void (wxCoord, wxCoord, wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawArc',               type = 'void (const wxPoint &, const wxPoint &, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxPoint &, const wxPoint &)' },
    { name = 'wxDC::DrawCheckMark',         type = 'void (wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawCheckMark',         type = 'void (const wxRect &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &)' },
    { name = 'wxDC::DrawEllipticArc',       type = 'void (wxCoord, wxCoord, wxCoord, wxCoord, double, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord, double, double)' },
    { name = 'wxDC::DrawEllipticArc',       type = 'void (const wxPoint &, const wxSize &, double, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxSize &, double, double)' },
    { name = 'wxDC::DrawPoint',             type = 'void (wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord)' },
    { name = 'wxDC::DrawPoint',             type = 'void (const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &)' },
    { name = 'wxDC::DrawLines',             type = 'void (int, const wxPoint *, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(int, const wxPoint *, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawLines',             type = 'void (const wxPointList *, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPointList *, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawPolygon',           type = 'void (int, const wxPoint *, wxCoord, wxCoord, wxPolygonFillMode)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(int, const wxPoint *, wxCoord, wxCoord, wxPolygonFillMode)' },
    { name = 'wxDC::DrawPolygon',           type = 'void (const wxPointList *, wxCoord, wxCoord, wxPolygonFillMode)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPointList *, wxCoord, wxCoord, wxPolygonFillMode)' },
    { name = 'wxDC::DrawPolyPolygon',
                                                type =
        'void (int, const int *, const wxPoint *, wxCoord, wxCoord, wxPolygonFillMode)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(int, const int *, const wxPoint *, wxCoord, wxCoord, wxPolygonFillMode)' },
    { name = 'wxDC::DrawRectangle',         type = 'void (wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawRectangle',         type = 'void (const wxPoint &, const wxSize &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxSize &)' },
    { name = 'wxDC::DrawRectangle',         type = 'void (const wxRect &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &)' },
    { name = 'wxDC::DrawRoundedRectangle',  type = 'void (wxCoord, wxCoord, wxCoord, wxCoord, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord, double)' },
    { name = 'wxDC::DrawRoundedRectangle',  type = 'void (const wxPoint &, const wxSize &, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxSize &, double)' },
    { name = 'wxDC::DrawRoundedRectangle',  type = 'void (const wxRect &, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &, double)' },
    { name = 'wxDC::DrawCircle',            type = 'void (wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawCircle',            type = 'void (const wxPoint &, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, wxCoord)' },
    { name = 'wxDC::DrawEllipse',           type = 'void (wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawEllipse',           type = 'void (const wxPoint &, const wxSize &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPoint &, const wxSize &)' },
    { name = 'wxDC::DrawEllipse',           type = 'void (const wxRect &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxRect &)' },
    { name = 'wxDC::DrawIcon',              type = 'void (const wxIcon &, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxIcon &, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawIcon',              type = 'void (const wxIcon &, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxIcon &, const wxPoint &)' },
    { name = 'wxDC::DrawBitmap',            type = 'void (const wxBitmap &, wxCoord, wxCoord, _Bool)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxBitmap &, wxCoord, wxCoord, _Bool)' },
    { name = 'wxDC::DrawBitmap',            type = 'void (const wxBitmap &, const wxPoint &, _Bool)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxBitmap &, const wxPoint &, _Bool)' },
    { name = 'wxDC::DrawText',              type = 'void (const wxString &, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawText',              type = 'void (const wxString &, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, const wxPoint &)' },
    { name = 'wxDC::DrawRotatedText',       type = 'void (const wxString &, wxCoord, wxCoord, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, wxCoord, wxCoord, double)' },
    { name = 'wxDC::DrawRotatedText',       type = 'void (const wxString &, const wxPoint &, double)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, const wxPoint &, double)' },
    { name = 'wxDC::DrawLabel',             type =
    'void (const wxString &, const wxBitmap &, const wxRect &, int, int, wxRect *)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, const wxBitmap &, const wxRect &, int, int, wxRect *)' },
    { name = 'wxDC::DrawLabel',             type = 'void (const wxString &, const wxRect &, int, int)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxString &, const wxRect &, int, int)' },
    { name = 'wxDC::Blit',
                                                type =
        '_Bool (wxCoord, wxCoord, wxCoord, wxCoord, wxDC *, wxCoord, wxCoord, wxRasterOperationMode, _Bool, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord, wxDC *, wxCoord, wxCoord, wxRasterOperationMode, _Bool, wxCoord, wxCoord)' },
    { name = 'wxDC::Blit',
                                                type =
        '_Bool (const wxPoint &, const wxSize &, wxDC *, const wxPoint &, wxRasterOperationMode, _Bool, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxPoint &, const wxSize &, wxDC *, const wxPoint &, wxRasterOperationMode, _Bool, const wxPoint &)' },
    { name = 'wxDC::StretchBlit',
                                                type =
        '_Bool (wxCoord, wxCoord, wxCoord, wxCoord, wxDC *, wxCoord, wxCoord, wxCoord, wxCoord, wxRasterOperationMode, _Bool, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord, wxDC *, wxCoord, wxCoord, wxCoord, wxCoord, wxRasterOperationMode, _Bool, wxCoord, wxCoord)' },
    { name = 'wxDC::StretchBlit',
                                                type =
        '_Bool (const wxPoint &, const wxSize &, wxDC *, const wxPoint &, const wxSize &, wxRasterOperationMode, _Bool, const wxPoint &)',
                                                                                                                                                                                               pointer_type =
        '_Bool (class wxDC::*)(const wxPoint &, const wxSize &, wxDC *, const wxPoint &, const wxSize &, wxRasterOperationMode, _Bool, const wxPoint &)' },
    { name = 'wxDC::GetAsBitmap',           type = 'wxBitmap (const wxRect *) const',
                                                                                                                                                                                               pointer_type =
        'wxBitmap (class wxDC::*)(const wxRect *) const' },
    { name = 'wxDC::DrawSpline',            type = 'void (wxCoord, wxCoord, wxCoord, wxCoord, wxCoord, wxCoord)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord, wxCoord, wxCoord)' },
    { name = 'wxDC::DrawSpline',            type = 'void (int, const wxPoint *)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(int, const wxPoint *)' },
    { name = 'wxDC::DrawSpline',            type = 'void (const wxPointList *)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxPointList *)' },
    { name = 'wxDC::GetHDC',                type = 'WXHDC (void) const',                                                                                                                   pointer_type =
    'WXHDC (class wxDC::*)(void) const' },
    { name = 'wxDC::AcquireHDC',            type = 'WXHDC (void)',                                                                                                                         pointer_type =
    'WXHDC (class wxDC::*)(void)' },
    { name = 'wxDC::ReleaseHDC',            type = 'void (WXHDC)',                                                                                                                         pointer_type =
    'void (class wxDC::*)(WXHDC)' },
    { name = 'wxDC::GetTempHDC',            type = 'TempHDC (void)',                                                                                                                       pointer_type =
    'TempHDC (class wxDC::*)(void)' },
    { name = 'wxDC::GetGraphicsContext',    type = 'wxGraphicsContext *(void) const',
                                                                                                                                                                                               pointer_type =
        'wxGraphicsContext *(class wxDC::*)(void) const' },
    { name = 'wxDC::SetGraphicsContext',    type = 'void (wxGraphicsContext *)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(wxGraphicsContext *)' },
    { name = 'wxDC::wxDC',                  type = 'void (wxDCImpl *)',                                                                                                                    pointer_type =
    'void (class wxDC::*)(wxDCImpl *)' },
    { name = 'wxDC::SetWindow',             type = 'void (wxWindow *)',                                                                                                                    pointer_type =
    'void (class wxDC::*)(wxWindow *)' },
    { name = 'wxDC::GetClassInfo',          type = 'wxClassInfo *(void) const',
                                                                                                                                                                                               pointer_type =
        'wxClassInfo *(class wxDC::*)(void) const' },
    { name = 'wxDC::wxDC',                  type = 'void (const wxDC &)',
                                                                                                                                                                                               pointer_type =
        'void (class wxDC::*)(const wxDC &)' },
    { name = 'wxDC::operator=',             type = 'wxDC &(const wxDC &)',
                                                                                                                                                                                               pointer_type =
        'wxDC &(class wxDC::*)(const wxDC &)' },

}
