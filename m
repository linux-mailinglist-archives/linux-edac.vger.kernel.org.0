Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BE50FE6
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfFXPJa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62956 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730576AbfFXPJa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8CWP025874;
        Mon, 24 Jun 2019 08:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=xm2a27qAk/BaWT78UTBGSNLc+nJGfzMzTPzfeO+4NU4=;
 b=g992ynDvCaIzK0jsrx3ivFvBnzSUA6wGzdO++xP4VN0hEJm+HJIz29z6rpU+M23B7UrQ
 p693Vd3ug5tc0sC3oudlaQjkq21AiqdfHicUnzI9Im8/swEld/duXCekekBkeFqfOc10
 Odo1dpgDh6MrvfSnHaHaFi2P0DXRf8LBbLuX9XAfBjQ5Unc8jz2i1iya9UpjcK4DntQC
 2amKkxmynNlNx0mx+MiOlb5cS916FkmaIzOH0emyPPtOdyBkfMWm6m12V+lXUsYSu0IM
 7TfFov2pCNWuE+onK6egKahkG3ceIubcuhT9etx/fIQWelTpplx0tfNVEmJXiycMTZOt ZQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7t7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:24 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:23 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm2a27qAk/BaWT78UTBGSNLc+nJGfzMzTPzfeO+4NU4=;
 b=QR8gYiHCJ/CuGI8uCeqzZXZTkMsDlZSWxoZXi+W/yPotRwKg0p1/ArOzMR18jU8JIYUpYiVXIxjdezJrY7dtWDIY7a6/36xUjWqlxijWyNbm/5nvuj5oBTJ4BPSiL181hkGhE9yCl31RnuAdTgJn4LNrFPTZpLre96PjgdmR22Q=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:22 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:22 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 13/24] EDAC, ghes: Add support for legacy API counters
Thread-Topic: [PATCH v2 13/24] EDAC, ghes: Add support for legacy API counters
Thread-Index: AQHVKp7NCU80sqh790Onv0iU1Olm1Q==
Date:   Mon, 24 Jun 2019 15:09:22 +0000
Message-ID: <20190624150758.6695-14-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: bbf0ae92-7722-4e57-ab32-08d6f8b5eff6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB3197C4BA7046791AC993124AD9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4IpL94XpVy4zbOSbo1UveI0rsSP8Mbi090fbyIcNW4xPi1wOwwdlTmF+E33+cX3z3uHuAGoWkniRFBAaV+zrh0Iw6OY5R4TpvGnF7R2T0wv5vjW1SdRhbcpHq82zlmJGc2RsTSx5Ci8Y6bWwHIllatEv2mXzug5xdGdLliZzFnfIIRF38+DAibJTXtYC3mP6oHgoXxju3TeEHwwdC8uEkPjLmQFtNgxdVRSssiAZ+B646g1tqCEn6bv92JOup0tM+IRGibjosmSBVcZ02KhWWB0CR2G4cJqyaMIbqICkcFSDhweXgB7i6Ft1eG2EtxhFE42KXnTmRxT/7Rs/jDhvUQ6BuxAdcMyjxadWvHxElSoxawC3fzT0AMdVE0ld4eV6S9TXwFNa+ldFso7OHYOeQkoeMXxMmpHV4Giiw0sbW0k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf0ae92-7722-4e57-ab32-08d6f8b5eff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:22.0931
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

