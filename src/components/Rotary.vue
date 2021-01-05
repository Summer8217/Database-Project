<template>
  <v-row align="start" justify="center">
    <LuckyWheel
      ref="LuckyWheel"
      width="700px"
      height="700px"
      :prizes="prizes"
      :default-style="defaultStyle"
      :blocks="blocks"
      :buttons="buttons"
      @start="startCallBack"
      @end="endCallBack"
    />
  </v-row>
</template>

<script>
export default {
  data () {
    return {
      prizes: [],
      defaultStyle: {
        fontColor: '#000',
        fontSize: '20px'
      },
      blocks: [
        { padding: '13px', background: '#3b5998' }
      ],
      buttons: [
        { radius: '50px', background: '#3b5998' },
        { radius: '45px', background: '#fff' },
        { radius: '41px', background: '#8b9dc3', pointer: true },
        {
          radius: '35px',
          background: '#dfe3ee',
          fonts: [{ text: '抽獎', top: '-13px' }]
         }
      ],
    }
  },
  mounted () {
    this.getPrizesList()
  },
  methods: {
    getPrizesList () {
      this.prizes = []
      let data = ['$100折價卷', '$50折價卷', '$10折價卷', '9折優惠卷', '8折優惠卷', '7折優惠卷', '$200折價卷', '5折優惠卷']
      data.forEach((item, index) => {
        this.prizes.push({
          title: item,
          background: index % 2 ? '#8b9dc3' : '#dfe3ee',
          fonts: [{ text: item, top: '10%' }],
        })
      })
    },
    startCallBack () {
      this.$refs.LuckyWheel.play()
      setTimeout(() => {
        this.$refs.LuckyWheel.stop(Math.random() * 8 >> 0)
      }, 3000)
    },
    endCallBack (prize) {
      alert(`恭喜你獲得${prize.title}`)
    },
  }
}
</script>