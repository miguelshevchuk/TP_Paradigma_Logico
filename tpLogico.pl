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
tiene('Tinsmith Circle 1774', instalacion('Aire Acondicionado')).
tiene('Tinsmith Circle 1774', instalacion('Extractor de aire')).
tiene('Tinsmith Circle 1774', instalacion('Calefacción a gas')).
precio('Tinsmith Circle 1774', 700).

tiene('Av. Moreno 708', ambientes(7)).
tiene('Av. Moreno 708', jardin()).
tiene('Av. Moreno 708', piscina(30)).
tiene('Av. Moreno 708', instalacion('Aire Acondicionado')).
tiene('Av. Moreno 708', instalacion('Extractor de aire')).
tiene('Av. Moreno 708', instalacion('Calefacción por loza radiante')).
tiene('Av. Moreno 708', instalacion('Vidrios dobles')).
precio('Av. Moreno 708', 2000).

tiene('Av. Siempre Viva 742', ambientes(4)).
tiene('Av. Siempre Viva 742', jardin()).
tiene('Av. Siempre Viva 742', instalacion('Calefacción a gas')).
precio('Av. Siempre Viva 742', 1000).

tiene('Calle Falsa 123', ambientes(3)).
precio('Calle Falsa 123', 2000).

quiere(carlos, ambientes(3)).
quiere(carlos, jardin()).
quiere(ana, piscina(100)).
quiere(ana, instalacion('Aire Acondicionado')).
quiere(ana, instalacion('Vidrios dobles')).
quiere(maria, piscina(15)).
quiere(maria, ambientes(2)).

quiere(pedro, instalacion('Vidrios dobles')).
quiere(pedro, instalacion('Calefacción por loza radiante')).
quiere(pedro, Deseo) :-
  quiere(maria, Deseo).

quiere(chameleon, Deseo) :-
  quiere(Alguien, Deseo),
  Alguien \= chameleon.

inicializarPropPersona(Propiedad, Persona) :-
  persona(Persona),
  propiedad(Propiedad).

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
  inicializarPropPersona(Propiedad, Persona),
  forall(quiere(Persona,Deseo), cumple(Propiedad, Deseo)).

mejorOpcion(Propiedad, Persona) :-
  inicializarPropPersona(Propiedad, Persona),
  cumpleTodo(Propiedad, Persona),
  findall(Prop, (cumpleTodo(Prop, Persona), elPrecio1EsMenorQueEl2(Prop, Propiedad) ), Propiedades),
  length(Propiedades,Cantidad),
  Cantidad is 0.

elPrecio1EsMenorQueEl2(Propiedad2, Propiedad) :-
  precio(Propiedad, Precio),
  Propiedad2 \= Propiedad,
  precio(Propiedad2, Precio2),
  Precio2 < Precio.

% todosCumplenTodo(Persona, Propiedades) :-
%   findall(Prop, (cumpleTodo(Prop, Persona), Prop \= Propiedad), Propiedades),}.

mejorOpcion2(Propiedad, Persona) :-
  inicializarPropPersona(Propiedad, Persona),
  cumpleTodo(Propiedad, Persona),
  findall(Prop, (cumpleTodo(Prop, Persona), Prop \= Propiedad), Propiedades),
  precioMenorEnTodaLaLista(Propiedad, Propiedades).

precioMenorEnTodaLaLista(Propiedad, []).
precioMenorEnTodaLaLista(Propiedad, [Propiedad2 | Cola]) :-
  precioMenorEnTodaLaLista(Precio, Cola),
  elPrecio1EsMenorQueEl2(Propiedad2, Propiedad).

% mejorOpcion2(Propiedad, Persona) :-
%   inicializarPropPersona(Propiedad, Persona),
%   cumpleTodo(Propiedad, Persona),
%   precio(Propiedad, Precio),
%   forall(precio(Propiedad2,Precio2), (cumpleTodo(Propiedad2, Persona), Propiedad2 \= Propiedad, Precio < Precio2)).

estaSatisfecho(Persona) :-
  persona(Persona),
  findall(Prop, cumpleTodo(Prop, Persona), Propiedades),
  length(Propiedades,Cantidad),
  Cantidad > 0.

filtrarPersonas(Condicion, Personas) :-
  findall(Persona, call(Condicion, Persona), Personas).

efectividad(Efectividad):-
  filtrarPersonas(estaSatisfecho, PersonasSatisfechas),
  filtrarPersonas(persona, Personas),
  length(PersonasSatisfechas, CantSatisfechos),
  length(Personas, CantPersonas),
  Efectividad is CantSatisfechos / CantPersonas.

% esPropiedadChicaa(Propiedad):-
%   not(tiene(Propiedad,ambientes(A))).

esPropiedadChica(Propiedad):-
  propiedad(Propiedad),
  tiene(Propiedad,ambientes(Ambientes)),
  Ambientes =< 1.

esPropiedadTop(Propiedad):-
  not(esPropiedadChica(Propiedad)),
  tiene(Propiedad, instalacion('Aire Acondicionado')).


%%%%%%%%%%%%%%%%    CONSULTAS    %%%%%%%%%%%%%%%%%
%1)
%?- tiene(Propiedad,piscina(30)).
%Propiedad = 'Av. Moreno 708'.

%2)
% ?- tiene(Propiedad,ambientes(Cant)), tiene(Propiedad2, ambientes(Cant)),Propiedad \= Propiedad2.
% Propiedad = 'Tinsmith Circle 1774',
% Cant = 3,
% Propiedad2 = 'Calle Falsa 123' ;
% Propiedad = 'Calle Falsa 123',
% Cant = 3,
% Propiedad2 = 'Tinsmith Circle 1774' ;
% false.

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

%9)
% ?- mejorOpcion(Propiedad, Persona).
% Propiedad = 'Tinsmith Circle 1774',
% Persona = carlos ;
% Propiedad = 'Av. Moreno 708',
% Persona = maria ;
% Propiedad = 'Av. Moreno 708',
% Persona = pedro ;
% false.

%10)
% ?- efectividad(Efectividad).
% Efectividad = 0.6.

% Gracias al polimorfismo, no necesitamos hacer cambios de codigo para la consulta solicitada.
% Como las instalaciones que se agregan, no precisaban un tratamiento diferenciado en el predicado "cumple",
% hicimos buen uso del polimorfismo parametrico, y no tuvimos que modificar el predicado ya mencionado.

%11)
% ?- esPropiedadTop(Propiedad).
% Propiedad = 'Tinsmith Circle 1774' ;
% Propiedad = 'Av. Moreno 708' ;
% false.
