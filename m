Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879A250FEC
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfFXPJM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:12 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16188 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730401AbfFXPJL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:11 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8CWL025874;
        Mon, 24 Jun 2019 08:09:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=XzkIXlo2AUzfgtRQG3BbJZmCvL+GYLS9DAmwQTt4JcQ=;
 b=VJeU+hYnVTavU2FKRkKJ4yZwOhTXWDBTj9pOehJBQAh4bkV1RQ4APeo+UC5SZHktWe9X
 UAdOh1fKDPLxId25QaAq9s5Dm+L3Lre2WuirsFKVnF70J4kTHUP0lyPh4iGAnQY9Vjn1
 MBG4sxfVngaWU4NG/CTnjMPCPqyowigV4qcIWivAulnJ6zv3PCKVsCtP+zQ/XoCzMgBH
 /Ss51bIY7g8XlC99p0EunlLcZ3bHN2S4OihJiF5MrS2dgBNz0Eqtynz1gt1x2upAMiPA
 MEIoMK5/3tiyyU0RDoUyQCj/g6k5p6A/I6p45u8lvauk/p54fiIhQ9avAIT1OugGsI3u 0A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:05 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:02 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzkIXlo2AUzfgtRQG3BbJZmCvL+GYLS9DAmwQTt4JcQ=;
 b=pWrcx9PrkA/2ZBj3xu8WxvGzHtkAYai4UkC5beQc7yxhhRbUZuQed+smn35T2srpWFqlkpk9lrK1Xzcs7k5of385y7aURuz0LHCYfy3UUFqpMp9xI6bHTwTHA/gB4Xsqm090wqK23zGYskwiI0JsyXG5V5B1PARVSsvVeMUaVkA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:01 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:01 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 04/24] EDAC, ghes: Unify trace_mc_event() code with edac_mc
 driver
Thread-Topic: [PATCH v2 04/24] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Index: AQHVKp7BHx6v+XRJ/ECy94o4MVS4fg==
Date:   Mon, 24 Jun 2019 15:09:00 +0000
Message-ID: <20190624150758.6695-5-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: dbb61737-e45a-4cd1-3bd8-08d6f8b5e361
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB319751BAA6DAA2D17993E643D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UXqjk+nBSRtH13VjFwvtHzshExLWNqUZHSXbJIK2kdOZlYDlGtyMKUiUv47/2OcRi9wRtWQ3RGNi3TL+SluEQhZKeUVU4IReBnigTKBwrZPlKG1eHAGqZFz+GUaTuZfU/N/qSdionpIvBQdSrqxZWB+k07wK/z44oymlqSVjkJvMAcvTf+5YA+SwVduEjdjdx9/cp7d5k/TGoPURSrdivANZ0lw8LQGJ9orv8A1sycRAaa1HAHRwAoPQ2UjgBYRa/Y/t2y2//g3M8/gvgRObZy1//k8piXmJpQkBsEPgH4ds6kmi4yX6xUpEknncihoYv+NbHlr6cjZxC2vKOjoDre46k7VibeUuPtH/f9WkcCBYQbu2vXVknWHmomqLA2EXBkFPrxjmiqTR1U1aldlXoXTkGkulCVR5k1skmPWy4oc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb61737-e45a-4cd1-3bd8-08d6f8b5e361
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:00.9801
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

