

function Grafico(titulo, datos)
figure;
bar(datos)
xlabel('Calidad')
ylabel('Numero de Imagenes')
title(titulo)
set(gca, 'XTickLabel', {'Buena (<50)', 'Mala (>50)'})
end








