(**
  
  This module contains a single function to override the StyleServices global variable from the
  VCL.Themes unit so that we can get VTV controls to theme in accordance with the RAD Studio 10.2.2
  IDE Theming and above.

  Please this unit into VirtualTress and VirtualTrees.StyleHooks AFTER ther VCL.Themes declaration in 
  the uses clause.

  @Author  David Hoyle
  @Version 1.0
  @Date   14 Oct 2018
  
**)
Unit VirtualTrees.IDETheming;

Interface

Uses
  VCL.Themes;

  Function StyleServices : TCustomStyleServices;

Implementation

Uses
  {$IFDEF DEBUG}
  CodeSiteLogging,
  {$ENDIF}
  ToolsAPI,
  System.SysUtils;

(**

  This method either returns the global VCL.Themes StylesServices instance or if available the IDEs
  StyleServices.

  @precon  None.
  @postcon The style services to be used by the component is returned.

  @todo    Could do with caching the reference as owner draw calls this a lot.

  @return  a TCustomStyleServices

**)
Function StyleServices : TCustomStyleServices;

{$IF CompilerVersion >= 32.0}
Var
  ITS : IOTAIDEThemingServices;
{$IFEND}

Begin
  Result := VCL.Themes.StyleServices;
  {$IF CompilerVersion >= 32.0}
  If Supports(BorlandIDEServices, IOTAIDEThemingServices, ITS) Then
    If ITS.IDEThemingEnabled Then
      Result := ITS.StyleServices;
  {$IFEND}
End;

End.

