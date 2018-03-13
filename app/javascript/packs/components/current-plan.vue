<template>
    <div id="current-plan">
        <div>Won – {{closed}} $</div>
        <div>Plan – {{currentPlan}} $</div>
    </div>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "",
        closed: 400000,
        currentPlan: 200000
      }
    }
  }
</script>

<style scoped>

</style>