clear all
close all
clc

%{
    Datos de la actividad:
    Proyecto Final: Correlaci�n Cruzada Normalizada.
    Descripci�n: Resuelve cualquiera de las propuestas de proyecto como un problema de optimizaci�n 
    con restricciones. Puedes utilizar el algoritmo evolutivo de tu preferencia.
%}


%Para comenzar con la resoluci�n del proyecto, debemos primero cargar y crear todos los datos necesarios de la problem�tica, es decir, las im�genes, H y W, etc.

%Cargamos la imagen original (la imagen en donde buscaremos la plantilla).
%La llamaremos Imagen tal cual:

Imagen = imread('Image_1.bmp');

%Ahora, cargamos la segunda imagen (la plantilla). Le daremos de nombre Plantilla tal cual:

Plantilla = imread('Template.bmp');

%Ahora, requerimos hacer que las imagenes se encuentren en escala de grises, no en formato RGB. As� que, las convertiremos:

%Mediante la funci�n rgb2gray, pasaremos a la Imagen Original (que guardamos con nombre Imagen) 
%como par�metro para que nos regrese tal imagen en blanco y negro.

%Al valor obtenido le llamaremos ImagenTratada:
ImagenTratada = rgb2gray(Imagen);

%Hacemos lo mismo para la plantilla. Al resultado lo llamaremos PlantillaTratada:

PlantillaTratada = rgb2gray(Plantilla);

%Ahora obtenemos los tama�os, en cada dimesi�n, de ambas imagenes. Tales valores los almacenamos en matrices:

[H,W] = size(ImagenTratada);
[h,w] = size(PlantillaTratada);

%A continuaci�n, establecemos los valores de los par�metros que requiere el algoritmo:

%---------------------------------------------------------
%Dimensi�n:

Dimension = 2;%Definimos el valor de la dimensi�n. En este caso es dos, ya que solamente requerimos obtenemos los valores de x e y del punto en la imagen que representa el match de la plantilla con esta.

%---------------------------------------------------------

%---------------------------------------------------------

%---------------------------------------------------------

disp('Correlaci�n Cruzada Normalizada');

%---------------------------------------------------------
%N�mero De Individuos:

%Pedimos primero el n�mero de individuos que tendr� nuestra poblaci�n:
NumeroDeIndividuos = -1;
while NumeroDeIndividuos < 5 %Definimos tambi�n que el n�mero de individuos, en este caso, debe de ser mayor a 5 para ser un valor v�lido (ya que en la polinizaci�n local se requieren por lo menos 3 individuos diferentes (Xi, Xj & Xk)).
    NumeroDeIndividuos = input('\nIngrese El N�mero De Individuos Que Tendr� La Poblaci�n (M�nimo 5):\n>>> ');
end

%---------------------------------------------------------

%---------------------------------------------------------
%N�mero De Iteraciones:

%Pedimos el n�mero de iteraciones a generar:
NumeroDeIteraciones= -1;
while NumeroDeIteraciones <= 0
    NumeroDeIteraciones = input('\nIngrese El N�mero De Iteraciones A Generar:\n>>> ');
end

%---------------------------------------------------------

%---------------------------------------------------------
%L�mites:

%En este caso los l�mites no ser�n pedidos, se obtendr�n autom�ticamente, con
%el prop�sito de evitar crear individuos en luagres  donde el tama�o de la plantilla supere el tama�o de la imagen original. 

%El valor m�nimo en cada dimensi�n [x,y] es 1, ya que no hay posiciones negativas (x,y) en la imagen.
Minimo = [1 1]'; %Por lo tanto, la matriz de m�nimo ser� de valores 1 y 1 para x e y.

%El valor m�ximo en x ser� el ancho de la imagen original menos el ancho de la plantilla. As� aseguramos lo descrito anteriormente:
LimiteMaximoX = W - w;

%Y para el l�mite m�ximo en y ser� el alto de la imagen original menos el alto de la plantilla:
LimiteMaximoY = H - h;

%Entonces, creamos la matrix de M�ximo utilizando los valores obtenidos con anterioridad.
Maximo = [LimiteMaximoX LimiteMaximoY]'; 

%---------------------------------------------------------

%---------------------------------------------------------
%Par�metros constantes requeridos por los algoritmos:

%Definimos los valores constantes con valores aceptables:

ParametroDePaso = 1.5;
CriterioDeProbabilidad = 0.6; %en este caso el criterio de probabilidad esta entre 0.5, ya que en este algoritmo la polinizaci�n local (algoritmo de evoluci�n diferencial) genera resultados muy favorables, por lo que es de suma importancia que este m�todo se realize constantemente.
FactorDeAmplificacion = 1.2;
ConstanteDeRecombinacion = 0.9;

%---------------------------------------------------------

%Obtenemos y mostramos los resultados obtenidos:

format longEng

%---------------------------------------------------------
%Polinizaci�n evolutiva (Algoritmo h�brido creado):
disp(' ');

Solucion = PolinizacionEvolutiva(ImagenTratada,PlantillaTratada,NumeroDeIteraciones,NumeroDeIndividuos, Minimo, Maximo, Dimension, ParametroDePaso, CriterioDeProbabilidad ,FactorDeAmplificacion,ConstanteDeRecombinacion);

disp('Resultado De (x,y) Obtenido: ');
valor = sprintf('X: %d  | Y: %d | Evaluaci�n: %d\n',Solucion(1),Solucion(2),NCC(ImagenTratada,PlantillaTratada,Solucion));
disp(valor);

%Mostramos la imagen con el match encontrado:
figure('Name','  R e s u l t a d o  O b t e n i d o')
hold on

imshow(Imagen);

%En variables auxiliares guardamos los valores de x e y respectivos al valor de la Soluci�n encontrada:
xp = Solucion(1);
yp = Solucion(2);

%Dibujamos el match en la imagen:
line([xp xp+w], [yp yp],'Color','r','LineWidth',3);
line([xp xp], [yp yp+h],'Color','r','LineWidth',3);
line([xp+w xp+w], [yp yp+h],'Color','r','LineWidth',3);
line([xp xp+w], [yp+h yp+h],'Color','r','LineWidth',3);


