Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE5550FEA
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfFXPJT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:19 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8656 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729578AbfFXPJS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:18 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8DQp025885;
        Mon, 24 Jun 2019 08:09:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=jFsFLKHCcJPeWPXNzKZ4zNh9o3eVIQkcVZvv8t0zFMo=;
 b=MZn0SVV6XBDYYgTKGAHbdWJFivnj47h/iXRTD5TTduViqKlhPPfBb7u0sqUw5ECIKjL8
 TYdHNMNWeRDPRaiIxaAiu23E+frCyEjbnQ33j6kl7dUIboBq5BICB9G+wMObgHDXQVvh
 hO708bwWIccOsI1qau8UZEoLzaPQIdzBHH7wmINZ4Fphq/4P0x03VxP9pdfA6n5sETx6
 Ew3ks1E+C+FfQIW6xLo3SWfWQ0RxivCpn+UPGeQplRohSRQtQAdB8hwYgr6C0xedlm3V
 gBU0tHyMTsArJs+yf+vKbX5oSoxKIrZooQLz9H6anwZsKGuS9XZEhvLPo5BetoLb8JRa Pg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:11 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:10 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFsFLKHCcJPeWPXNzKZ4zNh9o3eVIQkcVZvv8t0zFMo=;
 b=Xa9nqIF/IKzbzRW6WjwTp39ibzQaNKTeHyA9mvdFNEV+lYcgWVj9QWBoOrxbbtg+7q2DLcBUeona5tPeajRwWZfoBejzcbcl6l9ieUA9jTGX1NFlzsxzND9APVc9yD+XUm+GA8RYz5HKSBej0VAQ3g2zvBTLNAoV98DX+x8Dg8A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:09 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:09 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 07/24] EDAC: Kill EDAC_DIMM_OFF() macro
Thread-Topic: [PATCH v2 07/24] EDAC: Kill EDAC_DIMM_OFF() macro
Thread-Index: AQHVKp7Fo1m2H4puVkaf5rh/3X0l2A==
Date:   Mon, 24 Jun 2019 15:09:09 +0000
Message-ID: <20190624150758.6695-8-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: f70a0cf3-f19d-41f5-4679-08d6f8b5e7ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB3197EE59B33BC158B0BEF73DD9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oSCVQIkoSnlySzEazvoh8ZzQo39H2STsk+PJLkhHxNchehmLbvwqmXZHmZ0qG/DTvxo0T1bM1I0+hzs1/abfrS6NX8cM5O6OMmHjV/u2FVH+g/n6Cgrlh2XGd6FJ/emNFPoLp77B2amgbPwooX1E4XlK/qulOTse8MP00WMlBIBPVEImtQyO49r+7RVERcFWLbhWnL9/RDdE4D3PedqNXEwPQwz2RUvvWK1LpMl4AISof+B9pGePzSaSYDf6E7mAqftr+8FWvC4KwTs18//EhpWfczeCvXIhSBdoY3w2CzDwOBTUGUVBhz4zlCkKQsZxGkq27b+j70ywtdR+b4f8txnOrhqSFi2o3haE8Ok5Pgrp9Ys/DLpbKUZTWQDd2T2IVIEBtthQW4IO9nhd1yhhq633m1JcJVg6tVUfbIVrvaU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f70a0cf3-f19d-41f5-4679-08d6f8b5e7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:09.0505
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

