<template>
    <div id="app">
    <v-app id="inspire">
        <div>
        <v-data-table
            :headers="headers"
            :items="desserts"
            :sort-by.sync="sortBy"
            :sort-desc.sync="sortDesc"
            :options.sync="options"
            :server-items-length="totalDesserts"
            :loading="loading"
            :single-expand="singleExpand"
            :expanded.sync="expanded"
            item-key="name"
            show-expand
            class="elevation-1"
        >
            <template v-slot:expanded-item="{ item }" >
                <thead>
            <tr>
                <th class="text-left">
                商品名稱
                </th>
                <th class="text-left">
                商品類型
                </th>
                <th class="text-left">
                商品單價
                </th>
                <th class="text-left">
                商品數量
                </th>
            </tr>
            </thead>
            <tbody>
            <tr
                v-for="pro in item.products"
                :key="pro.id"
            >
                <td>{{ pro.name }}</td>
                <td>{{ pro.type }}</td>
                <td>{{ pro.price }}</td>
                <td>{{ pro.quantity }}</td>
            </tr>
            </tbody>
            </template>
        </v-data-table>
        </div>
    </v-app>
    </div>
</template>

<script>
import axios from 'axios'
    export default {
        data: () => ({
            sortBy: 'date',
            sortDesc: false,
            expanded: [],
            singleExpand: false,
            totalDesserts: 0,
            desserts: [],
            loading: true,
            options: {},
            headers: [
                { text: 'ID', align: 'start', value: 'id' },
                { text: 'Shipping Type', value: 'shipping_type', align: 'start' },
                { text: 'Payment Type', value: 'payment_type', align: 'start' },
                { text: 'Status', value: 'status', align: 'start' },
                { text: 'Total Price', value: 'total_price', align: 'start' },
                { text: 'Date', value: 'date', align: 'start' },
                { text: '', value: 'data-table-expand' },
            ],
        }),
        watch: {
            options: {
            handler () {
                this.getDataFromApi()
            },
            deep: true,
            },
        },
        mounted () {
            this.getDataFromApi()
        },
        methods: {
            getDataFromApi () {
            this.loading = true

            var config={
                method: 'get',
                url: '/api/get-orders',
                headers: {'Authorization': localStorage.getItem("accessToken")}
            }
            
            axios(config).then((response) => {
                this.desserts = response.data
                this.totalDesserts = response.data.length
                this.loading = false
            })
            },
            /**
             * In a real application this would be a call to fetch() or axios.get()
             */
            fakeApiCall () {
            return new Promise((resolve, reject) => {
                const { sortBy, sortDesc, page, itemsPerPage } = this.options

                let items = this.getDesserts()
                const total = items.length

                if (sortBy.length === 1 && sortDesc.length === 1) {
                items = items.sort((a, b) => {
                    const sortA = a[sortBy[0]]
                    const sortB = b[sortBy[0]]

                    if (sortDesc[0]) {
                    if (sortA < sortB) return 1
                    if (sortA > sortB) return -1
                    return 0
                    } else {
                    if (sortA < sortB) return -1
                    if (sortA > sortB) return 1
                    return 0
                    }
                })
                }

                if (itemsPerPage > 0) {
                items = items.slice((page - 1) * itemsPerPage, page * itemsPerPage)
                }

                setTimeout(() => {
                resolve({
                    items,
                    total,
                })
                }, 1000)
            })
            },
            getDesserts () {
            return [
                {
                name: 'Frozen Yogurt',
                calories: 159,
                fat: 6.0,
                carbs: 24,
                protein: 4.0,
                iron: '1%',
                product:[1,2,3]
                },
                {
                name: 'Ice cream sandwich',
                calories: 237,
                fat: 9.0,
                carbs: 37,
                protein: 4.3,
                iron: '1%',
                },
                {
                name: 'Eclair',
                calories: 262,
                fat: 16.0,
                carbs: 23,
                protein: 6.0,
                iron: '7%',
                },
                {
                name: 'Cupcake',
                calories: 305,
                fat: 3.7,
                carbs: 67,
                protein: 4.3,
                iron: '8%',
                },
                {
                name: 'Gingerbread',
                calories: 356,
                fat: 16.0,
                carbs: 49,
                protein: 3.9,
                iron: '16%',
                },
                {
                name: 'Jelly bean',
                calories: 375,
                fat: 0.0,
                carbs: 94,
                protein: 0.0,
                iron: '0%',
                },
                {
                name: 'Lollipop',
                calories: 392,
                fat: 0.2,
                carbs: 98,
                protein: 0,
                iron: '2%',
                },
                {
                name: 'Honeycomb',
                calories: 408,
                fat: 3.2,
                carbs: 87,
                protein: 6.5,
                iron: '45%',
                },
                {
                name: 'Donut',
                calories: 452,
                fat: 25.0,
                carbs: 51,
                protein: 4.9,
                iron: '22%',
                },
                {
                name: 'KitKat',
                calories: 518,
                fat: 26.0,
                carbs: 65,
                protein: 7,
                iron: '6%',
                },
            ]
            },
        },
    }
</script>