<template>
    <div id="bdm-scoring" class="main__block">
        <table class="table">
            <tr class="table__row table__row--title">
                <td class="table__data">Who</td>
                <td class="table__data">Activity</td>
                <td class="table__data">New contacts</td>
                <td class="table__data">New deals</td>
                <td class="table__data">Decision deals</td>
                <td class="table__data">Won deals</td>
            </tr>
            <tr class="table__row">
                <td class="table__data">Total</td>
                <td class="table__data">{{totalActivities}}</td>
                <td class="table__data">{{totalPersons}}</td>
                <td class="table__data">{{totalCreatedDeals}}/{{newDealsPlan}}</td>
                <td class="table__data">{{totalDecisionDeals}}</td>
                <td class="table__data">{{totalWonDeals}}/{{wonDealsPlan}}</td>
            </tr>
            <tr v-for="(manager, index) in sortedManagers" class="table__row">
                <td class="table__data">{{manager.name}}</td>
                <td class="table__data">{{manager.activities_count}}</td>
                <td class="table__data">{{manager.person_count}}</td>
                <td class="table__data">{{manager.created_deals}}</td>
                <td class="table__data">{{manager.decision_deals}}</td>
                <td class="table__data table__data--bold">{{manager.won_deals}}</td>
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