<template>
  <div id="root">
    <current-plan></current-plan>
    <bdm-scoring></bdm-scoring>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import CurrentPlan from './current-plan.vue';
import BdmScoring from './bdm-scoring.vue';

export default {
  data: function () {
    return {
      message: ""
    }
  },
  components: {
    CurrentPlan,
    BdmScoring
  }
}
</script>

