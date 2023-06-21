function GraficoNIQE(titulo, datos)
figure;
bar(datos)
xlabel('Distancias')
ylabel('Numero de Imagenes')
title(titulo)
set(gca, 'XTickLabel', {'<1', '<2','<3','<=4','>4'})
end

