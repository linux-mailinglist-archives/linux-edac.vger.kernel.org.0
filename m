Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1421F50FCC
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfFXPJp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:45 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14776 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730794AbfFXPJp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:45 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF053n018453;
        Mon, 24 Jun 2019 08:09:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=K9GfRHH0jcdtWOydVObOCSt9IlWuHJ/kns8jWsyBVi0=;
 b=n8+9G88Uvk+0A5cqfuHH6nXaJPjKH+E/xyoT8TEbieinlLkG3vOu/AeiyidowAN2Vf9J
 GfADM1hbBxNRkOgmI8TcoLI63Y5RVjmOHcJSkhCpQf2nYWg+QeK4xygyr3MPwQNpe5eJ
 9ZxtYIaVnMX9eytn9b1GzEj1KQOIifDi4B+Z14BKVvLYQKWnExRb/cgwrA/psjk38GMA
 gNzu5X75ICUZdjLa75K0H0/0d4h4a1CuTxdg+tq7HMglvIwrcf3PngMPPaXy+E6xQUNR
 rw5dtngS+nv44NjJvsvVgkmA0SQLfNp7b8Mb0rwpHry9v0exzVznuWisc22yH8eU6ScB Yw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9tby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:38 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:37 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9GfRHH0jcdtWOydVObOCSt9IlWuHJ/kns8jWsyBVi0=;
 b=QmHyjbUK+xxXjyeEme1w67qbUZ7PRN0OE7AUsbRVVO/vmyBDhsaQxS7FAIZwjFNu5hM4HKpf9gTED/687HWeaSl7+EypOQ7lg+ZsqQ401dRaVS2IgO+OM7lsu4dIzvwDfgRRDt6w215tt2t8KiJIXVRkqqA+cs3aTqYYjZDFuQ4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2589.namprd18.prod.outlook.com (20.179.82.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:09:35 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:35 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 20/24] EDAC, ghes: Identify dimm by node, card, module and
 handle
Thread-Topic: [PATCH v2 20/24] EDAC, ghes: Identify dimm by node, card, module
 and handle
