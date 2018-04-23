<template>
	<div id="current-plan" class="main__block main__block--left">

		<div class="main__block__title-box">
			<h3 class="title title--fact">${{ formatPrice(wonTotalFact) }}</h3>
		</div>

		<div class="main__block__title-box">
			<h3 class="title title--plan">
				${{ formatPrice(wonTotalPlan) }}
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
					<path d="M512 65.83l-76.8 10.96L446.18 0l-58.42 58.41a247.08 247.08 0 0 0-139.52-42.9C111.14 15.51 0 126.66 0 263.76S111.14 512 248.24 512c137.1 0 248.24-111.14 248.24-248.24 0-51.73-15.83-99.76-42.9-139.52L512 65.83zM390.86 406.38c-38.1 38.1-88.74 59.07-142.62 59.07s-104.52-20.98-142.62-59.07c-38.1-38.1-59.07-88.75-59.07-142.62s20.98-104.53 59.07-142.62a200.37 200.37 0 0 1 142.62-59.08c46.04 0 89.72 15.33 125.23 43.56L318 161.1a123.54 123.54 0 0 0-69.76-21.45c-68.55 0-124.12 55.57-124.12 124.12s55.57 124.12 124.12 124.12 124.12-55.57 124.12-124.12c0-25.87-7.92-49.88-21.45-69.76l55.47-55.47a200.16 200.16 0 0 1 43.56 125.23 200.38 200.38 0 0 1-59.08 142.62zM238 274a23.2 23.2 0 0 0 16.46 6.81 23.2 23.2 0 0 0 16.45-6.81l46.1-46.1a77.1 77.1 0 0 1 8.82 35.85c0 42.77-34.8 77.57-77.58 77.57s-77.57-34.8-77.57-77.57 34.8-77.58 77.57-77.58c12.93 0 25.12 3.2 35.85 8.82L238 241.1a23.27 23.27 0 0 0 0 32.9z"/>
				</svg>
			</h3>
		</div>

	</div>
</template>

<script>
    export default {
        props: ['wonTotalFact', 'wonTotalPlan'],
        computed: {
            classObject: function () {
            }
        },
		methods: {
			formatPrice: function(value) {
				let val = (value/1).toFixed(0).replace('.', ',')
				return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "'")
			}
		}
    }
</script>
