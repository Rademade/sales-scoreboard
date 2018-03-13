import Vue from 'vue'
import Root from './components/root.vue'
import _ from 'lodash'

document.addEventListener('DOMContentLoaded', () => {
    const $el = document.body.appendChild(document.createElement('root'));
    const app = new Vue({
            el: $el,
            render: h => h(Root)
    });
});