Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C650FC9
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfFXPJm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36412 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730682AbfFXPJl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8Eai025899;
        Mon, 24 Jun 2019 08:09:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=uM9KgsvD2e9WjIvDSEv9d7g7JoMCbdcjIlzib1u3/tg=;
 b=a6B7hSr9kwxH2RaO4IifGadswW8IF9+5p0m2R9llDJeWCWY4JJ3yHuOmjAZJRz0sNUsE
 nN4r+DMf4BAWq8J4UQ8MLzKu1I1DoJyHaVR211Z7Ch54A2QScAjywF7OfMbrMHmjtSGz
 I+d8WKB91tvvM57gg8fhXY2wJMHeRlqCd8uQ3coECTySF9eTEFnijv4MEUcZY5/TyYje
 58wmwqOHSLDv0kM/HHxexMuKn/QHof8jId2QAes4CZBg8N3h9jc0lNJn233B9RFQlmAn
 aIrrdhQaxBTTg2GXp9hLyuHdvqY9arNq6j/2vAl3dT21VBzlEzak0RHFjFukz9TEkB4Q eA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:34 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:33 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uM9KgsvD2e9WjIvDSEv9d7g7JoMCbdcjIlzib1u3/tg=;
 b=ZtDEvpKF5ycbnE3xJg3qOT5YmypfRrD78JlrTMPMx+xQk8YKglkvZOqhx79Whp3nKzDc0wWpJ7lkLZlhtZ/gAg8Xlx4z/aG6vFSqT/3r0E8ZKsmRPhz0Izht9UfdI5uP0/DkJTDby/8kACZHIt8xrAuN8PwLswX6FIK0RLyVFrc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:32 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:32 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 18/24] EDAC, ghes: Fill sysfs with the DMI DIMM label
 information
Thread-Topic: [PATCH v2 18/24] EDAC, ghes: Fill sysfs with the DMI DIMM label
 information
