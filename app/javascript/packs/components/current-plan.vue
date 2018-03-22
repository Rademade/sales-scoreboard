<template>
    <div id="current-plan" class="main__block main__block--left">

        <div class="main__block__title-box">
            <h3 class="title title--fact">${{wonTotalFact}}</h3>
            <h4 class="subtitle subtitle--fact">Won</h4>
        </div>

        <div class="main__block__title-box">
            <h3 class="title title--plan">${{wonTotalPlan}}</h3>
            <h4 class="subtitle subtitle--plan">Plan</h4>
        </div>

    </div>
</template>

<script>
    export default {
        props: ['wonTotalFact', 'wonTotalPlan']
    }
</script>