V2UgZG8gbm90IG5lZWQgdG8gY2FsY3VsYXRlIHRoZSBvZmZzZXQgaW4gdGhlIG1jJ3MgZGltbSBh
cnJheSwgbGV0J3MNCmp1c3Qgc3RvcmUgdGhlIGluZGV4IGluIHN0cnVjdCBkaW1tX2luZm8gYW5k
IHdlIGNhbiBnZXQgcmlkIG9mIHRoaXMNCm1hY3JvLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQg
UmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19t
Yy5jICAgICAgIHwgMTMgKysrKy0tLS0tLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMu
YyB8IDIwICsrKystLS0tLS0tLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvZWRhYy5oICAgICAgICAg
fCA0MSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAzIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNjYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2VkYWMvZWRhY19tYy5jIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KaW5kZXggYzk1OWU4
YjE2NDNjLi5jNDRiYzgzZTg1MDIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5j
DQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQpAQCAtMzE4LDcgKzMxOCw3IEBAIHN0cnVj
dCBtZW1fY3RsX2luZm8gKmVkYWNfbWNfYWxsb2ModW5zaWduZWQgbWNfbnVtLA0KIAl1bnNpZ25l
ZCBzaXplLCB0b3RfZGltbXMgPSAxLCBjb3VudCA9IDE7DQogCXVuc2lnbmVkIHRvdF9jc3Jvd3Mg
PSAxLCB0b3RfY2hhbm5lbHMgPSAxLCB0b3RfZXJyY291bnQgPSAwOw0KIAl2b2lkICpwdnQsICpw
LCAqcHRyID0gTlVMTDsNCi0JaW50IGksIGosIHJvdywgY2huLCBuLCBsZW4sIG9mZjsNCisJaW50
IGlkeCwgaSwgaiwgcm93LCBjaG4sIG4sIGxlbjsNCiAJYm9vbCBwZXJfcmFuayA9IGZhbHNlOw0K
IA0KIAlCVUdfT04obl9sYXllcnMgPiBFREFDX01BWF9MQVlFUlMgfHwgbl9sYXllcnMgPT0gMCk7
DQpAQCAtNDI2LDIwICs0MjYsMTUgQEAgc3RydWN0IG1lbV9jdGxfaW5mbyAqZWRhY19tY19hbGxv
Yyh1bnNpZ25lZCBtY19udW0sDQogCW1lbXNldCgmcG9zLCAwLCBzaXplb2YocG9zKSk7DQogCXJv
dyA9IDA7DQogCWNobiA9IDA7DQotCWZvciAoaSA9IDA7IGkgPCB0b3RfZGltbXM7IGkrKykgew0K
Kwlmb3IgKGlkeCA9IDA7IGlkeCA8IHRvdF9kaW1tczsgaWR4KyspIHsNCiAJCWNoYW4gPSBtY2kt
PmNzcm93c1tyb3ddLT5jaGFubmVsc1tjaG5dOw0KLQkJb2ZmID0gRURBQ19ESU1NX09GRihsYXll
ciwgbl9sYXllcnMsIHBvc1swXSwgcG9zWzFdLCBwb3NbMl0pOw0KLQkJaWYgKG9mZiA8IDAgfHwg
b2ZmID49IHRvdF9kaW1tcykgew0KLQkJCWVkYWNfbWNfcHJpbnRrKG1jaSwgS0VSTl9FUlIsICJF
REFDIGNvcmUgYnVnOiBFREFDX0RJTU1fT0ZGIGlzIHRyeWluZyB0byBkbyBhbiBpbGxlZ2FsIGRh
dGEgYWNjZXNzXG4iKTsNCi0JCQlnb3RvIGVycm9yOw0KLQkJfQ0KIA0KIAkJZGltbSA9IGt6YWxs
b2Moc2l6ZW9mKCoqbWNpLT5kaW1tcyksIEdGUF9LRVJORUwpOw0KIAkJaWYgKCFkaW1tKQ0KIAkJ
CWdvdG8gZXJyb3I7DQotCQltY2ktPmRpbW1zW29mZl0gPSBkaW1tOw0KKwkJbWNpLT5kaW1tc1tp
ZHhdID0gZGltbTsNCiAJCWRpbW0tPm1jaSA9IG1jaTsNCi0JCWRpbW0tPmlkeCA9IG9mZjsNCisJ
CWRpbW0tPmlkeCA9IGlkeDsNCiANCiAJCS8qDQogCQkgKiBDb3B5IERJTU0gbG9jYXRpb24gYW5k
IGluaXRpYWxpemUgaXQuDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMu
YyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMNCmluZGV4IDI5ZGQ5NzE5ZjgyZi4uYTY5
ZTk5MjA2YTZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYw0KKysr
IGIvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYw0KQEAgLTU1OSwxNCArNTU5LDggQEAgc3Rh
dGljIHNzaXplX3QgZGltbWRldl9jZV9jb3VudF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCiB7
DQogCXN0cnVjdCBkaW1tX2luZm8gKmRpbW0gPSB0b19kaW1tKGRldik7DQogCXUzMiBjb3VudDsN
Ci0JaW50IG9mZjsNCi0NCi0Jb2ZmID0gRURBQ19ESU1NX09GRihkaW1tLT5tY2ktPmxheWVycywN
Ci0JCQkgICAgZGltbS0+bWNpLT5uX2xheWVycywNCi0JCQkgICAgZGltbS0+bG9jYXRpb25bMF0s
DQotCQkJICAgIGRpbW0tPmxvY2F0aW9uWzFdLA0KLQkJCSAgICBkaW1tLT5sb2NhdGlvblsyXSk7
DQotCWNvdW50ID0gZGltbS0+bWNpLT5jZV9wZXJfbGF5ZXJbZGltbS0+bWNpLT5uX2xheWVycy0x
XVtvZmZdOw0KKw0KKwljb3VudCA9IGRpbW0tPm1jaS0+Y2VfcGVyX2xheWVyW2RpbW0tPm1jaS0+
bl9sYXllcnMtMV1bZGltbS0+aWR4XTsNCiAJcmV0dXJuIHNwcmludGYoZGF0YSwgIiV1XG4iLCBj
b3VudCk7DQogfQ0KIA0KQEAgLTU3NiwxNCArNTcwLDggQEAgc3RhdGljIHNzaXplX3QgZGltbWRl
dl91ZV9jb3VudF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCiB7DQogCXN0cnVjdCBkaW1tX2lu
Zm8gKmRpbW0gPSB0b19kaW1tKGRldik7DQogCXUzMiBjb3VudDsNCi0JaW50IG9mZjsNCi0NCi0J
b2ZmID0gRURBQ19ESU1NX09GRihkaW1tLT5tY2ktPmxheWVycywNCi0JCQkgICAgZGltbS0+bWNp
LT5uX2xheWVycywNCi0JCQkgICAgZGltbS0+bG9jYXRpb25bMF0sDQotCQkJICAgIGRpbW0tPmxv
Y2F0aW9uWzFdLA0KLQkJCSAgICBkaW1tLT5sb2NhdGlvblsyXSk7DQotCWNvdW50ID0gZGltbS0+
bWNpLT51ZV9wZXJfbGF5ZXJbZGltbS0+bWNpLT5uX2xheWVycy0xXVtvZmZdOw0KKw0KKwljb3Vu
dCA9IGRpbW0tPm1jaS0+dWVfcGVyX2xheWVyW2RpbW0tPm1jaS0+bl9sYXllcnMtMV1bZGltbS0+
aWR4XTsNCiAJcmV0dXJuIHNwcmludGYoZGF0YSwgIiV1XG4iLCBjb3VudCk7DQogfQ0KIA0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZWRhYy5oIGIvaW5jbHVkZS9saW51eC9lZGFjLmgNCmlu
ZGV4IDEzNjdhM2ZjNTQ0Zi4uMmVlOWI4NTk4YWUwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51
eC9lZGFjLmgNCisrKyBiL2luY2x1ZGUvbGludXgvZWRhYy5oDQpAQCAtMzYyLDQ3ICszNjIsNiBA
QCBzdHJ1Y3QgZWRhY19tY19sYXllciB7DQogICovDQogI2RlZmluZSBFREFDX01BWF9MQVlFUlMJ
CTMNCiANCi0vKioNCi0gKiBFREFDX0RJTU1fT0ZGIC0gTWFjcm8gcmVzcG9uc2libGUgdG8gZ2V0
IGEgcG9pbnRlciBvZmZzZXQgaW5zaWRlIGEgcG9pbnRlcg0KLSAqCQkgICBhcnJheSBmb3IgdGhl
IGVsZW1lbnQgZ2l2ZW4gYnkgW2xheWVyMCxsYXllcjEsbGF5ZXIyXQ0KLSAqCQkgICBwb3NpdGlv
bg0KLSAqDQotICogQGxheWVyczoJYSBzdHJ1Y3QgZWRhY19tY19sYXllciBhcnJheSwgZGVzY3Jp
YmluZyBob3cgbWFueSBlbGVtZW50cw0KLSAqCQl3ZXJlIGFsbG9jYXRlZCBmb3IgZWFjaCBsYXll
cg0KLSAqIEBubGF5ZXJzOglOdW1iZXIgb2YgbGF5ZXJzIGF0IHRoZSBAbGF5ZXJzIGFycmF5DQot
ICogQGxheWVyMDoJbGF5ZXIwIHBvc2l0aW9uDQotICogQGxheWVyMToJbGF5ZXIxIHBvc2l0aW9u
LiBVbnVzZWQgaWYgbl9sYXllcnMgPCAyDQotICogQGxheWVyMjoJbGF5ZXIyIHBvc2l0aW9uLiBV
bnVzZWQgaWYgbl9sYXllcnMgPCAzDQotICoNCi0gKiBGb3IgMSBsYXllciwgdGhpcyBtYWNybyBy
ZXR1cm5zICJ2YXJbbGF5ZXIwXSAtIHZhciI7DQotICoNCi0gKiBGb3IgMiBsYXllcnMsIHRoaXMg
bWFjcm8gaXMgc2ltaWxhciB0byBhbGxvY2F0ZSBhIGJpLWRpbWVuc2lvbmFsIGFycmF5DQotICog
YW5kIHRvIHJldHVybiAidmFyW2xheWVyMF1bbGF5ZXIxXSAtIHZhciI7DQotICoNCi0gKiBGb3Ig
MyBsYXllcnMsIHRoaXMgbWFjcm8gaXMgc2ltaWxhciB0byBhbGxvY2F0ZSBhIHRyaS1kaW1lbnNp
b25hbCBhcnJheQ0KLSAqIGFuZCB0byByZXR1cm4gInZhcltsYXllcjBdW2xheWVyMV1bbGF5ZXIy
XSAtIHZhciIuDQotICoNCi0gKiBBIGxvb3AgY291bGQgYmUgdXNlZCBoZXJlIHRvIG1ha2UgaXQg
bW9yZSBnZW5lcmljLCBidXQsIGFzIHdlIG9ubHkgaGF2ZQ0KLSAqIDMgbGF5ZXJzLCB0aGlzIGlz
IGEgbGl0dGxlIGZhc3Rlci4NCi0gKg0KLSAqIEJ5IGRlc2lnbiwgbGF5ZXJzIGNhbiBuZXZlciBi
ZSAwIG9yIG1vcmUgdGhhbiAzLiBJZiB0aGF0IGV2ZXIgaGFwcGVucywNCi0gKiBhIE5VTEwgaXMg
cmV0dXJuZWQsIGNhdXNpbmcgYW4gT09QUyBkdXJpbmcgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIHJv
dXRpbmUsDQotICogd2l0aCB3b3VsZCBwb2ludCB0byB0aGUgZGV2ZWxvcGVyIHRoYXQgaGUncyBk
b2luZyBzb21ldGhpbmcgd3JvbmcuDQotICovDQotI2RlZmluZSBFREFDX0RJTU1fT0ZGKGxheWVy
cywgbmxheWVycywgbGF5ZXIwLCBsYXllcjEsIGxheWVyMikgKHsJCVwNCi0JaW50IF9faTsJCQkJ
CQkJXA0KLQlpZiAoKG5sYXllcnMpID09IDEpCQkJCQkJXA0KLQkJX19pID0gbGF5ZXIwOwkJCQkJ
CVwNCi0JZWxzZSBpZiAoKG5sYXllcnMpID09IDIpCQkJCQlcDQotCQlfX2kgPSAobGF5ZXIxKSAr
ICgobGF5ZXJzWzFdKS5zaXplICogKGxheWVyMCkpOwkJXA0KLQllbHNlIGlmICgobmxheWVycykg
PT0gMykJCQkJCVwNCi0JCV9faSA9IChsYXllcjIpICsgKChsYXllcnNbMl0pLnNpemUgKiAoKGxh
eWVyMSkgKwlcDQotCQkJICAgICgobGF5ZXJzWzFdKS5zaXplICogKGxheWVyMCkpKSk7CQlcDQot
CWVsc2UJCQkJCQkJCVwNCi0JCV9faSA9IC1FSU5WQUw7CQkJCQkJXA0KLQlfX2k7CQkJCQkJCQlc
DQotfSkNCi0NCiBzdHJ1Y3QgZGltbV9pbmZvIHsNCiAJc3RydWN0IGRldmljZSBkZXY7DQogDQot
LSANCjIuMjAuMQ0KDQo=
