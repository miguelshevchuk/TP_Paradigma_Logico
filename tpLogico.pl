persona(carlos).
persona(ana).
persona(maria).
persona(pedro).
persona(chameleon).

propiedad(Propiedad) :-
  tiene(Propiedad, _).

% conjuntoInstalaciones(Instalaciones).

tiene('Tinsmith Circle 1774', ambientes(3)).
tiene('Tinsmith Circle 1774', jardin).
tiene('Tinsmith Circle 1774', instalaciones(['Aire Acondicionado', 'Extractor de aire', 'Calefacción a gas'])).
precio('Tinsmith Circle 1774', 700).

tiene('Av. Moreno 708', ambientes(7)).
tiene('Av. Moreno 708', jardin).
tiene('Av. Moreno 708', piscina(30)).
tiene('Av. Moreno 708', instalaciones(['Aire Acondicionado', 'Extractor de aire', 'Calefacción por loza radiante', 'Vidrios dobles'])).
precio('Av. Moreno 708', 2000).

tiene('Av. Siempre Viva 742', ambientes(4)).
tiene('Av. Siempre Viva 742', jardin).
tiene('Av. Siempre Viva 742', instalaciones(['Calefacción a gas'])).
precio('Av. Siempre Viva 742', 1000).

tiene('Calle Falsa 123', ambientes(3)).
precio('Calle Falsa 123', 2000).

quiere(carlos, ambientes(3)).
quiere(carlos, jardin).
quiere(ana, piscina(100)).
quiere(ana, instalaciones(['Aire Acondicionado', 'Vidrios dobles'])).
quiere(maria, piscina(15)).
quiere(maria, ambientes(2)).

quiere(pedro, instalaciones(['Vidrios dobles', 'Calefacción por loza radiante'])).
quiere(pedro, Deseo) :-
  quiere(maria, Deseo).

quiere(chameleon, Deseo) :-
  Alguien \= chameleon,
  quiere(Alguien, Deseo).

inicializarPropPersona(Propiedad, Persona) :-
  persona(Persona),
  propiedad(Propiedad).

cumple(Propiedad, ambientes(AmbientesDeseados)) :-
  quiere(_, ambientes(AmbientesDeseados)),
  tiene(Propiedad, ambientes(Cantidad)),
  Cantidad >= AmbientesDeseados.

cumple(Propiedad, piscina(MetrosPiletaDeseados)) :-
  tiene(Propiedad, piscina(MetrosPileta)),
  quiere(_, piscina(MetrosPiletaDeseados)),
  MetrosPileta >= MetrosPiletaDeseados.

cumple(Propiedad,instalaciones(InstalacionesDeseadas)):-
  % conjuntoInstalaciones(Instalaciones),
    quiere(_, instalaciones(InstalacionesDeseadas)),
		tiene(Propiedad, instalaciones(Instalaciones)),
		forall(member(Instalacion, InstalacionesDeseadas), member(Instalacion,Instalaciones)).

cumple(Propiedad, Caracteristica) :-
  tiene(Propiedad, Caracteristica).

caracteristicaQueNoCumpleNingunaPropiedad(Caracteristica) :-
  quiere(_,Caracteristica),
  not(cumple(_, Caracteristica)).

cumpleTodo(Propiedad, Persona) :-
  persona(Persona),
  propiedad(Propiedad),
  forall(quiere(Persona,Deseo), cumple(Propiedad, Deseo)).

mejorOpcion(Propiedad, Persona) :-
  cumpleTodo(Propiedad,Persona),
  precio(Propiedad,Precio),
  forall(cumpleTodo(Propiedad2, Persona), (precio(Propiedad2, Precio2),  Precio =< Precio2)).

mejorOpcion2(Propiedad, Persona) :-
  cumpleTodo(Propiedad, Persona),
  precio(Propiedad, Precio),
  not((cumpleTodo(Propiedad2, Persona), precio(Propiedad2, Precio2), Precio2 < Precio)).

estaSatisfecho(Persona) :-
  cumpleTodo(_, Persona).

