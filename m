Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8349E50FC4
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfFXPJ3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:29 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31880 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729578AbfFXPJ2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:28 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF0Kft018697;
        Mon, 24 Jun 2019 08:09:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1z4n1jeMPp6r5mxtCk8Fww1wa8P4O49mEyhBNwJ/G2s=;
 b=KTjUtGI0wzLeDnBcQGu8e3EJ9ZFmRr4HhDGkl0g7Rw++S5bI3rAn/gvR+UzYtFDXNw0S
 /kJp3muvHsT5uLprywGCDr32yqzDxi4ceJ3eKJFc/L6VxmJHJQa0t/I9V6hY7EYgepPF
 q/2ILazFLGyAFUX9/0tqwO1EjxuQQhyi980dYa2Wn8vi5yOjy5bbzTd3L5TtWjStTk1F
 hUKElj/BMUoo8GW/5/2AAfH1ykKcdka7U1ms024AzvWitLleshuv2y7qulPRcXdEA1YO
 FSi4Sp+LdNxcel/6QsjSO5U8yQmHAbLBjVuPif5lMC0TrhO7KHGZiIoJ70LxwnzARTFA Rg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9taf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:20 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:19 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z4n1jeMPp6r5mxtCk8Fww1wa8P4O49mEyhBNwJ/G2s=;
 b=iLrmvrhHoEqBOlhb3dXMB+Fzp9rfnKvQM13iIu071a6e0pJD81GFb27TFaZDvJlTBa+Oqb3qUKsI6oeAWyngznovMQNXwjtzwx9082ibfBSazwTyswT1YAZxgZZP803Ff4abIAt+pQEsivOVTza2RCI9Uie4E/5D6PtbqM/9qhM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:17 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:17 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 11/24] EDAC, mc: Rework edac_raw_mc_handle_error() to use
 struct dimm_info
Thread-Topic: [PATCH v2 11/24] EDAC, mc: Rework edac_raw_mc_handle_error() to
 use struct dimm_info
Thread-Index: AQHVKp7LH4BzYmX+0kOgmnuIJiKvpw==
Date:   Mon, 24 Jun 2019 15:09:17 +0000
Message-ID: <20190624150758.6695-12-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ba94cb3a-ec6d-4c73-5b2c-08d6f8b5ed60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB3197896EE4DBFD47190CE8ECD9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ooK+K5j9JPaaRMMaVHI5I6EhsJov3REDgW/7xXcXpuYxoReYfItvbKIn4ESPGPy2OoiNpItzw3dESrx+voDrMdpjTX3RxalKMkxvUxseos/2YdCKz+Si1o5Wbns1NR32/C6KuxR6VjarpsQ79t9+IRlY/i5lzkabzqJakuE+cKYl5th26Ij2Ih/iO5I5yP/NEc2DQlPgKIi7gXhTuNFhLDvVbs/k5x85PJAJ75slOCMsMhZkQm2MYRNVEUPaztjKtpewS4aqtl0m7UBIla+xKhrJulRksV5+jz1hNCgvdChYuMCzWyUbS+6PyL8uYBR4yPByyDOx1GG+RFyyCHBJ9/kgo5nDnXHpA/G4JBbvRfat5fKr0uqu8WmRvykIcAxZTwbeynupXnfA+2zGEziKBChs75kuxxyMtaHpFUmaKxg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba94cb3a-ec6d-4c73-5b2c-08d6f8b5ed60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:17.7086
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

