Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B229050FBC
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfFXPJJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62614 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730309AbfFXPJI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:08 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF053e018453;
        Mon, 24 Jun 2019 08:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=6/A5zqX04PLpyB5bKH4TTNu46QmN6tpzA0tBihV9SZc=;
 b=R3cFoapQluu9/y7C66MCYJ/CPBU6RCu5vy0r8QXVeeZi9kq8CgJBCnRwaXsTghWD/lUz
 WQwxMH8sTPnOYnHT0uk0Xw14xq+gEV8AWzJvAEULTzulqDs92HWlffk+5RAEqoj7iTCZ
 joM0s0eh18xqtu5p37mLHHRU1FvXRXu7r1GsCURXOxt77uKfzQEaZiuqvl7OVgazpvs0
 7lR7Llklwbu0JplEwAffs+DxaEnNk4BLHO1aczTmhL69Bagi/77H1L+Dx4xILcTGzhvc
 8jLINZaLw0kuvAY+m606yz10hir9iqBnyYJB8wqjIkgoEMt47Jv0HXtsoF/8hmusdN7K BQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9t94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:08:59 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:08:58 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/A5zqX04PLpyB5bKH4TTNu46QmN6tpzA0tBihV9SZc=;
 b=Y2Pb7rntMAGdBB+PZGq7Z4Ln0y8QJwWZ97S4xWmuqiNTUBmTpGn0ntuD6Q/oykSnnzjz2pTL9HZzoRQqDtnvIGBvWgK7Ebo+sagifx9dm+jiNaA5MrIkWnL/jnrdAHa/iDonYuJL13dhWtiNnVYZuAfiUMM2pgQQawuyhsiUMuQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2589.namprd18.prod.outlook.com (20.179.82.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:08:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:08:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVKp6+pL7VEIGXA0Cki9BKQoDoyg==
Date:   Mon, 24 Jun 2019 15:08:57 +0000
Message-ID: <20190624150758.6695-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 5758b553-24b4-4664-22fd-08d6f8b5e11b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2589;
x-ms-traffictypediagnostic: MN2PR18MB2589:
x-microsoft-antispam-prvs: <MN2PR18MB25899EBB79CD21CD81624C5AD9E00@MN2PR18MB2589.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(2906002)(2616005)(486006)(476003)(52116002)(256004)(5660300002)(66446008)(73956011)(66946007)(1076003)(14454004)(6116002)(86362001)(3846002)(99286004)(6486002)(68736007)(81166006)(81156014)(6436002)(4326008)(305945005)(50226002)(53936002)(7736002)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(6512007)(107886003)(71190400001)(71200400001)(36756003)(26005)(102836004)(386003)(186003)(11346002)(76176011)(6506007)(110136005)(316002)(54906003)(446003)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2589;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tbo/VAI2B/p24PGKxYVgzIBKsL0E3YWUMNHVXZcpE7t3zb/KCapIvEMw1/Q3JfMpiDt/Xd6zvsQf8+VBNvRCS9wjP97aL0U2FRdl4yZiohCMFwPbb56xyZCJrYUsJwBY7h/UnjAdAqd1Zlfrp5ZfQtj+7JXnFp847T8fokQvRZ8CYbe0qW2DFYblRVQR9Ab5YYSXkz1rJjUPZWJY/sTOvi4eNXRivdq1+WxRPBfl6zhha2yKoLaM7c2+jf/0OF87CVbnN+HUEitzDvEuxyb0IAIzJkVsfhpzPRahRz2yN+l6rZnE5bFEC9erepDI0Xb64crmbvV8SedRnIWsAxQMBw0c5mHk8AvziEib7L8/Vm8RXPuubmRneLDVW7gtwgN560m7KnZ6hKLiDMgMft83lUcV6hmBOjddOBTWahPDmko=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5758b553-24b4-4664-22fd-08d6f8b5e11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:08:57.2322
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

VGhlIGNvbnZlcnNpb24gZnJvbSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBtYXNrIHRvIGEgZ3JhaW4g
KGRlZmluZWQgYXMNCmdyYW51bGFyaXR5IGluIGJ5dGVzKSBpcyBicm9rZW46DQoNCgllLT5ncmFp
biA9IH4obWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrICYgflBBR0VfTUFTSyk7DQoNCkUuZy4s
IGEgcGh5c2ljYWwgYWRkcmVzcyBtYXNrIG9mIH4weGZmZiBzaG91bGQgZ2l2ZSBhIGdyYWluIG9m
IDB4MTAwMCwNCmluc3RlYWQgdGhlIGdyYWluIGlzIHdyb25nIHdpdGggdGhlIHVwcGVyIGJpdHMg
YWx3YXlzIHNldC4gV2UgYWxzbw0KcmVtb3ZlIHRoZSBsaW1pdGF0aW9uIHRvIHRoZSBwYWdlIHNp
emUgYXMgdGhlIGdyYW51bGFyaXR5IGlzIHVucmVsYXRlZA0KdG8gdGhlIHBhZ2Ugc2l6ZSB1c2Vk
IGluIHRoZSBzeXN0ZW0uIFdlIGZpeCB0aGlzIHdpdGg6DQoNCgllLT5ncmFpbiA9IH5tZW1fZXJy
LT5waHlzaWNhbF9hZGRyX21hc2sgKyAxOw0KDQpOb3RlOiBXZSBuZWVkIHRvIGFkb3B0IHRoZSBn
cmFpbl9iaXRzIGNhbGN1bGF0aW9uIGFzIGUtPmdyYWluIGlzIG5vdyBhDQpwb3dlciBvZiAyIGFu
ZCBubyBsb25nZXIgYSBiaXQgbWFzay4gVGhlIGZvcm11bGEgaXMgbm93IHRoZSBzYW1lIGFzIGlu
DQplZGFjX21jIGFuZCBjYW4gbGF0ZXIgYmUgdW5pZmllZC4NCg0KU2lnbmVkLW9mZi1ieTogUm9i
ZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQG1hcnZlbGwuY29tPg0KLS0tDQogZHJpdmVycy9lZGFjL2do
ZXNfZWRhYy5jIHwgMTIgKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZ2hlc19l
ZGFjLmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4IDdmMTlmMWM2NzJjMy4uZDA5
NWQ5OGQ2YThkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQorKysgYi9k
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCkBAIC0yMjIsNiArMjIyLDcgQEAgdm9pZCBnaGVzX2Vk
YWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2VyciAqbWVt
X2VycikNCiAJLyogQ2xlYW5zIHRoZSBlcnJvciByZXBvcnQgYnVmZmVyICovDQogCW1lbXNldChl
LCAwLCBzaXplb2YgKCplKSk7DQogCWUtPmVycm9yX2NvdW50ID0gMTsNCisJZS0+Z3JhaW4gPSAx
Ow0KIAlzdHJjcHkoZS0+bGFiZWwsICJ1bmtub3duIGxhYmVsIik7DQogCWUtPm1zZyA9IHB2dC0+
bXNnOw0KIAllLT5vdGhlcl9kZXRhaWwgPSBwdnQtPm90aGVyX2RldGFpbDsNCkBAIC0zMTcsNyAr
MzE4LDcgQEAgdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3Qg
Y3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCiANCiAJLyogRXJyb3IgZ3JhaW4gKi8NCiAJaWYg
KG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1BBX01BU0spDQotCQll
LT5ncmFpbiA9IH4obWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrICYgflBBR0VfTUFTSyk7DQor
CQllLT5ncmFpbiA9IH5tZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2sgKyAxOw0KIA0KIAkvKiBN
ZW1vcnkgZXJyb3IgbG9jYXRpb24sIG1hcHBlZCBvbiBlLT5sb2NhdGlvbiAqLw0KIAlwID0gZS0+
bG9jYXRpb247DQpAQCAtNDMzLDggKzQzNCwxNSBAQCB2b2lkIGdoZXNfZWRhY19yZXBvcnRfbWVt
X2Vycm9yKGludCBzZXYsIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0KIAlpZiAo
cCA+IHB2dC0+b3RoZXJfZGV0YWlsKQ0KIAkJKihwIC0gMSkgPSAnXDAnOw0KIA0KKwkvKg0KKwkg
KiBXZSBleHBlY3QgdGhlIGh3IHRvIHJlcG9ydCBhIHJlYXNvbmFibGUgZ3JhaW4sIGZhbGxiYWNr
IHRvDQorCSAqIDEgYnl0ZSBncmFudWxhcml0eSBvdGhlcndpc2UuDQorCSAqLw0KKwlpZiAoV0FS
Tl9PTl9PTkNFKCFlLT5ncmFpbikpDQorCQllLT5ncmFpbiA9IDE7DQorCWdyYWluX2JpdHMgPSBm
bHNfbG9uZyhlLT5ncmFpbiAtIDEpOw0KKw0KIAkvKiBHZW5lcmF0ZSB0aGUgdHJhY2UgZXZlbnQg
Ki8NCi0JZ3JhaW5fYml0cyA9IGZsc19sb25nKGUtPmdyYWluKTsNCiAJc25wcmludGYocHZ0LT5k
ZXRhaWxfbG9jYXRpb24sIHNpemVvZihwdnQtPmRldGFpbF9sb2NhdGlvbiksDQogCQkgIkFQRUkg
bG9jYXRpb246ICVzICVzIiwgZS0+bG9jYXRpb24sIGUtPm90aGVyX2RldGFpbCk7DQogCXRyYWNl
X21jX2V2ZW50KHR5cGUsIGUtPm1zZywgZS0+bGFiZWwsIGUtPmVycm9yX2NvdW50LA0KLS0gDQoy
LjIwLjENCg0K