Thread-Index: AQHVKp7TlohNjeevI0uW0dYjj5ZrXQ==
Date:   Mon, 24 Jun 2019 15:09:31 +0000
Message-ID: <20190624150758.6695-19-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 70fd5ff4-65f3-4488-93d6-08d6f8b5f5b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB319783775CCB91C3C7535C62D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GLgd4KeZOz4EJsKY8Wtg8ExkWyqQIeNFvBPb9BreJgIu5tzRCs5o5NL34Pn1/3LAy8EzNTM193EGeH/aXOXwDH39f9UGMKbZ1dz60QCc9q8wPmnlzvTIX3KfXgZtR1q6kWZiEF3x74xoW3ziEO+b8+IMRL2dleUIOzw8qn+1d8aiXWqSFPUKFnN4ozN7K9fBsnlLGf2qaicVK8cGPiitH7o0LDKrpxlyJQHBVj2Z9EAvb3QvoMC9nT9uinTN0jXF++PFi7IJ7I6ofMuuzurYZBU1jPEHoA5j6FeeBd2IutmGerX7ePIBlzxPOdgXBNpfe1h1ERJvISuSadd03uaOEd0R7YvIrYYn3pN2VwkBpicyFjTgoc1UZLjvOZfXAzrzo1deD07kVXB9XAj+q22Q5UGOkFrbjzSyZkpMgn4pFFc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fd5ff4-65f3-4488-93d6-08d6f8b5f5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:31.9725
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
ZWRhYy5jDQppbmRleCA2M2RlMTE2NTQ2NDkuLjljMzQ5NWY3MzY1YiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpA
QCAtMjY1LDEwICsyNjUsNiBAQCBzdGF0aWMgdm9pZCBnaGVzX2VkYWNfZG1pZGVjb2RlKGNvbnN0
IHN0cnVjdCBkbWlfaGVhZGVyICpkaCwgdm9pZCAqYXJnKQ0KIAkJZGltbS0+ZHR5cGUgPSBERVZf
VU5LTk9XTjsNCiAJCWRpbW0tPmdyYWluID0gMTI4OwkJLyogTGlrZWx5LCB3b3JzZSBjYXNlICov
DQogDQotCQkvKg0KLQkJICogRklYTUU6IEl0IHNob3VsZG4ndCBiZSBoYXJkIHRvIGFsc28gZmls
bCB0aGUgRElNTSBsYWJlbHMNCi0JCSAqLw0KLQ0KIAkJaWYgKGRpbW0tPm5yX3BhZ2VzKSB7DQog
CQkJZWRhY19kYmcoMSwgIkRJTU0laTogJXMgc2l6ZSA9ICVkIE1CJXNcbiIsDQogCQkJCW1pLT5p
ZHgsIGVkYWNfbWVtX3R5cGVzW2RpbW0tPm10eXBlXSwNCkBAIC0zMDIsNiArMjk4LDcgQEAgc3Rh
dGljIGludCBtZW1faW5mb19zZXR1cCh2b2lkKQ0KIHsNCiAJc3RydWN0IGdoZXNfZGltbV9pbmZv
ICpkaW1tOw0KIAlib29sIGVuYWJsZV9udW1hID0gdHJ1ZTsNCisJY29uc3QgY2hhciAqYmFuaywg
KmRldmljZTsNCiAJaW50IG51bSA9IDA7DQogCWludCBpZHggPSAwOw0KIAlpbnQgcmV0Ow0KQEAg
LTMxNywxMyArMzE0LDI3IEBAIHN0YXRpYyBpbnQgbWVtX2luZm9fc2V0dXAodm9pZCkNCiAJZG1p
X3dhbGsoZ2hlc19lZGFjX3NldF9uaWQsIE5VTEwpOw0KIA0KIAlmb3JfZWFjaF9kaW1tKGRpbW0p
IHsNCisJCWJhbmsgPSBkZXZpY2UgPSBOVUxMOw0KKwkJZG1pX21lbWRldl9uYW1lKGRpbW0tPmRp
bW1faW5mby5zbWJpb3NfaGFuZGxlLA0KKwkJCQkmYmFuaywgJmRldmljZSk7DQorCQlpZiAoYmFu
ayAmJiBkZXZpY2UpIHsNCisJCQlzbnByaW50ZihkaW1tLT5kaW1tX2luZm8ubGFiZWwsDQorCQkJ
CXNpemVvZihkaW1tLT5kaW1tX2luZm8ubGFiZWwpLA0KKwkJCQkiJXMgJXMiLCBiYW5rLCBkZXZp
Y2UpOw0KKwkJfSBlbHNlIHsNCisJCQkqZGltbS0+ZGltbV9pbmZvLmxhYmVsID0gJ1wwJzsNCisJ
CX0NCisNCiAJCWlmIChkaW1tLT5udW1hX25vZGUgPT0gTlVNQV9OT19OT0RFKQ0KIAkJCWVuYWJs
ZV9udW1hID0gZmFsc2U7DQogCQllbHNlDQogCQkJbWVtX2luZm8uZGltbXNfcGVyX25vZGVbZGlt
bS0+bnVtYV9ub2RlXSsrOw0KIA0KLQkJZWRhY19kYmcoMSwgIkRJTU0laTogRm91bmQgbWVtIHJh
bmdlIFslcGEtJXBhXSBvbiBub2RlICVkXG4iLA0KLQkJCWRpbW0tPmlkeCwgJmRpbW0tPnN0YXJ0
LCAmZGltbS0+ZW5kLCBkaW1tLT5udW1hX25vZGUpOw0KKwkJZWRhY19kYmcoMSwgIkRJTU0laTog
Rm91bmQgbWVtIHJhbmdlIFslcGEtJXBhXSBvbiBub2RlICVkLCBoYW5kbGU6IDB4JS40eCVzJXNc
biIsDQorCQkJZGltbS0+aWR4LCAmZGltbS0+c3RhcnQsICZkaW1tLT5lbmQsIGRpbW0tPm51bWFf
bm9kZSwNCisJCQlkaW1tLT5kaW1tX2luZm8uc21iaW9zX2hhbmRsZSwNCisJCQkqZGltbS0+ZGlt
bV9pbmZvLmxhYmVsID8gIiwgbGFiZWw6ICIgOiAiIiwNCisJCQlkaW1tLT5kaW1tX2luZm8ubGFi
ZWwpOw0KIAl9DQogDQogCWlmIChlbmFibGVfbnVtYSkNCkBAIC0zODEsNiArMzkyLDkgQEAgc3Rh
dGljIHZvaWQgbWVtX2luZm9fcHJlcGFyZV9tY2koc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKQ0K
IAkJbWNpX2RpbW0tPmR0eXBlCQk9IGRtaV9kaW1tLT5kdHlwZTsNCiAJCW1jaV9kaW1tLT5ncmFp
bgkJPSBkbWlfZGltbS0+Z3JhaW47DQogCQltY2lfZGltbS0+c21iaW9zX2hhbmRsZSA9IGRtaV9k
aW1tLT5zbWJpb3NfaGFuZGxlOw0KKw0KKwkJaWYgKCpkbWlfZGltbS0+bGFiZWwpDQorCQkJc3Ry
Y3B5KG1jaV9kaW1tLT5sYWJlbCwgZG1pX2RpbW0tPmxhYmVsKTsNCiAJfQ0KIA0KIAlpZiAoaW5k
ZXggIT0gbWNpLT50b3RfZGltbXMpDQotLSANCjIuMjAuMQ0KDQo=
