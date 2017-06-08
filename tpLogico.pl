persona(carlos).
persona(ana).
persona(maria).
persona(pedro).
persona(chameleon).

propiedad('Tinsmith Circle 1774').
propiedad('Av. Moreno 708').
propiedad('Av. Siempre Viva 742').
propiedad('Calle Falsa 123').

tiene('Tinsmith Circle 1774', ambientes(3)).
tiene('Tinsmith Circle 1774', jardin()).
precio('Tinsmith Circle 1774', 700).

tiene('Av. Moreno 708', ambientes(7)).
tiene('Av. Moreno 708', jardin()).
tiene('Av. Moreno 708', piscina(30)).
precio('Av. Moreno 708', 2000).

tiene('Av. Siempre Viva 742', ambientes(4)).
tiene('Av. Siempre Viva 742', jardin()).
precio('Av. Siempre Viva 742', 1000).

tiene('Calle Falsa 123', ambientes(3)).
precio('Calle Falsa 123', 2000).

quiere(carlos, ambientes(3)).
quiere(carlos, jardin()).
quiere(ana, piscina(100)).
quiere(maria, piscina(15)).
quiere(maria, ambientes(2)).

quiere(pedro, Deseo) :-
  quiere(maria, Deseo).

quiere(chameleon, Deseo) :-
  quiere(Alguien, Deseo),
  Alguien \= chameleon.

cumple(Propiedad, ambientes(AmbientesDeseados)) :-
  tiene(Propiedad, ambientes(Cantidad)),
  Cantidad >= AmbientesDeseados.

cumple(Propiedad, piscina(MetrosPiletaDeseados)) :-
  tiene(Propiedad, piscina(MetrosPileta)),
  MetrosPileta >= MetrosPiletaDeseados.

cumple(Propiedad, Caracteristica) :-
  tiene(Propiedad, Caracteristica).

propiedadCumpleCaracteristicas(Propiedad, Persona) :-
  quiere(Persona, Deseo),
  cumple(Propiedad, Deseo).

cumpleTodo(Propiedad, Persona) :-
  persona(Persona),
  propiedad(Propiedad),
  forall(quiere(Persona,Deseo), cumple(Propiedad, Deseo)).

%%%%%%%%%%%%%%%%    CONSULTAS    %%%%%%%%%%%%%%%%%
%1)
%?- tiene(Propiedad,piscina(30)).
%Propiedad = 'Av. Moreno 708'.

%2)
% ?- tiene(Propiedad,ambientes(Cant)), tiene(Propiedad2, ambientes(Cant)).
% Propiedad = Propiedad2, Propiedad2 = 'Tinsmith Circle 1774',
% Cant = 3 ;
% Propiedad = 'Tinsmith Circle 1774',
% Cant = 3,
% Propiedad2 = 'Calle Falsa 123' ;
% Propiedad = Propiedad2, Propiedad2 = 'Av. Moreno 708',
% Cant = 7 ;
% Propiedad = Propiedad2, Propiedad2 = 'Av. Siempre Viva 742',
% Cant = 4 ;
% Propiedad = 'Calle Falsa 123',
% Cant = 3,
% Propiedad2 = 'Tinsmith Circle 1774' ;
% Propiedad = Propiedad2, Propiedad2 = 'Calle Falsa 123',
% Cant = 3.

%3)
% ?- quiere(pedro, Deseo).
% Deseo = ambientes(2) ;
% Deseo = piscina(15).

%4)
% ?- cumple(Propiedad, ambientes(2)).
% Propiedad = 'Tinsmith Circle 1774' ;
% Propiedad = 'Av. Moreno 708' ;
% Propiedad = 'Av. Siempre Viva 742' ;
% Propiedad = 'Calle Falsa 123' ;
% false.

%5)
% ?- propiedadCumpleCaracteristicas(Propiedad,pedro).
% Propiedad = 'Tinsmith Circle 1774' ;
% Propiedad = 'Av. Moreno 708' ;
% Propiedad = 'Av. Siempre Viva 742' ;
% Propiedad = 'Calle Falsa 123' ;
% false.

%6)
% ?- quiere(Persona, Deseo), cumple('Av. Moreno 708', Deseo).
% Persona = carlos,
% Deseo = ambientes(3) ;
% Persona = carlos,
% Deseo = jardin() ;
% Persona = maria,
% Deseo = piscina(15) ;
% Persona = maria,
% Deseo = ambientes(2) ;
% Persona = pedro,
% Deseo = piscina(15) ;
% Persona = pedro,
% Deseo = ambientes(2) ;
% Persona = chameleon,
% Deseo = ambientes(3) ;
% Persona = chameleon,
% Deseo = jardin() ;
% Persona = chameleon,
% Deseo = piscina(15) ;
% Persona = chameleon,
% Deseo = ambientes(2) ;
% Persona = chameleon,
% Deseo = piscina(15) ;
% Persona = chameleon,
% Deseo = ambientes(2) ;
% ERROR: Out of local stack

% 7)
% ?- quiere(_,Deseo), not(cumple(_, Deseo)).
% Deseo = piscina(100) ;
% Deseo = piscina(100) ;

%8)
% ?- cumpleTodo(Propiedad,Persona).
% Propiedad = 'Tinsmith Circle 1774',
% Persona = carlos ;
% Propiedad = 'Av. Moreno 708',
% Persona = carlos ;
% Propiedad = 'Av. Siempre Viva 742',
% Persona = carlos ;
% Propiedad = 'Av. Moreno 708',
% Persona = maria ;
% Propiedad = 'Av. Moreno 708',
% Persona = pedro ;
% false.
