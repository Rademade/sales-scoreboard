<template>
    <div id="bdm-scoring">
        <table border="1">
            <tr>
                <td>Who</td>
                <td>Activity</td>
                <td>New contacts</td>
                <td>New deals</td>
                <td>Decision deals</td>
                <td>Won deals</td>
            </tr>
            <tr>
                <td>Total</td>
                <td>{{totalActivities}}</td>
                <td>{{totalPersons}}</td>
                <td>{{totalCreatedDeals}}/{{newDealsPlan}}</td>
                <td>{{totalDecisionDeals}}</td>
                <td>{{totalWonDeals}}/{{wonDealsPlan}}</td>
            </tr>
            <tr v-for="(manager, index) in sortedManagers">
                <td>{{manager.name}}</td>
                <td>{{manager.activities_count}}</td>
                <td>{{manager.person_count}}</td>
                <td>{{manager.created_deals}}</td>
                <td>{{manager.decision_deals}}</td>
                <td><b>{{manager.won_deals}}</b></td>
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