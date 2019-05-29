Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995C92D808
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE2Ioq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49564 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbfE2Ioo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:44 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8do5G017769;
        Wed, 29 May 2019 01:44:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=gH07SKJSQPdDv/5bA0/8ymvQicLgvr2M4038/DDZ8dk=;
 b=NpnlqoVtiNhoMV9hZdtqNtZoFWalcIzOlI0DeXOsPwiTG7PKZeHw963Hyj/7+vwXGlKs
 ca96eszuXpU20WeeDxdNKh0WZ75kVVF3eq0u3aDmIXIEgiSnaHoCeVxuumJ2DIeMwjmr
 cRoBQSmLHKYXN7IdA2O1X2RRewnnPKLSccNq7tj9bnfts7hAAYRvT/pdEpuyOLNgMs7q
 XB02PBwEN6J8cxlopLLsMxuwlL9UMbHkW/N3NcOZ9pn31lTmy/idW3H8AgQRRP/ZAZjp
 S3szMRxfkkXJG31rk6ytT6tLXrJ9JsKjO8U8agjT6NaSdoSSTPz9LZyuRxMfmPFCWfna bQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:37 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:35 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH07SKJSQPdDv/5bA0/8ymvQicLgvr2M4038/DDZ8dk=;
 b=MBUDhLvrH0U6nacsY/sOssJgeSLvBS9gyLiX+apQxWQVwwkFTR4/yNa1GIrZc7S1Y+euaukS/UX7t0vfdq6NRl/ZrBjyegJqN54pe+yo7Lu8rF98vjJ/+tr1VbxO3KJNNdTdCac1b0kiSj6G+qM4GfMWaDfPO4imPAtS5t1eqD8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:31 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:31 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Topic: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Index: AQHVFfq76DACswz/0kCLO71UP6WlZA==
Date:   Wed, 29 May 2019 08:44:30 +0000
Message-ID: <20190529084344.28562-13-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 48f98d83-122d-4b5f-9855-08d6e411ddcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437DFDFCF4126B5EA63D725D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9SzTuwoWv3Pxe8JuELv0nAxIYrMSoVIhI6s8ASrtx7oAtTq9hRunlQeQhACxPjf+7HqPuBvNFPmveXQcqQVx3RcUuskRA+lQWIW1bpGkZLUGy5qIsXBq3E5A0DwWO7B6jzetBrFA15v4720636HueMJ5GibrRyM1tMNp3KqAlGeeZBbbeRD8plEFSIF7rJtHRrd89AuaHC5r/+RRnEZk7CTeXqdMneTtFgcc82niifFI1HnfwQXK8KrIfLDxTmuxtINWOaBEaowua3uBR/sMlA8utDtvO0scMqoLTZ7NjEPwqjNovSgizsCSiuZfypkJYXlpcXUf5JcbcciiR48H5iulYTQKGLHBn2vAfRZn0nh+Y0V6SySZo3msDcAm/KA6owmigQLLm5VgjUqAZ0R6/7BGdIEd8EQyoBFMAet1XEU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f98d83-122d-4b5f-9855-08d6e411ddcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:30.8855
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

