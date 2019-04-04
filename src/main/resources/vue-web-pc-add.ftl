<template>
    <div class="wrapper">
        <el-form ref="form" :model="form" :rules="formRules" style="width: 460px;" label-width="100px">
            <#list properties as property>
                <el-form-item label="" prop="${property}">
            <el-input  v-model="form.${property}"></el-input>
                </el-form-item>
            </#list>
            <el-form-item>
                <el-button type="primary" @click="addBtnClick" :loading="addLoading">添加</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    import SelfDictSelect from '@/components/SelfDictSelect.vue'
    import OfficeInputSelect from '@/views/office/OfficeInputSelect'
    export default {
        components: {
            SelfDictSelect, OfficeInputSelect },
        name: '${modelName}Add',
        data () {
            return {
                form: {
                    <#list properties as property>
                    ${property}: '',
                    </#list>
                },
                addLoading: false,
                formRules: {
                <#list properties as property>
                    ${property}: [
                        {required: true, message: '必填', trigger: 'blur'}
                    ],
                </#list>

                }
            }
        },
        mounted () {
        },
        methods: {
            addBtnClick () {
                let self = this
                if (self.addLoading === false) {
                    this.$refs['form'].validate((valid) => {
                        if (valid) {
                            // 请求添加
                            self.addLoading = true
                            self.$http.post('${crudUrl}', self.form)
                                .then(function (response) {
                                    self.$message.info('${moduleSimpleComment}添加成功')
                                    self.addLoading = false
                                })
                                .catch(function (response) {
                                    self.$message.error('${moduleSimpleComment}添加失败，请稍后再试')
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
        computed: {
        },
        watch: {
        },
        beforeRouteEnter  (to, from, next) {
            next(vm => {
                // 通过 `vm` 访问组件实例
                let dataControl = '${modelName}AddLoadData=true'
                if (vm.$utils.loadDataControl.has(dataControl)) {
                    // 重置表单
                    vm.resetForm()
                    vm.$utils.loadDataControl.remove(dataControl)
                }
            })
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .wrapper{
        padding:1.5rem;
    }
</style>
