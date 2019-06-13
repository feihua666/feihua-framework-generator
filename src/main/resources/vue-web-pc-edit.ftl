<template>

    <div class="fh-page-wrapper">
        <el-form ref="form" class="fh-background-white fh-padding-30" :model="form" :rules="formRules" style="width: 460px;" label-width="100px" v-loading="formDataLoading">
            <#list properties as property>
                <el-form-item label="${property.remarks}" prop="${property.property}">
            <el-input  v-model="form.${property.property}"></el-input>
                </el-form-item>
            </#list>
            <el-form-item>
                <el-button type="primary" icon="el-icon-check" @click="updateBtnClick" :loading="addLoading">修改</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    import SelfDictSelect from '@/components/SelfDictSelect.vue'
    import OfficeInputSelect from '@/views/office/OfficeInputSelect'
    export default {
        name: '${modelName}Edit',
        components: {
            SelfDictSelect, OfficeInputSelect},
        data () {
            return {
                // 编辑的id
                id: null,
                form: {
                    <#list properties as property>
                    ${property.property}: '',
                        </#list>
                    updateTime: null
                },
                formDataLoading: false,
                addLoading: false,
                formRules: {
                <#list properties as property>
                ${property.property}: [
                    {required: true, message: '必填', trigger: 'blur'}
                ],
                </#list>
                }
            }
        },
        mounted () {
            this.id = this.$route.params.id
            this.loadEditData(this.id)
        },
        methods: {
            loadEditData (id) {
                if (this.formDataLoading === true) {
                    return
                }
                this.resetForm()
                let self = this
                self.formDataLoading = true
                self.$http.get('${crudUrl}/' + self.id)
                    .then(function (response) {
                        let content = response.data.data.content
                        <#list properties as property>
                        self.form.${property.property} = content.${property.property}
                            </#list>
                        self.form.updateTime = content.updateAt
                        self.formDataLoading = false
                        return Promise.resolve(content)
                    })
                    .catch(function (response) {
                        self.formDataLoading = false
                    })
            },
            updateBtnClick () {
                let self = this
                if (self.addLoading === false) {
                    this.$refs['form'].validate((valid) => {
                        if (valid) {
                            // 请求添加
                            self.addLoading = true
                            self.$http.put('${crudUrl}/' + self.id, self.form)
                                .then(function (response) {
                                    self.$message.success('${moduleSimpleComment}修改成功')
                                    self.addLoading = false
                                })
                                .catch(function (response) {
                                    if (response.response.status === 404) {
                                        self.$message.error('${moduleSimpleComment}改失败，数据不存在或已被他人修改，请刷新列表后再试')
                                    }
                                    self.addLoading = false
                                })
                        } else {
                            return false
                        }
                    })
                } else {
                    self.$message.info('正在请求中，请耐心等待')
                }
            },
            resetForm () {
                this.$refs['form'].resetFields()
            }
        },
        watch: {
        },
        // tab切换如果参数不一样，重新加载数据
        beforeRouteEnter  (to, from, next) {
            next(vm => {
                // 通过 `vm` 访问组件实例
                let dataControl = '${modelName}EditLoadData=true'
                if (vm.id !== vm.$route.params.id || vm.$utils.loadDataControl.has(dataControl)) {
                    vm.id = vm.$route.params.id
                    vm.loadEditData(vm.id)
                    vm.$utils.loadDataControl.remove(dataControl)
                }
            })
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
