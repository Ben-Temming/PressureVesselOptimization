%adding clear so ensure that the variables are always updated
clear

%---------Get and check inputs:
%getting pressure 
P = str2num(get(findobj('tag','pressure'),'string'));
%pressure cannot be negative and cannot be empty
if isempty (P) || P <= 0 
    errordlg('Enter valid value for Pressure')
    return
end

%getting capacity 
C = str2num(get(findobj('tag','capacity'),'string'));
%capacity cannot be negative and cannot be empty
if isempty (C) || C <= 0 
    errordlg('Enter valid value for Capacity')
    return
end

%getting factor of safty 
nd = str2num(get(findobj('tag','safty_factor'),'string'));
%capacity cannot be negative and cannot be empty
if isempty (nd) || nd <= 0 
    errordlg('Enter valid value for Factor of Safty')
    return
end

%getting Max length 
Ltc = str2num(get(findobj('tag','max_length'),'string'));
%length cannot be negative and cannot be empty
if isempty (Ltc) || Ltc <= 0 
    errordlg('Enter valid value for Max Length')
    return
end

%getting Max height 
Hc = str2num(get(findobj('tag','max_height'),'string'));
%height cannot be negative and cannot be empty
if isempty (Hc) || Hc <= 0 
    errordlg('Enter valid value for Max Height')
    return
end

%getting ri step size
ri_step = str2num(get(findobj('tag','ri_step'),'string'));
%ri_step cannot be negative and cannot be empty
if isempty (ri_step) || ri_step <= 0 
    errordlg('Enter valid value for ri step size')
    return
end


%calculations-----------------------------------------
%getting the materials and their values from Materials.mat
load('Materials.mat');
%converting P from bar to Pa (1bar = 100000Pa)
P = P *100000;
ri_step = ri_step*10^-3; %convert ri_step from mm to m
ri_min = ri_step; %cannot be 0 so must be size of step
%storing the result
result = [];
for i=1:length(material) %for every material 
     Sy = material(i).Sy;
     CF = material(i).CF;
     all_stress = Sy/nd; %allowable stress (Pa)
     available_t = material(i).t;
     for j=1:length(available_t) % for every thickness
         t = available_t(j);
         ri_max = (Hc/2)-t; %maximum possible ri depending on given Hc
         
         for ri=ri_min:ri_step:ri_max %for every ri, exhaustive Search 
             %calculating r0, H, L and Lt
             r0 = ri+t;
             H = 2*r0;
             Vi = C/1000; %vessel internal volume (m3) = capacity (L)/1000
             L = (Vi - (4/3*pi*ri^3))/(pi*ri^2); %length (m)
             Lt = L + 2*r0;
             %calculating material volume and cost index
             Vmat = 2*pi*ri*t*L + 4*pi*(ri)^2*t; %vessel material volume m3)
             CI = Vmat*CF; %vessel cost index 
             
             %calculating von mises stress
             % for type: 0 == 'thin-walled' ,1 == thick-walled
             if t/ri < 0.05
                 type = 0;
                 stress_t = P*ri/t;
                 stress_r = 0;
                 stress_l = P*ri/(2*t);
             else
                 type = 1;
                 stress_t = ((ri^2*P)/(r0^2-ri^2))*(1+((r0)^2)/((ri)^2));
                 stress_r = ((ri^2*P)/(r0^2-ri^2))*(1-((r0)^2)/((ri)^2));
                 stress_l = (ri^2*P)/(r0^2-ri^2);
             end
            
             von_mises_stress = sqrt(((stress_t - stress_r)^2 + (stress_t - stress_l)^2 + (stress_l - stress_r)^2)/2);
             
             %ensuring that both height and length are above 0
             %and are below their given constraint values
             %and the condition for strees is fulfilled
             %Lt and H must be less that or equal to Ltc and Hc
             if (0 < H) && (H<= Hc) && (0 < L) &&(0 < Lt) && (Lt <= Ltc) && (von_mises_stress < all_stress)
                result = [result; ri, L, t, i, type, all_stress, von_mises_stress, Vmat, CI, Lt, H];
             end
         end
     end
end

%if we cannot find a solution, popup-message and end calculations
if isempty (result)
     set([findobj('tag','internal_radius'),findobj('tag','length'), 
         findobj('tag','thickness'), ...
         findobj('tag','material_index'),findobj('tag','total_height'), 
         findobj('tag','solution_type'),...
         findobj('tag','allowable_stress'), 
         findobj('tag','von_mises_stress'), ...
         findobj('tag','material_volume'), 
         findobj('tag','cost_index'),findobj('tag','total_length'), ...
        ], 'string', '');
     errordlg('No solution for this problem')
     return
end


%sort array by cost
sorted_result = sortrows(result, 9);
%selecting the cheapest option
solution = sorted_result(1,:);

%-----getting the values to display, round to appropriate engineering precision
internal_radius = round(solution(1),4,'significant');
length = round(solution(2),4,'significant');
thickness = solution(3)*10^3;
material_index = solution(4);
%type of solution
if solution(5) == 0
    solution_type = 'thin-walled';
else
    solution_type = 'thick-walled';
end

allowable_stress = round(solution(6)/10^6, 5,'significant');
von_mises_stress = round(solution(7)/10^6, 5,'significant');
material_volume = round(solution(8),3,'significant');
cost_index = round(solution(9),3,'significant');
total_length = round(solution(10),4,'significant');
total_height = round(solution(11),4,'significant');

%-------------Displaying outputs---------------------------
%displaying internal radius
set(findobj('tag','internal_radius'),'string', num2str(internal_radius))
set(findobj('tag','length'),'string', num2str(length))
set(findobj('tag','thickness'),'string', num2str(thickness))
set(findobj('tag','material_index'),'string', num2str(material_index))
set(findobj('tag','total_height'),'string', num2str(total_height))
set(findobj('tag','solution_type'),'string', num2str(solution_type))
set(findobj('tag','allowable_stress'),'string', num2str(allowable_stress))
set(findobj('tag','von_mises_stress'),'string', num2str(von_mises_stress))
set(findobj('tag','material_volume'),'string', num2str(material_volume))
set(findobj('tag','cost_index'),'string', num2str(cost_index))
set(findobj('tag','total_length'),'string', num2str(total_length))
%message for successful calculation 
f = msgbox(' Solution Found');
