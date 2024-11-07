@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_LIBROS_4638
  as select from    ztb_libros_4638 as Libros
    inner join      ztb_catego_4638 as Categorias on Libros.bi_categ = Categorias.bi_categ
    left outer join ZC_CLNTSLIB4638 as Ventas     on Libros.id_libro = Ventas.IdLibro
  association [0..*] to ZC_CLIENTES4638 as _Clientes on $projection.IdLibro = _Clientes.IdLibro
{
  key Libros.id_libro        as IdLibro,
      Libros.titulo          as Titulo,
      Libros.bi_categ        as Categoria,
      Libros.autor           as Autor,
      Libros.editorial       as Editorial,
      Libros.idioma          as Idioma,
      Libros.paginas         as Paginas,
      @Semantics.amount.currencyCode: 'Moneda'
      Libros.precio          as Precio,
      case
      when Ventas.Ventas < 1 then 0
      when Ventas.Ventas = 1 then 1
      when Ventas.Ventas = 2 then 2
      when Ventas.Ventas > 2 then 3
      else 0
      end                    as Ventas,
      case Ventas.Ventas
      when 0 then ''
      else ''
      end                    as Text,
      Libros.moneda          as Moneda,
      Libros.formato         as Formato,
      Libros.url             as Imagen,
      Categorias.descripcion as Descripcion,
      _Clientes
}