VGhlIGdoZXMgZHJpdmVyIGlzIG5vdCBhYmxlIHlldCB0byBjb3VudCBsZWdhY3kgQVBJIGNvdW50
ZXJzIGluIHN5c2ZzLA0KZS5nLjoNCg0KIC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAv
Y3Nyb3cyL2NlX2NvdW50DQogL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9jc3JvdzIv
Y2gwX2NlX2NvdW50DQogL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9jc3JvdzIvY2gx
X2NlX2NvdW50DQoNCk1ha2UgY291bnRpbmcgY3Nyb3dzL2NoYW5uZWxzIGdlbmVyaWMgc28gdGhh
dCB0aGUgZ2hlcyBkcml2ZXIgY2FuIHVzZQ0KaXQgdG9vLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2Jl
cnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRh
Y19tYy5jICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiBk
cml2ZXJzL2VkYWMvZWRhY19tYy5oICAgfCAgNyArKysrKystDQogZHJpdmVycy9lZGFjL2doZXNf
ZWRhYy5jIHwgIDIgKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE5IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2VkYWNfbWMuYyBiL2RyaXZl
cnMvZWRhYy9lZGFjX21jLmMNCmluZGV4IDg2MTNhMzFkYzg2Yy4uZjdlNmE3NTFmMzA5IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2VkYWNf
bWMuYw0KQEAgLTEwMDcsNyArMTAwNyw4IEBAIHN0YXRpYyB2b2lkIGVkYWNfdWVfZXJyb3Ioc3Ry
dWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KIHZvaWQgZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKGNv
bnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCQkgICAgICBzdHJ1Y3QgbWVt
X2N0bF9pbmZvICptY2ksDQogCQkJICAgICAgc3RydWN0IGRpbW1faW5mbyAqZGltbSwNCi0JCQkg
ICAgICBzdHJ1Y3QgZWRhY19yYXdfZXJyb3JfZGVzYyAqZSkNCisJCQkgICAgICBzdHJ1Y3QgZWRh
Y19yYXdfZXJyb3JfZGVzYyAqZSwNCisJCQkgICAgICBpbnQgcm93LCBpbnQgY2hhbikNCiB7DQog
CWNoYXIgZGV0YWlsWzgwXTsNCiAJdTggZ3JhaW5fYml0czsNCkBAIC0xMDQwLDcgKzEwNDEsMjMg
QEAgdm9pZCBlZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IoY29uc3QgZW51bSBod19ldmVudF9tY19l
cnJfdHlwZSB0eXBlLA0KIAkJCSAgICAgIGUtPmxhYmVsLCBkZXRhaWwsIGUtPm90aGVyX2RldGFp
bCk7DQogCX0NCiANCisJLyogb2xkIEFQSSdzIGNvdW50ZXJzICovDQorCWlmIChkaW1tKSB7DQor
CQlyb3cgPSBkaW1tLT5jc3JvdzsNCisJCWNoYW4gPSBkaW1tLT5jc2NoYW5uZWw7DQorCX0NCisN
CisJaWYgKHJvdyA+PSAwKSB7DQorCQlpZiAodHlwZSA9PSBIV19FVkVOVF9FUlJfQ09SUkVDVEVE
KSB7DQorCQkJbWNpLT5jc3Jvd3Nbcm93XS0+Y2VfY291bnQgKz0gZS0+ZXJyb3JfY291bnQ7DQor
CQkJaWYgKGNoYW4gPj0gMCkNCisJCQkJbWNpLT5jc3Jvd3Nbcm93XS0+Y2hhbm5lbHNbY2hhbl0t
PmNlX2NvdW50ICs9IGUtPmVycm9yX2NvdW50Ow0KKwkJfSBlbHNlIHsNCisJCQltY2ktPmNzcm93
c1tyb3ddLT51ZV9jb3VudCArPSBlLT5lcnJvcl9jb3VudDsNCisJCX0NCisJfQ0KIA0KKwllZGFj
X2RiZyg0LCAiY3Nyb3cvY2hhbm5lbCB0byBpbmNyZW1lbnQ6ICglZCwlZClcbiIsIHJvdywgY2hh
bik7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcik7DQog
DQpAQCAtMTE3MSwyMiArMTE4OCwxMCBAQCB2b2lkIGVkYWNfbWNfaGFuZGxlX2Vycm9yKGNvbnN0
IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCX0NCiAJfQ0KIA0KLQlpZiAoIXBl
cl9sYXllcl9yZXBvcnQpIHsNCisJaWYgKCFwZXJfbGF5ZXJfcmVwb3J0KQ0KIAkJc3RyY3B5KGUt
PmxhYmVsLCAiYW55IG1lbW9yeSIpOw0KLQl9IGVsc2Ugew0KLQkJZWRhY19kYmcoNCwgImNzcm93
L2NoYW5uZWwgdG8gaW5jcmVtZW50OiAoJWQsJWQpXG4iLCByb3csIGNoYW4pOw0KLQkJaWYgKHAg
PT0gZS0+bGFiZWwpDQotCQkJc3RyY3B5KGUtPmxhYmVsLCAidW5rbm93biBtZW1vcnkiKTsNCi0J
CWlmICh0eXBlID09IEhXX0VWRU5UX0VSUl9DT1JSRUNURUQpIHsNCi0JCQlpZiAocm93ID49IDAp
IHsNCi0JCQkJbWNpLT5jc3Jvd3Nbcm93XS0+Y2VfY291bnQgKz0gZXJyb3JfY291bnQ7DQotCQkJ
CWlmIChjaGFuID49IDApDQotCQkJCQltY2ktPmNzcm93c1tyb3ddLT5jaGFubmVsc1tjaGFuXS0+
Y2VfY291bnQgKz0gZXJyb3JfY291bnQ7DQotCQkJfQ0KLQkJfSBlbHNlDQotCQkJaWYgKHJvdyA+
PSAwKQ0KLQkJCQltY2ktPmNzcm93c1tyb3ddLT51ZV9jb3VudCArPSBlcnJvcl9jb3VudDsNCi0J
fQ0KKwllbHNlIGlmICghKmUtPmxhYmVsKQ0KKwkJc3RyY3B5KGUtPmxhYmVsLCAidW5rbm93biBt
ZW1vcnkiKTsNCiANCiAJLyogRmlsbCB0aGUgUkFNIGxvY2F0aW9uIGRhdGEgKi8NCiAJcCA9IGUt
PmxvY2F0aW9uOw0KQEAgLTEyMDQsNiArMTIwOSw2IEBAIHZvaWQgZWRhY19tY19oYW5kbGVfZXJy
b3IoY29uc3QgZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIA0KIAlkaW1tID0gZWRh
Y19nZXRfZGltbShtY2ksIHRvcF9sYXllciwgbWlkX2xheWVyLCBsb3dfbGF5ZXIpOw0KIA0KLQll
ZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBkaW1tLCBlKTsNCisJZWRhY19yYXdf
bWNfaGFuZGxlX2Vycm9yKHR5cGUsIG1jaSwgZGltbSwgZSwgcm93LCBjaGFuKTsNCiB9DQogRVhQ
T1JUX1NZTUJPTF9HUEwoZWRhY19tY19oYW5kbGVfZXJyb3IpOw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZWRhYy9lZGFjX21jLmggYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQppbmRleCBiODE2Y2Yz
Y2FhZWUuLmM0ZGRkNWMxZTI0YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmgN
CisrKyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmgNCkBAIC0yMTYsNiArMjE2LDEwIEBAIGV4dGVy
biBpbnQgZWRhY19tY19maW5kX2Nzcm93X2J5X3BhZ2Uoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNp
LA0KICAqIEBtY2k6CQlhIHN0cnVjdCBtZW1fY3RsX2luZm8gcG9pbnRlcg0KICAqIEBkaW1tOgkJ
YSBzdHJ1Y3QgZGltbV9pbmZvIHBvaW50ZXINCiAgKiBAZToJCQllcnJvciBkZXNjcmlwdGlvbg0K
KyAqIEByb3c6CQljc3JvdyBoaW50IGlmIHRoZXJlIGlzIG5vIGRpbW0gaW5mbyAoPDAgaWYNCisg
KgkJCXVua25vd24pDQorICogQGNoYW46CQljc2NoYW5uZWwgaGludCBpZiB0aGVyZSBpcyBubyBk
aW1tIGluZm8gKDwwIGlmDQorICoJCQl1bmtub3duKQ0KICAqDQogICogVGhpcyByYXcgZnVuY3Rp
b24gaXMgdXNlZCBpbnRlcm5hbGx5IGJ5IGVkYWNfbWNfaGFuZGxlX2Vycm9yKCkuIEl0IHNob3Vs
ZA0KICAqIG9ubHkgYmUgY2FsbGVkIGRpcmVjdGx5IHdoZW4gdGhlIGhhcmR3YXJlIGVycm9yIGNv
bWUgZGlyZWN0bHkgZnJvbSBCSU9TLA0KQEAgLTIyNCw3ICsyMjgsOCBAQCBleHRlcm4gaW50IGVk
YWNfbWNfZmluZF9jc3Jvd19ieV9wYWdlKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCiB2b2lk
IGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcihjb25zdCBlbnVtIGh3X2V2ZW50X21jX2Vycl90eXBl
IHR5cGUsDQogCQkJICAgICAgc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KIAkJCSAgICAgIHN0
cnVjdCBkaW1tX2luZm8gKmRpbW0sDQotCQkJICAgICAgc3RydWN0IGVkYWNfcmF3X2Vycm9yX2Rl
c2MgKmUpOw0KKwkJCSAgICAgIHN0cnVjdCBlZGFjX3Jhd19lcnJvcl9kZXNjICplLA0KKwkJCSAg
ICAgIGludCByb3csIGludCBjaGFuKTsNCiANCiAvKioNCiAgKiBlZGFjX21jX2hhbmRsZV9lcnJv
cigpIC0gUmVwb3J0cyBhIG1lbW9yeSBldmVudCB0byB1c2Vyc3BhY2UuDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRl
eCBmNmVhNGIwNzBiZmUuLmVhNGQ1MzA0MzE5OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9n
aGVzX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtNDM1LDcgKzQz
NSw3IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNw
ZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogDQogCWRpbW1faW5mbyA9IGVkYWNfZ2V0X2RpbW1f
YnlfaW5kZXgobWNpLCBlLT50b3BfbGF5ZXIpOw0KIA0KLQllZGFjX3Jhd19tY19oYW5kbGVfZXJy
b3IodHlwZSwgbWNpLCBkaW1tX2luZm8sIGUpOw0KKwllZGFjX3Jhd19tY19oYW5kbGVfZXJyb3Io
dHlwZSwgbWNpLCBkaW1tX2luZm8sIGUsIC0xLCAtMSk7DQogDQogCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmdoZXNfbG9jaywgZmxhZ3MpOw0KIH0NCi0tIA0KMi4yMC4xDQoNCg==
