function arrayModificado = DistanciasNIQE(valor, array)

if valor < 1

    array(1) = array(1) + 1;
else
    if valor < 2
        array(2) = array(2) + 1;
    else
        if valor < 3
            array(3)= array(3) +1;
        else
            if valor <=4
                array(4)=array(4)+1;
            else
                if valor > 4
                    array(5)=array(5)+1;
                end

    
            end
        end
    end
end


arrayModificado = array;  % Devolver el arreglo modificado

end


