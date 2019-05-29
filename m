Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D58A2D810
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfE2IpA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:45:00 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35588 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726909AbfE2Io7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:59 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8imwM026181;
        Wed, 29 May 2019 01:44:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=P032/2mUDARC0KfBoQ1xOYrSE/a7RwcAnyqNMZPCrIY=;
 b=KjFFaJFJxYNzlkdthsaEfTTi6vTYNkolODC9oaQi28y967jaIzP9QFKhZVmDyWy99fmU
 XmDBwVFh3fd3ugmQ9BbgY04Gr0kCgV1S9CGMhd4bURZfOyVmSGC/JWGR/aZKdoU1ZCMn
 jnOmX00K3F3gfN8qNQLLOR/w2gNmm8WNG9FdilDBidAb3CL//c9Jl17+zoPFhl1VZxiw
 FMW+klrwZLoawxfv+ZdmoXkYfUsKG1z0mc5k1g1WfiY02CMjJZpLXf+xi9KZJf0ywjTc
 HN/8vxzcN/bpBYPpy2lUmvujRfHCQHleH22a6Z9/9QQfqH3boDgxX8oxc/cK9k7hKEGc SA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1r8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:48 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:47 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P032/2mUDARC0KfBoQ1xOYrSE/a7RwcAnyqNMZPCrIY=;
 b=MHkT7WyIqLyGNAIg5ahCrbvBi/Hojyrl8xOwTzhHJRyJQ+9/Pob/35fl2YaRzJbltHsCWjMZGhIS3pcxwgjIyfZSDUS0m1MNZqcK95riCB5NZ1MgvdVPzTML6incIxKWiVTF1gsXzzNzPvejiLdqTFtZb9y4M9hEXFdSBqWVRLQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:43 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:43 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 18/21] EDAC, mc: Introduce edac_mc_alloc_by_dimm() for per
 dimm allocation
Thread-Topic: [PATCH 18/21] EDAC, mc: Introduce edac_mc_alloc_by_dimm() for
 per dimm allocation
Thread-Index: AQHVFfrDZJ6YG32qm0SpPdrScZiSnA==
Date:   Wed, 29 May 2019 08:44:43 +0000
Message-ID: <20190529084344.28562-19-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e9fc6991-fcdb-46fd-175d-08d6e411e549
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB343783A81BA085D9C8F8D2C0D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4eFJV1NmeYJh3JB7D9RgSophtSjiiaAAjusBxfBz5EhlCAYp176DvG1LN1eCsxFmdS1/abcge4XYFn4a+Hz2RHRqcQpjHR4AYIFrRG5MkiF3wA0PioQ24eoc6GmyIUqF+DcFQ29cA5YwkQgpkAv8rfyF2AtIsBc6MmJNqdIgGfRywmVFeNKvPRpzzluY1KvsqrSDLTXDAwXO/9JLa5K1WVBQvYu1xTAY94tLyWqmpVb2rYrK89fTtu/SlGBALgf7/+cXzxRfLnRGF0L1O4W23Abn7p8laKIoc23VzAMI0XsNvPryGEBZYCzOggei7824N01rqGjxnyyAkugdG3jjine88o6OUHQ1qX8cznM7Cs7tH8HuRVnOpsAZFPtCnXXrj86dEj9Mr6kMKenezjRaIjpGJS38KQDdbEPCjYVhXbY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fc6991-fcdb-46fd-175d-08d6e411e549
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:43.5135
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
X21jLmMgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQppbmRleCBmN2U2YTc1MWYzMDkuLmJkZWI5
ZmQwODI0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCisrKyBiL2RyaXZl
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
X2VkYWMuYw0KaW5kZXggYjg4NzhmZjQ5OGQxLi40YmFjNjQzZDM0MDQgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0K
QEAgLTcwNywxMSArNzA3LDEyIEBAIGdoZXNfZWRhY19yZWdpc3Rlcl9vbmUoaW50IG5pZCwgc3Ry
dWN0IGdoZXMgKmdoZXMsIHN0cnVjdCBkZXZpY2UgKnBhcmVudCkNCiAJc3RydWN0IGVkYWNfbWNf
bGF5ZXIgbGF5ZXJzWzFdOw0KIA0KIAlsYXllcnNbMF0udHlwZSA9IEVEQUNfTUNfTEFZRVJfQUxM
X01FTTsNCi0JbGF5ZXJzWzBdLnNpemUgPSBtZW1faW5mby5udW1fcGVyX25vZGVbbmlkXTsNCisJ
bGF5ZXJzWzBdLnNpemUgPSAwOw0KIAlsYXllcnNbMF0uaXNfdmlydF9jc3JvdyA9IHRydWU7DQog
DQotCW1jaSA9IGVkYWNfbWNfYWxsb2MobmlkLCBBUlJBWV9TSVpFKGxheWVycyksIGxheWVycywN
Ci0JCQlzaXplb2Yoc3RydWN0IGdoZXNfZWRhY19wdnQpKTsNCisJbWNpID0gZWRhY19tY19hbGxv
Y19ieV9kaW1tKG5pZCwgbWVtX2luZm8ubnVtX3Blcl9ub2RlW25pZF0sDQorCQkJCUFSUkFZX1NJ
WkUobGF5ZXJzKSwgbGF5ZXJzLA0KKwkJCQlzaXplb2Yoc3RydWN0IGdoZXNfZWRhY19wdnQpKTsN
CiAJaWYgKCFtY2kpIHsNCiAJCXByX2VycigiQ2FuJ3QgYWxsb2NhdGUgbWVtb3J5IGZvciBFREFD
IGRhdGFcbiIpOw0KIAkJcmV0dXJuIC1FTk9NRU07DQotLSANCjIuMjAuMQ0KDQo=
