Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3650FD6
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfFXPKC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:10:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37490 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730794AbfFXPJt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8Chs025865;
        Mon, 24 Jun 2019 08:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Ikk2ij3rACKTpnbrxZ4dsUrvelonDMRzq529ZdMkYY8=;
 b=WMJfCTsBpJOVqT8ro56LPICqx5F7GHIEDSu7iTwjEvoSaiw8Om5d3ht7un2JWWrBFlAq
 8M61ZW86D+rdYzJ2ScS/HNchO68TunxUg7llrIsjcVSO74wN7AESr7JTKo3mAZ/gho7G
 7leDl45Yoc1SxILZDgFchc4TXAOrKdpKyuDI79Z1vwIdPePGxM7yzBsUC3Oq1VlBns5T
 OyP2WjBPJynxaNTTZBdXxPUOQfZqmxCVqGNJbh4O2iq984RphTXZ29W3Tr0FemI4gR8i
 O6pf4rUKca5lacPNG2Sr+/q80+5MiV8107+oWxWn58Bwu14En930/Wj0inoNzEO1fFoJ eQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:42 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikk2ij3rACKTpnbrxZ4dsUrvelonDMRzq529ZdMkYY8=;
 b=Gzf3dKrdyLKuRTqV4kESZvFjYQjbC3fk/KScbxyGw5voMJ/vY2SqoLTgkSaDid+uUc8RKyGEUfSatWqeAUqYHQQyUU0hzwm5lGgSNIFePMLF+8Vjw/ykiLVboNv9hxuN+KgZHeQzVYvhGT3FTigvbx+xx22Kv+Y4Xf2q0JM8NSU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:39 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 22/24] EDAC, ghes: Move struct member smbios_handle to
 struct ghes_dimm_info
Thread-Topic: [PATCH v2 22/24] EDAC, ghes: Move struct member smbios_handle to
 struct ghes_dimm_info
Thread-Index: AQHVKp7YEBE65Vw/lk2wmDPTirYKWQ==
Date:   Mon, 24 Jun 2019 15:09:39 +0000
Message-ID: <20190624150758.6695-23-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: d66ed5c5-e459-43a7-68c5-08d6f8b5fa92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB31979AA653FB9C3C7D5B8076D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NT7DT70fQQB7tQa906ijvOhLzx+mdMzLyVJsgo1DIddh5BFyXmPL9JHT1Nl4WEL2yWWJNTwHoGTpdvo/PlgFpQY+uye2Ks05qQ3ZWeEIeriZq4+UcPmoDiMn8+K8Wqa8tysX4o8rkxYZ9tzOR3EjEpsbtLc8bZOUEu/hsb17EN36OqDFZEbGCEQE7vRIiCsww2cmUa4qyEwNCnQ2l064s67Svfkd1YZBcgb2KexNwgCKL3h5MqcR5ihW82zrekXCH76FQh03ZwerZcEInXZIeFilIxR8u7+H9dWkWr7Jn9sy2F1MZdbhl+WzFdYtE2zBiLE99f3hd5FFrDxk0iKSX1gMjzExWAP2Cx5WtYLQc3kJ6HrGgZkJDf12qiQSgW/z6UwlJTrrC7eW4ET2Mj7kVXfIzTfCmalpRK51/tffn3A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d66ed5c5-e459-43a7-68c5-08d6f8b5fa92
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:39.8800
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

