Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E062D81E
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE2Ip3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:45:29 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35472 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726806AbfE2Ioq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:46 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8eGUE022567;
        Wed, 29 May 2019 01:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=2qhE73MCALD+UUzghC/uvCkk7w4it/MmTxCz/igrhjg=;
 b=MQFiK0J12G83ymxlQLuBi8DWVDLZmEmM+vkawEz0Gulbox8J1QVaqv3W3lGTtzDK03Cu
 gUo0kQTdbFw7rWLSyeOtrJ9N2Q3b+De80OTb9PuwAl/3eKyfQdOYVbTRAmPO1swcBsP7
 xMvleNyEwk0kSHFgQZQwqjk3SN0vKh879YcE0btMF4Fq/R20odjxU3auflm4LayI/MQ4
 XpLFdTtBy3f4eq3XhPq+qOjnwRzkN/2DJVU4XKvna6ATzWsew1Pq/hs1Ka/zR7o2O2kd
 y2oR+9yEpcUPEnUx+ZbZqxNzF5uPl2XyfbgTg+8S5uiiC/8u5I74yjsZPzP096Wevfon oA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:39 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:38 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qhE73MCALD+UUzghC/uvCkk7w4it/MmTxCz/igrhjg=;
 b=qaxnvRMtUVY8A/DoD5MCYV4Cyc9MMcoCD1QtzmhKzPuv5+ikvae9/oHfzSaL7T++fjuMpD4kXD+cUcDJq83oEKW6UWLxPWhCooeEc7YimKHnyyCY9bAqLvcTCvjVuxUJ8c1ldXklxupYLuUuNCrkJ03Pg3IAPak2+8+R5CWBGcc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 15/21] EDAC, ghes: Moving code around ghes_edac_register()
Thread-Topic: [PATCH 15/21] EDAC, ghes: Moving code around
 ghes_edac_register()
Thread-Index: AQHVFfq/R2KXSNdBLEaBrkIutPx52w==
Date:   Wed, 29 May 2019 08:44:37 +0000
Message-ID: <20190529084344.28562-16-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e5b2b118-4deb-40b0-6b46-08d6e411e171
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437C050CC9CD74C2E4CF6DFD91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fu+e12lgxw4W+o83FcLKU3q7/zUft2ZUCqzYTfjQgjIOqxYndv8kpCFCjJmMAzzGMic3GgfRCxi3F3DSgVOqINc+AG8+Ohi1YlzYQcN9KRD/tnjc/jeCrwpBUWENkIIT8TbXSyQxc198VGUIo1EiqZNrG8ej1yz69vpndPLo3dVi583Ti4Zfj+OcpXXEHqYASmPb5VXASvjTFTOQY7xKOTOd9gPFD21J5vaUZRATGjhcPHNTTT5ii90VOWMCg9cb0LIrvGF8YDc4nybmJgJwhOPL3qx/9tIWVzbh/ecJn6Wk5U7x2F6AOw0Z4KhuOR4wUPVT0hBxRJzAHFRozE7dKIvCtqYAEZhlOdnBijuPP+ACxQmvEqYUsUbv1w6i7IZPvYk/nE+cFAuDLXFlYP9njq3MdlG/avu+0O+fuOFKzhI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b2b118-4deb-40b0-6b46-08d6e411e171
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:37.0169
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

VGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBvZiB0aGUgbmV4dCBwYXRjaCB0byBtYWtlIHRoZSBjaGFu
Z2VzIHRoZXJlDQptb3JlIHZpc2libGUuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmVydCBSaWNodGVy
IDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyB8
IDk3ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4
IDA4MzQ1MmE0OGI0Mi4uYzM5Y2RmZGZiOGRiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2do
ZXNfZWRhYy5jDQorKysgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCkBAIC02NDUsNDUgKzY0
NSwxOSBAQCBzdGF0aWMgc3RydWN0IGFjcGlfcGxhdGZvcm1fbGlzdCBwbGF0X2xpc3RbXSA9IHsN
CiAJeyB9IC8qIEVuZCAqLw0KIH07DQogDQotaW50IGdoZXNfZWRhY19yZWdpc3RlcihzdHJ1Y3Qg
Z2hlcyAqZ2hlcywgc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQNCitnaGVzX2VkYWNf
cmVnaXN0ZXJfb25lKGludCBuaWQsIHN0cnVjdCBnaGVzICpnaGVzLCBzdHJ1Y3QgZGV2aWNlICpw
YXJlbnQpDQogew0KLQlib29sIGZha2UgPSBmYWxzZTsNCiAJaW50IHJjOw0KIAlzdHJ1Y3QgbWVt
X2N0bF9pbmZvICptY2k7DQogCXN0cnVjdCBlZGFjX21jX2xheWVyIGxheWVyc1sxXTsNCi0JaW50
IGlkeCA9IC0xOw0KLQ0KLQlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkgew0KLQkJLyogQ2hl
Y2sgaWYgc2FmZSB0byBlbmFibGUgb24gdGhpcyBzeXN0ZW0gKi8NCi0JCWlkeCA9IGFjcGlfbWF0
Y2hfcGxhdGZvcm1fbGlzdChwbGF0X2xpc3QpOw0KLQkJaWYgKCFmb3JjZV9sb2FkICYmIGlkeCA8
IDApDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCX0gZWxzZSB7DQotCQlpZHggPSAwOw0KLQl9DQot
DQotCS8qDQotCSAqIFdlIGhhdmUgb25seSBvbmUgbG9naWNhbCBtZW1vcnkgY29udHJvbGxlciB0
byB3aGljaCBhbGwgRElNTXMgYmVsb25nLg0KLQkgKi8NCi0JaWYgKGF0b21pY19pbmNfcmV0dXJu
KCZnaGVzX2luaXQpID4gMSkNCi0JCXJldHVybiAwOw0KLQ0KLQlyYyA9IG1lbV9pbmZvX3NldHVw
KCk7DQotCWlmIChyYyA9PSAtRUlOVkFMKSB7DQotCQkvKiB3ZSd2ZSBnb3QgYSBib2d1cyBCSU9T
ICovDQotCQlmYWtlID0gdHJ1ZTsNCi0JCXJjID0gbWVtX2luZm9fc2V0dXBfZmFrZSgpOw0KLQl9
DQotCWlmIChyYyA8IDApIHsNCi0JCXByX2VycigiQ2FuJ3QgYWxsb2NhdGUgbWVtb3J5IGZvciBE
SU1NIGRhdGFcbiIpOw0KLQkJcmV0dXJuIHJjOw0KLQl9DQogDQogCWxheWVyc1swXS50eXBlID0g
RURBQ19NQ19MQVlFUl9BTExfTUVNOw0KIAlsYXllcnNbMF0uc2l6ZSA9IG1lbV9pbmZvLm51bV9k
aW1tOw0KIAlsYXllcnNbMF0uaXNfdmlydF9jc3JvdyA9IHRydWU7DQogDQotCW1jaSA9IGVkYWNf
bWNfYWxsb2MoMCwgQVJSQVlfU0laRShsYXllcnMpLCBsYXllcnMsIHNpemVvZihzdHJ1Y3QgZ2hl
c19lZGFjX3B2dCkpOw0KKwltY2kgPSBlZGFjX21jX2FsbG9jKG5pZCwgQVJSQVlfU0laRShsYXll
cnMpLCBsYXllcnMsDQorCQkJc2l6ZW9mKHN0cnVjdCBnaGVzX2VkYWNfcHZ0KSk7DQogCWlmICgh
bWNpKSB7DQogCQlwcl9lcnIoIkNhbid0IGFsbG9jYXRlIG1lbW9yeSBmb3IgRURBQyBkYXRhXG4i
KTsNCiAJCXJldHVybiAtRU5PTUVNOw0KQEAgLTY5Myw3ICs2NjcsNyBAQCBpbnQgZ2hlc19lZGFj
X3JlZ2lzdGVyKHN0cnVjdCBnaGVzICpnaGVzLCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCWdoZXNf
cHZ0LT5naGVzCT0gZ2hlczsNCiAJZ2hlc19wdnQtPm1jaQk9IG1jaTsNCiANCi0JbWNpLT5wZGV2
ID0gZGV2Ow0KKwltY2ktPnBkZXYgPSBwYXJlbnQ7DQogCW1jaS0+bXR5cGVfY2FwID0gTUVNX0ZM
QUdfRU1QVFk7DQogCW1jaS0+ZWRhY19jdGxfY2FwID0gRURBQ19GTEFHX05PTkU7DQogCW1jaS0+
ZWRhY19jYXAgPSBFREFDX0ZMQUdfTk9ORTsNCkBAIC03MDEsMTkgKzY3NSw2IEBAIGludCBnaGVz
X2VkYWNfcmVnaXN0ZXIoc3RydWN0IGdoZXMgKmdoZXMsIHN0cnVjdCBkZXZpY2UgKmRldikNCiAJ
bWNpLT5jdGxfbmFtZSA9ICJnaGVzX2VkYWMiOw0KIAltY2ktPmRldl9uYW1lID0gImdoZXMiOw0K
IA0KLQlpZiAoZmFrZSkgew0KLQkJcHJfaW5mbygiVGhpcyBzeXN0ZW0gaGFzIGEgdmVyeSBjcmFw
cHkgQklPUzogSXQgZG9lc24ndCBldmVuIGxpc3QgdGhlIERJTU1TLlxuIik7DQotCQlwcl9pbmZv
KCJJdHMgU01CSU9TIGluZm8gaXMgd3JvbmcuIEl0IGlzIGRvdWJ0ZnVsIHRoYXQgdGhlIGVycm9y
IHJlcG9ydCB3b3VsZFxuIik7DQotCQlwcl9pbmZvKCJ3b3JrIG9uIHN1Y2ggc3lzdGVtLiBVc2Ug
dGhpcyBkcml2ZXIgd2l0aCBjYXV0aW9uXG4iKTsNCi0JfSBlbHNlIGlmIChpZHggPCAwKSB7DQot
CQlwcl9pbmZvKCJUaGlzIEVEQUMgZHJpdmVyIHJlbGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBt
ZW1vcnkgYW5kIGdldCBlcnJvciByZXBvcnRzLlxuIik7DQotCQlwcl9pbmZvKCJVbmZvcnR1bmF0
ZWx5LCBub3QgYWxsIEJJT1NlcyByZWZsZWN0IHRoZSBtZW1vcnkgbGF5b3V0IGNvcnJlY3RseS5c
biIpOw0KLQkJcHJfaW5mbygiU28sIHRoZSBlbmQgcmVzdWx0IG9mIHVzaW5nIHRoaXMgZHJpdmVy
IHZhcmllcyBmcm9tIHZlbmRvciB0byB2ZW5kb3IuXG4iKTsNCi0JCXByX2luZm8oIklmIHlvdSBm
aW5kIGluY29ycmVjdCByZXBvcnRzLCBwbGVhc2UgY29udGFjdCB5b3VyIGhhcmR3YXJlIHZlbmRv
clxuIik7DQotCQlwcl9pbmZvKCJ0byBjb3JyZWN0IGl0cyBCSU9TLlxuIik7DQotCQlwcl9pbmZv
KCJUaGlzIHN5c3RlbSBoYXMgJWQgRElNTSBzb2NrZXRzLlxuIiwgbWVtX2luZm8ubnVtX2RpbW0p
Ow0KLQl9DQotDQogCW1jaV9hZGRfZGltbV9pbmZvKG1jaSk7DQogDQogCXJjID0gZWRhY19tY19h
ZGRfbWMobWNpKTsNCkBAIC03MzgsMyArNjk5LDUxIEBAIHZvaWQgZ2hlc19lZGFjX3VucmVnaXN0
ZXIoc3RydWN0IGdoZXMgKmdoZXMpDQogDQogCWtmcmVlKG1lbV9pbmZvLmRpbW1zKTsNCiB9DQor
DQoraW50IGdoZXNfZWRhY19yZWdpc3RlcihzdHJ1Y3QgZ2hlcyAqZ2hlcywgc3RydWN0IGRldmlj
ZSAqZGV2KQ0KK3sNCisJYm9vbCBmYWtlID0gZmFsc2U7DQorCWludCByYzsNCisJaW50IGlkeCA9
IC0xOw0KKw0KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkgew0KKwkJLyogQ2hlY2sgaWYg
c2FmZSB0byBlbmFibGUgb24gdGhpcyBzeXN0ZW0gKi8NCisJCWlkeCA9IGFjcGlfbWF0Y2hfcGxh
dGZvcm1fbGlzdChwbGF0X2xpc3QpOw0KKwkJaWYgKCFmb3JjZV9sb2FkICYmIGlkeCA8IDApDQor
CQkJcmV0dXJuIC1FTk9ERVY7DQorCX0gZWxzZSB7DQorCQlpZHggPSAwOw0KKwl9DQorDQorCS8q
IFdlIGhhdmUgb25seSBvbmUgZ2hlcyBpbnN0YW5jZSBhdCBhIHRpbWUuICovDQorCWlmIChhdG9t
aWNfaW5jX3JldHVybigmZ2hlc19pbml0KSA+IDEpDQorCQlyZXR1cm4gMDsNCisNCisJcmMgPSBt
ZW1faW5mb19zZXR1cCgpOw0KKwlpZiAocmMgPT0gLUVJTlZBTCkgew0KKwkJLyogd2UndmUgZ290
IGEgYm9ndXMgQklPUyAqLw0KKwkJZmFrZSA9IHRydWU7DQorCQlyYyA9IG1lbV9pbmZvX3NldHVw
X2Zha2UoKTsNCisJfQ0KKwlpZiAocmMgPCAwKSB7DQorCQlwcl9lcnIoIkNhbid0IGFsbG9jYXRl
IG1lbW9yeSBmb3IgRElNTSBkYXRhXG4iKTsNCisJCXJldHVybiByYzsNCisJfQ0KKw0KKwlpZiAo
ZmFrZSkgew0KKwkJcHJfaW5mbygiVGhpcyBzeXN0ZW0gaGFzIGEgdmVyeSBjcmFwcHkgQklPUzog
SXQgZG9lc24ndCBldmVuIGxpc3QgdGhlIERJTU1TLlxuIik7DQorCQlwcl9pbmZvKCJJdHMgU01C
SU9TIGluZm8gaXMgd3JvbmcuIEl0IGlzIGRvdWJ0ZnVsIHRoYXQgdGhlIGVycm9yIHJlcG9ydCB3
b3VsZFxuIik7DQorCQlwcl9pbmZvKCJ3b3JrIG9uIHN1Y2ggc3lzdGVtLiBVc2UgdGhpcyBkcml2
ZXIgd2l0aCBjYXV0aW9uXG4iKTsNCisJfSBlbHNlIGlmIChpZHggPCAwKSB7DQorCQlwcl9pbmZv
KCJUaGlzIEVEQUMgZHJpdmVyIHJlbGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBtZW1vcnkgYW5k
IGdldCBlcnJvciByZXBvcnRzLlxuIik7DQorCQlwcl9pbmZvKCJVbmZvcnR1bmF0ZWx5LCBub3Qg
YWxsIEJJT1NlcyByZWZsZWN0IHRoZSBtZW1vcnkgbGF5b3V0IGNvcnJlY3RseS5cbiIpOw0KKwkJ
cHJfaW5mbygiU28sIHRoZSBlbmQgcmVzdWx0IG9mIHVzaW5nIHRoaXMgZHJpdmVyIHZhcmllcyBm
cm9tIHZlbmRvciB0byB2ZW5kb3IuXG4iKTsNCisJCXByX2luZm8oIklmIHlvdSBmaW5kIGluY29y
cmVjdCByZXBvcnRzLCBwbGVhc2UgY29udGFjdCB5b3VyIGhhcmR3YXJlIHZlbmRvclxuIik7DQor
CQlwcl9pbmZvKCJ0byBjb3JyZWN0IGl0cyBCSU9TLlxuIik7DQorCQlwcl9pbmZvKCJUaGlzIHN5
c3RlbSBoYXMgJWQgRElNTSBzb2NrZXRzLlxuIiwgbWVtX2luZm8ubnVtX2RpbW0pOw0KKwl9DQor
DQorCXJjID0gZ2hlc19lZGFjX3JlZ2lzdGVyX29uZSgwLCBnaGVzLCBkZXYpOw0KKw0KKwlyZXR1
cm4gcmM7DQorfQ0KLS0gDQoyLjIwLjENCg0K
