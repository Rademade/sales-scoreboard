<template>
    <div id="current-plan">
        <div>Won – {{wonTotalFact}} $</div>
        <div>Plan – {{wonTotalPlan}} $</div>
    </div>
</template>

<script>
    export default {
        props: ['wonTotalFact', 'wonTotalPlan']
    }
</script>

<style scoped>

</style>