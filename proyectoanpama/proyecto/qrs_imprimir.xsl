<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <title>QRs para imprimir - MAPSHOP</title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }

          body {
            font-family: Arial, sans-serif;
            background: white;
            color: #333;
          }

          /* Esta cabecera solo se ve en pantalla, no se imprime */
          .no-print {
            background-color: #222;
            color: white;
            text-align: center;
            padding: 20px;
          }

          .no-print h1 { font-size: 1.5rem; margin-bottom: 6px; }
          .no-print p  { font-size: 0.85rem; color: #aaa; }

          .btn-imprimir {
            display: inline-block;
            margin-top: 12px;
            background: white;
            color: #222;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            border: none;
            font-weight: bold;
          }
          .btn-imprimir:hover { background: #eee; }

          /* GRID DE QRs */
          .hoja {
            padding: 20px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            max-width: 800px;
            margin: 20px auto;
          }

          /* CADA QR */
          .qr-item {
            border: 2px dashed #ccc;
            border-radius: 6px;
            padding: 16px;
            text-align: center;
          }

          .qr-item img {
            width: 150px;
            height: 150px;
            display: block;
            margin: 0 auto 10px;
          }

          .qr-nombre {
            font-size: 0.8rem;
            font-weight: bold;
            margin-bottom: 4px;
            line-height: 1.3;
          }

          .qr-id {
            font-size: 0.75rem;
            color: #888;
            margin-bottom: 4px;
          }

          .qr-precio {
            font-size: 1rem;
            font-weight: bold;
            color: #222;
          }

          /* INSTRUCCIONES DE RECORTE */
          .instrucciones {
            text-align: center;
            font-size: 0.75rem;
            color: #aaa;
            margin: 0 auto 20px;
            max-width: 800px;
            padding: 0 20px;
          }

          /* ── ESTILOS DE IMPRESIÓN ── */
          @media print {
            /* Ocultamos la cabecera y el botón */
            .no-print { display: none; }

            body { background: white; }

            .hoja {
              margin: 0;
              padding: 10px;
              max-width: 100%;
            }

            .qr-item {
              break-inside: avoid;
            }
          }
        </style>
      </head>
      <body>

     
        <div class="hoja">
          <xsl:for-each select="inventario/objeto">
            <div class="qr-item">

             
              <img>
                <xsl:attribute name="src">
                  <xsl:text>https://api.qrserver.com/v1/create-qr-code/?data=http://mapshop.local/item_</xsl:text>
                  <xsl:value-of select="id"/>
                  <xsl:text>&amp;format=svg&amp;size=150x150</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:text>QR </xsl:text>
                  <xsl:value-of select="id"/>
                </xsl:attribute>
              </img>

              <div class="qr-nombre"><xsl:value-of select="nombre"/></div>
              <div class="qr-id">ID: <xsl:value-of select="id"/></div>
              <div class="qr-precio"><xsl:value-of select="precio"/>&#8364;</div>

            </div>
          </xsl:for-each>
        </div>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