conjuntoSegun(Condicion, EntidadesSinRepetir) :-
  findall(Entidad, call(Condicion, Entidad), Entidades),
  list_to_set(Entidades, EntidadesSinRepetir).

efectividad(Efectividad):-
  conjuntoSegun(estaSatisfecho, PersonasSatisfechas),
  conjuntoSegun(persona, Personas),
  length(PersonasSatisfechas, CantSatisfechos),
  length(Personas, CantPersonas),
  Efectividad is CantSatisfechos / CantPersonas.

esPropiedadChicaa(Propiedad):-
  propiedad(Propiedad),
  not(tiene(Propiedad,ambientes(_))).

esPropiedadChica(Propiedad):-
  tiene(Propiedad,ambientes(1)).

esPropiedadTop(Propiedad):-
  cumple(Propiedad, instalaciones(['Aire Acondicionado'])),
  not(esPropiedadChica(Propiedad)).


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
% ?- cumple(_, ambientes(2)).
% true .

%5)
% ?- cumple(Propiedad, Deseo), quiere(pedro, Deseo).
% Propiedad = 'Tinsmith Circle 1774',
% Deseo = ambientes(2) ;
% Propiedad = 'Av. Moreno 708',
% Deseo = ambientes(2) ;
% Propiedad = 'Av. Siempre Viva 742',
% Deseo = ambientes(2) ;
% Propiedad = 'Calle Falsa 123',
% Deseo = ambientes(2) ;
% Propiedad = 'Tinsmith Circle 1774',
% Deseo = ambientes(2) ;
% Propiedad = 'Av. Moreno 708',
% Deseo = ambientes(2) ;
% Propiedad = 'Av. Siempre Viva 742',
% Deseo = ambientes(2) ;
% Propiedad = 'Calle Falsa 123',
% Deseo = ambientes(2) ;
% Propiedad = 'Av. Moreno 708',
% Deseo = piscina(15) ;
% Propiedad = 'Av. Moreno 708',
% Deseo = piscina(15) ;
% false.

%6)
% ?- quiere(Persona, Deseo), cumple('Av. Moreno 708', Deseo).
% Persona = carlos,
% Deseo = ambientes(3) ;
% Persona = carlos,
% Deseo = jardin ;
% Persona = maria,
% Deseo = piscina(15) ;
% Persona = maria,
% Deseo = piscina(15) ;
% Persona = maria,
% Deseo = ambientes(2) ;
% Persona = maria,
% Deseo = ambientes(2) ;
% Persona = pedro,
% Deseo = piscina(15) ;
% Persona = pedro,
% Deseo = piscina(15) ;
% Persona = pedro,
% Deseo = ambientes(2) ;
% Persona = pedro,
% Deseo = ambientes(2) ;
% false.

% 7)
% ?- caracteristicaQueNoCumpleNingunaPropiedad(Caracteristica).
% Caracteristica = piscina(100) ;
% false.

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
% ?- mejorOpcion2(Propiedad, Persona).
% Propiedad = 'Tinsmith Circle 1774',
% Persona = carlos ;
% Propiedad = 'Tinsmith Circle 1774',
% Persona = carlos ;
% Propiedad = 'Av. Moreno 708',
% Persona = maria ;
% Propiedad = 'Av. Moreno 708',
% Persona = maria ;
% Propiedad = 'Av. Moreno 708',
% Persona = maria ;
% Propiedad = 'Av. Moreno 708',
% Persona = pedro ;
% Propiedad = 'Av. Moreno 708',
% Persona = pedro ;
% Propiedad = 'Av. Moreno 708',
% Persona = pedro ;
% Propiedad = 'Tinsmith Circle 1774',
% Persona = chameleon ;
% Propiedad = 'Tinsmith Circle 1774',
% Persona = chameleon ;
% false.

%10)
% ?- efectividad(Efectividad).
% Efectividad = 0.8.

% Gracias al polimorfismo ad-hoc, solo tuvimos que agregar una clausula de "cumple" para cumplir con los requerimientos.
% Tambien hicimos buen uso del polimorfismo parametrico, en el predicado "cumpleTodo".

%11)
% ?- esPropiedadTop(Propiedad).
% false.
