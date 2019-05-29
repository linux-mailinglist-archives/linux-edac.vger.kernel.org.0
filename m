Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD62E2D817
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE2Io4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:56 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49680 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726909AbfE2Io4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:56 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8do5J017769;
        Wed, 29 May 2019 01:44:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=0uSevHM08KKRz2QHhXRbwahsPgL6zTaQutoBy4FaRGk=;
 b=t2RpN4Q4u4Da7C1LZt6wq57U37rO8OplP04e2v8femVSajutG/mlEndrmkRT7ONrmHMo
 rBvzSnyJL1E8yz4QC1yNPZy/O8wke/C5iaL8c6FGDHjTKxE3qI2ZMuxIhU6wyJS7Do5X
 hf517c9/TuO3Hu90KBF286O52/6cR/xm9vC0byGCCvqStLfL0WGi4MUpQAtkNIxlX3pR
 esSAPmf/v0sKz40ZDlhWABv4BC8iTlJ0gD4ugZHm5THyWof5w8ss5bkTzsUE18RTyQi8
 7974xFN72QhQWn9SajuORnPO9cx/kP+kdxXOYPZMgrGoBy6fRgSNQPCdRgqpg7xPPHMP hg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:48 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:46 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uSevHM08KKRz2QHhXRbwahsPgL6zTaQutoBy4FaRGk=;
 b=DUPPnmu8eVnkqclupFmEikig6iNpJbdruJUEb38x/yue1K9VPLVz38hrWIhF+bkJRwBqGjrUaNkGCto/xxfFb20SdHjdg6NpnpoUFckCjcsojSE7NA9NICaD8zwF/+qV+q0+XE05I4lLDGIq7jDxfjCLSbhFdtqvEAaOMuP74U0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:41 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:41 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 17/21] EDAC, ghes: Fill sysfs with the DMI DIMM label
 information
Thread-Topic: [PATCH 17/21] EDAC, ghes: Fill sysfs with the DMI DIMM label
 information
Thread-Index: AQHVFfrBkFN+vkv8Z0OsrMgAzX4Eeg==
Date:   Wed, 29 May 2019 08:44:41 +0000
Message-ID: <20190529084344.28562-18-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 48a9e888-9069-4936-2955-08d6e411e3da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437E158D52BCA68895F2AD3D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JmgWDWbuvM2khGszzYRFLSmj20Nza8DqHVJwxFNUxCa9y4pJxKU+h7ne+4ggNEGbK3Iu8pDNoLlcJVoDXnrvpM4ClT4Kk/gL954JkRzU4nkDpxTFGkFDg61hD7pKFRvY7kju80qc6AZg1yKNBqd/gD+Uv26TQPWX3Wsb9WkkZpbuP9sKVJYnNi+2IpjJ1Oh01eZRdQtepdFtktoh8Ffrm/1TcqY0bh3IiZFAkN+KNivKuL99VZsCNjbs4tzrnq5g6r1X+2qxKSmFjMGnXp4lpqG0EeCZb8bfbQEiS5m0B3Ep4RrwWVqbo9OP40zsvzh/r7BRikMvLc2G5i60EdxKlcz2BRX6NPSzXgcU/1x0v7kpD7ZT5Mz3slSyUliscI7Bj6OCzYzZXQ6YcvuhNg9wlj58+h4X14IjQSI7aASz+hk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a9e888-9069-4936-2955-08d6e411e3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:41.1568
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

