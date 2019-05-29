Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D92D826
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfE2Ipj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:45:39 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49538 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbfE2Ioj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:39 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8doqY017791;
        Wed, 29 May 2019 01:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=nKwZxi1myEspKdU3HROV4Me4eokbwIVj/uTY/R3dhxo=;
 b=w3AdXKDRXex63m2nSJwhNLXV3s/qiwqH9H5HU00dcM7fS4gE7Ex6sY6dZvMc4/Ro4MKY
 n3PE746RYUZhnL3xnzYz3HV0ITMIc8jYslQxp+Q+Ld8oxhlePoDk01Dfx3MtULV7djdv
 0q+ll6i/BRbNM9nwvAigjDAIk5EY6y70ZHc2zn57ucNfHrD655ucL/5KLkcIAAV6B5du
 7VgXaZzHQd+8D+S90svAGnxH2NrgJXCnEcIvByExKOPjcsCrVxtGvve/brB5FSoU5ACs
 C2CscqT4lyjMWS8QTlpg1lGuSmt9hnCHCtagFS7FRcTRKh1MXbZxi08I1Dul+eCqKFgx tw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:32 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:30 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKwZxi1myEspKdU3HROV4Me4eokbwIVj/uTY/R3dhxo=;
 b=eLIH9LfLd+NAmu/dtlOcJeeyT4SlvjHt+fidY8lwQ3bQ9N5jPwMHKKwgmFsde7i/lm5/Y8Qd7SHSwnwZaf8IetqVII1EYfK9h4Zp9IHcosfCMgm3os2WGpCelY5zDCkcAUn7mtHMNl95fxxgA6+fgQ7VE3YgpBfGqPkyc34KFEI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:28 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:28 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with edac_mc
 driver
Thread-Topic: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Index: AQHVFfq6gjLVec/X00qyYoFkU9EVEg==
Date:   Wed, 29 May 2019 08:44:28 +0000
Message-ID: <20190529084344.28562-12-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 5eff7721-877f-4761-eb6a-08d6e411dc6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437C412C39AD4F22C527D6ED91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oyoSj9ed3P8VMy8lFG/zguykNKkF1mut9QjgzKskcy2fO9/v2Yf7Uc/SpZp1GrcTiN5Y9wOeMJiSQC1ZKvcoTmtdWdfD0Vzth7XaSGZj0jORqmZloU60Jf3yWruyE62uiazvqtp4U2M3gKT+Xy01fRfxu5zgSzGy8KI+VbmmklFoxixH1dVQq6IQMEU0AM14xcOUzEZaSpOjKuemMWLUc2UDXKAAvd+hNcNmEZ4DUuTBhAjne5h/h4YlaEo1D3nuhMJuI4qpNf3gafKCu/ZjZFgS3SlLeyX7B7Tbt3f3DTwzu4Onszw6Rqt4FW8ahFhZjzXZUCRFVxZFVQ5LW3n3bRvP8soIA63loHT9A0muVsGSQEHWLhbKFUtCPk0ZztuuOSckflYCrp35ryyJPTfGQJr7B9XRu3c9zM/a4tqD+QA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff7721-877f-4761-eb6a-08d6e411dc6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:28.6169
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

