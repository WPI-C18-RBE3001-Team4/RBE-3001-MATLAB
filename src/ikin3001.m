function S = ikin3001(p,d)
try        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   test data   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %{
    %test point (x, y, z) (units: mm)
    
    p = ([300;100;135]);
    
    d = true;
    %}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DEBUG = d;

        
    px = p(1,1);
    py = p(2,1);
    pz = p(3,1);
    
    
    %Links (mm)
    L1 = 135;
    L2 = 175;
    %L3 = 169.28;
    L3 = 180;
    L4 = sqrt((pz-L1)^2+(px)^2+(py)^2);
    
    theta1 = atan2d(py,px);
    theta2 = atan2d( ( pz-L1 ), ( sqrt( (px)^2 + (py)^2 ) ) ) + acosd( ( (L2)^2 + (L4)^2 - (L3)^2 ) / (2*L2*L4));        
    theta3 = -acosd(-((L3)^2+(L2)^2-(L4)^2)/(2*L2*L3));
        
    if DEBUG
        disp(sprintf('theta1 = %f, theta2 = %f, theta3 = %f', theta1, theta2, theta3));
    end
    
    if theta1 > 90 || theta1 < -90
        msg = sprintf('Theta1 is out of bounds. Desired position x = %f, y = %f, z = %f, is out of reach.',px, py, pz);
        error();
    elseif theta2 > 120 || theta2 < -10
        msg = sprintf('Theta2 is out of bounds. Desired position x = %f, y = %f, z = %f, is out of reach.',px, py, pz);
        error();
    elseif theta3 > 130 || theta3 < -130
        msg = sprintf('Theta3 is out of bounds. Desired position x = %f, y = %f, z = %f, is out of reach.',px, py, pz);
        error();
    else
        S = [theta1 ; theta2; theta3];
    end
    
catch
    %input errors lead to this message
    error(msg);
end