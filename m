Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6821C50FEB
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfFXPJR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:17 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57022 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730476AbfFXPJP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:15 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8FJZ025903;
        Mon, 24 Jun 2019 08:09:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=BUZsqVL7YZsjTmOqbkH+7mTjGbV1gGSnUZ5iMdLGsmY=;
 b=DHA0uNidijE/Q4QvReEc4LICWqIEU5u0WR3Slx/VYMDmmuQrW8HAY6JN7dFAlP8c0d66
 y3pooha4hVhkt8cdqr5YGBNWtgg8KlIMJiLfx86PesaPUDALpas10zitzunZd0DNjhGF
 Pn17B6hvGBrdxj8oW8grrN3y/2MvS5wpyM6nbfMRJ1Y4Nl+ZMv7KV6UUtNWYUoaqe0Im
 ypHLFiLbFtrMNGo+CkA3S8yiSuVfLnfgf0rcFWWmi/IWRXGuxSXggMynviR4jfJ5P59u
 pBE0kM9EVVaSLPiU/8XmTRGYM1jpSboPxy+jYStEMdFMZhjuRaiJdu188DRO42P+1f3H lg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7rg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:08 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:04 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUZsqVL7YZsjTmOqbkH+7mTjGbV1gGSnUZ5iMdLGsmY=;
 b=chrxlK5LaJuq6QzsKUybN+r4TVKtvfCrqm7UCn9kWLsgESSU9NIC4Ch1zGH9JnxlQoisPYKRI5lO4J4cPZ/NLuXIgcxj2mS+RBBXC3yrhPGVqql+uUvgz6OaT6GnTFMzyxlm8AmyaKZP0ypXeMPh1BaExmgfSe94+yTA+BTAb7c=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 05/24] EDAC, mc: Fix and improve sysfs init functions
Thread-Topic: [PATCH v2 05/24] EDAC, mc: Fix and improve sysfs init functions
Thread-Index: AQHVKp7CWIyiXnaYckSK7vYUHbfuPA==
Date:   Mon, 24 Jun 2019 15:09:02 +0000
Message-ID: <20190624150758.6695-6-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 7701ef64-9742-4f17-b37a-08d6f8b5e477
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB319719FFF0E5C071537EA07DD9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8ZwaLMFdgAPeIdsZnmM+i1tKscNEv2hEJXchtB/8cxnpNgDuMAi4N3RQ4Hyb+dHo2m5GHNwaa5M8mWU05j4ke5sXByS2GL2Cia49opNIVN+GuC5ZwWZOS1L8I+t6vJqeB4G1806dpk5a6Aksg5+IOG5AxNcOk2LtCTtZDz628NsZsP/tBmlQmPztAl6vZZQntixdOQE1Nj28zDGS1FaiMlaEvoSk9gILCtoAbJxwV65Rzll8N54wE1oyF7NyDSTqFHQo5Uh2k8kt1VEv7TipdOQXOF1s/OOpVQ+7Eh9KyRWwUSP4prlGQBLc72FrIY53Dq/safhN2vj+ewduIrwAO1wZU4vWKY/oFz/Kb7QUpK2FvsFC678rC4pgLZINVK0KZ9rvz7ZtBl+u/sMxcK4J72Yvuq7/2Rg31VpP8f4nQ7A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7701ef64-9742-4f17-b37a-08d6f8b5e477
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:02.8121
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

