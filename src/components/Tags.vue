<template>
  <div class="tags-box">
    <el-tag
      :key="tag"
      v-for="tag in tags"
      :closable="true"
      :close-transition="false"
      @close="handleClose(tag)"
    >
      {{tag}}
    </el-tag>
    <el-input
      class="input-new-tag"
      v-if="inputVisible"
      v-model="inputValue"
      ref="saveTagInput"
      size="mini"
      @keyup.enter.native="handleInputConfirm"
      @blur="handleInputConfirm"
    >
    </el-input>
    <el-button v-else class="button-new-tag" size="small" @click="showInput">+ Add Extension</el-button>
  </div>
</template>

<script>

export default {
  props: {
    tags: Array
  },
  data () {
    return {
      inputVisible: false,
      inputValue: ''
    }
  },
  methods: {
    handleClose (tag) {
      this.tags.splice(this.tags.indexOf(tag), 1)
      this.$emit('change', this.tags)
    },

    showInput () {
      this.inputVisible = true
      this.$nextTick(_ => {
        this.$refs.saveTagInput.$refs.input.focus()
      })
    },

    handleInputConfirm () {
      let inputValue = this.inputValue
      if (inputValue) {
        this.tags.push(inputValue)
        this.$emit('change', this.tags)
      }
      this.inputVisible = false
      this.inputValue = ''
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .tags-box .el-tag + .el-tag {
    margin-left: 10px;
    margin-top: 10px;
  }

  .tags-box .button-new-tag {
    margin-left: 10px;
    margin-top: 10px;
    height: 24px;
    line-height: 22px;
    padding-top: 0;
    padding-bottom: 0
  }

  .tags-box .input-new-tag {
    width: 78px;
    margin-left: 10px;
    margin-top: 10px;
    vertical-align: bottom
  }

  .tags-box .input-new-tag .el-input__inner {
    height: 24px
  }
</style>
