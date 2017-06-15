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
      <div class="el-upload__text">Drop file here or <em>click to start</em>, then process it will start automatically</div>
      <div class="el-upload__tip" slot="tip">
        zip files with any size (this app using your browser RAM)
        <br> <br>
        Warning! If file too big, it's ok if page content generating with a delay.
      </div>
    </el-upload>
    <el-row>
      <el-col :xs="{span: 20, offset: 2}" :sm="{span: 12, offset: 6}" :md="{span: 10, offset: 7}" :lg="{span: 8, offset: 8}">
        <p class="help-choosing">
          Choose preset from whitelist (of extensions) to open and concatinating files here (click on tab)
        </p>
        <el-tabs type="card" @tab-click="handleTabClick">
          <el-tab-pane :label="preset.title" v-for="preset in presets" :key="preset.title">
            <tags :tags="preset.value" @change="handleTagsChanges" />
          </el-tab-pane>
        </el-tabs>
      </el-col>
    </el-row>
    <div id="output">
      <div class="header" v-show="buttons">
        <el-button id="copy" type="primary" data-clipboard-target="#output .content">Copy to clipboard</el-button>
        <el-button @click="handleClear">Clear</el-button>
      </div>
      <div class="content">
        <!-- content of files here -->
      </div>
    </div>
  </div>
</template>

<script>

import JSZip from 'jszip'
import Clipboard from 'clipboard'
import _ from 'lodash'
import Tags from './Tags'

const defaultExtensions = ['php', 'js', 'vue', 'htaccess', 'html']

const processFile = (file, selectedExtensions) => {
  JSZip.loadAsync(file.raw)
  .then(function (zip) {
    zip.forEach(function (relativePath, zipEntry) {
      if (!zipEntry.dir && !zipEntry.name.includes('__MACOSX')) {
        const currentFileExtension = zipEntry.name.split('.').pop()
        if (selectedExtensions.includes(currentFileExtension)) {
          zip.file(zipEntry.name).async('string').then(function (content) {
            let ptag = document.createElement('pre')
            ptag.innerHTML = `<strong>${zipEntry.name}</strong><br><br>${_.escape(content)}`
            document
              .querySelector('#output .content')
              .appendChild(ptag)
          })
        }
      }
    })
  })
}

export default {
  data () {
    return {
      buttons: false,
      presets: [
        { title: 'PHP', value: defaultExtensions },
        { title: 'JS', value: ['js', 'vue', 'jsx', 'html'] },
        { title: 'Go', value: ['go'] },
        { title: 'iOS', value: ['swift', 'c', 'h', 'storyboard'] },
        { title: 'Android', value: ['java', 'kt', 'xml'] },
        { title: 'Custom', value: [] }
      ],
      selectedExtensions: defaultExtensions
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
    handleChange (file, fileList) {
      processFile(file, this.selectedExtensions)
      this.buttons = true
    },
    handleClear () {
      document
        .querySelector('#output .content')
        .innerHTML = ''
      this.buttons = false
    },
    handleTabClick (tab, event) {
      const item = _.find(this.presets, o => o.title === tab.label)
      this.selectedExtensions = item.value
    },
    handleTagsChanges (tags) {
      this.selectedExtensions = tags
    }
  },
  components: {
    Tags
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  * {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }

  .el-row {
    margin-top: -35px;
  }

  .upload-zip, .who-is-who, .help-choosing {
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }

  .who-is-who {
    font-size: 1.4em
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
