%% fun��o para checar se o valor � positivo

function [delta,dx] = checksignal(value)

    if value<0
        delta=abs(value);
        dx=0;
    else
        delta=value;
        dx=1;
    end
    
end