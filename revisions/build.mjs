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

const footer = `<div style="width:100%;font-size:8pt;font-family:Arial,sans-serif;padding:0 16mm;display:flex;justify-content:space-between">
  <span>Modélisation de Données · Examen type</span>
  <span><span class="pageNumber"></span> / <span class="totalPages"></span></span>
</div>`

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
    headerTemplate: '<span></span>',
    footerTemplate: footer,
    margin: { top: '15mm', bottom: '17mm', left: '16mm', right: '16mm' },
  })
  rmSync(html)
}

await browser.close()
