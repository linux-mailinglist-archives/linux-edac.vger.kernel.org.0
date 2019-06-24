Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280B450FC6
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfFXPJi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62922 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730682AbfFXPJf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:35 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF0720018628;
        Mon, 24 Jun 2019 08:09:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fGiKqzPfUc9AXTHSQs9EVcWX6jy3P7JI7GKuDwheurI=;
 b=CKgBRbYARYn1hUyrxb0dCbUlA+fBle9XyaE7mtHsQAdDczARz4sb13sPLW2fGnzNbr9a
 81FLfzSnbZlyqRs6pdEuoiC3oIPLMrc/6Q+aFI11KbdoYrG963yU0bPx38nXlo56uFhD
 qoL4UT/cweY8L+S/LiQ+JbPSeG7bLVQPj4k+IXmQnrb1nawy/2LUqbfE7IOQatoPaBCG
 FQU3gTLV5kE7NkgvJemlnBVHaQwCa0Ur8IUvAVSj0tAO9ArqGCEw91PLZ1YS8U8vWOJe
 4Xttguaq3Eg9LChUD63/n+ayMsjGGhGEbGu0YsDERkY9vKnG0ORkiXEedHhv5YcBntYg Fw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9tb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:27 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:26 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGiKqzPfUc9AXTHSQs9EVcWX6jy3P7JI7GKuDwheurI=;
 b=X8AieWewTvPsg2KjquFqgxlERr3aYybwMejjJy4RaUii+fRytIFor0ZLNz6R2U5seg7BvZ5zS6uw0IHzvtVLKyGA9buoxCqsHNw66OabqSGWKChwajRPZ792bIFKLR3tX4MGFKCNngG/7P01tyG6HU4NFG9IX/jz5d0PUHMo5a4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:26 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:26 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 15/24] EDAC, ghes: Extract numa node information for each
 dimm
Thread-Topic: [PATCH v2 15/24] EDAC, ghes: Extract numa node information for
 each dimm
Thread-Index: AQHVKp7PrQ3keExIu02YFGQ2PMgwJg==
Date:   Mon, 24 Jun 2019 15:09:25 +0000
Message-ID: <20190624150758.6695-16-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: c4a9dddb-7085-4244-8bb2-08d6f8b5f23b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB3197EADC4FC4838419F19558D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jk+lQP38n/+InFfn3SYvE+rahkc5CtHtaqlAdTQkcQkdcAWRmdNHNP5me/DZB5vaTMA3IqTNNJrhXsLL/dIt/VEjZXBexQb7RJSg2qU3254Eptzp/Z5RPvvNnM7sqRS+thg8ct2T1GJvV/zEJScL5ur5Jas0gZIAXm/Shes4cNDbJzcrDuEQF+RXMTja8f1SEAV3MUsJsQjJdLYMJIdQp2aaxMsLD8UdXa5pSg/d0xsfVNO1dganmDBfTjzF0HV9CGiN/u75GutuWdS5vyNYcwPsYnBRysG9uGcYQEmbmjDaXM8/jGi98pvRic7iJsy2G4m5o+csj/m+p4HVx4Ko+2q/JlJbDxEBaJA3aFFcMlKIXulK8rurUMz6jzVssXd7YMze+lpSuiZ+wFKYuJESMhtujVDX/aUD02l9u6Wn9kw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a9dddb-7085-4244-8bb2-08d6f8b5f23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:25.9659
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

