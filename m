Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F950FD4
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfFXPJ5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:57 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39476 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730834AbfFXPJx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:53 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF0721018628;
        Mon, 24 Jun 2019 08:09:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Tx8UpEyPpXRqn/yZZOFXfPjItqJVXdo1VdCwoLR5kA4=;
 b=UZpk3s4H5QWSy98Vz3/ZvpIB09ZvoCSSpJTZ7mIhKGq3h6nzilK36C161QhMupDk8zNE
 6jqfkscYfhq9R8WUV+y7vm001EO3pohmjS3vnJqywF3hFagtzeSAelqUPFwcu/CLe0ec
 oPhDIpeics8E0FM5hdcMNgIcF6sfEZ12tRkQZxJSDN2e/zs2IZItlbvKQEL4P2aY2uZQ
 NjwD+Xq+QfZ5nslQU8i9fbytF0lQROqqAa94guQD7N8ZSLAUON0gun/xXnfMC8m1Hg9I
 Nd5j/KGaHwGRqvNpPFj60NuIE+E1BLWLjHgoQmF/c0SgFZB9hsdepy/BpvjIeAlEPDH7 fQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9tck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:46 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:45 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx8UpEyPpXRqn/yZZOFXfPjItqJVXdo1VdCwoLR5kA4=;
 b=GReAI3vuAlTMqio6qmTN8hLSMp7c8IJkRkf//tv+PvNqak53CU/iYP1CV8u1C9iFIG99Tg8DxJnmH47ZVCZV17Rd+jgIjGl2ExkiGxfhJHsw1Ch2nEy3dV0wSK2FSkG2KttGZhSqiU8vWRpakAs4iX9xIxz+bSGAXbXrulwQy64=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:44 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:44 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 24/24] EDAC, ghes: Disable legacy API for ARM64
