// Génère les PDF de l'examen type à partir des fichiers Markdown.
// Depuis la racine du dépôt : node revisions/build.mjs
import { execFileSync } from 'node:child_process'
import { existsSync, rmSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'
import { chromium } from 'playwright-chromium'

const dir = dirname(fileURLToPath(import.meta.url))
// Le corrigé est ignoré par git : il n'existe pas dans un clone du dépôt.
const documents = ['examen-type', 'examen-type-corrige'].filter((name) => existsSync(join(dir, `${name}.md`)))

const pageNumbers = `<div style="width:100%;text-align:center;font-size:9px;color:#666;font-family:Helvetica,Arial,sans-serif">
  <span class="pageNumber"></span> / <span class="totalPages"></span>
</div>`

const headers = {
  'examen-type': `<div style="width:100%;font-size:12px;color:#222;font-family:Helvetica,Arial,sans-serif;padding:0 18mm;text-align:right">
    Nom :&nbsp;____________&nbsp;&nbsp; Prénom :&nbsp;____________&nbsp;&nbsp; Classe :&nbsp;________
  </div>`,
  'examen-type-corrige': `<div style="width:100%;font-size:12px;color:#d6271e;font-weight:bold;font-family:Helvetica,Arial,sans-serif;padding:0 18mm;text-align:right">CORRIGÉ</div>`,
}

const browser = await chromium.launch()
const page = await browser.newPage()

for (const name of documents) {
  const html = join(dir, `.${name}.html`)
  execFileSync('pandoc', [`${name}.md`, '-f', 'markdown+task_lists', '-s', '--columns=10000', '--css=style.css', '-o', html], { cwd: dir })
  await page.goto(`file://${html}`)
  await page.pdf({
    path: join(dir, `${name}.pdf`),
    format: 'A4',
    printBackground: true,
    displayHeaderFooter: true,
    headerTemplate: headers[name],
    footerTemplate: pageNumbers,
    margin: { top: '22mm', bottom: '16mm', left: '18mm', right: '18mm' },
  })
  rmSync(html)
}

await browser.close()
