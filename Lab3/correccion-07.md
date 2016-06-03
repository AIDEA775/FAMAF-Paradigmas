# Laboratorio 3 - Corrección

### Nota: 9 (93%)

### Observaciones Generales

Muy buen trabajo! Algunos errores menores a nivel funcional, pero la arquitectura muy bien pensada y el código legible.

Sigan así chicos.

### Funcionalidad (45%)
- Falla la comparación de cartas, ya que no compara por número sino por palo. Por ejemplo, tengo este caso:

```
    Mazo: 3 cartas
    Ronda:
    A  O3
    B  C2



        C(1): O5 C12 C10 B3 C3 B7 C2 B4 O4
    Que carta vas a jugar C?
        >>> C12   <<<

    El jugador A gano la ronda.
```

Donde el jugador C juega C12, con lo cual debería ganar la ronda, sin embargo la gana el jugador A ya que el ORO le gana a la COPA, sin embargo este criterio solo es para desempatar cartas con igual número.

- SMIN  no funciona. Por ejemplo, si estoy en esta situación: E4 C2 E8 B5 C8 B2 SMIN y juego SMIN, esperaría que la carta C2 salga del mazo del jugador, y robar otra carta del mazo gral. Sin embargo obtengo esto: E4 C2 E8 B5 C8 B2 E2. Vemos que C2 sigue estando en el mazo del jugador.

### Arquitectura (22.5%)

- Sin comentarios.

### Aspectos varios (22.5%)

- No tienen la carpeta `bin`, ni tampoco la crean con el make motivo por el cual éste falla.

- `alejandro jose` podría commitear más seguido.

### Code Styling (10%)

- Sin comentarios.