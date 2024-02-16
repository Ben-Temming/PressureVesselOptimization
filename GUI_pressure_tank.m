%Initialisation
clc
clear
close all % closes previously generated GUIs
format short g
format compact
%--------------------------------------------------------
%Main figure containing the uicontrols
my_figure=figure('Position', [50,50,800,295],'Name','Pressure Vessel Optimizer'); %position, size

%Text box for Inputs
uicontrol('Parent',my_figure,'Style','text','String', 'Inputs: ',... 
    'Position',[95,260,47,22],'HorizontalAlignment','Left', 'FontSize',14);

%Text and Edit boxes for pressure
uicontrol('Parent',my_figure,'Style','text','String', 'Pressure (bar) =',...
    'Position',[17,227,82,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','pressure','Style','edit','String', ' ',...
    'Position',[113,227,100,22]);

%Text and Edit boxes for Capacity
uicontrol('Parent',my_figure,'Style','text','String', 'Capacity (L) =',...
    'Position',[28,192,71,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','capacity','Style','edit','String', ' ',...
    'Position',[113,192,100,22]);

%Text and Edit boxes for Factor of safty
uicontrol('Parent',my_figure,'Style','text','String', 'Factor of Safty =',...
    'Position',[7,157,91,22],'HorizontalAlignment','Right');
    uicontrol('Parent',my_figure,'tag','safty_factor','Style','edit','String', ' ',...
    'Position',[113,157,100,22]);

%Text and Edit boxes for Max length
uicontrol('Parent',my_figure,'Style','text','String', 'Max Length (m) =',...
    'Position',[9,123,89,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','max_length','Style','edit','String', ' ',...
     'Position',[113,123,100,22]);

%Text and Edit boxes for Max height
uicontrol('Parent',my_figure,'Style','text','String', 'Max Height (m) =',...
    'Position',[9,90,89,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','max_height','Style','edit','String', ' ',...
    'Position',[113,90,100,22]);


%Text and Edit boxes for step size
uicontrol('Parent',my_figure,'Style','text','String', 'ri step size (mm) =',... %move 
    'Position',[9,55,92,24],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','ri_step','Style','edit','String', ' ',...
    'Position',[113,55,100,22]);%30


%%results 
%Text box for outputs
uicontrol('Parent',my_figure,'Style','text','String', 'Optimized results for pressure vessel ',...
    'Position',[367,260,330,22],'HorizontalAlignment','Left', 'FontSize',14);

%Text and Edit boxes for Internal Radius
uicontrol('Parent',my_figure,'Style','text','String', 'Internal Radius (m) =',...
    'Position',[255,217,111,22],'HorizontalAlignment','Right');
    uicontrol('Parent',my_figure,'tag','internal_radius','Style','edit','String', ' ',...
    'Position',[375,217,100,22]);

%Text and Edit boxes for Optimal length
uicontrol('Parent',my_figure,'Style','text','String', 'Optimal Length (m) =',...
    'Position',[257,179,111,22],'HorizontalAlignment','Right');
    uicontrol('Parent',my_figure,'tag','length','Style','edit','String', ' ',...
    'Position',[375,179,100,22]);

%Text and Edit boxes for Optimal thickness
uicontrol('Parent',my_figure,'Style','text','String', 'Optimal Thickness (mm) =',...
    'Position',[221,142,147,22],'HorizontalAlignment','Right');
    uicontrol('Parent',my_figure,'tag','thickness','Style','edit','String', ' ',...
    'Position',[375,142,100,22]);

%Text and Edit boxes for Material index
uicontrol('Parent',my_figure,'Style','text','String', 'Material Index =',...
    'Position',[257,103,111,22],'HorizontalAlignment','Right');
    uicontrol('Parent',my_figure,'tag','material_index','Style','edit','String', ' ',...
    'Position',[375,103,100,22]);

%Text and Edit boxes for Total Height
uicontrol('Parent',my_figure,'Style','text','String', 'Total Height (m) =',...
    'Position',[280,67,90,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','total_height','Style','edit','String', ' ',...
    'Position',[375,67,100,22]);

%Text and Edit boxes for Allowable Stree
uicontrol('Parent',my_figure,'Style','text','String', 'Allowable Stress (MPa) =',...
    'Position',[506,217,139,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','allowable_stress','Style','edit','String', ' ',...
    'Position',[653,217,100,22]);


%Text and Edit boxes for Von Mises Strees
uicontrol('Parent',my_figure,'Style','text','String', 'Von Mises Stress (MPa) =',...
    'Position',[506,179,139,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','von_mises_stress','Style','edit','String', ' ',...
    'Position',[653,179,100,22]);


%Text and Edit boxes for Volume of Material
uicontrol('Parent',my_figure,'Style','text','String', 'Volume of Material (m^3) =',...
    'Position',[506,142,139,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','material_volume','Style','edit','String', ' ',...
    'Position',[653,142,100,22]);

%Text and Edit boxes for Cost index
uicontrol('Parent',my_figure,'Style','text','String', 'Cost Index =',...
    'Position',[578,103,68,22],'HorizontalAlignment','Right'); 
    uicontrol('Parent',my_figure,'tag','cost_index','Style','edit','String', ' ',...
    'Position',[653,103,100,22]);

%Text and Edit boxes for Total Length
uicontrol('Parent',my_figure,'Style','text','String', 'Total Length (m) =',...
    'Position',[555,70,91,22],'HorizontalAlignment','Right'); %[555,67,90,22] 
    uicontrol('Parent',my_figure,'tag','total_length','Style','edit','String', ' ',...
    'Position',[653,67,100,22]);

%Text and Edit boxes for Solution Type
uicontrol('Parent',my_figure,'Style','text','String', 'Solution Type =',...
    'Position',[360,25,111,22],'HorizontalAlignment','Right');
    uicontrol('Parent',my_figure,'tag','solution_type','Style','edit','String', ' ',...
    'Position',[476,25,100,22]);

%Push button (calculate) 
%calling calculations script
uicontrol('Parent',my_figure,'tag','run','Style','pushbutton','string','Calculate',...
    'Position',[55,20,100,25],'callback','optimization_search') 






