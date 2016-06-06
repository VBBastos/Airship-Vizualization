%% função para criação de deltas

function [deltaX ,deltaY, deltaZ, deltaRX, deltaRY, deltaRZ] =...
         deltas(x1,x0,y1,y0,z1,z0,rx1,rx0,ry1,ry0,rz1,rz0)

    deltaX = x1-x0;
    deltaY = y1-y0;
    deltaZ = z1-z0;
    deltaRX = rx1-rx0;
    deltaRY = ry1-ry0;
    deltaRZ = rz1-rz0;
    
end