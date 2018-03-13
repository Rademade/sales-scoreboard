<template>
    <div id="bdm-scoring">
        <table border="1">
            <tr>
                <td>№</td>
                <td>Who</td>
                <td>Activity</td>
                <td>New contacts</td>
                <td>New deals</td>
                <td>Closed</td>
            </tr>
            <tr>
                <td>Total</td>
                <td></td>
                <td>{{totalActivities}}</td>
                <td>{{totalContacts}}</td>
                <td>{{totalDeals}}/{{planDeals}}</td>
                <td>{{totalClosed}}/{{planClosed}}</td>
            </tr>
            <tr v-for="(manager, index) in sortedManagers">
                <td>{{index + 1}}</td>
                <td>{{manager.name}}</td>
                <td>{{manager.activities}}</td>
                <td>{{manager.contacts}}</td>
                <td>{{manager.deals}}</td>
                <td>{{manager.closed}}</td>
            </tr>
        </table>
    </div>
</template>

<script>
    export default {
        computed: {
            totalActivities: function(){
                return _.sumBy(this.managers, 'activities');
            },
            totalContacts: function(){
                return _.sumBy(this.managers, 'contacts');
            },
            totalDeals: function(){
                return _.sumBy(this.managers, 'deals');
            },
            totalClosed: function(){
                return _.sumBy(this.managers, 'closed');
            },
            sortedManagers: function() {
                let sorted = _.orderBy(this.managers, ['activities'], ['desc']);
                sorted = _.orderBy(sorted, ['contacts'], ['desc']);
                sorted = _.orderBy(sorted, ['deals'], ['desc']);
                return _.orderBy(sorted, ['closed'], ['desc']);
            }
        },
        data: function () {
            return {
                planDeals: 0,
                planClosed: 0,
                managers: [
                    {name: 'Vitaliy Bondarchyk', activities: 500, contacts: 4, deals: 2, closed: 4 },
                    {name: 'Vitaliy Bondarchyk', activities: 500, contacts: 4, deals: 4, closed: 4 },
                    {name: 'Vitaliy Bondarchyk', activities: 502, contacts: 4, deals: 2, closed: 4 },
                    {name: 'Vitaliy Bondarchyk', activities: 500, contacts: 4, deals: 2, closed: 5 }
                ]
            }
        }
    }
</script>


<style scoped>
</style>