UmV3b3JrIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcigpIHRvIHVzZSBzdHJ1Y3QgZGltbV9pbmZv
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+
DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19tYy5jICAgfCAyOCArKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWMuaCAgIHwgIDIgKysNCiBkcml2ZXJzL2Vk
YWMvZ2hlc19lZGFjLmMgfCAgNSArKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZWRhY19t
Yy5jIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KaW5kZXggYmNlMzliMmUxMGM5Li5hOGQ0NDcx
ZTIzOGMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQorKysgYi9kcml2ZXJz
L2VkYWMvZWRhY19tYy5jDQpAQCAtODg5LDExICs4ODksOSBAQCBjb25zdCBjaGFyICplZGFjX2xh
eWVyX25hbWVbXSA9IHsNCiBFWFBPUlRfU1lNQk9MX0dQTChlZGFjX2xheWVyX25hbWUpOw0KIA0K
IHN0YXRpYyB2b2lkIGVkYWNfaW5jX2NlX2Vycm9yKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwN
Ci0JCQkgICAgICBjb25zdCBpbnQgcG9zW0VEQUNfTUFYX0xBWUVSU10sDQorCQkJICAgICAgc3Ry
dWN0IGRpbW1faW5mbyAqZGltbSwNCiAJCQkgICAgICBjb25zdCB1MTYgY291bnQpDQogew0KLQlz
dHJ1Y3QgZGltbV9pbmZvICpkaW1tID0gZWRhY19nZXRfZGltbShtY2ksIHBvc1swXSwgcG9zWzFd
LCBwb3NbMl0pOw0KLQ0KIAltY2ktPmNlX21jICs9IGNvdW50Ow0KIA0KIAlpZiAoZGltbSkNCkBA
IC05MDMsMTEgKzkwMSw5IEBAIHN0YXRpYyB2b2lkIGVkYWNfaW5jX2NlX2Vycm9yKHN0cnVjdCBt
ZW1fY3RsX2luZm8gKm1jaSwNCiB9DQogDQogc3RhdGljIHZvaWQgZWRhY19pbmNfdWVfZXJyb3Io
c3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KLQkJCQkgICAgY29uc3QgaW50IHBvc1tFREFDX01B
WF9MQVlFUlNdLA0KLQkJCQkgICAgY29uc3QgdTE2IGNvdW50KQ0KKwkJCSAgICAgIHN0cnVjdCBk
aW1tX2luZm8gKmRpbW0sDQorCQkJICAgICAgY29uc3QgdTE2IGNvdW50KQ0KIHsNCi0Jc3RydWN0
IGRpbW1faW5mbyAqZGltbSA9IGVkYWNfZ2V0X2RpbW0obWNpLCBwb3NbMF0sIHBvc1sxXSwgcG9z
WzJdKTsNCi0NCiAJbWNpLT51ZV9tYyArPSBjb3VudDsNCiANCiAJaWYgKGRpbW0pDQpAQCAtOTE3
LDggKzkxMyw4IEBAIHN0YXRpYyB2b2lkIGVkYWNfaW5jX3VlX2Vycm9yKHN0cnVjdCBtZW1fY3Rs
X2luZm8gKm1jaSwNCiB9DQogDQogc3RhdGljIHZvaWQgZWRhY19jZV9lcnJvcihzdHJ1Y3QgbWVt
X2N0bF9pbmZvICptY2ksDQorCQkJICBzdHJ1Y3QgZGltbV9pbmZvICpkaW1tLA0KIAkJCSAgY29u
c3QgdTE2IGVycm9yX2NvdW50LA0KLQkJCSAgY29uc3QgaW50IHBvc1tFREFDX01BWF9MQVlFUlNd
LA0KIAkJCSAgY29uc3QgY2hhciAqbXNnLA0KIAkJCSAgY29uc3QgY2hhciAqbG9jYXRpb24sDQog
CQkJICBjb25zdCBjaGFyICpsYWJlbCwNCkBAIC05NDYsNyArOTQyLDcgQEAgc3RhdGljIHZvaWQg
ZWRhY19jZV9lcnJvcihzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ksDQogCQkJCSAgICAgICBlcnJv
cl9jb3VudCwgbXNnLCBtc2dfYXV4LCBsYWJlbCwNCiAJCQkJICAgICAgIGxvY2F0aW9uLCBkZXRh
aWwpOw0KIAl9DQotCWVkYWNfaW5jX2NlX2Vycm9yKG1jaSwgcG9zLCBlcnJvcl9jb3VudCk7DQor
CWVkYWNfaW5jX2NlX2Vycm9yKG1jaSwgZGltbSwgZXJyb3JfY291bnQpOw0KIA0KIAlpZiAobWNp
LT5zY3J1Yl9tb2RlID09IFNDUlVCX1NXX1NSQykgew0KIAkJLyoNCkBAIC05NzAsOCArOTY2LDgg
QEAgc3RhdGljIHZvaWQgZWRhY19jZV9lcnJvcihzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ksDQog
fQ0KIA0KIHN0YXRpYyB2b2lkIGVkYWNfdWVfZXJyb3Ioc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNp
LA0KKwkJCSAgc3RydWN0IGRpbW1faW5mbyAqZGltbSwNCiAJCQkgIGNvbnN0IHUxNiBlcnJvcl9j
b3VudCwNCi0JCQkgIGNvbnN0IGludCBwb3NbRURBQ19NQVhfTEFZRVJTXSwNCiAJCQkgIGNvbnN0
IGNoYXIgKm1zZywNCiAJCQkgIGNvbnN0IGNoYXIgKmxvY2F0aW9uLA0KIAkJCSAgY29uc3QgY2hh
ciAqbGFiZWwsDQpAQCAtMTAwNSwxNSArMTAwMSwxNSBAQCBzdGF0aWMgdm9pZCBlZGFjX3VlX2Vy
cm9yKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCiAJCQkgICAgICBtc2csIG1zZ19hdXgsIGxh
YmVsLCBsb2NhdGlvbiwgZGV0YWlsKTsNCiAJfQ0KIA0KLQllZGFjX2luY191ZV9lcnJvcihtY2ks
IHBvcywgZXJyb3JfY291bnQpOw0KKwllZGFjX2luY191ZV9lcnJvcihtY2ksIGRpbW0sIGVycm9y
X2NvdW50KTsNCiB9DQogDQogdm9pZCBlZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IoY29uc3QgZW51
bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIAkJCSAgICAgIHN0cnVjdCBtZW1fY3RsX2lu
Zm8gKm1jaSwNCisJCQkgICAgICBzdHJ1Y3QgZGltbV9pbmZvICpkaW1tLA0KIAkJCSAgICAgIHN0
cnVjdCBlZGFjX3Jhd19lcnJvcl9kZXNjICplKQ0KIHsNCiAJY2hhciBkZXRhaWxbODBdOw0KLQlp
bnQgcG9zW0VEQUNfTUFYX0xBWUVSU10gPSB7IGUtPnRvcF9sYXllciwgZS0+bWlkX2xheWVyLCBl
LT5sb3dfbGF5ZXIgfTsNCiAJdTggZ3JhaW5fYml0czsNCiANCiAJLyoNCkBAIC0xMDM4LDcgKzEw
MzQsNyBAQCB2b2lkIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcihjb25zdCBlbnVtIGh3X2V2ZW50
X21jX2Vycl90eXBlIHR5cGUsDQogCQkJInBhZ2U6MHglbHggb2Zmc2V0OjB4JWx4IGdyYWluOiVs
ZCBzeW5kcm9tZToweCVseCIsDQogCQkJZS0+cGFnZV9mcmFtZV9udW1iZXIsIGUtPm9mZnNldF9p
bl9wYWdlLA0KIAkJCWUtPmdyYWluLCBlLT5zeW5kcm9tZSk7DQotCQllZGFjX2NlX2Vycm9yKG1j
aSwgZS0+ZXJyb3JfY291bnQsIHBvcywgZS0+bXNnLCBlLT5sb2NhdGlvbiwNCisJCWVkYWNfY2Vf
ZXJyb3IobWNpLCBkaW1tLCBlLT5lcnJvcl9jb3VudCwgZS0+bXNnLCBlLT5sb2NhdGlvbiwNCiAJ
CQkgICAgICBlLT5sYWJlbCwgZGV0YWlsLCBlLT5vdGhlcl9kZXRhaWwsDQogCQkJICAgICAgZS0+
cGFnZV9mcmFtZV9udW1iZXIsIGUtPm9mZnNldF9pbl9wYWdlLCBlLT5ncmFpbik7DQogCX0gZWxz
ZSB7DQpAQCAtMTA0Niw3ICsxMDQyLDcgQEAgdm9pZCBlZGFjX3Jhd19tY19oYW5kbGVfZXJyb3Io
Y29uc3QgZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIAkJCSJwYWdlOjB4JWx4IG9m
ZnNldDoweCVseCBncmFpbjolbGQiLA0KIAkJCWUtPnBhZ2VfZnJhbWVfbnVtYmVyLCBlLT5vZmZz
ZXRfaW5fcGFnZSwgZS0+Z3JhaW4pOw0KIA0KLQkJZWRhY191ZV9lcnJvcihtY2ksIGUtPmVycm9y
X2NvdW50LCBwb3MsIGUtPm1zZywgZS0+bG9jYXRpb24sDQorCQllZGFjX3VlX2Vycm9yKG1jaSwg
ZGltbSwgZS0+ZXJyb3JfY291bnQsIGUtPm1zZywgZS0+bG9jYXRpb24sDQogCQkJICAgICAgZS0+
bGFiZWwsIGRldGFpbCwgZS0+b3RoZXJfZGV0YWlsKTsNCiAJfQ0KIA0KQEAgLTEyMTIsNiArMTIw
OCw4IEBAIHZvaWQgZWRhY19tY19oYW5kbGVfZXJyb3IoY29uc3QgZW51bSBod19ldmVudF9tY19l
cnJfdHlwZSB0eXBlLA0KIAlpZiAocCA+IGUtPmxvY2F0aW9uKQ0KIAkJKihwIC0gMSkgPSAnXDAn
Ow0KIA0KLQllZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBlKTsNCisJZGltbSA9
IGVkYWNfZ2V0X2RpbW0obWNpLCB0b3BfbGF5ZXIsIG1pZF9sYXllciwgbG93X2xheWVyKTsNCisN
CisJZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKHR5cGUsIG1jaSwgZGltbSwgZSk7DQogfQ0KIEVY
UE9SVF9TWU1CT0xfR1BMKGVkYWNfbWNfaGFuZGxlX2Vycm9yKTsNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2VkYWMvZWRhY19tYy5oIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuaA0KaW5kZXggNDE2NWUx
NTk5NWFkLi5iODE2Y2YzY2FhZWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5o
DQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQpAQCAtMjE0LDYgKzIxNCw3IEBAIGV4dGVy
biBpbnQgZWRhY19tY19maW5kX2Nzcm93X2J5X3BhZ2Uoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNp
LA0KICAqDQogICogQHR5cGU6CQlzZXZlcml0eSBvZiB0aGUgZXJyb3IgKENFL1VFL0ZhdGFsKQ0K
ICAqIEBtY2k6CQlhIHN0cnVjdCBtZW1fY3RsX2luZm8gcG9pbnRlcg0KKyAqIEBkaW1tOgkJYSBz
dHJ1Y3QgZGltbV9pbmZvIHBvaW50ZXINCiAgKiBAZToJCQllcnJvciBkZXNjcmlwdGlvbg0KICAq
DQogICogVGhpcyByYXcgZnVuY3Rpb24gaXMgdXNlZCBpbnRlcm5hbGx5IGJ5IGVkYWNfbWNfaGFu
ZGxlX2Vycm9yKCkuIEl0IHNob3VsZA0KQEAgLTIyMiw2ICsyMjMsNyBAQCBleHRlcm4gaW50IGVk
YWNfbWNfZmluZF9jc3Jvd19ieV9wYWdlKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCiAgKi8N
CiB2b2lkIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcihjb25zdCBlbnVtIGh3X2V2ZW50X21jX2Vy
cl90eXBlIHR5cGUsDQogCQkJICAgICAgc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KKwkJCSAg
ICAgIHN0cnVjdCBkaW1tX2luZm8gKmRpbW0sDQogCQkJICAgICAgc3RydWN0IGVkYWNfcmF3X2Vy
cm9yX2Rlc2MgKmUpOw0KIA0KIC8qKg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9naGVzX2Vk
YWMuYyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KaW5kZXggNzU3YTAyZjJjZTQ5Li43ODZm
MWIzMmVlZTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCisrKyBiL2Ry
aXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KQEAgLTE5Myw2ICsxOTMsNyBAQCBzdGF0aWMgdm9pZCBn
aGVzX2VkYWNfZG1pZGVjb2RlKGNvbnN0IHN0cnVjdCBkbWlfaGVhZGVyICpkaCwgdm9pZCAqYXJn
KQ0KIA0KIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNw
ZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogew0KKwlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tX2lu
Zm87DQogCWVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZTsNCiAJc3RydWN0IGVkYWNfcmF3
X2Vycm9yX2Rlc2MgKmU7DQogCXN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaTsNCkBAIC00MzEsNyAr
NDMyLDkgQEAgdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3Qg
Y3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCiAJaWYgKHAgPiBwdnQtPm90aGVyX2RldGFpbCkN
CiAJCSoocCAtIDEpID0gJ1wwJzsNCiANCi0JZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKHR5cGUs
IG1jaSwgZSk7DQorCWRpbW1faW5mbyA9IGVkYWNfZ2V0X2RpbW1fYnlfaW5kZXgobWNpLCBlLT50
b3BfbGF5ZXIpOw0KKw0KKwllZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBkaW1t
X2luZm8sIGUpOw0KIA0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZnaGVzX2xvY2ssIGZsYWdz
KTsNCiB9DQotLSANCjIuMjAuMQ0KDQo=
