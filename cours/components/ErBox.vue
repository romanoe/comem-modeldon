<script setup lang="ts">
interface Row {
  key?: string
  name: string
  type?: string
  id?: boolean
  note?: string
}

withDefaults(defineProps<{
  name: string
  rows?: Row[]
  emptyRows?: number
  hl?: 'name' | 'rows' | 'keys' | 'none'
}>(), {
  rows: () => [],
  emptyRows: 0,
  hl: 'none',
})
</script>

<template>
  <table class="er-box">
    <thead>
      <tr>
        <th :colspan="rows.some(r => r.note) ? 3 : 2" :class="{ hl: hl === 'name' }">{{ name }}</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="n in emptyRows" :key="`empty-${n}`">
        <td class="er-key" />
        <td class="er-attr" />
      </tr>
      <tr v-for="row in rows" :key="row.name">
        <td class="er-key" :class="{ hl: hl === 'keys' }">{{ row.key ?? '' }}</td>
        <td class="er-attr" :class="{ hl: hl === 'rows', id: row.id }">
          <span class="er-name">{{ row.name }}</span><span v-if="row.type" class="er-type">{{ row.type }}</span>
        </td>
        <td v-if="rows.some(r => r.note)" class="er-note">{{ row.note ?? '' }}</td>
      </tr>
    </tbody>
  </table>
</template>

<style scoped>
.er-box {
  border-collapse: collapse;
  border: 1px solid var(--text);
  margin: 0.55rem auto;
  width: auto;
  min-width: 14rem;
  font-size: 0.72rem;
  line-height: 1.2;
}

.er-box th,
.er-box td {
  border: 1px solid var(--text) !important;
  padding: 0.35rem 0.7rem;
  text-align: left;
  vertical-align: middle;
  background: none;
}

.er-box th {
  text-align: center;
  font-weight: 700;
  font-size: 0.82rem;
  letter-spacing: 0;
  text-transform: none;
  padding: 0.45rem 0.6rem;
}

.er-attr:empty::after,
.er-key:empty::after {
  content: '\00a0';
}

.er-key {
  width: 4.6rem;
  font-weight: 700;
  text-align: center;
  white-space: nowrap;
}

.er-attr.id {
  font-weight: 700;
  text-decoration: underline;
}

.er-type {
  opacity: 0.75;
  margin-left: 0.5em;
}

.er-note {
  font-style: italic;
  opacity: 0.6;
  white-space: nowrap;
}

.er-box th.hl,
.er-box td.hl,
.er-box td.hl .er-type {
  color: #e92528;
  opacity: 1;
}
</style>
