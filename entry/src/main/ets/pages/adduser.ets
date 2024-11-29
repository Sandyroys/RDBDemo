import { promptAction, router } from '@kit.ArkUI';
import { User } from '../db/User';
import UserAPI from '../db/UserAPI';

@Entry
@Component
struct Register {
  @State userName: string = '张三'
  @State userSex: string = '男'
  @State userAge: number = 18
  @State userTel: string = '15688886666'
  @State userList: User[] = []
  private userTableApi = UserAPI

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      // LOGO
      Image($r('app.media.user'))
        .objectFit(ImageFit.Contain)
        .height('12%')

      // 用户名输入框
      TextInput({ placeholder: '请输入用户名', text: this.userName })
        .margin(10).width('80%').fontSize(30)
        .onChange((v) => {
          this.userName = v
        })

      // 性别选择
      Row() {
        Radio({ value: '男', group: 'sexGroup' })
          .height(30)
          .width(50)
          .onClick(() => {
            this.userSex = '男'
          }).checked(true)
        Text('男')
          .fontSize(25)
        Radio({ value: '女', group: 'sexGroup' })
          .height(30)
          .width(50)
          .onClick(() => {
            this.userSex = '女'
          })
        Text('女')
          .fontSize(25)
      }.width('80%').align(Alignment.Start)
      .margin({ top: 10 })

      // 年龄输入框
      TextInput({ placeholder: '请输入年龄', text: '' + this.userAge })
        .margin(10)
        .width('80%')
        .fontSize(30)
        .type(InputType.Number)
        .onChange((v) => {
          this.userAge = Number(v)
        })
      // 电话输入框
      TextInput({ placeholder: '请输入电话', text: this.userTel })
        .margin(10).width('80%').fontSize(30)
        .onChange((v) => {
          this.userTel = v
        })
      // 添加按钮
      Button('添加', { type: ButtonType.Capsule, stateEffect: true })
        .width('50%')
        .height('6%')
        .margin(30)
        .fontSize(30)
        .backgroundColor('#1890FF')
        .onClick(() => {
          if (!this.checkInputData()) {
            return;
          }
          this.addUser();
        });
    }
    .width('100%')
    .height('100%')
  }

  // 数据校验
  checkInputData() {
    // 这里仅仅判断用户名是否为空
    if (this.userName == '') {
      promptAction.showToast({
        message: '用户名不能为空',
        duration: 3000,
        bottom: '30%'
      });
      return false;
    }
    return true;
  }

  //  添加用户
  addUser() {
    // 将用户信息存入数据库中
    let user = new User( this.userName, this.userSex, this.userAge, this.userTel );
    this.userTableApi.insertUser(user);
    // 添加之后，跳转到首页
    router.back({
      url: 'pages/index'
    });
  }
}