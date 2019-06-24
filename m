Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7E50FDA
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfFXPKK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:10:10 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51100 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730741AbfFXPJm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:42 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8Chr025865;
        Mon, 24 Jun 2019 08:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=9p112X5vlP5tM0VhbyYF8Z0EJbyNYhiz5vn1s8E3Loo=;
 b=pDf1lpmLe+6rWNvk1OROhCjMH62NX6DIMK5aOrVy89578R8rT46e6BLoSRKh5IgJ9Srt
 C3djJHqkdqZ6Y/pgsyzqNOY9AwujdlaRkb6GJmaloDhP4pV699hABUwq+PGSKXIhQ7mB
 EZy7qGUgelt6HpnQh3bqa4YGKEEYf+oyH91jc0yUsE04cPryebJmp9vZHEwH0IH1tTB1
 iE0rfnJZ16KyluhGSpLlSJVZk+X8qSgmjL39y4tGwQGnLMFoslQRTibRgSJbevOEMp54
 3wt4mj6OxWf2e6oMW5hKCwT7qOJw9guuUEkqDXoOvMzqieESUeLpDbK+a27otnrPPEzj WQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:36 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:35 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p112X5vlP5tM0VhbyYF8Z0EJbyNYhiz5vn1s8E3Loo=;
 b=djqqRsjd7y3lER55mqP4QWzUpr9J4dSPfMg1BLiBOe8Yb+CB/U5hHGnm6G5fQpi9HiwQSwhcQV9aao9IoGz8GschdmHyL8GsQlmV+BQca2yH5jz/vSuXq7Dts07dHfPlvS9dMrZwP52Jkh9Lkzl0SS/Ql4OiitzaysIdOij+qeA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2589.namprd18.prod.outlook.com (20.179.82.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:09:34 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:34 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 19/24] EDAC, mc: Introduce edac_mc_alloc_by_dimm() for per
 dimm allocation
Thread-Topic: [PATCH v2 19/24] EDAC, mc: Introduce edac_mc_alloc_by_dimm() for
 per dimm allocation
Thread-Index: AQHVKp7UctlFYfkY5E6kkBd7Mn0FtQ==
Date:   Mon, 24 Jun 2019 15:09:33 +0000
Message-ID: <20190624150758.6695-20-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: b66c438e-07ad-4954-e3da-08d6f8b5f70d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2589;
x-ms-traffictypediagnostic: MN2PR18MB2589:
x-microsoft-antispam-prvs: <MN2PR18MB2589BDDE9C9B9C613EC5F511D9E00@MN2PR18MB2589.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(2906002)(2616005)(486006)(476003)(52116002)(14444005)(256004)(5660300002)(66446008)(73956011)(66946007)(1076003)(14454004)(6116002)(86362001)(3846002)(99286004)(6486002)(68736007)(81166006)(81156014)(6436002)(4326008)(305945005)(50226002)(53936002)(7736002)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(6512007)(107886003)(71190400001)(71200400001)(36756003)(26005)(102836004)(386003)(186003)(11346002)(76176011)(6506007)(110136005)(316002)(54906003)(446003)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2589;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4qlKn9DnbpIHx+bdG+86QbFKBdcQLvGZHupBT8CTbcISGaRXqPUgrmbeNlwgcOsb4Aanqm8OasMxHSMkBzX5/OtEjRZYI31Njs337mzgpdPkjASNlIO1x2wJrKqAmba1y68Ghd09rV7TZSJ7DkJ6n+STWZ6XQF+YorpGNgn0oi/O++6TRoy7y79SKTtc3BFLJWobQTQP5dvDn+XIQtvLDlU61ZCFAIf7A/grpOL6E+SaTduEHy9l4Ym7xuP35+hNQl+/i8Cmav4DdJxc0SsCyAbUTfudcJhpMI8ZkIyX3jxs/HW0yKFeoVsGXD+yqIQFGoZ2dHgjjkL1gfGmznBdXc/V6W/3kvYdoAtnK4ufFRHlCtq5NbDulhQ54yYeDSMczlOE6bkVMl6pp27PnDrHOzzMoFGwAS4Qm6DwFh+gaMQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b66c438e-07ad-4954-e3da-08d6f8b5f70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:34.0783
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

