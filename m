Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45BF2D819
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfE2IpP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:45:15 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49664 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbfE2Ioz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8doO7017780;
        Wed, 29 May 2019 01:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GUy40+DnrF6OKmv6P4tIQfRAjMx1FBjH2O7IeBlDwQA=;
 b=AMUvekIgvWcZh/XwYCRPpO1FWMI1WcyVEUNrpnWqtbjxpQjSK1hmXnAxtsm4f6xyb8zN
 N7PmFgR2R2b4AVU2sETTkXNvrgWUIBq/hag3nijMZL5o2PvisKD1Wluft67eMxTLiprT
 i1o34zepXX7OFF7ulI6+c9+S8OWR8eXlO/2e4BeR3eZfvM5t+otIrLyFxbSx44pXjb9G
 4wrbWilvRc7oILMIdkZU1X9o/+SdEIgQAo+QdWgdQss7iwxVR17fJXiozXUK8qNr/gyC
 bLvD1l8EElqoC2mmVsRiKOa3KYmDRu95XbAWmSg8Jz8jkN6UdfKacglixGPc+Jazboi5 oQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:49 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:47 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUy40+DnrF6OKmv6P4tIQfRAjMx1FBjH2O7IeBlDwQA=;
 b=mAGOAFymtg2P1Czg9tx1ytPR+F66Cq18uWzxBvg3Q1W0yZ965hF5Oqn+bPlfAAQtR0Vc+H5JC1ecT4d0nAV/bDB/tPmTz0LipzJAJIpP0WwjjYQDlYTUwIi0UIApaKUJtGTy78M892wPLeJG88XQbf09zO1Ipr4y+YTcwtt0y/g=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:45 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:45 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 19/21] EDAC, ghes: Identify dimm by node, card, module and
 handle
Thread-Topic: [PATCH 19/21] EDAC, ghes: Identify dimm by node, card, module
 and handle
