<template>
  <div id="root" class="main">
    <current-plan
      v-bind:won-total-fact="wonTotalFact"
      v-bind:won-suggestion="wonSuggestion"
      v-bind:won-total-plan="wonTotalPlan"
    ></current-plan>
    <bdm-scoring
      v-bind:new-deals-plan="newDealsPlan"
      v-bind:won-deals-plan="wonDealsPlan"
    ></bdm-scoring>
  </div>
</template>

<script>
import CurrentPlan from './current-plan.vue';
import BdmScoring from './bdm-scoring.vue';
import { HTTP } from 'Services/http.js';

export default {
  data: function () {
    return {
      wonTotalFact: 0,
      wonSuggestion: 0,
      wonTotalPlan: 0,
      newDealsPlan: 0,
      wonDealsPlan: 0
    }
  },
  created() {
    this.loadTotalWon();
    setInterval(() => {
      this.loadTotalWon();
    }, 10*60*1000);
  },
  methods: {
    loadTotalWon: function() {
      HTTP.get('plan').then(response => {
        this.wonTotalFact = response.data.won_total_fact;
        this.wonSuggestion = response.data.won_suggestion;
        this.wonTotalPlan = response.data.won_total_plan;
        this.newDealsPlan = response.data.new_deals_plan;
        this.wonDealsPlan = response.data.won_deals_plan;
      });
    }
  },
  components: {
    CurrentPlan,
    BdmScoring
  }
}
</script>

