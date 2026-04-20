# Unlisted app distribution

苹果的“非公开应用分发”（Unlisted App Distribution）是专门为那些不适合面向大众、但需要通过App Store进行分发的应用设计的分发方式。你可以把它理解为一种“隐藏上架”模式。

## 一、 核心特点

1. 只能通过直接链接访问，完全不可搜索
   这是非公开应用最核心的特点。应用成功上架后，它不会出现在任何App Store的搜索结果、排行榜、推荐列表或分类目录中。唯一找到并下载它的方式，就是通过一个特定的直接链接。

2. 体验与公开应用完全一致
   虽然入口是隐藏的，但用户通过链接打开后，看到的是一个标准的App Store产品页面。下载、安装、更新以及后续的版本迭代，都和从App Store下载其他任何公开应用的流程与体验完全一样。这比企业签名或TestFlight等临时分发方式要稳定和方便得多。

3. “隐藏”但不等于“私密”
   苹果官方特别强调，非公开应用是“隐藏的”，但并非“私密的”。因为任何人都可以通过分享的链接访问并下载该应用。因此，如果你的应用涉及敏感信息，苹果强烈建议在应用内自行构建一套身份验证或授权机制来防止未经授权的使用。

## 二、 适用的场景

非公开应用最适合分发给那些无法通过Apple商务管理或Apple校园教务管理进行管理的特定受众。典型场景包括：

- 企业内部工具：专供员工使用的内部办公应用、工时记录或排班应用，尤其是员工使用的是个人设备且不受企业统一管理的情况。

- 合作伙伴或渠道应用：例如，汽车厂商为其经销商网络开发的应用，或为加盟商、销售伙伴提供的专用工具。

- 活动或研究相关应用：为特定大型会议、学术会议或某项研究项目开发的配套应用，受众仅限于参会者或研究对象。

- 面向特定客户的应用：为特定教育机构的学生、企业的重要客户等非内部员工但需提供专属服务的人群开发的应用。

## 三、 与其他分发方式的区别

苹果主要有以下几种分发方式，容易混淆，这里做一个区分：

| 分发方式 | 非公开应用（Unlisted App）                                     | 公开应用（Public App）                | 定制应用（Custom App）                                 | 企业签名（Enterprise）                |
| -------- | -------------------------------------------------------------- | ------------------------------------- | ------------------------------------------------------ | ------------------------------------- |
| 可见性   | 仅通过直接链接访问，不可搜索                                   | 在App Store中完全公开，可搜索、可推荐 | 通过Apple商务管理或Apple校园教务管理私有分发给特定组织 | 完全不经过App Store，企业内部自签分发 |
| 受众     | 有限受众（如员工、合作伙伴、活动参与者）                       | 普通大众                              | 特定的企业或教育机构                                   | 公司内部员工                          |
| 分发渠道 | App Store（通过链接）                                          | App Store                             | Apple商务管理/Apple校园教务管理                        | 企业内部门户或MDM                     |
| 设备管理 | 支持通过Apple商务管理/校园教务管理进行管理，也支持用户个人设备 | 通常为个人设备                        | 必须通过MDM进行管理                                    | 必须通过MDM进行管理                   |

## 四、 如何申请

申请流程是条件性的，主要步骤入下：

1. 准备应用：你的应用必须已经准备好发布（处于最终状态），并且要么已经存在于App Store上，要么是一个全新的应用记录。

2. 提交审核：在将应用提交给App Review审核时，在“审核备注”中明确注明，此应用希望申请成为非公开应用。

3. 填写申请表格：提交审核后，需要填写官方的“Unlisted App Request”表格。申请链接:https://developer.apple.com/contact/request/unlisted-app/。在表格中，你需要描述应用解决的业务问题、为何需要非公开分发以及目标受众规模等信息。

4. 等待批准：苹果会对每个请求进行审核。批准后，App Store Connect中应用的“定价与供应情况”下的分发方式会变更为“非公开应用”，并会生成专属链接。如果被拒绝，可以根据反馈修改后重新申请。

> 重要提示：
> 已通过Apple商务管理/校园教务管理私有分发的应用无法直接转换，需要创建一个新的应用记录，先将分发方式设为“公开”，再提交非公开申请。
> 一旦被批准为非公开应用，未来的所有版本都将保持这种分发方式，无法再转回普通的公开应用。

## 五、 分发与管理

一旦获得批准，分发就变得非常简单：

- 对于不受管理的用户（如员工个人手机）：直接将App Store链接通过邮件、内部网站等方式发送给用户即可。用户点击链接，就能跳转到App Store正常下载。

- 对于受管理的设备（如公司配发的设备）：组织的管理员可以将该链接添加到Apple商务管理或Apple校园教务管理的“App和图书”中，然后通过移动设备管理（MDM） 将应用静默推送到所有受管理的设备上。

## 六、 Unlisted App Request示例

```
Have you submitted your app to the App Store for review?
yes

Describe in detail the business problem your app solves and why unlisted app distribution helps solves this problem.
该app将被使用在特定的工程建设中,是我们建设管理平台的一部分。施工人员、监理人员对施工过程中的的进度、质量等关键因素进行把控，以及安全隐患上报等。

Why do you prefer unlisted app distribution over public distribution on the App Store?
该app仅提供给工程建设过程中的相关单位员工使用，不提供对外的注册入口。

Why do you prefer unlisted app distribution over private distribution to specific organizations via Apple Business Manager or Apple School Manager?
只需要提供一个固定链接，相对使用过程比较简单。因此更适合我们的客户使用，因为我们的客户普遍不太擅长使用兑换码等等操作，他们需要简单快速安装应用，然后使用他们需要的功能。

Will your app be distributed internally to your employees, externally to partners and/or customers, or both?
Externally

How many people will use this app?
1000

How many organizations (example: businesses or schools) will use this app?
1

Who is your app designed for?
Corporate customers

What category best describes your app?
Productivity

Will the app be distributed to managed devices, unmanaged devices, or both?
Unmanaged

How many devices will be unmanaged?
1000

In what regions will your app be available?
China

```
