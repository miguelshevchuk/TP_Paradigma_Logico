propiedad('Tinsmith Circle 1774', 3, true, 0, 700).
propiedad('Av. Moreno 708', 7, true, 30, 2000).
propiedad('Av. Siempre Viva 742', 4, true, 0, 1000).
propiedad('Calle Falsa 123', 3, false, 0, 200).

usuario(carlos, 3, true, _).
usuario(ana, _, _, 30).
usuario(maria, 2, _, 15).

usuario(pedro, Ambientes, Jardin, MetrosPileta) :-
  usuario(maria, Ambientes, Jardin, MetrosPileta).

usuario(chameleon, Ambientes, Jardin, MetrosPileta) :-
  usuario(Usuario, Ambientes, Jardin, MetrosPileta),
  Usuario \= chameleon.

mismaCantidadAmbientes(propiedad(Direccion1, Ambientes, TieneJardin1, MetrosPileta1, Precio1), propiedad(Direccion2, Ambientes, TieneJardin2, MetrosPileta2, Precio2)) :-
  propiedad(Direccion1, Ambientes, TieneJardin1, MetrosPileta1, Precio1),
  propiedad(Direccion2, Ambientes, TieneJardin2, MetrosPileta2, Precio2),
  Direccion1 \= Direccion2.

propiedadCumpleCaracteristicas(propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio), usuario(Nombre, AmbientesDeseados, TieneJardin, MetrosPiletaDeseados)) :-
  propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio),
  usuario(Nombre, AmbientesDeseados, TieneJardin, MetrosPiletaDeseados),
  cumpleCaracteristicaAmbientes(propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio), AmbientesDeseados),
  cumpleCaracteristicaPileta(propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio), MetrosPiletaDeseados).

cumpleCaracteristicaAmbientes(propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio), AmbientesDeseados) :-
  propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio),
  AmbientesDeseados =< Ambientes.

cumpleCaracteristicaPileta(propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio), MetrosPiletaDeseados) :-
  propiedad(Direccion, Ambientes, TieneJardin, MetrosPileta, Precio),
  MetrosPiletaDeseados =< MetrosPileta.

%Consulta: propiedad(Direccion, _, _, 30, _).
%Respuesta: Direccion = 'Av. Moreno 708'.

%Consulta: mismaCantidadAmbientes(propiedad(Direccion1, Ambientes, _, _, _), propiedad(Direccion2, Ambientes, _, _, _)).
/*Respuesta:
Direccion1 = 'Tinsmith Circle 1774',
Ambientes = 3,
Direccion2 = 'Calle Falsa 123' ;
Direccion1 = 'Calle Falsa 123',
Ambientes = 3,
Direccion2 = 'Tinsmith Circle 1774' ;
false.
*/

%Consulta: usuario(pedro, Ambientes, Jardin, MetrosPileta).
/*Respuesta:
Ambientes = 2,
MetrosPileta = 15.
*/

%Consulta: cumpleCaracteristicaAmbientes(propiedad(Direccion, _, _, _, _), 2).
/*Respuesta:
Direccion = 'Tinsmith Circle 1774' ;
Direccion = 'Av. Moreno 708' ;
Direccion = 'Av. Siempre Viva 742' ;
Direccion = 'Calle Falsa 123'.
*/

%Consulta: propiedadCumpleCaracteristicas(propiedad(Direccion, _, _, _, _), usuario(pedro, 2, _, 15)).
/*Respuesta:
Direccion = 'Av. Moreno 708' ;
false.
*/