U3lzdGVtcyB1c2luZyBBQ1BJIEdIRVMgZm9yIGVycm9yIGRldGVjdGlvbiBkbyBub3QgaGF2ZSBl
eGFjdA0Ka25vd2xlZGdlIG9mIHRoZSBtZW1vcnkgaGllcmFyY2h5LiBDb21wYXJlZCB0byBvdGhl
ciBtZW1vcnkgY29udHJvbGxlcg0KZHJpdmVycyB0aGUgdG90YWwgc2l6ZSBvZiBlYWNoIGxheWVy
IGlzIHVua25vd24gKGNhcmQvbW9kdWxlLA0KY2hhbm5lbC9zbG90LCBldGMuKS4gQnV0IHRoZXJl
IGlzIHRoZSB0b3RhbCBudW1iZXIgb2YgZGltbXMuIFNvIGFkZCBhDQpmdW5jdGlvbiB0byBhbGxv
Y2F0ZSBhbiBtYyBkZXZpY2UgdGhpcyB3YXkuIFRoZSBlZGFjJ3MgZHJpdmVyIHVzZXMNCmludGVy
bmFsbHkgYSBkaW1tIGluZGV4IGFscmVhZHkgZm9yIGRhdGEgYWNjZXNzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJz
L2VkYWMvZWRhY19tYy5jICAgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWMuaCAgIHwgMTcgKysrKysrLS0NCiBkcml2ZXJz
L2VkYWMvZ2hlc19lZGFjLmMgfCAgNyArKy0tDQogMyBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRp
b25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFj
X21jLmMgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQppbmRleCBlZWEwOWM2YWNkM2UuLjNhNDA0
OTZhMTk3MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCisrKyBiL2RyaXZl
cnMvZWRhYy9lZGFjX21jLmMNCkBAIC0zMDMsMTAgKzMwMywxMSBAQCBzdGF0aWMgdm9pZCBfZWRh
Y19tY19mcmVlKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCiAJa2ZyZWUobWNpKTsNCiB9DQog
DQotc3RydWN0IG1lbV9jdGxfaW5mbyAqZWRhY19tY19hbGxvYyh1bnNpZ25lZCBtY19udW0sDQot
CQkJCSAgIHVuc2lnbmVkIG5fbGF5ZXJzLA0KLQkJCQkgICBzdHJ1Y3QgZWRhY19tY19sYXllciAq
bGF5ZXJzLA0KLQkJCQkgICB1bnNpZ25lZCBzel9wdnQpDQorc3RydWN0IG1lbV9jdGxfaW5mbyAq
X19lZGFjX21jX2FsbG9jKHVuc2lnbmVkIG1jX251bSwNCisJCQkJdW5zaWduZWQgZGltbV9udW0s
DQorCQkJCXVuc2lnbmVkIG5fbGF5ZXJzLA0KKwkJCQlzdHJ1Y3QgZWRhY19tY19sYXllciAqbGF5
ZXJzLA0KKwkJCQl1bnNpZ25lZCBzel9wdnQpDQogew0KIAlzdHJ1Y3QgbWVtX2N0bF9pbmZvICpt
Y2k7DQogCXN0cnVjdCBlZGFjX21jX2xheWVyICpsYXllcjsNCkBAIC0zMjEsNiArMzIyLDcgQEAg
c3RydWN0IG1lbV9jdGxfaW5mbyAqZWRhY19tY19hbGxvYyh1bnNpZ25lZCBtY19udW0sDQogCWJv
b2wgcGVyX3JhbmsgPSBmYWxzZTsNCiANCiAJQlVHX09OKG5fbGF5ZXJzID4gRURBQ19NQVhfTEFZ
RVJTIHx8IG5fbGF5ZXJzID09IDApOw0KKw0KIAkvKg0KIAkgKiBDYWxjdWxhdGUgdGhlIHRvdGFs
IGFtb3VudCBvZiBkaW1tcyBhbmQgY3Nyb3dzL2NzY2hhbm5lbHMgd2hpbGUNCiAJICogaW4gdGhl
IG9sZCBBUEkgZW11bGF0aW9uIG1vZGUNCkBAIC0zMzYsNiArMzM4LDI2IEBAIHN0cnVjdCBtZW1f
Y3RsX2luZm8gKmVkYWNfbWNfYWxsb2ModW5zaWduZWQgbWNfbnVtLA0KIAkJCXBlcl9yYW5rID0g
dHJ1ZTsNCiAJfQ0KIA0KKwkvKiBhbGxvY2F0ZSBkaW1tX251bSBESU1NUywgbGF5ZXIgc2l6ZSBt
dXN0IGJlIHplcm8gKi8NCisJaWYgKGRpbW1fbnVtKSB7DQorCQlpZiAoZGltbV9udW0gPD0gMCB8
fA0KKwkJCWxheWVyc1swXS5zaXplIHx8DQorCQkJKG5fbGF5ZXJzID4gMSAmJiBsYXllcnNbMV0u
c2l6ZSkgfHwNCisJCQkobl9sYXllcnMgPiAyICYmIGxheWVyc1syXS5zaXplKSkgew0KKwkJCWVk
YWNfcHJpbnRrKEtFUk5fV0FSTklORywgRURBQ19NQywNCisJCQkJImludmFsaWQgbGF5ZXIgZGF0
YVxuIik7DQorCQkJcmV0dXJuIE5VTEw7DQorCQl9DQorDQorCQkvKg0KKwkJICogQXNzdW1lIDEg
Y3Nyb3cgcGVyIGRpbW0gd2hpY2ggYWxzbyBtZWFucyAxIGNoYW5uZWwNCisJCSAqIHBlciBjc3Jv
dy4NCisJCSAqLw0KKwkJdG90X2RpbW1zCT0gZGltbV9udW07DQorCQl0b3RfY3Nyb3dzCT0gZGlt
bV9udW07DQorCQl0b3RfY2hhbm5lbHMJPSAxOw0KKwl9DQorDQogCS8qIEZpZ3VyZSBvdXQgdGhl
IG9mZnNldHMgb2YgdGhlIHZhcmlvdXMgaXRlbXMgZnJvbSB0aGUgc3RhcnQgb2YgYW4gbWMNCiAJ
ICogc3RydWN0dXJlLiAgV2Ugd2FudCB0aGUgYWxpZ25tZW50IG9mIGVhY2ggaXRlbSB0byBiZSBh
dCBsZWFzdCBhcw0KIAkgKiBzdHJpbmdlbnQgYXMgd2hhdCB0aGUgY29tcGlsZXIgd291bGQgcHJv
dmlkZSBpZiB3ZSBjb3VsZCBzaW1wbHkNCkBAIC00MjIsMjUgKzQ0NCwxMCBAQCBzdHJ1Y3QgbWVt
X2N0bF9pbmZvICplZGFjX21jX2FsbG9jKHVuc2lnbmVkIG1jX251bSwNCiAJCWRpbW0tPm1jaSA9
IG1jaTsNCiAJCWRpbW0tPmlkeCA9IGlkeDsNCiANCi0JCS8qDQotCQkgKiBDb3B5IERJTU0gbG9j
YXRpb24gYW5kIGluaXRpYWxpemUgaXQuDQotCQkgKi8NCi0JCWxlbiA9IHNpemVvZihkaW1tLT5s
YWJlbCk7DQotCQlwID0gZGltbS0+bGFiZWw7DQotCQluID0gc25wcmludGYocCwgbGVuLCAibWMj
JXUiLCBtY19udW0pOw0KLQkJcCArPSBuOw0KLQkJbGVuIC09IG47DQotCQlmb3IgKGogPSAwOyBq
IDwgbl9sYXllcnM7IGorKykgew0KLQkJCW4gPSBzbnByaW50ZihwLCBsZW4sICIlcyMldSIsDQot
CQkJCSAgICAgZWRhY19sYXllcl9uYW1lW2xheWVyc1tqXS50eXBlXSwNCi0JCQkJICAgICBwb3Nb
al0pOw0KLQkJCXAgKz0gbjsNCi0JCQlsZW4gLT0gbjsNCi0JCQlkaW1tLT5sb2NhdGlvbltqXSA9
IHBvc1tqXTsNCi0NCi0JCQlpZiAobGVuIDw9IDApDQotCQkJCWJyZWFrOw0KLQkJfQ0KKwkJLyog
dW5rbm93biBsb2NhdGlvbiAqLw0KKwkJZGltbS0+bG9jYXRpb25bMF0gPSAtMTsNCisJCWRpbW0t
PmxvY2F0aW9uWzFdID0gLTE7DQorCQlkaW1tLT5sb2NhdGlvblsyXSA9IC0xOw0KIA0KIAkJLyog
TGluayBpdCB0byB0aGUgY3Nyb3dzIG9sZCBBUEkgZGF0YSAqLw0KIAkJY2hhbi0+ZGltbSA9IGRp
bW07DQpAQCAtNDYyLDYgKzQ2OSwzNCBAQCBzdHJ1Y3QgbWVtX2N0bF9pbmZvICplZGFjX21jX2Fs
bG9jKHVuc2lnbmVkIG1jX251bSwNCiAJCQl9DQogCQl9DQogDQorCQkvKg0KKwkJICogQ29weSBE
SU1NIGxvY2F0aW9uIGFuZCBpbml0aWFsaXplIGl0Lg0KKwkJICovDQorCQlsZW4gPSBzaXplb2Yo
ZGltbS0+bGFiZWwpOw0KKwkJcCA9IGRpbW0tPmxhYmVsOw0KKwkJbiA9IHNucHJpbnRmKHAsIGxl
biwgIm1jIyV1IiwgbWNfbnVtKTsNCisJCXAgKz0gbjsNCisJCWxlbiAtPSBuOw0KKw0KKwkJaWYg
KGRpbW1fbnVtKSB7DQorCQkJbiA9IHNucHJpbnRmKHAsIGxlbiwgImRpbW0jJXUiLCBpZHgpOw0K
KwkJCXAgKz0gbjsNCisJCQlsZW4gLT0gbjsNCisJCQljb250aW51ZTsNCisJCX0NCisNCisJCWZv
ciAoaiA9IDA7IGogPCBuX2xheWVyczsgaisrKSB7DQorCQkJbiA9IHNucHJpbnRmKHAsIGxlbiwg
IiVzIyV1IiwNCisJCQkJICAgICBlZGFjX2xheWVyX25hbWVbbGF5ZXJzW2pdLnR5cGVdLA0KKwkJ
CQkgICAgIHBvc1tqXSk7DQorCQkJcCArPSBuOw0KKwkJCWxlbiAtPSBuOw0KKwkJCWRpbW0tPmxv
Y2F0aW9uW2pdID0gcG9zW2pdOw0KKw0KKwkJCWlmIChsZW4gPD0gMCkNCisJCQkJYnJlYWs7DQor
CQl9DQorDQogCQkvKiBJbmNyZW1lbnQgZGltbSBsb2NhdGlvbiAqLw0KIAkJZm9yIChqID0gbl9s
YXllcnMgLSAxOyBqID49IDA7IGotLSkgew0KIAkJCXBvc1tqXSsrOw0KQEAgLTQ4MCw3ICs1MTUs
NyBAQCBzdHJ1Y3QgbWVtX2N0bF9pbmZvICplZGFjX21jX2FsbG9jKHVuc2lnbmVkIG1jX251bSwN
CiANCiAJcmV0dXJuIE5VTEw7DQogfQ0KLUVYUE9SVF9TWU1CT0xfR1BMKGVkYWNfbWNfYWxsb2Mp
Ow0KK0VYUE9SVF9TWU1CT0xfR1BMKF9fZWRhY19tY19hbGxvYyk7DQogDQogdm9pZCBlZGFjX21j
X2ZyZWUoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKQ0KIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2VkYWMvZWRhY19tYy5oIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuaA0KaW5kZXggYzRkZGQ1YzFl
MjRjLi5lODIxNTg0N2Y4NTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQor
KysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQpAQCAtOTksNiArOTksMTAgQEAgZG8gewkJCQkJ
CQkJCVwNCiAgKiBlZGFjX21jX2FsbG9jKCkgLSBBbGxvY2F0ZSBhbmQgcGFydGlhbGx5IGZpbGwg
YSBzdHJ1Y3QgJm1lbV9jdGxfaW5mby4NCiAgKg0KICAqIEBtY19udW06CQlNZW1vcnkgY29udHJv
bGxlciBudW1iZXINCisgKiBAZGltbV9udW06CQlOdW1iZXIgb2YgRElNTXMgdG8gYWxsb2NhdGUu
IElmIG5vbi16ZXJvIHRoZQ0KKyAqCQkJQGxheWVycycgc2l6ZSBwYXJhbWV0ZXIgbXVzdCBiZSB6
ZXJvLiBVc2VmdWwNCisgKgkJCWlmIHRoZSBNQyBoaWVyYXJjaHkgaXMgdW5rbm93biBidXQgdGhl
IG51bWJlcg0KKyAqCQkJb2YgRElNTXMgaXMga25vd24uDQogICogQG5fbGF5ZXJzOgkJTnVtYmVy
IG9mIE1DIGhpZXJhcmNoeSBsYXllcnMNCiAgKiBAbGF5ZXJzOgkJRGVzY3JpYmVzIGVhY2ggbGF5
ZXIgYXMgc2VlbiBieSB0aGUgTWVtb3J5IENvbnRyb2xsZXINCiAgKiBAc3pfcHZ0OgkJc2l6ZSBv
ZiBwcml2YXRlIHN0b3JhZ2UgbmVlZGVkDQpAQCAtMTIyLDEwICsxMjYsMTUgQEAgZG8gewkJCQkJ
CQkJCVwNCiAgKglPbiBzdWNjZXNzLCByZXR1cm4gYSBwb2ludGVyIHRvIHN0cnVjdCBtZW1fY3Rs
X2luZm8gcG9pbnRlcjsNCiAgKgklTlVMTCBvdGhlcndpc2UNCiAgKi8NCi1zdHJ1Y3QgbWVtX2N0
bF9pbmZvICplZGFjX21jX2FsbG9jKHVuc2lnbmVkIG1jX251bSwNCi0JCQkJICAgdW5zaWduZWQg
bl9sYXllcnMsDQotCQkJCSAgIHN0cnVjdCBlZGFjX21jX2xheWVyICpsYXllcnMsDQotCQkJCSAg
IHVuc2lnbmVkIHN6X3B2dCk7DQorc3RydWN0IG1lbV9jdGxfaW5mbyAqX19lZGFjX21jX2FsbG9j
KHVuc2lnbmVkIG1jX251bSwNCisJCQkJdW5zaWduZWQgZGltbV9udW0sDQorCQkJCXVuc2lnbmVk
IG5fbGF5ZXJzLA0KKwkJCQlzdHJ1Y3QgZWRhY19tY19sYXllciAqbGF5ZXJzLA0KKwkJCQl1bnNp
Z25lZCBzel9wdnQpOw0KKyNkZWZpbmUgZWRhY19tY19hbGxvYyhtY19udW0sIG5fbGF5ZXJzLCBs
YXllcnMsIHN6X3B2dCkgXA0KKwlfX2VkYWNfbWNfYWxsb2MobWNfbnVtLCAwLCBuX2xheWVycywg
bGF5ZXJzLCBzel9wdnQpDQorI2RlZmluZSBlZGFjX21jX2FsbG9jX2J5X2RpbW0obWNfbnVtLCBk
aW1tX251bSwgbl9sYXllcnMsIGxheWVycywgc3pfcHZ0KSBcDQorCV9fZWRhY19tY19hbGxvYyht
Y19udW0sIGRpbW1fbnVtLCBuX2xheWVycywgbGF5ZXJzLCBzel9wdnQpDQogDQogLyoqDQogICog
ZWRhY19nZXRfb3duZXIgLSBSZXR1cm4gdGhlIG93bmVyJ3MgbW9kX25hbWUgb2YgRURBQyBNQw0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9naGVz
X2VkYWMuYw0KaW5kZXggOWMzNDk1ZjczNjViLi45N2Y5OTIwMDYyODEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0K
QEAgLTcwMiwxMSArNzAyLDEyIEBAIGdoZXNfZWRhY19yZWdpc3Rlcl9vbmUoaW50IG5pZCwgc3Ry
dWN0IGdoZXMgKmdoZXMsIHN0cnVjdCBkZXZpY2UgKnBhcmVudCkNCiAJc3RydWN0IGVkYWNfbWNf
bGF5ZXIgbGF5ZXJzWzFdOw0KIA0KIAlsYXllcnNbMF0udHlwZSA9IEVEQUNfTUNfTEFZRVJfQUxM
X01FTTsNCi0JbGF5ZXJzWzBdLnNpemUgPSBtZW1faW5mby5kaW1tc19wZXJfbm9kZVtuaWRdOw0K
KwlsYXllcnNbMF0uc2l6ZSA9IDA7DQogCWxheWVyc1swXS5pc192aXJ0X2Nzcm93ID0gdHJ1ZTsN
CiANCi0JbWNpID0gZWRhY19tY19hbGxvYyhuaWQsIEFSUkFZX1NJWkUobGF5ZXJzKSwgbGF5ZXJz
LA0KLQkJCXNpemVvZihzdHJ1Y3QgZ2hlc19lZGFjX3B2dCkpOw0KKwltY2kgPSBlZGFjX21jX2Fs
bG9jX2J5X2RpbW0obmlkLCBtZW1faW5mby5kaW1tc19wZXJfbm9kZVtuaWRdLA0KKwkJCQlBUlJB
WV9TSVpFKGxheWVycyksIGxheWVycywNCisJCQkJc2l6ZW9mKHN0cnVjdCBnaGVzX2VkYWNfcHZ0
KSk7DQogCWlmICghbWNpKSB7DQogCQlwcl9lcnIoIkNhbid0IGFsbG9jYXRlIG1lbW9yeSBmb3Ig
RURBQyBkYXRhXG4iKTsNCiAJCXJldHVybiAtRU5PTUVNOw0KLS0gDQoyLjIwLjENCg0K
