Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5A2D80A
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE2Ioq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49578 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfE2Ioq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8do5I017769;
        Wed, 29 May 2019 01:44:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=u9alLq7IezxnE8uRDb+x5yZz/pbYz8zbGCqaefQpu/A=;
 b=mLhsNSPAVtAIOC2aVTNyV9WGnElMhrqICSX19QLcXLJi1hqAzqf9n4RS/pQOBcbctnBQ
 x6fjfC3qbkgY35B7Di2Z+uWi+uuIVCqJL0VzYqazj0lDt1HRuyMQUb7E8MU2SlT12WeK
 tdWP7VVPZMqlBlmX3ed7x45r40thJXduLnl43YoK3P1QCuFgbvy53caO4nXPQwHBOMkC
 zbFSBdVF3NnehKuHYoXj9N0t0yYmgpv/z/VHQ/4hYrbdK4KzN1TivAzlDWO0BW3IzT1s
 qPmW7+WMtIL8xy2KYJ8758fyfqpRGyi072JEZztRzSLsTwAeVQ0wLD1blBXxqLA5Mzm1 eQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p6g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:38 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:37 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9alLq7IezxnE8uRDb+x5yZz/pbYz8zbGCqaefQpu/A=;
 b=wWFJSX8uN2Me5hmId/PnSgA4S3cTumVTmjJv6keiNY17EJM7p1zqCKFsKySfcrhM5Gp2LFsjwJ5IYw21Ryu9x8BvBuHHcg0wlTRprKv92b/MO5zlPIIlkgXmWDvHHJo3M+jXCyv5QzCAKOQh8TnMtUbHDfReityKHlTM6ct9L0k=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:35 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:35 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 14/21] EDAC, ghes: Extract numa node information for each dimm
Thread-Topic: [PATCH 14/21] EDAC, ghes: Extract numa node information for each
 dimm