Thread-Topic: [PATCH v2 24/24] EDAC, ghes: Disable legacy API for ARM64
Thread-Index: AQHVKp7btZJqTl0650643IuYJMBHSA==
Date:   Mon, 24 Jun 2019 15:09:44 +0000
Message-ID: <20190624150758.6695-25-rrichter@marvell.com>
References: <20190624150758.6695-1-rrichter@marvell.com>
In-Reply-To: <20190624150758.6695-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0035.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::24)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82481c05-4725-4ff2-696f-08d6f8b5fd3a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB31970B9036D22C50EFB8A437D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bm0o3OMJXooSrdPgF9EIJzSVWSAn4XfYUMc6CaLwWgSEIhO+zBxExVEKX1s+AUysyHuX8ei+a2ttgfFnW3VyGmWXNqe+fe9Cc8EDh5zMK+0HrIR2JC6x66F9SMzY6/GhEj9YC/zyXAGha1O7C/PfJpt6VcS+6CoYEVUa2uoU4pfvfWh7TU/BcQ3GkdpRzdCO4LCfELVfiKKtTms2KijAYKPsBH5aBMUVcCsrOqnJoegqgTFxlgIZNg+E177ra4kecneDRt2DZWHX1KbrmCyYGPFhWat8I6tjEFa8GfBGjE+G5K7ZoqAt4W/FlDQShQm8SHGZpdIaGq5VPFbxxrJy1UlYv3LgQcX4HauSVxEf1exKslH//00d2BWGD6OpahBgK46IPvh5Q0ZcBzlSrXzx/NXbEmHhFOgqJJgvNqiCLt4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82481c05-4725-4ff2-696f-08d6f8b5fd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:44.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3197
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SmFtZXMgTW9yc2U6ICJJJ20gYWxsIGZvciByZW1vdmluZy93YXJuaW5nLWl0cy1icm9rZW4gaXQg
d2hlbg0KZ2hlc19lZGFjIGlzIGluIHVzZS4iDQoNCkxldCdzIGp1c3QgZGlzYWJsZSBsZWdhY3kg
QVBJIGZvciB0aGUgZ2hlcyBkcml2ZXIgb24gYXJtNjQuIFRob3VnaCwgSQ0KZG9uJ3QgYWdyZWUg
d2l0aCBpdCBhcyB0aGVyZSBzdGlsbCBjb3VsZCBiZSBzb21lIHVzZXJsYW5kIHRvb2xzIHRoYXQN
CnVzZSB0aGlzIGludGVyZmFjZSB0aGF0IGNhbm5vdCBiZSB1c2VkIGFueSBsb25nZXIgYWZ0ZXIg
YSB0cmFuc2l0aW9uDQpmcm9tIHg4NiB0byBhcm02NC4gSSBsZWF2ZSB0aGF0IGRlY2lzaW9uIHVw
IHRvIEphbWVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFy
dmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19tYy5jICAgfCAzNCArKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWMuaCAgIHwgIDcg
KysrKysrKw0KIGRyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyB8ICA0ICsrKy0NCiAzIGZpbGVzIGNo
YW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2VkYWMvZWRhY19tYy5jIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KaW5kZXggOTM4
M2ExMTc5YjgzLi5kN2ExMjBkN2UzMDQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19t
Yy5jDQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQpAQCAtMjc2LDE2ICsyNzYsMTEgQEAg
dm9pZCAqZWRhY19hbGlnbl9wdHIodm9pZCAqKnAsIHVuc2lnbmVkIHNpemUsIGludCBuX2VsZW1z
KQ0KIAlyZXR1cm4gKHZvaWQgKikoKCh1bnNpZ25lZCBsb25nKXB0cikgKyBhbGlnbiAtIHIpOw0K
IH0NCiANCi1zdGF0aWMgdm9pZCBfZWRhY19tY19mcmVlKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1j
aSkNCitzdGF0aWMgdm9pZCBfZWRhY19tY19mcmVlX2xlZ2FjeShzdHJ1Y3QgbWVtX2N0bF9pbmZv
ICptY2kpDQogew0KLQlpbnQgaSwgY2huLCByb3c7DQorCWludCBjaG4sIHJvdzsNCiAJc3RydWN0
IGNzcm93X2luZm8gKmNzcjsNCiANCi0JaWYgKG1jaS0+ZGltbXMpIHsNCi0JCWZvciAoaSA9IDA7
IGkgPCBtY2ktPnRvdF9kaW1tczsgaSsrKQ0KLQkJCWtmcmVlKG1jaS0+ZGltbXNbaV0pOw0KLQkJ
a2ZyZWUobWNpLT5kaW1tcyk7DQotCX0NCiAJaWYgKG1jaS0+Y3Nyb3dzKSB7DQogCQlmb3IgKHJv
dyA9IDA7IHJvdyA8IG1jaS0+bnJfY3Nyb3dzOyByb3crKykgew0KIAkJCWNzciA9IG1jaS0+Y3Ny
b3dzW3Jvd107DQpAQCAtMzAwLDkgKzI5NSwzNCBAQCBzdGF0aWMgdm9pZCBfZWRhY19tY19mcmVl
KHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCiAJCX0NCiAJCWtmcmVlKG1jaS0+Y3Nyb3dzKTsN
CiAJfQ0KK30NCisNCitzdGF0aWMgdm9pZCBfZWRhY19tY19mcmVlKHN0cnVjdCBtZW1fY3RsX2lu
Zm8gKm1jaSkNCit7DQorCWludCBpOw0KKw0KKwlpZiAobWNpLT5kaW1tcykgew0KKwkJZm9yIChp
ID0gMDsgaSA8IG1jaS0+dG90X2RpbW1zOyBpKyspDQorCQkJa2ZyZWUobWNpLT5kaW1tc1tpXSk7
DQorCQlrZnJlZShtY2ktPmRpbW1zKTsNCisJfQ0KKw0KKwlfZWRhY19tY19mcmVlX2xlZ2FjeSht
Y2kpOw0KKw0KIAlrZnJlZShtY2kpOw0KIH0NCiANCit2b2lkIGVkYWNfbWNfZGlzYWJsZV9sZWdh
Y3lfYXBpKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCit7DQorI2lmZGVmIENPTkZJR19FREFD
X0xFR0FDWV9TWVNGUw0KKwlfZWRhY19tY19mcmVlX2xlZ2FjeShtY2kpOw0KKwltY2ktPm5yX2Nz
cm93cyA9IDA7DQorCW1jaS0+bnVtX2NzY2hhbm5lbCA9IDA7DQorCW1jaS0+Y3Nyb3dzID0gTlVM
TDsNCisjZW5kaWYNCit9DQorRVhQT1JUX1NZTUJPTF9HUEwoZWRhY19tY19kaXNhYmxlX2xlZ2Fj
eV9hcGkpOw0KKw0KIHN0cnVjdCBtZW1fY3RsX2luZm8gKl9fZWRhY19tY19hbGxvYyh1bnNpZ25l
ZCBtY19udW0sDQogCQkJCXVuc2lnbmVkIGRpbW1fbnVtLA0KIAkJCQl1bnNpZ25lZCBuX2xheWVy
cywNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5oIGIvZHJpdmVycy9lZGFjL2Vk
YWNfbWMuaA0KaW5kZXggZTgyMTU4NDdmODUzLi5kMWJhY2M1ZjQ3ZjUgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2VkYWMvZWRhY19tYy5oDQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQpAQCAt
MjcwLDYgKzI3MCwxMyBAQCB2b2lkIGVkYWNfbWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVudW0gaHdf
ZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCQkgIGNvbnN0IGNoYXIgKm1zZywNCiAJCQkgIGNv
bnN0IGNoYXIgKm90aGVyX2RldGFpbCk7DQogDQorLyoqDQorICogZWRhY19tY19kaXNhYmxlX2xl
Z2FjeV9hcGkoKSAtIERpc2FibGUgbGVnYWN5IHN5c2ZzIEFQSQ0KKyAqDQorICogQG1jaToJCWEg
c3RydWN0IG1lbV9jdGxfaW5mbyBwb2ludGVyDQorICovDQordm9pZCBlZGFjX21jX2Rpc2FibGVf
bGVnYWN5X2FwaShzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2kpOw0KKw0KIC8qDQogICogZWRhYyBt
aXNjIEFQSXMNCiAgKi8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgYi9k
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4IDcxNDYyMzIwNDIzMi4uODA0ZTQ4NzczZjY2
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQorKysgYi9kcml2ZXJzL2Vk
YWMvZ2hlc19lZGFjLmMNCkBAIC03ODAsNyArNzgwLDkgQEAgZ2hlc19lZGFjX3JlZ2lzdGVyX29u
ZShpbnQgbmlkLCBzdHJ1Y3QgZ2hlcyAqZ2hlcywgc3RydWN0IGRldmljZSAqcGFyZW50KQ0KIAlt
Y2ktPmRldl9uYW1lID0gZGV2X25hbWUoZGV2KTsNCiANCiAJbWVtX2luZm9fcHJlcGFyZV9tY2ko
bWNpKTsNCi0NCisjaWZkZWYgQ09ORklHX0FSTTY0DQorCWVkYWNfbWNfZGlzYWJsZV9sZWdhY3lf
YXBpKG1jaSk7DQorI2VuZGlmDQogCXJjID0gZWRhY19tY19hZGRfbWMobWNpKTsNCiAJaWYgKHJj
IDwgMCkgew0KIAkJcHJfZXJyKCJDYW4ndCByZWdpc3RlciBhdCBFREFDIGNvcmUgKCVkKVxuIiwg
cmMpOw0KLS0gDQoyLjIwLjENCg0K