VGhpcyBwYXRjaCBleHRyYWN0cyB0aGUgRElNTSBsYWJlbCBmcm9tIHRoZSBETUkgdGFibGUgYW5k
IHB1dHMgdGhpcw0KaW5mb3JtYXRpb24gaW50byBzeXNmcy4gRS5nLiBvbiBhIFRodW5kZXJYMiBz
eXN0ZW0gd2UgZm91bmQgdGhpcyBub3c6DQoNCiAjIGdyZXAgLiAvc3lzL2RldmljZXMvc3lzdGVt
L2VkYWMvbWMvbWMqL2RpbW0qL2RpbW1fbGFiZWwNCiAvc3lzL2RldmljZXMvc3lzdGVtL2VkYWMv
bWMvbWMwL2RpbW0wL2RpbW1fbGFiZWw6TjAgRElNTV9BMA0KIC9zeXMvZGV2aWNlcy9zeXN0ZW0v
ZWRhYy9tYy9tYzAvZGltbTEvZGltbV9sYWJlbDpOMCBESU1NX0IwDQogL3N5cy9kZXZpY2VzL3N5
c3RlbS9lZGFjL21jL21jMC9kaW1tMi9kaW1tX2xhYmVsOk4wIERJTU1fQzANCiAvc3lzL2Rldmlj
ZXMvc3lzdGVtL2VkYWMvbWMvbWMwL2RpbW0zL2RpbW1fbGFiZWw6TjAgRElNTV9EMA0KIC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAvZGltbTQvZGltbV9sYWJlbDpOMCBESU1NX0UwDQog
L3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9kaW1tNS9kaW1tX2xhYmVsOk4wIERJTU1f
RjANCiAvc3lzL2RldmljZXMvc3lzdGVtL2VkYWMvbWMvbWMwL2RpbW02L2RpbW1fbGFiZWw6TjAg
RElNTV9HMA0KIC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAvZGltbTcvZGltbV9sYWJl
bDpOMCBESU1NX0gwDQogL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMS9kaW1tMC9kaW1t
X2xhYmVsOk4xIERJTU1fSTANCiAvc3lzL2RldmljZXMvc3lzdGVtL2VkYWMvbWMvbWMxL2RpbW0x
L2RpbW1fbGFiZWw6TjEgRElNTV9KMA0KIC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzEv
ZGltbTIvZGltbV9sYWJlbDpOMSBESU1NX0swDQogL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21j
L21jMS9kaW1tMy9kaW1tX2xhYmVsOk4xIERJTU1fTDANCiAvc3lzL2RldmljZXMvc3lzdGVtL2Vk
YWMvbWMvbWMxL2RpbW00L2RpbW1fbGFiZWw6TjEgRElNTV9NMA0KIC9zeXMvZGV2aWNlcy9zeXN0
ZW0vZWRhYy9tYy9tYzEvZGltbTUvZGltbV9sYWJlbDpOMSBESU1NX04wDQogL3N5cy9kZXZpY2Vz
L3N5c3RlbS9lZGFjL21jL21jMS9kaW1tNi9kaW1tX2xhYmVsOk4xIERJTU1fTzANCiAvc3lzL2Rl
dmljZXMvc3lzdGVtL2VkYWMvbWMvbWMxL2RpbW03L2RpbW1fbGFiZWw6TjEgRElNTV9QMA0KDQpT
aWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0N
CiBkcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKy0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNf
ZWRhYy5jDQppbmRleCBlNWZhOTc3YmNmZDkuLmI4ODc4ZmY0OThkMSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpA
QCAtMjU0LDEwICsyNTQsNiBAQCBzdGF0aWMgdm9pZCBnaGVzX2VkYWNfZG1pZGVjb2RlKGNvbnN0
IHN0cnVjdCBkbWlfaGVhZGVyICpkaCwgdm9pZCAqYXJnKQ0KIAkJZGltbS0+ZHR5cGUgPSBERVZf
VU5LTk9XTjsNCiAJCWRpbW0tPmdyYWluID0gMTI4OwkJLyogTGlrZWx5LCB3b3JzZSBjYXNlICov
DQogDQotCQkvKg0KLQkJICogRklYTUU6IEl0IHNob3VsZG4ndCBiZSBoYXJkIHRvIGFsc28gZmls
bCB0aGUgRElNTSBsYWJlbHMNCi0JCSAqLw0KLQ0KIAkJaWYgKGRpbW0tPm5yX3BhZ2VzKSB7DQog
CQkJZWRhY19kYmcoMSwgIkRJTU0laTogJXMgc2l6ZSA9ICVkIE1CJXNcbiIsDQogCQkJCW1pLT5p
ZHgsIGVkYWNfbWVtX3R5cGVzW2RpbW0tPm10eXBlXSwNCkBAIC0yOTMsNiArMjg5LDcgQEAgc3Rh
dGljIGludCBtZW1faW5mb19zZXR1cCh2b2lkKQ0KIHsNCiAJc3RydWN0IGdoZXNfZGltbV9pbmZv
ICpkaW1tOw0KIAlib29sIGVuYWJsZV9udW1hID0gdHJ1ZTsNCisJY29uc3QgY2hhciAqYmFuaywg
KmRldmljZTsNCiAJaW50IGlkeCA9IDA7DQogDQogCW1lbXNldCgmbWVtX2luZm8sIDAsIHNpemVv
ZihtZW1faW5mbykpOw0KQEAgLTMxMiw2ICszMDksMTcgQEAgc3RhdGljIGludCBtZW1faW5mb19z
ZXR1cCh2b2lkKQ0KIAlkbWlfd2FsayhnaGVzX2VkYWNfc2V0X25pZCwgTlVMTCk7DQogDQogCWZv
cl9lYWNoX2RpbW0oZGltbSkgew0KKwkJYmFuayA9IGRldmljZSA9IE5VTEw7DQorCQlkbWlfbWVt
ZGV2X25hbWUoZGltbS0+ZGltbV9pbmZvLnNtYmlvc19oYW5kbGUsDQorCQkJCSZiYW5rLCAmZGV2
aWNlKTsNCisJCWlmIChiYW5rICYmIGRldmljZSkgew0KKwkJCXNucHJpbnRmKGRpbW0tPmRpbW1f
aW5mby5sYWJlbCwNCisJCQkJc2l6ZW9mKGRpbW0tPmRpbW1faW5mby5sYWJlbCksDQorCQkJCSIl
cyAlcyIsIGJhbmssIGRldmljZSk7DQorCQl9IGVsc2Ugew0KKwkJCSpkaW1tLT5kaW1tX2luZm8u
bGFiZWwgPSAnXDAnOw0KKwkJfQ0KKw0KIAkJaWYgKGRpbW0tPm51bWFfbm9kZSA9PSBOVU1BX05P
X05PREUpIHsNCiAJCQllbmFibGVfbnVtYSA9IGZhbHNlOw0KIAkJfSBlbHNlIHsNCkBAIC0zMjAs
OCArMzI4LDExIEBAIHN0YXRpYyBpbnQgbWVtX2luZm9fc2V0dXAodm9pZCkNCiAJCQltZW1faW5m
by5udW1fcGVyX25vZGVbZGltbS0+bnVtYV9ub2RlXSsrOw0KIAkJfQ0KIA0KLQkJZWRhY19kYmco
MSwgIkRJTU0laTogRm91bmQgbWVtIHJhbmdlIFslcGEtJXBhXSBvbiBub2RlICVkXG4iLA0KLQkJ
CWRpbW0tPmlkeCwgJmRpbW0tPnN0YXJ0LCAmZGltbS0+ZW5kLCBkaW1tLT5udW1hX25vZGUpOw0K
KwkJZWRhY19kYmcoMSwgIkRJTU0laTogRm91bmQgbWVtIHJhbmdlIFslcGEtJXBhXSBvbiBub2Rl
ICVkLCBoYW5kbGU6IDB4JS40eCVzJXNcbiIsDQorCQkJZGltbS0+aWR4LCAmZGltbS0+c3RhcnQs
ICZkaW1tLT5lbmQsIGRpbW0tPm51bWFfbm9kZSwNCisJCQlkaW1tLT5kaW1tX2luZm8uc21iaW9z
X2hhbmRsZSwNCisJCQkqZGltbS0+ZGltbV9pbmZvLmxhYmVsID8gIiwgbGFiZWw6ICIgOiAiIiwN
CisJCQlkaW1tLT5kaW1tX2luZm8ubGFiZWwpOw0KIAl9DQogDQogCW1lbV9pbmZvLmVuYWJsZV9u
dW1hID0gZW5hYmxlX251bWE7DQpAQCAtMzg3LDYgKzM5OCw5IEBAIHN0YXRpYyB2b2lkIG1jaV9h
ZGRfZGltbV9pbmZvKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCiAJCW1jaV9kaW1tLT5kdHlw
ZQkJPSBkbWlfZGltbS0+ZHR5cGU7DQogCQltY2lfZGltbS0+Z3JhaW4JCT0gZG1pX2RpbW0tPmdy
YWluOw0KIAkJbWNpX2RpbW0tPnNtYmlvc19oYW5kbGUgPSBkbWlfZGltbS0+c21iaW9zX2hhbmRs
ZTsNCisNCisJCWlmICgqZG1pX2RpbW0tPmxhYmVsKQ0KKwkJCXN0cmNweShtY2lfZGltbS0+bGFi
ZWwsIGRtaV9kaW1tLT5sYWJlbCk7DQogCX0NCiANCiAJaWYgKGluZGV4ICE9IG1jaS0+dG90X2Rp
bW1zKQ0KLS0gDQoyLjIwLjENCg0K