RHVwbGljYXRlIGNvZGUsIHJlbW92ZSBpdC4gVGhlIG9ubHkgZGlmZmVyZW5jZSBpcyB0aGUgbWlz
c2luZw0KSVNfRU5BQkxFRChDT05GSUdfUkFTKSBzd2l0Y2ggaW4gZ2hlc19lZGFjIHdoaWNoIHdl
IHdpbGwgbmVlZCB0aGVyZQ0KdG9vLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8
cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19tYy5jICAgfCAz
NCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9lZGFjL2doZXNf
ZWRhYy5jIHwgMTYgKy0tLS0tLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZWRh
Y19tYy5jIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KaW5kZXggNDVjYWM3NGFiODMzLi40YmJj
OGFlZGRmMzAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQorKysgYi9kcml2
ZXJzL2VkYWMvZWRhY19tYy5jDQpAQCAtMTA1Niw2ICsxMDU2LDIzIEBAIHZvaWQgZWRhY19yYXdf
bWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiB7
DQogCWNoYXIgZGV0YWlsWzgwXTsNCiAJaW50IHBvc1tFREFDX01BWF9MQVlFUlNdID0geyBlLT50
b3BfbGF5ZXIsIGUtPm1pZF9sYXllciwgZS0+bG93X2xheWVyIH07DQorCXU4IGdyYWluX2JpdHM7
DQorDQorCS8qDQorCSAqIFdlIGV4cGVjdCB0aGUgaHcgdG8gcmVwb3J0IGEgcmVhc29uYWJsZSBn
cmFpbiwgZmFsbGJhY2sgdG8NCisJICogMSBieXRlIGdyYW51bGFyaXR5IG90aGVyd2lzZS4NCisJ
ICovDQorCWlmIChXQVJOX09OX09OQ0UoIWUtPmdyYWluKSkNCisJCWUtPmdyYWluID0gMTsNCisJ
Z3JhaW5fYml0cyA9IGZsc19sb25nKGUtPmdyYWluIC0gMSk7DQorDQorCS8qIFJlcG9ydCB0aGUg
ZXJyb3IgdmlhIHRoZSB0cmFjZSBpbnRlcmZhY2UgKi8NCisJaWYgKElTX0VOQUJMRUQoQ09ORklH
X1JBUykpDQorCQl0cmFjZV9tY19ldmVudCh0eXBlLCBlLT5tc2csIGUtPmxhYmVsLCBlLT5lcnJv
cl9jb3VudCwNCisJCQkgICAgICAgbWNpLT5tY19pZHgsIGUtPnRvcF9sYXllciwgZS0+bWlkX2xh
eWVyLA0KKwkJCSAgICAgICBlLT5sb3dfbGF5ZXIsDQorCQkJICAgICAgIChlLT5wYWdlX2ZyYW1l
X251bWJlciA8PCBQQUdFX1NISUZUKSB8IGUtPm9mZnNldF9pbl9wYWdlLA0KKwkJCSAgICAgICBn
cmFpbl9iaXRzLCBlLT5zeW5kcm9tZSwgZS0+b3RoZXJfZGV0YWlsKTsNCiANCiAJLyogTWVtb3J5
IHR5cGUgZGVwZW5kZW50IGRldGFpbHMgYWJvdXQgdGhlIGVycm9yICovDQogCWlmICh0eXBlID09
IEhXX0VWRU5UX0VSUl9DT1JSRUNURUQpIHsNCkBAIC0xMDk1LDcgKzExMTIsNiBAQCB2b2lkIGVk
YWNfbWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwN
CiAJaW50IHJvdyA9IC0xLCBjaGFuID0gLTE7DQogCWludCBwb3NbRURBQ19NQVhfTEFZRVJTXSA9
IHsgdG9wX2xheWVyLCBtaWRfbGF5ZXIsIGxvd19sYXllciB9Ow0KIAlpbnQgaSwgbl9sYWJlbHMg
PSAwOw0KLQl1OCBncmFpbl9iaXRzOw0KIAlzdHJ1Y3QgZWRhY19yYXdfZXJyb3JfZGVzYyAqZSA9
ICZtY2ktPmVycm9yX2Rlc2M7DQogDQogCWVkYWNfZGJnKDMsICJNQyVkXG4iLCBtY2ktPm1jX2lk
eCk7DQpAQCAtMTIzNSwyMiArMTI1MSw2IEBAIHZvaWQgZWRhY19tY19oYW5kbGVfZXJyb3IoY29u
c3QgZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIAlpZiAocCA+IGUtPmxvY2F0aW9u
KQ0KIAkJKihwIC0gMSkgPSAnXDAnOw0KIA0KLQkvKg0KLQkgKiBXZSBleHBlY3QgdGhlIGh3IHRv
IHJlcG9ydCBhIHJlYXNvbmFibGUgZ3JhaW4sIGZhbGxiYWNrIHRvDQotCSAqIDEgYnl0ZSBncmFu
dWxhcml0eSBvdGhlcndpc2UuDQotCSAqLw0KLQlpZiAoV0FSTl9PTl9PTkNFKCFlLT5ncmFpbikp
DQotCQllLT5ncmFpbiA9IDE7DQotCWdyYWluX2JpdHMgPSBmbHNfbG9uZyhlLT5ncmFpbiAtIDEp
Ow0KLQ0KLQkvKiBSZXBvcnQgdGhlIGVycm9yIHZpYSB0aGUgdHJhY2UgaW50ZXJmYWNlICovDQot
CWlmIChJU19FTkFCTEVEKENPTkZJR19SQVMpKQ0KLQkJdHJhY2VfbWNfZXZlbnQodHlwZSwgZS0+
bXNnLCBlLT5sYWJlbCwgZS0+ZXJyb3JfY291bnQsDQotCQkJICAgICAgIG1jaS0+bWNfaWR4LCBl
LT50b3BfbGF5ZXIsIGUtPm1pZF9sYXllciwNCi0JCQkgICAgICAgZS0+bG93X2xheWVyLA0KLQkJ
CSAgICAgICAoZS0+cGFnZV9mcmFtZV9udW1iZXIgPDwgUEFHRV9TSElGVCkgfCBlLT5vZmZzZXRf
aW5fcGFnZSwNCi0JCQkgICAgICAgZ3JhaW5fYml0cywgZS0+c3luZHJvbWUsIGUtPm90aGVyX2Rl
dGFpbCk7DQotDQogCWVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcih0eXBlLCBtY2ksIGUpOw0KIH0N
CiBFWFBPUlRfU1lNQk9MX0dQTChlZGFjX21jX2hhbmRsZV9lcnJvcik7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRl
eCAwNDlkZTczYzNiYWQuLmJkM2JlMjVkMGQzZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9n
aGVzX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtMjAwLDcgKzIw
MCw2IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNw
ZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogCXN0cnVjdCBnaGVzX2VkYWNfcHZ0ICpwdnQgPSBn
aGVzX3B2dDsNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJY2hhciAqcDsNCi0JdTggZ3JhaW5f
Yml0czsNCiANCiAJaWYgKCFwdnQpDQogCQlyZXR1cm47DQpAQCAtNDM2LDIxICs0MzUsOCBAQCB2
b2lkIGdoZXNfZWRhY19yZXBvcnRfbWVtX2Vycm9yKGludCBzZXYsIHN0cnVjdCBjcGVyX3NlY19t
ZW1fZXJyICptZW1fZXJyKQ0KIAlpZiAocCA+IHB2dC0+b3RoZXJfZGV0YWlsKQ0KIAkJKihwIC0g
MSkgPSAnXDAnOw0KIA0KLQkvKg0KLQkgKiBXZSBleHBlY3QgdGhlIGh3IHRvIHJlcG9ydCBhIHJl
YXNvbmFibGUgZ3JhaW4sIGZhbGxiYWNrIHRvDQotCSAqIDEgYnl0ZSBncmFudWxhcml0eSBvdGhl
cndpc2UuDQotCSAqLw0KLQlpZiAoV0FSTl9PTl9PTkNFKCFlLT5ncmFpbikpDQotCQllLT5ncmFp
biA9IDE7DQotCWdyYWluX2JpdHMgPSBmbHNfbG9uZyhlLT5ncmFpbiAtIDEpOw0KLQ0KLQkvKiBH
ZW5lcmF0ZSB0aGUgdHJhY2UgZXZlbnQgKi8NCi0JdHJhY2VfbWNfZXZlbnQodHlwZSwgZS0+bXNn
LCBlLT5sYWJlbCwgZS0+ZXJyb3JfY291bnQsDQotCQkgICAgICAgbWNpLT5tY19pZHgsIGUtPnRv
cF9sYXllciwgZS0+bWlkX2xheWVyLCBlLT5sb3dfbGF5ZXIsDQotCQkgICAgICAgKGUtPnBhZ2Vf
ZnJhbWVfbnVtYmVyIDw8IFBBR0VfU0hJRlQpIHwgZS0+b2Zmc2V0X2luX3BhZ2UsDQotCQkgICAg
ICAgZ3JhaW5fYml0cywgZS0+c3luZHJvbWUsIGUtPm90aGVyX2RldGFpbCk7DQotDQogCWVkYWNf
cmF3X21jX2hhbmRsZV9lcnJvcih0eXBlLCBtY2ksIGUpOw0KKw0KIAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZnaGVzX2xvY2ssIGZsYWdzKTsNCiB9DQogDQotLSANCjIuMjAuMQ0KDQo=
