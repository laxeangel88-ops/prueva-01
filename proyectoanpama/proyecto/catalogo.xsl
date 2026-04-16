<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Catálogo - MAPSHOP</title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }

          body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
          }

          header {
            background-color: #222;
            color: white;
            text-align: center;
            padding: 30px;
          }

          header h1 { font-size: 2rem; margin-bottom: 8px; }
          header p  { font-size: 0.9rem; color: #aaa; }

          main {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
          }

          h2 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: #555;
          }

          /* GRID DE TARJETAS */
          .catalogo {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
          }

          /* TARJETA */
          .tarjeta {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
          }

          .tarjeta-header {
            background-color: #222;
            color: white;
            padding: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }

          .tarjeta-id   { font-size: 0.7rem; color: #aaa; margin-bottom: 4px; }
          .tarjeta-nombre { font-size: 1rem; font-weight: bold; }

          .tarjeta-precio {
            font-size: 1.5rem;
            font-weight: bold;
            color: #ffcc00;
            white-space: nowrap;
            margin-left: 12px;
          }

          .tarjeta-body { padding: 16px; }

          .campo {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            font-size: 0.85rem;
          }
          .campo:last-child { border-bottom: none; }

          .campo-label { color: #888; font-weight: bold; text-transform: uppercase; font-size: 0.75rem; }
          .campo-valor { color: #333; text-align: right; }

          .descripcion {
            background: #f9f9f9;
            border-left: 4px solid #222;
            padding: 10px 14px;
            margin: 0 16px 16px;
            font-size: 0.82rem;
            color: #555;
            line-height: 1.6;
            border-radius: 0 4px 4px 0;
          }

          /* QR */
          .qr-section {
            text-align: center;
            padding: 16px;
            border-top: 1px solid #eee;
          }

          .qr-section p {
            font-size: 0.7rem;
            color: #aaa;
            text-transform: uppercase;
            margin-bottom: 10px;
            letter-spacing: 0.05em;
          }

          .qr-section img {
            width: 120px;
            height: 120px;
          }

          .qr-id {
            font-size: 0.72rem;
            color: #aaa;
            margin-top: 6px;
          }

          /* BOTÓN VOLVER */
          .btn-volver {
            display: block;
            width: fit-content;
            margin: 30px auto;
            background-color: #222;
            color: white;
            text-decoration: none;
            padding: 12px 28px;
            border-radius: 6px;
            font-size: 0.95rem;
          }
          .btn-volver:hover { background-color: #444; }

          footer {
            text-align: center;
            padding: 20px;
            font-size: 0.8rem;
            color: #aaa;
          }

          @media (max-width: 600px) {
            header h1 { font-size: 1.5rem; }
            .catalogo { grid-template-columns: 1fr; }
          }
        </style>
      </head>
      <body>

        <header>
          <h1>🖥️ MAPSHOP</h1>
          <p>Catálogo de objetos disponibles</p>
        </header>

        <main>
          <h2>
            <!-- Cuenta cuántos objetos hay en el XML -->
            <xsl:value-of select="count(inventario/objeto)"/> objetos en venta
          </h2>

          <div class="catalogo">
            <!-- BUCLE: recorre cada <objeto> del XML -->
            <xsl:for-each select="inventario/objeto">
              <xsl:call-template name="tarjeta"/>
            </xsl:for-each>
          </div>

          <a href="index.html" class="btn-volver">← Volver al inicio</a>
        </main>

        <footer>
          <p>MAPSHOP 2025 — Generado con XML + XSLT</p>
        </footer>

      </body>
    </html>
  </xsl:template>


  <xsl:template name="tarjeta">
    <div class="tarjeta">

      <!-- CABECERA: nombre y precio -->
      <div class="tarjeta-header">
        <div>
          <div class="tarjeta-id">ID: <xsl:value-of select="id"/></div>
          <div class="tarjeta-nombre"><xsl:value-of select="nombre"/></div>
        </div>
        <div class="tarjeta-precio">
          <xsl:value-of select="precio"/>&#8364;
        </div>
      </div>

      <!-- CAMPOS: categoría, estado, propietario -->
      <div class="tarjeta-body">
        <div class="campo">
          <span class="campo-label">Categoría</span>
          <span class="campo-valor"><xsl:value-of select="categoria"/></span>
        </div>
        <div class="campo">
          <span class="campo-label">Estado</span>
          <span class="campo-valor"><xsl:value-of select="estado"/></span>
        </div>
        <div class="campo">
          <span class="campo-label">Propietario</span>
          <span class="campo-valor"><xsl:value-of select="propietario"/></span>
        </div>
      </div>

      <!-- DESCRIPCIÓN -->
      <div class="descripcion">
        <xsl:value-of select="descripcion"/>
      </div>

      <!-- QR: se genera automáticamente con la API usando el <id> del XML -->
      <div class="qr-section">
        <p>Código QR</p>
        <img>
          <xsl:attribute name="src">
            <xsl:text>https://api.qrserver.com/v1/create-qr-code/?data=http://mapshop.local/item_</xsl:text>
            <xsl:value-of select="id"/>
            <xsl:text>&amp;format=svg&amp;size=120x120</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:text>QR objeto </xsl:text>
            <xsl:value-of select="id"/>
          </xsl:attribute>
        </img>
        <div class="qr-id">item_<xsl:value-of select="id"/></div>
      </div>

    </div>
  </xsl:template>

</xsl:stylesheet>
