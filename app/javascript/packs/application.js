import Vue from 'vue'
import _ from 'lodash'
import Root from 'Components/root.vue'

document.addEventListener('DOMContentLoaded', () => {
    const $el = document.body.appendChild(document.createElement('root'));
    const app = new Vue({
            el: $el,
            render: h => h(Root)
    });
});