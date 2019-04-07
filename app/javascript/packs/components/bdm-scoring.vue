<template>
    <div id="bdm-scoring" class="main__block">
        <table class="table">
            <tr class="table__row">
                <td class="table__data table__data--large"></td>
                <td style="color: #3498db;" class="table__data table__data--large">New contacts</td>
                <td style="color: #c48adc;" class="table__data table__data--large">New deals</td>
                <td style="color: #e29e57;" class="table__data table__data--large">Decision deals</td>
                <td style="color: #f1c30f;" class="table__data table__data--large">Won deals</td>
                <td style="color: #00cc56;" class="table__data table__data--large">Won amount</td>
            </tr>
            <tr v-for="(manager, index) in sortedManagers" class="table__row">
                <td class="table__data table__data--name table__data--large table__data--bold">{{manager.name}}</td>
                <td style="color: #3498db;" class="table__data table__data--large">{{manager.person_count}}</td>
                <td style="color: #c48adc;" class="table__data table__data--large">{{manager.created_deals}}</td>
                <td style="color: #e29e57;" class="table__data table__data--large">{{manager.decision_deals}}</td>
                <td style="color: #f1c30f;" class="table__data table__data--large table__data--bold">{{manager.won_deals}}</td>
                <td style="color: #00cc56;" class="table__data table__data--large table__data--bold">{{formatPrice(manager.won_amount)}} $</td>
            </tr>
            <tr class="table__row">
                <td class="table__data table__data--name table__data--large table__data--bold">Total</td>
                <td style="color: #3498db;" class="table__data table__data--large">{{totalPersons}}</td>
                <td style="color: #c48adc;" class="table__data table__data--large">{{totalCreatedDeals}}/{{newDealsPlan}}</td>
                <td style="color: #e29e57;" class="table__data table__data--large">{{totalDecisionDeals}}</td>
                <td style="color: #f1c30f;" class="table__data table__data--large table__data--bold">{{totalWonDeals}}/{{wonDealsPlan}}</td>
                <td style="color: #00cc56;" class="table__data table__data--large table__data--bold">{{formatPrice(totalWonAmount)}} $</td>
            </tr>

        </table>
    </div>
</template>

<script>
    import { HTTP } from 'Services/http.js';
    import { formatPrice } from 'Helpers/format-price.js';

    export default {
        computed: {
            totalActivities: function(){
                return _.sumBy(this.managers, 'activities_count');
            },
            totalPersons: function(){
                return _.sumBy(this.managers, 'person_count');
            },
            totalCreatedDeals: function(){
                return _.sumBy(this.managers, 'created_deals');
            },
            totalDecisionDeals: function(){
                return _.sumBy(this.managers, 'decision_deals');
            },
            totalWonDeals: function(){
                return _.sumBy(this.managers, 'won_deals');
            },
            totalWonAmount: function(){
                return _.sumBy(this.managers, 'won_amount');
            },
            sortedManagers: function() {
                let sorted = _.orderBy(this.managers, ['activities'], ['desc']);
                sorted = _.orderBy(sorted, ['person_count'], ['desc']);
                sorted = _.orderBy(sorted, ['created_deals'], ['desc']);
                sorted = _.orderBy(sorted, ['decision_deals'], ['desc']);
                sorted = _.orderBy(sorted, ['won_deals'], ['desc']);
                return _.orderBy(sorted, ['won_amount'], ['desc']);
            }
        },
        props: ['newDealsPlan', 'wonDealsPlan'],
        data: function () {
            return {
                managers: []
            }
        },
        created() {
            this.loadSalesData();
            setInterval(() => {
                this.loadSalesData();
            }, 5*60*1000);
        },
        methods: {
            formatPrice: formatPrice,
            loadSalesData: function() {
                HTTP.get('sales').then(response => {
                    this.managers = response.data.sales
                });
            }
        }
    }
</script>


<style scoped>
</style>