UmVtb3ZlIGdvdG9zIGFzIHRoZXkganVzdCBjcmVhdGUgb3ZlcmhlYWQuIEFsc28sIGZpeCBkZWJ1
ZyBtZXNzYWdlIGZvcg0KdGhlIGNhc2UgZWRhY19jcmVhdGVfZGltbV9vYmplY3QoKSBpcyBmYWls
aW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5j
b20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19tY19zeXNmcy5jIHwgMjUgKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYyBiL2Ry
aXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMNCmluZGV4IDdjMDFlMWNjMDMwYy4uMjlkZDk3MTlm
ODJmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYw0KKysrIGIvZHJp
dmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYw0KQEAgLTY1NSw4ICs2NTUsOSBAQCBzdGF0aWMgaW50
IGVkYWNfY3JlYXRlX2RpbW1fb2JqZWN0KHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCiAJZXJy
ID0gZGV2aWNlX2FkZCgmZGltbS0+ZGV2KTsNCiAJaWYgKGVycikNCiAJCXB1dF9kZXZpY2UoJmRp
bW0tPmRldik7DQotDQotCWVkYWNfZGJnKDAsICJjcmVhdGVkIHJhbmsvZGltbSBkZXZpY2UgJXNc
biIsIGRldl9uYW1lKCZkaW1tLT5kZXYpKTsNCisJZWxzZQ0KKwkJZWRhY19kYmcoMCwgImNyZWF0
ZWQgcmFuay9kaW1tIGRldmljZSAlc1xuIiwNCisJCQlkZXZfbmFtZSgmZGltbS0+ZGV2KSk7DQog
DQogCXJldHVybiBlcnI7DQogfQ0KQEAgLTkzOCw3ICs5MzksNyBAQCBpbnQgZWRhY19jcmVhdGVf
c3lzZnNfbWNpX2RldmljZShzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ksDQogCWlmIChlcnIgPCAw
KSB7DQogCQllZGFjX2RiZygxLCAiZmFpbHVyZTogY3JlYXRlIGRldmljZSAlc1xuIiwgZGV2X25h
bWUoJm1jaS0+ZGV2KSk7DQogCQlwdXRfZGV2aWNlKCZtY2ktPmRldik7DQotCQlnb3RvIG91dDsN
CisJCXJldHVybiBlcnI7DQogCX0NCiANCiAJLyoNCkBAIC05ODcsNyArOTg4LDYgQEAgaW50IGVk
YWNfY3JlYXRlX3N5c2ZzX21jaV9kZXZpY2Uoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KIAl9
DQogCWRldmljZV91bnJlZ2lzdGVyKCZtY2ktPmRldik7DQogDQotb3V0Og0KIAlyZXR1cm4gZXJy
Ow0KIH0NCiANCkBAIC0xMDQ0LDEwICsxMDQ0LDggQEAgaW50IF9faW5pdCBlZGFjX21jX3N5c2Zz
X2luaXQodm9pZCkNCiAJaW50IGVycjsNCiANCiAJbWNpX3BkZXYgPSBremFsbG9jKHNpemVvZigq
bWNpX3BkZXYpLCBHRlBfS0VSTkVMKTsNCi0JaWYgKCFtY2lfcGRldikgew0KLQkJZXJyID0gLUVO
T01FTTsNCi0JCWdvdG8gb3V0Ow0KLQl9DQorCWlmICghbWNpX3BkZXYpDQorCQlyZXR1cm4gLUVO
T01FTTsNCiANCiAJbWNpX3BkZXYtPmJ1cyA9IGVkYWNfZ2V0X3N5c2ZzX3N1YnN5cygpOw0KIAlt
Y2lfcGRldi0+dHlwZSA9ICZtY19hdHRyX3R5cGU7DQpAQCAtMTA1NiwxNSArMTA1NCwxMCBAQCBp
bnQgX19pbml0IGVkYWNfbWNfc3lzZnNfaW5pdCh2b2lkKQ0KIA0KIAllcnIgPSBkZXZpY2VfYWRk
KG1jaV9wZGV2KTsNCiAJaWYgKGVyciA8IDApDQotCQlnb3RvIG91dF9wdXRfZGV2aWNlOw0KLQ0K
LQllZGFjX2RiZygwLCAiZGV2aWNlICVzIGNyZWF0ZWRcbiIsIGRldl9uYW1lKG1jaV9wZGV2KSk7
DQotDQotCXJldHVybiAwOw0KKwkJcHV0X2RldmljZShtY2lfcGRldik7DQorCWVsc2UNCisJCWVk
YWNfZGJnKDAsICJkZXZpY2UgJXMgY3JlYXRlZFxuIiwgZGV2X25hbWUobWNpX3BkZXYpKTsNCiAN
Ci0gb3V0X3B1dF9kZXZpY2U6DQotCXB1dF9kZXZpY2UobWNpX3BkZXYpOw0KLSBvdXQ6DQogCXJl
dHVybiBlcnI7DQogfQ0KIA0KLS0gDQoyLjIwLjENCg0K