QWxtb3N0IGR1cGxpY2F0ZSBjb2RlLCByZW1vdmUgaXQuDQoNCk5vdGU6IHRoZXJlIGlzIGEgZGlm
ZmVyZW5jZSBpbiB0aGUgY2FsY3VsYXRpb24gb2YgdGhlIGdyYWluX2JpdHMsDQp1c2luZyB0aGUg
ZWRhY19tYydzIHZlcnNpb24gaGVyZS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iZXJ0IFJpY2h0ZXIg
PHJyaWNodGVyQG1hcnZlbGwuY29tPg0KLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWMuYyAgIHwg
MjIgKysrKysrKysrKystLS0tLS0tLS0tLQ0KIGRyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyB8ICA5
IC0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5jIGIvZHJpdmVycy9l
ZGFjL2VkYWNfbWMuYw0KaW5kZXggYjFiZDBhMjNkMDJiLi44NjEzYTMxZGM4NmMgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5j
DQpAQCAtMTAxMCw2ICsxMDEwLDE3IEBAIHZvaWQgZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKGNv
bnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCQkgICAgICBzdHJ1Y3QgZWRh
Y19yYXdfZXJyb3JfZGVzYyAqZSkNCiB7DQogCWNoYXIgZGV0YWlsWzgwXTsNCisJdTggZ3JhaW5f
Yml0czsNCisNCisJLyogUmVwb3J0IHRoZSBlcnJvciB2aWEgdGhlIHRyYWNlIGludGVyZmFjZSAq
Lw0KKwlncmFpbl9iaXRzID0gZmxzX2xvbmcoZS0+Z3JhaW4pICsgMTsNCisNCisJaWYgKElTX0VO
QUJMRUQoQ09ORklHX1JBUykpDQorCQl0cmFjZV9tY19ldmVudCh0eXBlLCBlLT5tc2csIGUtPmxh
YmVsLCBlLT5lcnJvcl9jb3VudCwNCisJCQkgICAgICAgbWNpLT5tY19pZHgsIGUtPnRvcF9sYXll
ciwgZS0+bWlkX2xheWVyLA0KKwkJCSAgICAgICBlLT5sb3dfbGF5ZXIsDQorCQkJICAgICAgIChl
LT5wYWdlX2ZyYW1lX251bWJlciA8PCBQQUdFX1NISUZUKSB8IGUtPm9mZnNldF9pbl9wYWdlLA0K
KwkJCSAgICAgICBncmFpbl9iaXRzLCBlLT5zeW5kcm9tZSwgZS0+b3RoZXJfZGV0YWlsKTsNCiAN
CiAJLyogTWVtb3J5IHR5cGUgZGVwZW5kZW50IGRldGFpbHMgYWJvdXQgdGhlIGVycm9yICovDQog
CWlmICh0eXBlID09IEhXX0VWRU5UX0VSUl9DT1JSRUNURUQpIHsNCkBAIC0xMDUwLDcgKzEwNjEs
NiBAQCB2b2lkIGVkYWNfbWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVudW0gaHdfZXZlbnRfbWNfZXJy
X3R5cGUgdHlwZSwNCiAJaW50IHJvdyA9IC0xLCBjaGFuID0gLTE7DQogCWludCBwb3NbRURBQ19N
QVhfTEFZRVJTXSA9IHsgdG9wX2xheWVyLCBtaWRfbGF5ZXIsIGxvd19sYXllciB9Ow0KIAlpbnQg
aSwgbl9sYWJlbHMgPSAwOw0KLQl1OCBncmFpbl9iaXRzOw0KIAlzdHJ1Y3QgZWRhY19yYXdfZXJy
b3JfZGVzYyAqZSA9ICZtY2ktPmVycm9yX2Rlc2M7DQogCWJvb2wgcGVyX2xheWVyX3JlcG9ydCA9
IGZhbHNlOw0KIA0KQEAgLTExOTIsMTYgKzEyMDIsNiBAQCB2b2lkIGVkYWNfbWNfaGFuZGxlX2Vy
cm9yKGNvbnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJaWYgKHAgPiBlLT5s
b2NhdGlvbikNCiAJCSoocCAtIDEpID0gJ1wwJzsNCiANCi0JLyogUmVwb3J0IHRoZSBlcnJvciB2
aWEgdGhlIHRyYWNlIGludGVyZmFjZSAqLw0KLQlncmFpbl9iaXRzID0gZmxzX2xvbmcoZS0+Z3Jh
aW4pICsgMTsNCi0NCi0JaWYgKElTX0VOQUJMRUQoQ09ORklHX1JBUykpDQotCQl0cmFjZV9tY19l
dmVudCh0eXBlLCBlLT5tc2csIGUtPmxhYmVsLCBlLT5lcnJvcl9jb3VudCwNCi0JCQkgICAgICAg
bWNpLT5tY19pZHgsIGUtPnRvcF9sYXllciwgZS0+bWlkX2xheWVyLA0KLQkJCSAgICAgICBlLT5s
b3dfbGF5ZXIsDQotCQkJICAgICAgIChlLT5wYWdlX2ZyYW1lX251bWJlciA8PCBQQUdFX1NISUZU
KSB8IGUtPm9mZnNldF9pbl9wYWdlLA0KLQkJCSAgICAgICBncmFpbl9iaXRzLCBlLT5zeW5kcm9t
ZSwgZS0+b3RoZXJfZGV0YWlsKTsNCi0NCiAJZGltbSA9IGVkYWNfZ2V0X2RpbW0obWNpLCB0b3Bf
bGF5ZXIsIG1pZF9sYXllciwgbG93X2xheWVyKTsNCiANCiAJZWRhY19yYXdfbWNfaGFuZGxlX2Vy
cm9yKHR5cGUsIG1jaSwgZGltbSwgZSk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNf
ZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRleCBjMThmMTZiYzllNGQuLmY2
ZWE0YjA3MGJmZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KKysrIGIv
ZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtMjAyLDcgKzIwMiw2IEBAIHZvaWQgZ2hlc19l
ZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNwZXJfc2VjX21lbV9lcnIgKm1l
bV9lcnIpDQogCXN0cnVjdCBnaGVzX2VkYWNfcHZ0ICpwdnQgPSBnaGVzX3B2dDsNCiAJdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCiAJY2hhciAqcDsNCi0JdTggZ3JhaW5fYml0czsNCiANCiAJaWYgKCFw
dnQpDQogCQlyZXR1cm47DQpAQCAtNDM0LDE0ICs0MzMsNiBAQCB2b2lkIGdoZXNfZWRhY19yZXBv
cnRfbWVtX2Vycm9yKGludCBzZXYsIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0K
IAlpZiAocCA+IHB2dC0+b3RoZXJfZGV0YWlsKQ0KIAkJKihwIC0gMSkgPSAnXDAnOw0KIA0KLQkv
KiBHZW5lcmF0ZSB0aGUgdHJhY2UgZXZlbnQgKi8NCi0JZ3JhaW5fYml0cyA9IGZsc19sb25nKGUt
PmdyYWluKTsNCi0NCi0JdHJhY2VfbWNfZXZlbnQodHlwZSwgZS0+bXNnLCBlLT5sYWJlbCwgZS0+
ZXJyb3JfY291bnQsDQotCQkgICAgICAgbWNpLT5tY19pZHgsIGUtPnRvcF9sYXllciwgZS0+bWlk
X2xheWVyLCBlLT5sb3dfbGF5ZXIsDQotCQkgICAgICAgKGUtPnBhZ2VfZnJhbWVfbnVtYmVyIDw8
IFBBR0VfU0hJRlQpIHwgZS0+b2Zmc2V0X2luX3BhZ2UsDQotCQkgICAgICAgZ3JhaW5fYml0cywg
ZS0+c3luZHJvbWUsIGUtPm90aGVyX2RldGFpbCk7DQotDQogCWRpbW1faW5mbyA9IGVkYWNfZ2V0
X2RpbW1fYnlfaW5kZXgobWNpLCBlLT50b3BfbGF5ZXIpOw0KIA0KIAllZGFjX3Jhd19tY19oYW5k
bGVfZXJyb3IodHlwZSwgbWNpLCBkaW1tX2luZm8sIGUpOw0KLS0gDQoyLjIwLjENCg0K
