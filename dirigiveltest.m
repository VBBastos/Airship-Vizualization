clc, clear, close all

%Abertura do arquivo de posições
file1=load('posicao');
px=file1.posicao(:,1);
py=file1.posicao(:,2);
pz=file1.posicao(:,3);
plot3(px,py,pz)
title('Percurso')
v1=[min(px), max(px), min(py), max(py), 0, max(pz)];
axis(1.1*v1)

%Abertura de arquivo de angulos
file2=load('angulos');
rx=file2.angulos(:,1);
ry=file2.angulos(:,2);
rz=file2.angulos(:,3);

figure
t=1:length(rx);
plot(t/30,rx)
top=ceil(1.1*length(t)/30);
axis([0, top, -pi, pi])
hold on
plot(t/30,ry,'g-')
plot(t/30,rz,'r-')
legend('Rolagem (rx)','Arfagem (ry)','Guinada (rz)','Location','NorthEastOutside')
xlabel('Tempo (s)')
ylabel('Angulo (degrees)')
title('Angulos de orientação do dirigivel')

len=length(px); %Comprimento do vetor de posições
lastx=px(len);
lasty=py(len);
lastz=pz(len);
i=1;
x1=0;
y1=0;
z1=0;


while [x1,y1,z1]~=[lastx,lasty,lastz]
    
    % Open and Read file (*.txt)
    fid = fopen('C:\Users\Vinicius\Dropbox\DOUTORADO\Simulacoes\Dirigivel\Matlab.txt','r');
    spec = '%f X %f Y %f Z %f RX %f RY %f RZ %f %f';
    filedata = fscanf(fid,spec); %get file data
    fclose(fid); % Close file
    
    %Verification to start processing file (1=ready,0=waiting)   
    if filedata(1)==1 
        
        %Criação de valores para movimentação
        x0=px(i);
        x1=px(i+1);
        y0=py(i);
        y1=py(i+1);
        z0=pz(i);
        z1=pz(i+1);
        rx0=rx(i);
        rx1=rx(i+1);
        ry0=ry(i);
        ry1=ry(i+1);
        rz0=rz(i);
        rz1=rz(i+1);

        %Creating deltas
        [deltaX ,deltaY, deltaZ, deltaRX, deltaRY, deltaRZ] =...
             deltas(x1,x0,y1,y0,z1,z0,rx1,rx0,ry1,ry0,rz1,rz0);

        %Get variation abs value of x and y, Set prefix for variation signal (0=negative,1=positive)


        [deltaX,dx]=checksignal(deltaX);
        [deltaY,dy]=checksignal(deltaY);
        [deltaZ,dz]=checksignal(deltaZ);
        [deltaRX,drx]=checksignal(deltaRX);
        [deltaRY,dry]=checksignal(deltaRY);
        [deltaRZ,drz]=checksignal(deltaRZ);


        %Open and Write data on file (*.txt)
        fid = fopen('C:\Users\Vinicius\Dropbox\DOUTORADO\Simulacoes\Dirigivel\Matlab.txt','r+');
        writedata = [0; dx; deltaX; dy; deltaY; dz; deltaZ; drx; deltaRX;...
                     dry; deltaRY; drz; deltaRZ; 0];
        fprintf(fid,'%1.0f X %1.0f%1.4f Y %1.0f%1.4f Z %1.0f%1.4f RX %1.0f%1.4f RY %1.0f%1.4f RZ %1.0f%1.4f %1.0f',writedata);
        fclose(fid); %Close file
        
        i=i+1;
        
    end

end

%Set file start and end identificator (1=ready,0=waiting)
writedata(14) = 1;
writedata(1) = 1;

%Open and Write data on file (*.txt)
fid = fopen('C:\Users\Vinicius\Dropbox\DOUTORADO\Simulacoes\Dirigivel\Matlab.txt','r+');
fprintf(fid,'%1.0f X %1.0f%1.4f Y %1.0f%1.4f Z %1.0f%1.4f RX %1.0f%1.4f RY %1.0f%1.4f RZ %1.0f%1.4f %1.0f',writedata);
fclose(fid); %Close file