VGhpcyBpcyBwcml2YXRlIHRvIHRoZSBnaGVzX2VkYWMgZHJpdmVyLCBzbyBiZXR0ZXIga2VlcCB0
aGF0IGRhdGEgaW4NCnRoZSBzdHJ1Y3QgZ2hlc19kaW1tX2luZm8uDQoNClNpZ25lZC1vZmYtYnk6
IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRh
Yy9naGVzX2VkYWMuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvZWRhYy5o
ICAgICB8ICAyIC0tDQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVy
cy9lZGFjL2doZXNfZWRhYy5jDQppbmRleCBmYjVhNTRlMjc5MTcuLjcxNDYyMzIwNDIzMiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2do
ZXNfZWRhYy5jDQpAQCAtODgsNiArODgsNyBAQCBzdHJ1Y3QgZ2hlc19kaW1tX2luZm8gew0KIAlp
bnQJCW1vZHVsZTsNCiAJcGh5c19hZGRyX3QJc3RhcnQ7DQogCXBoeXNfYWRkcl90CWVuZDsNCisJ
dTE2CQlzbWJpb3NfaGFuZGxlOw0KIAl1MTYJCXBoeXNfaGFuZGxlOw0KIH07DQogDQpAQCAtMTg3
LDYgKzE4OCw3IEBAIHN0YXRpYyB2b2lkIGdoZXNfZWRhY19kbWlkZWNvZGUoY29uc3Qgc3RydWN0
IGRtaV9oZWFkZXIgKmRoLCB2b2lkICphcmcpDQogCQlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tID0g
Jm1pLT5kaW1tX2luZm87DQogCQl1MTYgcmRyX21hc2sgPSBCSVQoNykgfCBCSVQoMTMpOw0KIA0K
KwkJbWktPnNtYmlvc19oYW5kbGUgPSBlbnRyeS0+aGFuZGxlOw0KIAkJbWktPnBoeXNfaGFuZGxl
ID0gZW50cnktPnBoeXNfbWVtX2FycmF5X2hhbmRsZTsNCiANCiAJCWlmIChlbnRyeS0+c2l6ZSA9
PSAweGZmZmYpIHsNCkBAIC0yNjgsOCArMjcwLDYgQEAgc3RhdGljIHZvaWQgZ2hlc19lZGFjX2Rt
aWRlY29kZShjb25zdCBzdHJ1Y3QgZG1pX2hlYWRlciAqZGgsIHZvaWQgKmFyZykNCiAJCQkJZW50
cnktPnRvdGFsX3dpZHRoLCBlbnRyeS0+ZGF0YV93aWR0aCk7DQogCQl9DQogDQotCQlkaW1tLT5z
bWJpb3NfaGFuZGxlID0gZW50cnktPmhhbmRsZTsNCi0NCiAJCSgqaWR4KSsrOw0KIAl9DQogfQ0K
QEAgLTMwOCw4ICszMDgsNyBAQCBzdGF0aWMgaW50IG1lbV9pbmZvX3NldHVwKHZvaWQpDQogDQog
CWZvcl9lYWNoX2RpbW0oZGltbSkgew0KIAkJYmFuayA9IGRldmljZSA9IE5VTEw7DQotCQlkbWlf
bWVtZGV2X25hbWUoZGltbS0+ZGltbV9pbmZvLnNtYmlvc19oYW5kbGUsDQotCQkJCSZiYW5rLCAm
ZGV2aWNlKTsNCisJCWRtaV9tZW1kZXZfbmFtZShkaW1tLT5zbWJpb3NfaGFuZGxlLCAmYmFuaywg
JmRldmljZSk7DQogCQlpZiAoYmFuayAmJiBkZXZpY2UpIHsNCiAJCQlzbnByaW50ZihkaW1tLT5k
aW1tX2luZm8ubGFiZWwsDQogCQkJCXNpemVvZihkaW1tLT5kaW1tX2luZm8ubGFiZWwpLA0KQEAg
LTMyNSw3ICszMjQsNyBAQCBzdGF0aWMgaW50IG1lbV9pbmZvX3NldHVwKHZvaWQpDQogDQogCQll
ZGFjX2RiZygxLCAiRElNTSVpOiBGb3VuZCBtZW0gcmFuZ2UgWyVwYS0lcGFdIG9uIG5vZGUgJWQs
IGhhbmRsZTogMHglLjR4JXMlc1xuIiwNCiAJCQlkaW1tLT5pZHgsICZkaW1tLT5zdGFydCwgJmRp
bW0tPmVuZCwgZGltbS0+bnVtYV9ub2RlLA0KLQkJCWRpbW0tPmRpbW1faW5mby5zbWJpb3NfaGFu
ZGxlLA0KKwkJCWRpbW0tPnNtYmlvc19oYW5kbGUsDQogCQkJKmRpbW0tPmRpbW1faW5mby5sYWJl
bCA/ICIsIGxhYmVsOiAiIDogIiIsDQogCQkJZGltbS0+ZGltbV9pbmZvLmxhYmVsKTsNCiAJfQ0K
QEAgLTM4NCw3ICszODMsNiBAQCBzdGF0aWMgdm9pZCBtZW1faW5mb19wcmVwYXJlX21jaShzdHJ1
Y3QgbWVtX2N0bF9pbmZvICptY2kpDQogCQltY2lfZGltbS0+ZWRhY19tb2RlCT0gZG1pX2RpbW0t
PmVkYWNfbW9kZTsNCiAJCW1jaV9kaW1tLT5kdHlwZQkJPSBkbWlfZGltbS0+ZHR5cGU7DQogCQlt
Y2lfZGltbS0+Z3JhaW4JCT0gZG1pX2RpbW0tPmdyYWluOw0KLQkJbWNpX2RpbW0tPnNtYmlvc19o
YW5kbGUgPSBkbWlfZGltbS0+c21iaW9zX2hhbmRsZTsNCiANCiAJCWlmICgqZG1pX2RpbW0tPmxh
YmVsKQ0KIAkJCXN0cmNweShtY2lfZGltbS0+bGFiZWwsIGRtaV9kaW1tLT5sYWJlbCk7DQpAQCAt
NDE1LDEzICs0MTMsMTQgQEAgZ2V0X2FuZF9wcmVwYXJlX2RpbW1faW5mbyhpbnQgbmlkLCBpbnQg
Y2FyZCwgaW50IG1vZHVsZSwgaW50IGhhbmRsZSkNCiAJICogRGV2aWNlIFN0cnVjdHVyZSB0aGF0
IHJlcHJlc2VudHMgdGhlIE1lbW9yeSBNb2R1bGUpDQogCSAqLw0KIAlmb3JfZWFjaF9kaW1tKGRp
bW0pIHsNCi0JCWRpID0gZGltbS0+ZGltbTsNCi0JCWlmIChkaS0+c21iaW9zX2hhbmRsZSA9PSBo
YW5kbGUpDQorCQlpZiAoZGltbS0+c21iaW9zX2hhbmRsZSA9PSBoYW5kbGUpDQogCQkJZ290byBm
b3VuZDsNCiAJfQ0KIA0KIAlyZXR1cm4gTlVMTDsNCiBmb3VuZDoNCisJZGkgPSBkaW1tLT5kaW1t
Ow0KKw0KIAlpZiAoZGltbS0+Y2FyZCA8IDAgJiYgY2FyZCA+PSAwKQ0KIAkJZGltbS0+Y2FyZCA9
IGNhcmQ7DQogCWlmIChkaW1tLT5tb2R1bGUgPCAwICYmIG1vZHVsZSA+PSAwKQ0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZWRhYy5oIGIvaW5jbHVkZS9saW51eC9lZGFjLmgNCmluZGV4IDQw
ZTdkYTczNWU0OC4uMzJhZDg4MmJlYTE1IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9lZGFj
LmgNCisrKyBiL2luY2x1ZGUvbGludXgvZWRhYy5oDQpAQCAtMzg0LDggKzM4NCw2IEBAIHN0cnVj
dCBkaW1tX2luZm8gew0KIA0KIAl1bnNpZ25lZCBjc3JvdywgY3NjaGFubmVsOwkvKiBQb2ludHMg
dG8gdGhlIG9sZCBBUEkgZGF0YSAqLw0KIA0KLQl1MTYgc21iaW9zX2hhbmRsZTsgICAgICAgICAg
ICAgIC8qIEhhbmRsZSBmb3IgU01CSU9TIHR5cGUgMTcgKi8NCi0NCiAJdTMyIGNlX2NvdW50Ow0K
IAl1MzIgdWVfY291bnQ7DQogfTsNCi0tIA0KMi4yMC4xDQoNCg==
