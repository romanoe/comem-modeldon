<script setup lang="ts">
withDefaults(defineProps<{
  label?: string
  from?: string
  to?: string
  hl?: boolean
  row?: boolean
}>(), {
  label: '',
  from: '',
  to: '',
  hl: false,
  row: false,
})
</script>

<template>
  <div class="er-rel" :class="{ row }">
    <div class="er-rel-end"><slot name="top" /></div>
    <div class="er-rel-link" :class="{ hl }">
      <span v-if="from" class="er-rel-card">{{ from }}</span>
      <span class="er-rel-line" />
      <span v-if="label" class="er-rel-label">{{ label }}</span>
      <span class="er-rel-line" />
      <span v-if="to" class="er-rel-card">{{ to }}</span>
    </div>
    <div class="er-rel-end"><slot name="bottom" /></div>
  </div>
</template>

<style scoped>
.er-rel {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.er-rel.row {
  flex-direction: row;
  justify-content: center;
}

.er-rel.row .er-rel-link {
  flex-direction: row;
  padding: 0 0.15rem;
}

.er-rel.row .er-rel-line {
  width: 0.9rem;
  height: 1px;
}

.er-rel-end {
  display: flex;
  justify-content: center;
}

.er-rel-link {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
  padding: 0.15rem 0;
  color: var(--text);
}

.er-rel-line {
  width: 1px;
  height: 0.9rem;
  background: currentColor;
}

.er-rel-label,
.er-rel-card {
  font-family: var(--font-mono);
  font-size: 0.68rem;
  line-height: 1;
}

.er-rel-card {
  opacity: 0.75;
}

.er-rel-link.hl {
  color: #e92528;
}
</style>
