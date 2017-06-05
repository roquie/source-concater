<template>
  <div class="concat">
    <p class="who-is-who">
      This app just concatenate all text files contained in zip archive to one large.
      <br> And it mark each segment with relative path.
    </p>
    <el-upload
      class="upload-zip"
      drag
      action=""
      :on-change="handleChange"
      multiple>
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">Drop file here or <em>click to start</em></div>
      <div class="el-upload__tip" slot="tip">zip files with any size (this app using your browser RAM)</div>
    </el-upload>
    <div id="output">
      <div class="header" v-show="buttons">
        <el-button id="copy" type="primary" data-clipboard-target="#output .content">Copy to clipboard</el-button>
        <el-button @click="handleClear">Clear</el-button>
      </div>
      <div class="content">

      </div>
    </div>
  </div>
</template>

<script>

import JSZip from 'JSZip'
import Clipboard from 'clipboard'
import _ from 'lodash'

const processFile = (file) => {
  JSZip.loadAsync(file.raw)
  .then(function (zip) {
    zip.forEach(function (relativePath, zipEntry) {
      if (!zipEntry.dir) {
        zip.file(zipEntry.name).async('string').then(function (content) {
          let ptag = document.createElement('pre')
          ptag.innerHTML = `<strong>${zipEntry.name}</strong><br><br>${_.escape(content)}`
          document
            .querySelector('#output .content')
            .appendChild(ptag)
        })
      }
    })
  })
}

export default {
  name: 'concat',
  data () {
    return {
      buttons: false
    }
  },
  created () {
    let clipboard = new Clipboard('#copy')
    clipboard.on('success', (e) => {
      this.$notify({
        title: 'Success',
        message: 'Code output was copied to clipboard',
        type: 'success'
      })
    })
  },
  methods: {
    handleChange: function (file, fileList) {
      processFile(file)
      this.buttons = true
    },
    handleCopy: function () {

    },
    handleClear: function () {
      document
        .querySelector('#output .content')
        .innerHTML = ''
      this.buttons = false
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .upload-zip, .who-is-who {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }

  .who-is-who {
    font-size: 26px
  }
  .upload-zip {
    width: 360px;
    margin: 0 auto;
  }
  #output .header {
    text-align: center;
    margin-top: 20px;
   }
</style>