Thread-Index: AQHVFfrEFc2xj5nexkqG4JRDUNiq8A==
Date:   Wed, 29 May 2019 08:44:45 +0000
Message-ID: <20190529084344.28562-20-rrichter@marvell.com>
References: <20190529084344.28562-1-rrichter@marvell.com>
In-Reply-To: <20190529084344.28562-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::23) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [78.54.13.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6cd393-6d40-4d0f-33ff-08d6e411e681
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437E3D859B908343C9B7397D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r2n5TutrTGSmGGK/+6u9kjneM51PDHMxyHnGbd6EWkdpiKzEqiv/kz+uiF0IeCN4gVkL3LJeUEL+W3e4xyxoAXekK3cPajzN62psjnG6dT/p4Tl1219WwPtgKYt2+RlS9ASBabh+i6FyWJTzIxmi4xcYiZK1VFTmZfYJWbSx7nTCYzvvhYGTL0MWFNFYAJeR4qxzjbtH8cyb/2ywA30szjgCsxe24uvwVbgOGxAufyVfSbrpGthCz3XnSGKLu8uJfxWPhJlApkJ1z6ZPHSNIBdCauT5xGskgFgBrfuqmudFuaCCk+bFWkBid7SVyKVJQtAUfJgud6shgFlPHHAnPCM1CkOn1PWVSsSD8eMRFLRBrDYrH0BO7hSgqCDtgwDzPo34s+SDmWSH8LEpTkvCR66LjwqJDfWW/m6sDuEer3j4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6cd393-6d40-4d0f-33ff-08d6e411e681
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:45.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3437
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_05:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

QWNjb3JkaW5nIHRvIFNNQklPUyBTcGVjLiAyLjcgKE4uMi41IE1lbW9yeSBFcnJvciBTZWN0aW9u
KSwgYSBmYWlsaW5nDQpESU1NIChtb2R1bGUgb3IgcmFuayBudW1iZXIpIGNhbiBiZSBpZGVudGlm
aWVkIGJ5IGl0cyBlcnJvciBsb2NhdGlvbg0KY29uc2lzdGluZyBvZiBub2RlLCBjYXJkIGFuZCBt
b2R1bGUuIEEgbW9kdWxlIGhhbmRsZSBpcyB1c2VkIHRvIG1hcCBpdA0KdG8gdGhlIGRpbW1zIGxp
c3RlZCBpbiB0aGUgZG1pIHRhYmxlLiBDb2xsZWN0IGFsbCB0aG9zZSBkYXRhIGZyb20gdGhlDQpl
cnJvciByZWNvcmQgYW5kIHNlbGVjdCB0aGUgZGltbSBhY2NvcmRpbmdseS4gSW5jb25zaXN0ZW50
IGVycm9yDQpyZWNvcmRzIHdpbGwgYmUgcmVwb3J0ZWQgd2hpY2ggaXMgdGhlIGNhc2UgaWYgdGhl
IHNhbWUgZGltbSBoYW5kbGUNCnJlcG9ydHMgZXJyb3JzIHdpdGggZGlmZmVyZW50IG5vZGUsIGNh
cmQgb3IgbW9kdWxlLg0KDQpUaGUgY2hhbmdlIGFsbG93cyB0byBlbmFibGUgcGVyLWxheWVyIHJl
cG9ydGluZyBiYXNlZCBvbiBub2RlLCBjYXJkDQphbmQgbW9kdWxlIGluIHRoZSBuZXh0IHBhdGNo
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+
DQotLS0NCiBkcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgfCA3NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5j
IGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRleCA0YmFjNjQzZDM0MDQuLjA3Yzg0N2Vk
NzMxNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJpdmVy
cy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtODMsOCArODMsMTEgQEAgc3RydWN0IG1lbWFycl9kbWlf
ZW50cnkgew0KIA0KIHN0cnVjdCBnaGVzX2RpbW1faW5mbyB7DQogCXN0cnVjdCBkaW1tX2luZm8g
ZGltbV9pbmZvOw0KKwlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tOw0KIAlpbnQJCWlkeDsNCiAJaW50
CQludW1hX25vZGU7DQorCWludAkJY2FyZDsNCisJaW50CQltb2R1bGU7DQogCXBoeXNfYWRkcl90
CXN0YXJ0Ow0KIAlwaHlzX2FkZHJfdAllbmQ7DQogCXUxNgkJcGh5c19oYW5kbGU7DQpAQCAtMTE5
LDYgKzEyMiw4IEBAIHN0YXRpYyB2b2lkIGdoZXNfZGltbV9pbmZvX2luaXQodm9pZCkNCiAJZm9y
X2VhY2hfZGltbShkaW1tKSB7DQogCQlkaW1tLT5pZHgJPSBpZHg7DQogCQlkaW1tLT5udW1hX25v
ZGUJPSBOVU1BX05PX05PREU7DQorCQlkaW1tLT5jYXJkCT0gLTE7DQorCQlkaW1tLT5tb2R1bGUJ
PSAtMTsNCiAJCWlkeCsrOw0KIAl9DQogfQ0KQEAgLTQwMSw2ICs0MDYsMTMgQEAgc3RhdGljIHZv
aWQgbWNpX2FkZF9kaW1tX2luZm8oc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKQ0KIA0KIAkJaWYg
KCpkbWlfZGltbS0+bGFiZWwpDQogCQkJc3RyY3B5KG1jaV9kaW1tLT5sYWJlbCwgZG1pX2RpbW0t
PmxhYmVsKTsNCisNCisJCS8qDQorCQkgKiBGcm9tIGhlcmUgb24gZG8gbm90IHVzZSBhbnkgbG9u
Z2VyICZkaW1tLmRpbW1faW5mby4NCisJCSAqIEluc3RlYWQgc3dpdGNoIHRvIHRoZSBtY2kncyBk
aW1tIGluZm8gd2hpY2ggbWlnaHQNCisJCSAqIGNvbnRhaW4gdXBkYXRlZCBkYXRhLCBzdWNoIGFz
IHRoZSBsYWJlbC4NCisJCSAqLw0KKwkJZGltbS0+ZGltbSA9IG1jaV9kaW1tOw0KIAl9DQogDQog
CWlmIChpbmRleCAhPSBtY2ktPnRvdF9kaW1tcykNCkBAIC00MDgsMjQgKzQyMCw0NiBAQCBzdGF0
aWMgdm9pZCBtY2lfYWRkX2RpbW1faW5mbyhzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2kpDQogCQkJ
aW5kZXgsIG1jaS0+dG90X2RpbW1zKTsNCiB9DQogDQotc3RhdGljIHN0cnVjdCBtZW1fY3RsX2lu
Zm8gKmdldF9tY19ieV9ub2RlKGludCBuaWQpDQorLyogUmVxdWlyZXMgZ2hlc19sb2NrIGJlaW5n
IHNldC4gKi8NCitzdGF0aWMgc3RydWN0IGdoZXNfZGltbV9pbmZvICoNCitnZXRfYW5kX3ByZXBh
cmVfZGltbV9pbmZvKGludCBuaWQsIGludCBjYXJkLCBpbnQgbW9kdWxlLCBpbnQgaGFuZGxlKQ0K
IHsNCi0Jc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpID0gZWRhY19tY19maW5kKG5pZCk7DQorCXN0
YXRpYyBzdHJ1Y3QgZ2hlc19kaW1tX2luZm8gKmRpbW07DQorCXN0cnVjdCBkaW1tX2luZm8gKmRp
Ow0KIA0KLQlpZiAobWNpKQ0KLQkJcmV0dXJuIG1jaTsNCisJLyoNCisJICogV2UgcmVxdWlyZSBz
bWJpb3NfaGFuZGxlIGJlaW5nIHNldCBpbiB0aGUgZXJyb3IgcmVwb3J0IGZvcg0KKwkgKiBwZXIg
bGF5ZXIgcmVwb3J0aW5nIChTTUJJT1MgaGFuZGxlIGZvciB0aGUgVHlwZSAxNyBNZW1vcnkNCisJ
ICogRGV2aWNlIFN0cnVjdHVyZSB0aGF0IHJlcHJlc2VudHMgdGhlIE1lbW9yeSBNb2R1bGUpDQor
CSAqLw0KKwlmb3JfZWFjaF9kaW1tKGRpbW0pIHsNCisJCWRpID0gZGltbS0+ZGltbTsNCisJCWlm
IChkaS0+c21iaW9zX2hhbmRsZSA9PSBoYW5kbGUpDQorCQkJZ290byBmb3VuZDsNCisJfQ0KIA0K
LQlpZiAobnVtX3Bvc3NpYmxlX25vZGVzKCkgPiAxKSB7DQotCQllZGFjX21jX3ByaW50ayhmYWxs
YmFjaywgS0VSTl9XQVJOSU5HLA0KLQkJCSJJbnZhbGlkIG9yIG5vIG5vZGUgaW5mb3JtYXRpb24s
IGZhbGxpbmcgYmFjayB0byBmaXJzdCBub2RlOiAlcyIsDQotCQkJZmFsbGJhY2stPmRldl9uYW1l
KTsNCisJcmV0dXJuIE5VTEw7DQorZm91bmQ6DQorCWlmIChkaW1tLT5jYXJkIDwgMCAmJiBjYXJk
ID49IDApDQorCQlkaW1tLT5jYXJkID0gY2FyZDsNCisJaWYgKGRpbW0tPm1vZHVsZSA8IDAgJiYg
bW9kdWxlID49IDApDQorCQlkaW1tLT5tb2R1bGUgPSBtb2R1bGU7DQorDQorCWlmICgobnVtX3Bv
c3NpYmxlX25vZGVzKCkgPiAxICYmIGRpLT5tY2ktPm1jX2lkeCAhPSBuaWQpIHx8DQorCQkoY2Fy
ZCA+PSAwICYmIGNhcmQgIT0gZGltbS0+Y2FyZCkgfHwNCisJCShtb2R1bGUgPj0gMCAmJiBtb2R1
bGUgIT0gZGltbS0+bW9kdWxlKSkgew0KKwkJZWRhY19tY19wcmludGsoZGktPm1jaSwgS0VSTl9X
QVJOSU5HLA0KKwkJCSJJbmNvbnNpc3RlbnQgZXJyb3IgcmVwb3J0IChuaWQvY2FyZC9tb2R1bGUp
OiAlZC8lZC8lZCAoZGltbSVkOiAlZC8lZC8lZCkiLA0KKwkJCW5pZCwgY2FyZCwgbW9kdWxlLCBk
aS0+aWR4LA0KKwkJCWRpLT5tY2ktPm1jX2lkeCwgZGltbS0+Y2FyZCwgZGltbS0+bW9kdWxlKTsN
CiAJfQ0KIA0KLQlyZXR1cm4gZmFsbGJhY2s7DQorCXJldHVybiBkaW1tOw0KIH0NCiANCiB2b2lk
IGdoZXNfZWRhY19yZXBvcnRfbWVtX2Vycm9yKGludCBzZXYsIHN0cnVjdCBjcGVyX3NlY19tZW1f
ZXJyICptZW1fZXJyKQ0KIHsNCisJc3RydWN0IGdoZXNfZGltbV9pbmZvICpkaW1tOw0KIAlzdHJ1
Y3QgZGltbV9pbmZvICpkaW1tX2luZm87DQogCWVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlw
ZTsNCiAJc3RydWN0IGVkYWNfcmF3X2Vycm9yX2Rlc2MgKmU7DQpAQCAtNDM0LDYgKzQ2OCw5IEBA
IHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNwZXJfc2Vj
X21lbV9lcnIgKm1lbV9lcnIpDQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCWNoYXIgKnA7DQog
CWludCBuaWQgPSBOVU1BX05PX05PREU7DQorCWludCBjYXJkID0gLTE7DQorCWludCBtb2R1bGUg
PSAtMTsNCisJaW50IGhhbmRsZSA9IC0xOw0KIA0KIAkvKiBXZSBuZWVkIGF0IGxlYXN0IG9uZSBt
YyAqLw0KIAlpZiAoV0FSTl9PTl9PTkNFKCFmYWxsYmFjaykpDQpAQCAtNDQ5LDEwICs0ODYsMjMg
QEAgdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3QgY3Blcl9z
ZWNfbWVtX2VyciAqbWVtX2VycikNCiANCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmdoZXNfbG9jaywg
ZmxhZ3MpOw0KIA0KLQkvKiBzZWxlY3QgdGhlIG5vZGUncyBtYyBkZXZpY2UgKi8NCiAJaWYgKG1l
bV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX05PREUpDQogCQluaWQgPSBt
ZW1fZXJyLT5ub2RlOw0KLQltY2kgPSBnZXRfbWNfYnlfbm9kZShuaWQpOw0KKwlpZiAobWVtX2Vy
ci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURfQ0FSRCkNCisJCWNhcmQgPSBtZW1f
ZXJyLT5jYXJkOw0KKwlpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFM
SURfTU9EVUxFKQ0KKwkJbW9kdWxlID0gbWVtX2Vyci0+bW9kdWxlOw0KKwlpZiAobWVtX2Vyci0+
dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURfTU9EVUxFX0hBTkRMRSkNCisJCWhhbmRs
ZSA9IG1lbV9lcnItPm1lbV9kZXZfaGFuZGxlOw0KKw0KKwlkaW1tID0gZ2V0X2FuZF9wcmVwYXJl
X2RpbW1faW5mbyhuaWQsIGNhcmQsIG1vZHVsZSwgaGFuZGxlKTsNCisJaWYgKGRpbW0pDQorCQlt
Y2kgPSBkaW1tLT5kaW1tLT5tY2k7DQorCWVsc2UNCisJCW1jaSA9IGVkYWNfbWNfZmluZChuaWQp
Ow0KKwlpZiAoIW1jaSkNCisJCW1jaSA9IGZhbGxiYWNrOw0KKw0KIAlwdnQgPSBtY2ktPnB2dF9p
bmZvOw0KIAllID0gJm1jaS0+ZXJyb3JfZGVzYzsNCiANCkBAIC02NzAsNyArNzIwLDcgQEAgdm9p
ZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3QgY3Blcl9zZWNfbWVt
X2VyciAqbWVtX2VycikNCiAJaWYgKHAgPiBwdnQtPm90aGVyX2RldGFpbCkNCiAJCSoocCAtIDEp
ID0gJ1wwJzsNCiANCi0JZGltbV9pbmZvID0gZWRhY19nZXRfZGltbV9ieV9pbmRleChtY2ksIGUt
PnRvcF9sYXllcik7DQorCWRpbW1faW5mbyA9IGRpbW0gPyBkaW1tLT5kaW1tIDogTlVMTDsNCiAN
CiAJZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKHR5cGUsIG1jaSwgZGltbV9pbmZvLCBlLCAtMSwg
LTEpOw0KIA0KLS0gDQoyLjIwLjENCg0K