SW4gYSBsYXRlciBwYXRjaCB3ZSB3YW50IHRvIGhhdmUgb25lIG1jIGRldmljZSBwZXIgbm9kZS4g
VGhpcyBwYXRjaA0KZXh0cmFjdHMgdGhlIG51bWEgbm9kZSBpbmZvcm1hdGlvbiBmb3IgZWFjaCBk
aW1tLiBUaGlzIGlzIGRvbmUgYnkNCmNvbGxlY3RpbmcgdGhlIHBoeXNpY2FsIGFkZHJlc3MgcmFu
Z2VzIGZyb20gdGhlIERNSSB0YWJsZSAoTWVtb3J5DQpBcnJheSBNYXBwZWQgQWRkcmVzcyAtIFR5
cGUgMTkgb2YgU01CSU9TIHNwZWMpLiBUaGUgbm9kZSBpbmZvcm1hdGlvbg0KZm9yIGEgcGh5c2lj
YWwgYWRkcmVzcyBpcyBhbHJlYWR5IGtub3cgdG8gYSBudW1hIGF3YXJlIHN5c3RlbSAoZS5nLiBi
eQ0KdXNpbmcgdGhlIEFDUEkgX1BYTSBtZXRob2Qgb3IgdGhlIEFDUEkgU1JBVCB0YWJsZSksIHNv
IGJhc2VkIG9uIHRoZSBQQQ0Kd2UgY2FuIGFzc2lnbiB0aGUgbm9kZSBpZCB0byB0aGUgZGltbXMu
DQoNCkEgZmFsbGJhY2sgdGhhdCBkaXNhYmxlcyBudW1hIGlzIGltcGxlbWVudGVkIGluIGNhc2Ug
dGhlIG5vZGUNCmluZm9ybWF0aW9uIGlzIGluY29uc2lzdGVudC4NCg0KRS5nLiwgb24gYSBUaHVu
ZGVyWDIgc3lzdGVtIHRoZSBmb2xsb3dpbmcgbm9kZSBtYXBwaW5ncyBhcmUgZm91bmQNCmJhc2Vk
IG9uIHRoZSBETUkgdGFibGU6DQoNCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NMDog
Rm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDg4MDAwMDAwMDAtMHgwMDAwMDA5ZmZjZmZmZmZmXSBv
biBub2RlIDANCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NMTogRm91bmQgbWVtIHJh
bmdlIFsweDAwMDAwMDg4MDAwMDAwMDAtMHgwMDAwMDA5ZmZjZmZmZmZmXSBvbiBub2RlIDANCkVE
QUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NMjogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAw
MDg4MDAwMDAwMDAtMHgwMDAwMDA5ZmZjZmZmZmZmXSBvbiBub2RlIDANCkVEQUMgREVCVUc6IG1l
bV9pbmZvX3NldHVwOiBESU1NMzogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDg4MDAwMDAwMDAt
MHgwMDAwMDA5ZmZjZmZmZmZmXSBvbiBub2RlIDANCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVw
OiBESU1NNDogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDg4MDAwMDAwMDAtMHgwMDAwMDA5ZmZj
ZmZmZmZmXSBvbiBub2RlIDANCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NNTogRm91
bmQgbWVtIHJhbmdlIFsweDAwMDAwMDg4MDAwMDAwMDAtMHgwMDAwMDA5ZmZjZmZmZmZmXSBvbiBu
b2RlIDANCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NNjogRm91bmQgbWVtIHJhbmdl
IFsweDAwMDAwMDg4MDAwMDAwMDAtMHgwMDAwMDA5ZmZjZmZmZmZmXSBvbiBub2RlIDANCkVEQUMg
REVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NNzogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDg4
MDAwMDAwMDAtMHgwMDAwMDA5ZmZjZmZmZmZmXSBvbiBub2RlIDANCkVEQUMgREVCVUc6IG1lbV9p
bmZvX3NldHVwOiBESU1NODogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDlmZmQwMDAwMDAtMHgw
MDAwMDBiZmZjZmZmZmZmXSBvbiBub2RlIDENCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBE
SU1NOTogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDlmZmQwMDAwMDAtMHgwMDAwMDBiZmZjZmZm
ZmZmXSBvbiBub2RlIDENCkVEQUMgREVCVUc6IG1lbV9pbmZvX3NldHVwOiBESU1NMTA6IEZvdW5k
IG1lbSByYW5nZSBbMHgwMDAwMDA5ZmZkMDAwMDAwLTB4MDAwMDAwYmZmY2ZmZmZmZl0gb24gbm9k
ZSAxDQpFREFDIERFQlVHOiBtZW1faW5mb19zZXR1cDogRElNTTExOiBGb3VuZCBtZW0gcmFuZ2Ug
WzB4MDAwMDAwOWZmZDAwMDAwMC0weDAwMDAwMGJmZmNmZmZmZmZdIG9uIG5vZGUgMQ0KRURBQyBE
RUJVRzogbWVtX2luZm9fc2V0dXA6IERJTU0xMjogRm91bmQgbWVtIHJhbmdlIFsweDAwMDAwMDlm
ZmQwMDAwMDAtMHgwMDAwMDBiZmZjZmZmZmZmXSBvbiBub2RlIDENCkVEQUMgREVCVUc6IG1lbV9p
bmZvX3NldHVwOiBESU1NMTM6IEZvdW5kIG1lbSByYW5nZSBbMHgwMDAwMDA5ZmZkMDAwMDAwLTB4
MDAwMDAwYmZmY2ZmZmZmZl0gb24gbm9kZSAxDQpFREFDIERFQlVHOiBtZW1faW5mb19zZXR1cDog
RElNTTE0OiBGb3VuZCBtZW0gcmFuZ2UgWzB4MDAwMDAwOWZmZDAwMDAwMC0weDAwMDAwMGJmZmNm
ZmZmZmZdIG9uIG5vZGUgMQ0KRURBQyBERUJVRzogbWVtX2luZm9fc2V0dXA6IERJTU0xNTogRm91
bmQgbWVtIHJhbmdlIFsweDAwMDAwMDlmZmQwMDAwMDAtMHgwMDAwMDBiZmZjZmZmZmZmXSBvbiBu
b2RlIDENCg0KU2lnbmVkLW9mZi1ieTogUm9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQG1hcnZlbGwu
Y29tPg0KLS0tDQogZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIHwgOTggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5NyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFj
LmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4IDQ0YmZiNDk5YjE0Ny4uNzkzMzYy
YmVhMDQ0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQorKysgYi9kcml2
ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCkBAIC02NSwxNCArNjUsMzIgQEAgc3RydWN0IG1lbWRldl9k
bWlfZW50cnkgew0KIAl1MTYgY29uZl9tZW1fY2xrX3NwZWVkOw0KIH0gX19hdHRyaWJ1dGVfXygo
X19wYWNrZWRfXykpOw0KIA0KKy8qIE1lbW9yeSBBcnJheSBNYXBwZWQgQWRkcmVzcyAtIFR5cGUg
MTkgb2YgU01CSU9TIHNwZWMgKi8NCitzdHJ1Y3QgbWVtYXJyX2RtaV9lbnRyeSB7DQorCXU4CQl0
eXBlOw0KKwl1OAkJbGVuZ3RoOw0KKwl1MTYJCWhhbmRsZTsNCisJdTMyCQlzdGFydDsNCisJdTMy
CQllbmQ7DQorCXUxNgkJcGh5c19tZW1fYXJyYXlfaGFuZGxlOw0KKwl1OAkJcGFydGl0aW9uX3dp
ZHRoOw0KKwl1NjQJCWV4dF9zdGFydDsNCisJdTY0CQlleHRfZW5kOw0KK30gX19hdHRyaWJ1dGVf
XygoX19wYWNrZWRfXykpOw0KKw0KIHN0cnVjdCBnaGVzX2RpbW1faW5mbyB7DQogCXN0cnVjdCBk
aW1tX2luZm8gZGltbV9pbmZvOw0KIAlpbnQJCWlkeDsNCisJaW50CQludW1hX25vZGU7DQorCXBo
eXNfYWRkcl90CXN0YXJ0Ow0KKwlwaHlzX2FkZHJfdAllbmQ7DQorCXUxNgkJcGh5c19oYW5kbGU7
DQogfTsNCiANCiBzdHJ1Y3QgZ2hlc19tZW1faW5mbyB7DQotCWludCBudW1fZGltbTsNCisJaW50
CQludW1fZGltbTsNCiAJc3RydWN0IGdoZXNfZGltbV9pbmZvICpkaW1tczsNCisJaW50CQlkaW1t
c19wZXJfbm9kZVtNQVhfTlVNTk9ERVNdOw0KIH07DQogDQogc3RhdGljIHN0cnVjdCBnaGVzX21l
bV9pbmZvIG1lbV9pbmZvOw0KQEAgLTEwOCwxMiArMTI2LDUyIEBAIHN0YXRpYyBpbnQgZ2hlc19k
aW1tX2luZm9faW5pdChpbnQgbnVtKQ0KIA0KIAlmb3JfZWFjaF9kaW1tKGRpbW0pIHsNCiAJCWRp
bW0tPmlkeAk9IGlkeDsNCisJCWRpbW0tPm51bWFfbm9kZQk9IE5VTUFfTk9fTk9ERTsNCiAJCWlk
eCsrOw0KIAl9DQogDQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0aWMgdm9pZCBnaGVzX2VkYWNf
c2V0X25pZChjb25zdCBzdHJ1Y3QgZG1pX2hlYWRlciAqZGgsIHZvaWQgKmFyZykNCit7DQorCXN0
cnVjdCBtZW1hcnJfZG1pX2VudHJ5ICplbnRyeSA9IChzdHJ1Y3QgbWVtYXJyX2RtaV9lbnRyeSAq
KWRoOw0KKwlzdHJ1Y3QgZ2hlc19kaW1tX2luZm8gKmRpbW07DQorCXBoeXNfYWRkcl90IHN0YXJ0
LCBlbmQ7DQorCWludCBuaWQ7DQorDQorCWlmIChkaC0+dHlwZSAhPSBETUlfRU5UUllfTUVNX0FS
UkFZX01BUFBFRF9BRERSKQ0KKwkJcmV0dXJuOw0KKw0KKwkvKiBvbmx5IHN1cHBvcnQgU01CSU9T
IDIuNysgKi8NCisJaWYgKGVudHJ5LT5sZW5ndGggPCBzaXplb2YoKmVudHJ5KSkNCisJCXJldHVy
bjsNCisNCisJaWYgKGVudHJ5LT5zdGFydCA9PSAweGZmZmZmZmZmKQ0KKwkJc3RhcnQgPSBlbnRy
eS0+ZXh0X3N0YXJ0Ow0KKwllbHNlDQorCQlzdGFydCA9IGVudHJ5LT5zdGFydDsNCisJaWYgKGVu
dHJ5LT5lbmQgPT0gMHhmZmZmZmZmZikNCisJCWVuZCA9IGVudHJ5LT5leHRfZW5kOw0KKwllbHNl
DQorCQllbmQgPSBlbnRyeS0+ZW5kOw0KKw0KKwlpZiAoIXBmbl92YWxpZChQSFlTX1BGTihzdGFy
dCkpKQ0KKwkJcmV0dXJuOw0KKw0KKwluaWQgPSBwZm5fdG9fbmlkKFBIWVNfUEZOKHN0YXJ0KSk7
DQorCWlmIChuaWQgPCAwIHx8IG5pZCA+PSBNQVhfTlVNTk9ERVMgfHwgIW5vZGVfcG9zc2libGUo
bmlkKSkNCisJCW5pZCA9IE5VTUFfTk9fTk9ERTsNCisNCisJZm9yX2VhY2hfZGltbShkaW1tKSB7
DQorCQlpZiAoZW50cnktPnBoeXNfbWVtX2FycmF5X2hhbmRsZSA9PSBkaW1tLT5waHlzX2hhbmRs
ZSkgew0KKwkJCWRpbW0tPm51bWFfbm9kZQk9IG5pZDsNCisJCQlkaW1tLT5zdGFydAk9IHN0YXJ0
Ow0KKwkJCWRpbW0tPmVuZAk9IGVuZDsNCisJCX0NCisJfQ0KK30NCisNCiBzdGF0aWMgaW50IGdl
dF9kaW1tX3NtYmlvc19pbmRleCh1MTYgaGFuZGxlKQ0KIHsNCiAJc3RydWN0IG1lbV9jdGxfaW5m
byAqbWNpID0gZ2hlc19wdnQtPm1jaTsNCkBAIC0xMzUsNiArMTkzLDggQEAgc3RhdGljIHZvaWQg
Z2hlc19lZGFjX2RtaWRlY29kZShjb25zdCBzdHJ1Y3QgZG1pX2hlYWRlciAqZGgsIHZvaWQgKmFy
ZykNCiAJCXN0cnVjdCBkaW1tX2luZm8gKmRpbW0gPSAmbWktPmRpbW1faW5mbzsNCiAJCXUxNiBy
ZHJfbWFzayA9IEJJVCg3KSB8IEJJVCgxMyk7DQogDQorCQltaS0+cGh5c19oYW5kbGUgPSBlbnRy
eS0+cGh5c19tZW1fYXJyYXlfaGFuZGxlOw0KKw0KIAkJaWYgKGVudHJ5LT5zaXplID09IDB4ZmZm
Zikgew0KIAkJCXByX2luZm8oIkNhbid0IGdldCBESU1NJWkgc2l6ZVxuIiwgbWktPmlkeCk7DQog
CQkJZGltbS0+bnJfcGFnZXMgPSBNaUJfVE9fUEFHRVMoMzIpOy8qIFVua25vd24gKi8NCkBAIC0y
MjQsOCArMjg0LDIzIEBAIHN0YXRpYyB2b2lkIGdoZXNfZWRhY19kbWlkZWNvZGUoY29uc3Qgc3Ry
dWN0IGRtaV9oZWFkZXIgKmRoLCB2b2lkICphcmcpDQogCX0NCiB9DQogDQorc3RhdGljIHZvaWQg
bWVtX2luZm9fZGlzYWJsZV9udW1hKHZvaWQpDQorew0KKwlzdHJ1Y3QgZ2hlc19kaW1tX2luZm8g
KmRpbW07DQorDQorCWZvcl9lYWNoX2RpbW0oZGltbSkgew0KKwkJaWYgKGRpbW0tPm51bWFfbm9k
ZSAhPSBOVU1BX05PX05PREUpDQorCQkJbWVtX2luZm8uZGltbXNfcGVyX25vZGVbZGltbS0+bnVt
YV9ub2RlXSA9IDA7DQorCQlkaW1tLT5udW1hX25vZGUgPSAwOw0KKwl9DQorDQorCW1lbV9pbmZv
LmRpbW1zX3Blcl9ub2RlWzBdID0gbWVtX2luZm8ubnVtX2RpbW07DQorfQ0KKw0KIHN0YXRpYyBp
bnQgbWVtX2luZm9fc2V0dXAodm9pZCkNCiB7DQorCXN0cnVjdCBnaGVzX2RpbW1faW5mbyAqZGlt
bTsNCisJYm9vbCBlbmFibGVfbnVtYSA9IHRydWU7DQogCWludCBudW0gPSAwOw0KIAlpbnQgaWR4
ID0gMDsNCiAJaW50IHJldDsNCkBAIC0yMzgsNiArMzEzLDI1IEBAIHN0YXRpYyBpbnQgbWVtX2lu
Zm9fc2V0dXAodm9pZCkNCiAJCXJldHVybiByZXQ7DQogDQogCWRtaV93YWxrKGdoZXNfZWRhY19k
bWlkZWNvZGUsICZpZHgpOw0KKwlkbWlfd2FsayhnaGVzX2VkYWNfc2V0X25pZCwgTlVMTCk7DQor
DQorCWZvcl9lYWNoX2RpbW0oZGltbSkgew0KKwkJaWYgKGRpbW0tPm51bWFfbm9kZSA9PSBOVU1B
X05PX05PREUpDQorCQkJZW5hYmxlX251bWEgPSBmYWxzZTsNCisJCWVsc2UNCisJCQltZW1faW5m
by5kaW1tc19wZXJfbm9kZVtkaW1tLT5udW1hX25vZGVdKys7DQorDQorCQllZGFjX2RiZygxLCAi
RElNTSVpOiBGb3VuZCBtZW0gcmFuZ2UgWyVwYS0lcGFdIG9uIG5vZGUgJWRcbiIsDQorCQkJZGlt
bS0+aWR4LCAmZGltbS0+c3RhcnQsICZkaW1tLT5lbmQsIGRpbW0tPm51bWFfbm9kZSk7DQorCX0N
CisNCisJaWYgKGVuYWJsZV9udW1hKQ0KKwkJcmV0dXJuIDA7DQorDQorCS8qIHNvbWV0aGluZyB3
ZW50IHdyb25nLCBkaXNhYmxlIG51bWEgKi8NCisJaWYgKG51bV9wb3NzaWJsZV9ub2RlcygpID4g
MSkNCisJCXByX3dhcm4oIkNhbid0IGdldCBudW1hIGluZm8sIGRpc2FibGluZyBudW1hXG4iKTsN
CisJbWVtX2luZm9fZGlzYWJsZV9udW1hKCk7DQogDQogCXJldHVybiAwOw0KIH0NCkBAIC0yNTgs
NiArMzUyLDggQEAgc3RhdGljIGludCBtZW1faW5mb19zZXR1cF9mYWtlKHZvaWQpDQogCWRpbW0t
PmR0eXBlID0gREVWX1VOS05PV047DQogCWRpbW0tPmVkYWNfbW9kZSA9IEVEQUNfU0VDREVEOw0K
IA0KKwltZW1faW5mb19kaXNhYmxlX251bWEoKTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0g
DQoyLjIwLjENCg0K