Thread-Index: AQHVKp7VnLiZoYHFAEGHkRpNDru4Aw==
Date:   Mon, 24 Jun 2019 15:09:35 +0000
Message-ID: <20190624150758.6695-21-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: b599a715-7872-48b1-ff4c-08d6f8b5f832
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2589;
x-ms-traffictypediagnostic: MN2PR18MB2589:
x-microsoft-antispam-prvs: <MN2PR18MB258915163D58F15AF82E7E7FD9E00@MN2PR18MB2589.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(2906002)(2616005)(486006)(476003)(52116002)(14444005)(256004)(5660300002)(66446008)(73956011)(66946007)(1076003)(14454004)(6116002)(86362001)(3846002)(99286004)(6486002)(68736007)(81166006)(81156014)(6436002)(4326008)(305945005)(50226002)(53936002)(7736002)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(6512007)(107886003)(71190400001)(71200400001)(36756003)(26005)(102836004)(386003)(186003)(11346002)(76176011)(6506007)(110136005)(316002)(54906003)(446003)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2589;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bUAgWDCChLW5VycNAIiwIPaki+JVuuWFthCOQksPdhSgGdEeYtKs5N351RB9KoP7pPGmqRd5zOi4OOv+BuCS6iufQYuwQCWhbDvaqLkPbXufc7C/fq9NBQpuwKJAylvC0+w4vj17jajD+eIwnDJAUkK53n9s3SUV0tcBCOzAEpgeMlDB6InlblVggtqHXhzC66aqOIt1q/A059Qqs/smDJz8n/BNv85a0p0WaN0vkQ7R5gXAN9j5I+ROeYVFXkG4Qt7rDvztd5LBAh/NFO4qAl8M0xg1zn0imNC3l44oH+weFULJRzejFQ9/zc05K90oPaiTvPjwjnINb43RFx9xu6PpuaDqaN2oAkpcxkqaSkkrj5GFcXZ9X2BKLAUS7Zg1k0Fw4YkiYXXEsRGCoM/LRBRYaUAGnO9FtAEicF4gj1g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b599a715-7872-48b1-ff4c-08d6f8b5f832
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:35.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2589
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
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
IGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRleCA5N2Y5OTIwMDYyODEuLjY4OTg0MWM1
Yzg0ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJpdmVy
cy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtODEsOCArODEsMTEgQEAgc3RydWN0IG1lbWFycl9kbWlf
ZW50cnkgew0KIA0KIHN0cnVjdCBnaGVzX2RpbW1faW5mbyB7DQogCXN0cnVjdCBkaW1tX2luZm8g
ZGltbV9pbmZvOw0KKwlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tOw0KIAlpbnQJCWlkeDsNCiAJaW50
CQludW1hX25vZGU7DQorCWludAkJY2FyZDsNCisJaW50CQltb2R1bGU7DQogCXBoeXNfYWRkcl90
CXN0YXJ0Ow0KIAlwaHlzX2FkZHJfdAllbmQ7DQogCXUxNgkJcGh5c19oYW5kbGU7DQpAQCAtMTI4
LDYgKzEzMSw4IEBAIHN0YXRpYyBpbnQgZ2hlc19kaW1tX2luZm9faW5pdChpbnQgbnVtKQ0KIAlm
b3JfZWFjaF9kaW1tKGRpbW0pIHsNCiAJCWRpbW0tPmlkeAk9IGlkeDsNCiAJCWRpbW0tPm51bWFf
bm9kZQk9IE5VTUFfTk9fTk9ERTsNCisJCWRpbW0tPmNhcmQJPSAtMTsNCisJCWRpbW0tPm1vZHVs
ZQk9IC0xOw0KIAkJaWR4Kys7DQogCX0NCiANCkBAIC0zOTUsNiArNDAwLDEzIEBAIHN0YXRpYyB2
b2lkIG1lbV9pbmZvX3ByZXBhcmVfbWNpKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCiANCiAJ
CWlmICgqZG1pX2RpbW0tPmxhYmVsKQ0KIAkJCXN0cmNweShtY2lfZGltbS0+bGFiZWwsIGRtaV9k
aW1tLT5sYWJlbCk7DQorDQorCQkvKg0KKwkJICogRnJvbSBoZXJlIG9uIGRvIG5vdCB1c2UgYW55
IGxvbmdlciAmZGltbS5kaW1tX2luZm8uDQorCQkgKiBJbnN0ZWFkIHN3aXRjaCB0byB0aGUgbWNp
J3MgZGltbSBpbmZvIHdoaWNoIG1pZ2h0DQorCQkgKiBjb250YWluIHVwZGF0ZWQgZGF0YSwgc3Vj
aCBhcyB0aGUgbGFiZWwuDQorCQkgKi8NCisJCWRpbW0tPmRpbW0gPSBtY2lfZGltbTsNCiAJfQ0K
IA0KIAlpZiAoaW5kZXggIT0gbWNpLT50b3RfZGltbXMpDQpAQCAtNDAyLDI0ICs0MTQsNDYgQEAg
c3RhdGljIHZvaWQgbWVtX2luZm9fcHJlcGFyZV9tY2koc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNp
KQ0KIAkJCWluZGV4LCBtY2ktPnRvdF9kaW1tcyk7DQogfQ0KIA0KLXN0YXRpYyBzdHJ1Y3QgbWVt
X2N0bF9pbmZvICpnZXRfbWNfYnlfbm9kZShpbnQgbmlkKQ0KKy8qIFJlcXVpcmVzIGdoZXNfbG9j
ayBiZWluZyBzZXQuICovDQorc3RhdGljIHN0cnVjdCBnaGVzX2RpbW1faW5mbyAqDQorZ2V0X2Fu
ZF9wcmVwYXJlX2RpbW1faW5mbyhpbnQgbmlkLCBpbnQgY2FyZCwgaW50IG1vZHVsZSwgaW50IGhh
bmRsZSkNCiB7DQotCXN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSA9IGVkYWNfbWNfZmluZChuaWQp
Ow0KKwlzdGF0aWMgc3RydWN0IGdoZXNfZGltbV9pbmZvICpkaW1tOw0KKwlzdHJ1Y3QgZGltbV9p
bmZvICpkaTsNCiANCi0JaWYgKG1jaSkNCi0JCXJldHVybiBtY2k7DQorCS8qDQorCSAqIFdlIHJl
cXVpcmUgc21iaW9zX2hhbmRsZSBiZWluZyBzZXQgaW4gdGhlIGVycm9yIHJlcG9ydCBmb3INCisJ
ICogcGVyIGxheWVyIHJlcG9ydGluZyAoU01CSU9TIGhhbmRsZSBmb3IgdGhlIFR5cGUgMTcgTWVt
b3J5DQorCSAqIERldmljZSBTdHJ1Y3R1cmUgdGhhdCByZXByZXNlbnRzIHRoZSBNZW1vcnkgTW9k
dWxlKQ0KKwkgKi8NCisJZm9yX2VhY2hfZGltbShkaW1tKSB7DQorCQlkaSA9IGRpbW0tPmRpbW07
DQorCQlpZiAoZGktPnNtYmlvc19oYW5kbGUgPT0gaGFuZGxlKQ0KKwkJCWdvdG8gZm91bmQ7DQor
CX0NCiANCi0JaWYgKG51bV9wb3NzaWJsZV9ub2RlcygpID4gMSkgew0KLQkJZWRhY19tY19wcmlu
dGsoZmFsbGJhY2ssIEtFUk5fV0FSTklORywNCi0JCQkiSW52YWxpZCBvciBubyBub2RlIGluZm9y
bWF0aW9uLCBmYWxsaW5nIGJhY2sgdG8gZmlyc3Qgbm9kZTogJXMiLA0KLQkJCWZhbGxiYWNrLT5k
ZXZfbmFtZSk7DQorCXJldHVybiBOVUxMOw0KK2ZvdW5kOg0KKwlpZiAoZGltbS0+Y2FyZCA8IDAg
JiYgY2FyZCA+PSAwKQ0KKwkJZGltbS0+Y2FyZCA9IGNhcmQ7DQorCWlmIChkaW1tLT5tb2R1bGUg
PCAwICYmIG1vZHVsZSA+PSAwKQ0KKwkJZGltbS0+bW9kdWxlID0gbW9kdWxlOw0KKw0KKwlpZiAo
KG51bV9wb3NzaWJsZV9ub2RlcygpID4gMSAmJiBkaS0+bWNpLT5tY19pZHggIT0gbmlkKSB8fA0K
KwkJKGNhcmQgPj0gMCAmJiBjYXJkICE9IGRpbW0tPmNhcmQpIHx8DQorCQkobW9kdWxlID49IDAg
JiYgbW9kdWxlICE9IGRpbW0tPm1vZHVsZSkpIHsNCisJCWVkYWNfbWNfcHJpbnRrKGRpLT5tY2ks
IEtFUk5fV0FSTklORywNCisJCQkiSW5jb25zaXN0ZW50IGVycm9yIHJlcG9ydCAobmlkL2NhcmQv
bW9kdWxlKTogJWQvJWQvJWQgKGRpbW0lZDogJWQvJWQvJWQpIiwNCisJCQluaWQsIGNhcmQsIG1v
ZHVsZSwgZGktPmlkeCwNCisJCQlkaS0+bWNpLT5tY19pZHgsIGRpbW0tPmNhcmQsIGRpbW0tPm1v
ZHVsZSk7DQogCX0NCiANCi0JcmV0dXJuIGZhbGxiYWNrOw0KKwlyZXR1cm4gZGltbTsNCiB9DQog
DQogdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3QgY3Blcl9z
ZWNfbWVtX2VyciAqbWVtX2VycikNCiB7DQorCXN0cnVjdCBnaGVzX2RpbW1faW5mbyAqZGltbTsN
CiAJc3RydWN0IGRpbW1faW5mbyAqZGltbV9pbmZvOw0KIAllbnVtIGh3X2V2ZW50X21jX2Vycl90
eXBlIHR5cGU7DQogCXN0cnVjdCBlZGFjX3Jhd19lcnJvcl9kZXNjICplOw0KQEAgLTQyOCw2ICs0
NjIsOSBAQCB2b2lkIGdoZXNfZWRhY19yZXBvcnRfbWVtX2Vycm9yKGludCBzZXYsIHN0cnVjdCBj
cGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIAljaGFy
ICpwOw0KIAlpbnQgbmlkID0gTlVNQV9OT19OT0RFOw0KKwlpbnQgY2FyZCA9IC0xOw0KKwlpbnQg
bW9kdWxlID0gLTE7DQorCWludCBoYW5kbGUgPSAtMTsNCiANCiAJLyogV2UgbmVlZCBhdCBsZWFz
dCBvbmUgbWMgKi8NCiAJaWYgKFdBUk5fT05fT05DRSghZmFsbGJhY2spKQ0KQEAgLTQ0MywxMCAr
NDgwLDIzIEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0
IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogDQogCXNwaW5fbG9ja19pcnFzYXZlKCZnaGVz
X2xvY2ssIGZsYWdzKTsNCiANCi0JLyogc2VsZWN0IHRoZSBub2RlJ3MgbWMgZGV2aWNlICovDQog
CWlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9OT0RFKQ0KIAkJ
bmlkID0gbWVtX2Vyci0+bm9kZTsNCi0JbWNpID0gZ2V0X21jX2J5X25vZGUobmlkKTsNCisJaWYg
KG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX0NBUkQpDQorCQljYXJk
ID0gbWVtX2Vyci0+Y2FyZDsNCisJaWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJf
TUVNX1ZBTElEX01PRFVMRSkNCisJCW1vZHVsZSA9IG1lbV9lcnItPm1vZHVsZTsNCisJaWYgKG1l
bV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX01PRFVMRV9IQU5ETEUpDQor
CQloYW5kbGUgPSBtZW1fZXJyLT5tZW1fZGV2X2hhbmRsZTsNCisNCisJZGltbSA9IGdldF9hbmRf
cHJlcGFyZV9kaW1tX2luZm8obmlkLCBjYXJkLCBtb2R1bGUsIGhhbmRsZSk7DQorCWlmIChkaW1t
KQ0KKwkJbWNpID0gZGltbS0+ZGltbS0+bWNpOw0KKwllbHNlDQorCQltY2kgPSBlZGFjX21jX2Zp
bmQobmlkKTsNCisJaWYgKCFtY2kpDQorCQltY2kgPSBmYWxsYmFjazsNCisNCiAJcHZ0ID0gbWNp
LT5wdnRfaW5mbzsNCiAJZSA9ICZtY2ktPmVycm9yX2Rlc2M7DQogDQpAQCAtNjY1LDcgKzcxNSw3
IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNwZXJf
c2VjX21lbV9lcnIgKm1lbV9lcnIpDQogCWlmIChwID4gcHZ0LT5vdGhlcl9kZXRhaWwpDQogCQkq
KHAgLSAxKSA9ICdcMCc7DQogDQotCWRpbW1faW5mbyA9IGVkYWNfZ2V0X2RpbW1fYnlfaW5kZXgo
bWNpLCBlLT50b3BfbGF5ZXIpOw0KKwlkaW1tX2luZm8gPSBkaW1tID8gZGltbS0+ZGltbSA6IE5V
TEw7DQogDQogCWVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcih0eXBlLCBtY2ksIGRpbW1faW5mbywg
ZSwgLTEsIC0xKTsNCiANCi0tIA0KMi4yMC4xDQoNCg==