VGhlIGdoZXMgZHJpdmVyIGlzIG5vdCBhYmxlIHlldCB0byBjb3VudCBsZWdhY3kgQVBJIGNvdW50
ZXJzIGluIHN5c2ZzLA0KZS5nLjoNCg0KIC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAv
Y3Nyb3cyL2NlX2NvdW50DQogL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9jc3JvdzIv
Y2gwX2NlX2NvdW50DQogL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9jc3JvdzIvY2gx
X2NlX2NvdW50DQoNCk1ha2UgY291bnRpbmcgY3Nyb3dzL2NoYW5uZWxzIGdlbmVyaWMgc28gdGhh
dCB0aGUgZ2hlcyBkcml2ZXIgY2FuIHVzZQ0KaXQgdG9vLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2Jl
cnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRh
Y19tYy5jICAgfCAzOCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KIGRy
aXZlcnMvZWRhYy9lZGFjX21jLmggICB8ICA3ICsrKysrKy0NCiBkcml2ZXJzL2VkYWMvZ2hlc19l
ZGFjLmMgfCAgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTkgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5jIGIvZHJpdmVy
cy9lZGFjL2VkYWNfbWMuYw0KaW5kZXggYThkNDQ3MWUyMzhjLi5lZWEwOWM2YWNkM2UgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19t
Yy5jDQpAQCAtMTAwNyw3ICsxMDA3LDggQEAgc3RhdGljIHZvaWQgZWRhY191ZV9lcnJvcihzdHJ1
Y3QgbWVtX2N0bF9pbmZvICptY2ksDQogdm9pZCBlZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IoY29u
c3QgZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIAkJCSAgICAgIHN0cnVjdCBtZW1f
Y3RsX2luZm8gKm1jaSwNCiAJCQkgICAgICBzdHJ1Y3QgZGltbV9pbmZvICpkaW1tLA0KLQkJCSAg
ICAgIHN0cnVjdCBlZGFjX3Jhd19lcnJvcl9kZXNjICplKQ0KKwkJCSAgICAgIHN0cnVjdCBlZGFj
X3Jhd19lcnJvcl9kZXNjICplLA0KKwkJCSAgICAgIGludCByb3csIGludCBjaGFuKQ0KIHsNCiAJ
Y2hhciBkZXRhaWxbODBdOw0KIAl1OCBncmFpbl9iaXRzOw0KQEAgLTEwNDYsNyArMTA0NywyMiBA
QCB2b2lkIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcihjb25zdCBlbnVtIGh3X2V2ZW50X21jX2Vy
cl90eXBlIHR5cGUsDQogCQkJICAgICAgZS0+bGFiZWwsIGRldGFpbCwgZS0+b3RoZXJfZGV0YWls
KTsNCiAJfQ0KIA0KKwkvKiBvbGQgQVBJJ3MgY291bnRlcnMgKi8NCisJaWYgKGRpbW0pIHsNCisJ
CXJvdyA9IGRpbW0tPmNzcm93Ow0KKwkJY2hhbiA9IGRpbW0tPmNzY2hhbm5lbDsNCisJfQ0KIA0K
KwlpZiAobWNpLT5jc3Jvd3MgJiYgcm93ID49IDApIHsNCisJCWlmICh0eXBlID09IEhXX0VWRU5U
X0VSUl9DT1JSRUNURUQpIHsNCisJCQltY2ktPmNzcm93c1tyb3ddLT5jZV9jb3VudCArPSBlLT5l
cnJvcl9jb3VudDsNCisJCQlpZiAoY2hhbiA+PSAwKQ0KKwkJCQltY2ktPmNzcm93c1tyb3ddLT5j
aGFubmVsc1tjaGFuXS0+Y2VfY291bnQgKz0gZS0+ZXJyb3JfY291bnQ7DQorCQl9IGVsc2Ugew0K
KwkJCW1jaS0+Y3Nyb3dzW3Jvd10tPnVlX2NvdW50ICs9IGUtPmVycm9yX2NvdW50Ow0KKwkJfQ0K
KwkJZWRhY19kYmcoNCwgImNzcm93L2NoYW5uZWwgdG8gaW5jcmVtZW50OiAoJWQsJWQpXG4iLCBy
b3csIGNoYW4pOw0KKwl9DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGVkYWNfcmF3X21jX2hhbmRs
ZV9lcnJvcik7DQogDQpAQCAtMTE3NywyMiArMTE5MywxMCBAQCB2b2lkIGVkYWNfbWNfaGFuZGxl
X2Vycm9yKGNvbnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCX0NCiAJfQ0K
IA0KLQlpZiAoIXBlcl9sYXllcl9yZXBvcnQpIHsNCisJaWYgKCFwZXJfbGF5ZXJfcmVwb3J0KQ0K
IAkJc3RyY3B5KGUtPmxhYmVsLCAiYW55IG1lbW9yeSIpOw0KLQl9IGVsc2Ugew0KLQkJZWRhY19k
YmcoNCwgImNzcm93L2NoYW5uZWwgdG8gaW5jcmVtZW50OiAoJWQsJWQpXG4iLCByb3csIGNoYW4p
Ow0KLQkJaWYgKHAgPT0gZS0+bGFiZWwpDQotCQkJc3RyY3B5KGUtPmxhYmVsLCAidW5rbm93biBt
ZW1vcnkiKTsNCi0JCWlmICh0eXBlID09IEhXX0VWRU5UX0VSUl9DT1JSRUNURUQpIHsNCi0JCQlp
ZiAocm93ID49IDApIHsNCi0JCQkJbWNpLT5jc3Jvd3Nbcm93XS0+Y2VfY291bnQgKz0gZXJyb3Jf
Y291bnQ7DQotCQkJCWlmIChjaGFuID49IDApDQotCQkJCQltY2ktPmNzcm93c1tyb3ddLT5jaGFu
bmVsc1tjaGFuXS0+Y2VfY291bnQgKz0gZXJyb3JfY291bnQ7DQotCQkJfQ0KLQkJfSBlbHNlDQot
CQkJaWYgKHJvdyA+PSAwKQ0KLQkJCQltY2ktPmNzcm93c1tyb3ddLT51ZV9jb3VudCArPSBlcnJv
cl9jb3VudDsNCi0JfQ0KKwllbHNlIGlmICghKmUtPmxhYmVsKQ0KKwkJc3RyY3B5KGUtPmxhYmVs
LCAidW5rbm93biBtZW1vcnkiKTsNCiANCiAJLyogRmlsbCB0aGUgUkFNIGxvY2F0aW9uIGRhdGEg
Ki8NCiAJcCA9IGUtPmxvY2F0aW9uOw0KQEAgLTEyMTAsNiArMTIxNCw2IEBAIHZvaWQgZWRhY19t
Y19oYW5kbGVfZXJyb3IoY29uc3QgZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIA0K
IAlkaW1tID0gZWRhY19nZXRfZGltbShtY2ksIHRvcF9sYXllciwgbWlkX2xheWVyLCBsb3dfbGF5
ZXIpOw0KIA0KLQllZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBkaW1tLCBlKTsN
CisJZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKHR5cGUsIG1jaSwgZGltbSwgZSwgcm93LCBjaGFu
KTsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoZWRhY19tY19oYW5kbGVfZXJyb3IpOw0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmggYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQpp
bmRleCBiODE2Y2YzY2FhZWUuLmM0ZGRkNWMxZTI0YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRh
Yy9lZGFjX21jLmgNCisrKyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmgNCkBAIC0yMTYsNiArMjE2
LDEwIEBAIGV4dGVybiBpbnQgZWRhY19tY19maW5kX2Nzcm93X2J5X3BhZ2Uoc3RydWN0IG1lbV9j
dGxfaW5mbyAqbWNpLA0KICAqIEBtY2k6CQlhIHN0cnVjdCBtZW1fY3RsX2luZm8gcG9pbnRlcg0K
ICAqIEBkaW1tOgkJYSBzdHJ1Y3QgZGltbV9pbmZvIHBvaW50ZXINCiAgKiBAZToJCQllcnJvciBk
ZXNjcmlwdGlvbg0KKyAqIEByb3c6CQljc3JvdyBoaW50IGlmIHRoZXJlIGlzIG5vIGRpbW0gaW5m
byAoPDAgaWYNCisgKgkJCXVua25vd24pDQorICogQGNoYW46CQljc2NoYW5uZWwgaGludCBpZiB0
aGVyZSBpcyBubyBkaW1tIGluZm8gKDwwIGlmDQorICoJCQl1bmtub3duKQ0KICAqDQogICogVGhp
cyByYXcgZnVuY3Rpb24gaXMgdXNlZCBpbnRlcm5hbGx5IGJ5IGVkYWNfbWNfaGFuZGxlX2Vycm9y
KCkuIEl0IHNob3VsZA0KICAqIG9ubHkgYmUgY2FsbGVkIGRpcmVjdGx5IHdoZW4gdGhlIGhhcmR3
YXJlIGVycm9yIGNvbWUgZGlyZWN0bHkgZnJvbSBCSU9TLA0KQEAgLTIyNCw3ICsyMjgsOCBAQCBl
eHRlcm4gaW50IGVkYWNfbWNfZmluZF9jc3Jvd19ieV9wYWdlKHN0cnVjdCBtZW1fY3RsX2luZm8g
Km1jaSwNCiB2b2lkIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcihjb25zdCBlbnVtIGh3X2V2ZW50
X21jX2Vycl90eXBlIHR5cGUsDQogCQkJICAgICAgc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0K
IAkJCSAgICAgIHN0cnVjdCBkaW1tX2luZm8gKmRpbW0sDQotCQkJICAgICAgc3RydWN0IGVkYWNf
cmF3X2Vycm9yX2Rlc2MgKmUpOw0KKwkJCSAgICAgIHN0cnVjdCBlZGFjX3Jhd19lcnJvcl9kZXNj
ICplLA0KKwkJCSAgICAgIGludCByb3csIGludCBjaGFuKTsNCiANCiAvKioNCiAgKiBlZGFjX21j
X2hhbmRsZV9lcnJvcigpIC0gUmVwb3J0cyBhIG1lbW9yeSBldmVudCB0byB1c2Vyc3BhY2UuDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNf
ZWRhYy5jDQppbmRleCA3NDYwODM4NzZiNWYuLjgwNjM5OTZhMzExZCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpA
QCAtNDM0LDcgKzQzNCw3IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNl
diwgc3RydWN0IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogDQogCWRpbW1faW5mbyA9IGVk
YWNfZ2V0X2RpbW1fYnlfaW5kZXgobWNpLCBlLT50b3BfbGF5ZXIpOw0KIA0KLQllZGFjX3Jhd19t
Y19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBkaW1tX2luZm8sIGUpOw0KKwllZGFjX3Jhd19tY19o
YW5kbGVfZXJyb3IodHlwZSwgbWNpLCBkaW1tX2luZm8sIGUsIC0xLCAtMSk7DQogDQogCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmdoZXNfbG9jaywgZmxhZ3MpOw0KIH0NCi0tIA0KMi4yMC4xDQoN
Cg==
