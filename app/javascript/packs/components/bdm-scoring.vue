<template>
    <div id="bdm-scoring" class="main__block">
        <table class="table">
            <tr v-for="(manager, index) in sortedManagers" class="table__row">
                <td class="table__data table__data--name table__data--large table__data--bold">{{manager.name}}</td>
                <td style="color: #f1c40f;" class="table__data table__data--large">{{manager.activities_count}}</td>
                <td style="color: #3498db;" class="table__data table__data--large">{{manager.person_count}}</td>
                <td style="color: #8e44ad;" class="table__data table__data--large">{{manager.created_deals}}</td>
                <td style="color: #16a085;" class="table__data table__data--large">{{manager.decision_deals}}</td>
                <td style="color: #27ae60;" class="table__data table__data--large table__data--bold">{{manager.won_deals}}</td>
            </tr>
            <tr class="table__row">
                <td class="table__data table__data--name table__data--large table__data--bold">Total</td>
                <td style="color: #f1c40f;" class="table__data table__data--large">{{totalActivities}}</td>
                <td style="color: #3498db;" class="table__data table__data--large">{{totalPersons}}</td>
                <td style="color: #8e44ad;" class="table__data table__data--large">{{totalCreatedDeals}}/{{newDealsPlan}}</td>
                <td style="color: #16a085;" class="table__data table__data--large">{{totalDecisionDeals}}</td>
                <td style="color: #27ae60;" class="table__data table__data--large table__data--bold">{{totalWonDeals}}/{{wonDealsPlan}}</td>
            </tr>

            <tr class="table__row table__row--title">
                <td class="table__data table__data--history" colspan="6">
                    <span style="color: #f1c40f;">Activity</span>
                    <span style="color: #3498db;">New contacts</span>
                    <span style="color: #8e44ad;">New deals</span>
                    <span style="color: #16a085;">Decision deals</span>
                    <span style="color: #27ae60;">Won deals</span>

                </td>
            </tr>
        </table>
    </div>
</template>

<script>
    import { HTTP } from 'Services/http.js';

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
            sortedManagers: function() {
                let sorted = _.orderBy(this.managers, ['activities'], ['desc']);
                sorted = _.orderBy(sorted, ['person_count'], ['desc']);
                sorted = _.orderBy(sorted, ['created_deals'], ['desc']);
                sorted = _.orderBy(sorted, ['decision_deals'], ['desc']);
                return _.orderBy(sorted, ['won_deals'], ['desc']);
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