Thread-Index: AQHVFfq9sPfT7Zt2PE+R3bvTGIYDig==
Date:   Wed, 29 May 2019 08:44:35 +0000
Message-ID: <20190529084344.28562-15-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ac202288-64fa-4567-8f08-08d6e411e036
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB34378BB3BE15C5615771D5A2D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oCcwaQG/Xey/h8j1hSSXI/fQ8xAcXr2cpgAnOoNpFKvtN3pgu8FcvsH7YFIdXo0W1zgTCm7eYB+bXPsqV5lnqkDFfqTlAFOv119nG6qpScL7OIMS/QE4Ku0ITLf3avziQ8ITVfOkIR6D0U/Mp7bYLEr7QkOUheDUOBzxJMTMPYyezuFHZweW2ejBhwY/ywWf9bGnkbAwh9hG2wykC6d1GPDPLCN3w4Fw/s0UxA+NWk/1rH9CfM7mrSCawMKZ3HchXm+tQvJ1a0cZaTJ+vE4Tb8JpzyTpmSVBAyIjXoOlg9aa3RB4FJo/zZVHyUuM7juwN2xf25Y4crRhIabVN6eYeqXrvmAx8y3w+oasD7AjyPmDC6VdRpnj//OZyh+C4abObZuVJ0yPMcVuU85N8kTlzZGRbdyRjLpR8oGmYxAhkIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac202288-64fa-4567-8f08-08d6e411e036
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:35.0325
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
Y29tPg0KLS0tDQogZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIHwgMTA0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNfZWRh
Yy5jIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRleCA1MGY0ZWUzNmI3NTUuLjA4MzQ1
MmE0OGI0MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJp
dmVycy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtNjcsMTQgKzY3LDM0IEBAIHN0cnVjdCBtZW1kZXZf
ZG1pX2VudHJ5IHsNCiAJdTE2IGNvbmZfbWVtX2Nsa19zcGVlZDsNCiB9IF9fYXR0cmlidXRlX18o
KF9fcGFja2VkX18pKTsNCiANCisvKiBNZW1vcnkgQXJyYXkgTWFwcGVkIEFkZHJlc3MgLSBUeXBl
IDE5IG9mIFNNQklPUyBzcGVjICovDQorc3RydWN0IG1lbWFycl9kbWlfZW50cnkgew0KKwl1OAkJ
dHlwZTsNCisJdTgJCWxlbmd0aDsNCisJdTE2CQloYW5kbGU7DQorCXUzMgkJc3RhcnQ7DQorCXUz
MgkJZW5kOw0KKwl1MTYJCXBoeXNfbWVtX2FycmF5X2hhbmRsZTsNCisJdTgJCXBhcnRpdGlvbl93
aWR0aDsNCisJdTY0CQlleHRfc3RhcnQ7DQorCXU2NAkJZXh0X2VuZDsNCit9IF9fYXR0cmlidXRl
X18oKF9fcGFja2VkX18pKTsNCisNCiBzdHJ1Y3QgZ2hlc19kaW1tX2luZm8gew0KIAlzdHJ1Y3Qg
ZGltbV9pbmZvIGRpbW1faW5mbzsNCiAJaW50CQlpZHg7DQorCWludAkJbnVtYV9ub2RlOw0KKwlw
aHlzX2FkZHJfdAlzdGFydDsNCisJcGh5c19hZGRyX3QJZW5kOw0KKwl1MTYJCXBoeXNfaGFuZGxl
Ow0KIH07DQogDQogc3RydWN0IGdoZXNfbWVtX2luZm8gew0KLQlpbnQgbnVtX2RpbW07DQorCWlu
dAkJbnVtX2RpbW07DQogCXN0cnVjdCBnaGVzX2RpbW1faW5mbyAqZGltbXM7DQorCWludAkJbnVt
X25vZGVzOw0KKwlpbnQJCW51bV9wZXJfbm9kZVtNQVhfTlVNTk9ERVNdOw0KKwlib29sCQllbmFi
bGVfbnVtYTsNCiB9Ow0KIA0KIHN0cnVjdCBnaGVzX21lbV9pbmZvIG1lbV9pbmZvOw0KQEAgLTk3
LDEwICsxMTcsNTAgQEAgc3RhdGljIHZvaWQgZ2hlc19kaW1tX2luZm9faW5pdCh2b2lkKQ0KIA0K
IAlmb3JfZWFjaF9kaW1tKGRpbW0pIHsNCiAJCWRpbW0tPmlkeAk9IGlkeDsNCisJCWRpbW0tPm51
bWFfbm9kZQk9IE5VTUFfTk9fTk9ERTsNCiAJCWlkeCsrOw0KIAl9DQogfQ0KIA0KK3N0YXRpYyB2
b2lkIGdoZXNfZWRhY19zZXRfbmlkKGNvbnN0IHN0cnVjdCBkbWlfaGVhZGVyICpkaCwgdm9pZCAq
YXJnKQ0KK3sNCisJc3RydWN0IG1lbWFycl9kbWlfZW50cnkgKmVudHJ5ID0gKHN0cnVjdCBtZW1h
cnJfZG1pX2VudHJ5ICopZGg7DQorCXN0cnVjdCBnaGVzX2RpbW1faW5mbyAqZGltbTsNCisJcGh5
c19hZGRyX3Qgc3RhcnQsIGVuZDsNCisJaW50IG5pZDsNCisNCisJaWYgKGRoLT50eXBlICE9IERN
SV9FTlRSWV9NRU1fQVJSQVlfTUFQUEVEX0FERFIpDQorCQlyZXR1cm47DQorDQorCS8qIG9ubHkg
c3VwcG9ydCBTTUJJT1MgMi43KyAqLw0KKwlpZiAoZW50cnktPmxlbmd0aCA8IHNpemVvZigqZW50
cnkpKQ0KKwkJcmV0dXJuOw0KKw0KKwlpZiAoZW50cnktPnN0YXJ0ID09IDB4ZmZmZmZmZmYpDQor
CQlzdGFydCA9IGVudHJ5LT5leHRfc3RhcnQ7DQorCWVsc2UNCisJCXN0YXJ0ID0gZW50cnktPnN0
YXJ0Ow0KKwlpZiAoZW50cnktPmVuZCA9PSAweGZmZmZmZmZmKQ0KKwkJZW5kID0gZW50cnktPmV4
dF9lbmQ7DQorCWVsc2UNCisJCWVuZCA9IGVudHJ5LT5lbmQ7DQorDQorCWlmICghcGZuX3ZhbGlk
KFBIWVNfUEZOKHN0YXJ0KSkpDQorCQlyZXR1cm47DQorDQorCW5pZCA9IHBmbl90b19uaWQoUEhZ
U19QRk4oc3RhcnQpKTsNCisJaWYgKG5pZCA8IDAgfHwgbmlkID49IE1BWF9OVU1OT0RFUyB8fCAh
bm9kZV9wb3NzaWJsZShuaWQpKQ0KKwkJbmlkID0gTlVNQV9OT19OT0RFOw0KKw0KKwlmb3JfZWFj
aF9kaW1tKGRpbW0pIHsNCisJCWlmIChlbnRyeS0+cGh5c19tZW1fYXJyYXlfaGFuZGxlID09IGRp
bW0tPnBoeXNfaGFuZGxlKSB7DQorCQkJZGltbS0+bnVtYV9ub2RlCT0gbmlkOw0KKwkJCWRpbW0t
PnN0YXJ0CT0gc3RhcnQ7DQorCQkJZGltbS0+ZW5kCT0gZW5kOw0KKwkJfQ0KKwl9DQorfQ0KKw0K
IHN0YXRpYyBpbnQgZ2V0X2RpbW1fc21iaW9zX2luZGV4KHUxNiBoYW5kbGUpDQogew0KIAlzdHJ1
Y3QgbWVtX2N0bF9pbmZvICptY2kgPSBnaGVzX3B2dC0+bWNpOw0KQEAgLTIxMyw4ICsyNzMsMjUg
QEAgc3RhdGljIHZvaWQgZ2hlc19lZGFjX2RtaWRlY29kZShjb25zdCBzdHJ1Y3QgZG1pX2hlYWRl
ciAqZGgsIHZvaWQgKmFyZykNCiAJfQ0KIH0NCiANCitzdGF0aWMgdm9pZCBtZW1faW5mb19kaXNh
YmxlX251bWEodm9pZCkNCit7DQorCXN0cnVjdCBnaGVzX2RpbW1faW5mbyAqZGltbTsNCisNCisJ
Zm9yX2VhY2hfZGltbShkaW1tKSB7DQorCQlpZiAoZGltbS0+bnVtYV9ub2RlICE9IE5VTUFfTk9f
Tk9ERSkNCisJCQltZW1faW5mby5udW1fcGVyX25vZGVbZGltbS0+bnVtYV9ub2RlXSA9IDA7DQor
CQlkaW1tLT5udW1hX25vZGUgPSAwOw0KKwl9DQorDQorCW1lbV9pbmZvLm51bV9wZXJfbm9kZVsw
XSA9IG1lbV9pbmZvLm51bV9kaW1tOw0KKwltZW1faW5mby5udW1fbm9kZXMgPSAxOw0KKwltZW1f
aW5mby5lbmFibGVfbnVtYSA9IGZhbHNlOw0KK30NCisNCiBzdGF0aWMgaW50IG1lbV9pbmZvX3Nl
dHVwKHZvaWQpDQogew0KKwlzdHJ1Y3QgZ2hlc19kaW1tX2luZm8gKmRpbW07DQorCWJvb2wgZW5h
YmxlX251bWEgPSB0cnVlOw0KIAlpbnQgaWR4ID0gMDsNCiANCiAJbWVtc2V0KCZtZW1faW5mbywg
MCwgc2l6ZW9mKG1lbV9pbmZvKSk7DQpAQCAtMjMxLDYgKzMwOCwyOSBAQCBzdGF0aWMgaW50IG1l
bV9pbmZvX3NldHVwKHZvaWQpDQogDQogCWdoZXNfZGltbV9pbmZvX2luaXQoKTsNCiAJZG1pX3dh
bGsoZ2hlc19lZGFjX2RtaWRlY29kZSwgJmlkeCk7DQorCWRtaV93YWxrKGdoZXNfZWRhY19zZXRf
bmlkLCBOVUxMKTsNCisNCisJZm9yX2VhY2hfZGltbShkaW1tKSB7DQorCQlpZiAoZGltbS0+bnVt
YV9ub2RlID09IE5VTUFfTk9fTk9ERSkgew0KKwkJCWVuYWJsZV9udW1hID0gZmFsc2U7DQorCQl9
IGVsc2Ugew0KKwkJCWlmICghbWVtX2luZm8ubnVtX3Blcl9ub2RlW2RpbW0tPm51bWFfbm9kZV0p
DQorCQkJCW1lbV9pbmZvLm51bV9ub2RlcysrOw0KKwkJCW1lbV9pbmZvLm51bV9wZXJfbm9kZVtk
aW1tLT5udW1hX25vZGVdKys7DQorCQl9DQorDQorCQllZGFjX2RiZygxLCAiRElNTSVpOiBGb3Vu
ZCBtZW0gcmFuZ2UgWyVwYS0lcGFdIG9uIG5vZGUgJWRcbiIsDQorCQkJZGltbS0+aWR4LCAmZGlt
bS0+c3RhcnQsICZkaW1tLT5lbmQsIGRpbW0tPm51bWFfbm9kZSk7DQorCX0NCisNCisJbWVtX2lu
Zm8uZW5hYmxlX251bWEgPSBlbmFibGVfbnVtYTsNCisJaWYgKGVuYWJsZV9udW1hKQ0KKwkJcmV0
dXJuIDA7DQorDQorCS8qIHNvbWV0aGluZyB3ZW50IHdyb25nLCBkaXNhYmxlIG51bWEgKi8NCisJ
aWYgKG51bV9wb3NzaWJsZV9ub2RlcygpID4gMSkNCisJCXByX3dhcm4oIkNhbid0IGdldCBudW1h
IGluZm8sIGRpc2FibGluZyBudW1hXG4iKTsNCisJbWVtX2luZm9fZGlzYWJsZV9udW1hKCk7DQog
DQogCXJldHVybiAwOw0KIH0NCkBAIC0yNTgsNiArMzU4LDggQEAgc3RhdGljIGludCBtZW1faW5m
b19zZXR1cF9mYWtlKHZvaWQpDQogCWRpbW0tPmR0eXBlID0gREVWX1VOS05PV047DQogCWRpbW0t
PmVkYWNfbW9kZSA9IEVEQUNfU0VDREVEOw0KIA0KKwltZW1faW5mb19kaXNhYmxlX251bWEoKTsN
CisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoyLjIwLjENCg0K
