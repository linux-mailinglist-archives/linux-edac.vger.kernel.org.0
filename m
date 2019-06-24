Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6851950FBA
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfFXPJI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39286 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbfFXPJH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:07 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8CZ4025866;
        Mon, 24 Jun 2019 08:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pIs8IdJVaFhb/v9+wntLcWsZ3Y3pUgrJps923RgfgQU=;
 b=woPDsTcN6ObFwzvJf/EKY0u2JN8GDdvHU+tbP76RsUYTk9VdOoR5q5rnRRCKlAq/fsBY
 YYRUErvAP9mRfavlP+Kx4gEPZubRla9y39/XbTiVjNhZnkzr2y1fEAFj0bZf1Q50PHTE
 tCFlx0rGYb+czOe/heuRM7Lkrx48zubJF6BkxpO2zOUILV5ib9R9yh4zAcgVfbK5Q2Mr
 L5lq7wBsLZAbdcR3tgqcQ9RSRcBWVBPOEVhuOtK9Jn1+iRh6QIzoLD38gCppPsImRyOb
 CtMRmHUWPybUPqNVnlYI94FmnhSjKZCpxEsAJmgy3H6vJh/FnTtO19ahXvmWGy6MLquZ ZQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:08:58 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:08:56 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIs8IdJVaFhb/v9+wntLcWsZ3Y3pUgrJps923RgfgQU=;
 b=VIsf4jGXt8OXzzyVvIco5NHrVpU/HaNIqIZuWqegbLdZhhw4Q7cCsHcIBjkORuhgjj4JCOUnq6g4Dn4lrexduJGDLf3o4B9OArw61epaZWLXaXgTCGavidwF8bS9oO2kO8rYpIdqd+VUWwoNcCOGcrIA9EFDP08Ym1uEjhpYTzw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2589.namprd18.prod.outlook.com (20.179.82.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:08:55 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:08:55 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 01/24] EDAC, mc: Fix grain_bits calculation
Thread-Topic: [PATCH v2 01/24] EDAC, mc: Fix grain_bits calculation
Thread-Index: AQHVKp69wZOPr3Ki20aR3to5WmH54Q==
Date:   Mon, 24 Jun 2019 15:08:55 +0000
Message-ID: <20190624150758.6695-2-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 38f39192-31f6-4dbb-9b1b-08d6f8b5df77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2589;
x-ms-traffictypediagnostic: MN2PR18MB2589:
x-microsoft-antispam-prvs: <MN2PR18MB2589FC7F13AAF0121104BE1AD9E00@MN2PR18MB2589.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(2906002)(2616005)(486006)(476003)(52116002)(256004)(5660300002)(66446008)(73956011)(66946007)(1076003)(14454004)(6116002)(86362001)(3846002)(99286004)(6486002)(68736007)(81166006)(81156014)(6436002)(4326008)(305945005)(50226002)(53936002)(7736002)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(6512007)(107886003)(71190400001)(71200400001)(36756003)(26005)(102836004)(386003)(186003)(11346002)(76176011)(6506007)(110136005)(316002)(54906003)(446003)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2589;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tW3YM7F+FiRKwKjYcKvsD9X3KboF+u1aLwnJPRb96hrRPK6KtisRajTzUSMK5N0ug62mcxuJOBPx0RM0i6C85FoG7OgMALrzqbzu9N6IJADIx3dUp3Gf5Twteboz4TAy5kQmWIAQBWx2QfdZIyXwHmzDHBeR+0TYAGuYlkFyAGqwMPtdx4P2imCku5HIeo62dMcOGdsSYEsLSEvCDdF0vHVPU/z5xReRA293XEZvzWFAjThfmKnRy+ErEyvx5ErPv/qsoWUqSWCe1I9NtDEB5RYijdeZ+aO0WKtCrrOA0E9hoeB2u4yQZREpnAHO1GgODLqjLse39Wu27nPn5QjyfSFfTJKioI9ylLcb+WT+JHnPsHFMJ+plsXl/iQTh4tGZVqnSR78RvhKNQ/fgbNLKMc3pu804xKWWM4HQkAMNd8w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f39192-31f6-4dbb-9b1b-08d6f8b5df77
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:08:55.3183
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

VGhlIGdyYWluIGluIGVkYWMgaXMgZGVmaW5lZCBhcyAibWluaW11bSBncmFudWxhcml0eSBmb3Ig
YW4gZXJyb3INCnJlcG9ydCwgaW4gYnl0ZXMiLiBUaGUgZm9sbG93aW5nIGNhbGN1bGF0aW9uIG9m
IHRoZSBncmFpbl9iaXRzIGluDQplZGFjX21jIGlzIHdyb25nOg0KDQoJZ3JhaW5fYml0cyA9IGZs
c19sb25nKGUtPmdyYWluKSArIDE7DQoNCldoZXJlIGdyYWluX2JpdHMgaXMgZGVmaW5lZCBhczoN
Cg0KCWdyYWluID0gMSA8PCBncmFpbl9iaXRzDQoNCkV4YW1wbGU6DQoNCglncmFpbiA9IDgJIyA2
NCBiaXQgKDggYnl0ZXMpDQoJZ3JhaW5fYml0cyA9IGZsc19sb25nKDgpICsgMQ0KCWdyYWluX2Jp
dHMgPSA0ICsgMSA9IDUNCg0KCWdyYWluID0gMSA8PCBncmFpbl9iaXRzDQoJZ3JhaW4gPSAxIDw8
IDUgPSAzMg0KDQpSZXBsYWNpbmcgaXQgd2l0aCB0aGUgY29ycmVjdCBjYWxjdWxhdGlvbjoNCg0K
CWdyYWluX2JpdHMgPSBmbHNfbG9uZyhlLT5ncmFpbiAtIDEpOw0KDQpUaGUgZXhhbXBsZSBnaXZl
cyBub3c6DQoNCglncmFpbl9iaXRzID0gZmxzX2xvbmcoOCAtIDEpDQoJZ3JhaW5fYml0cyA9IGZs
c19sb25nKDggLSAxKQ0KCWdyYWluX2JpdHMgPSAzDQoNCglncmFpbiA9IDEgPDwgMyA9IDgNCg0K
Tm90ZTogV2UgbmVlZCB0byBjaGVjayBpZiB0aGUgaGFyZHdhcmUgcmVwb3J0cyBhIHJlYXNvbmFi
bGUgZ3JhaW4gIT0gMA0KYW5kIGZhbGxiYWNrIHdpdGggYSB3YXJuX29uY2UgYW5kIDEgYnl0ZSBn
cmFudWxhcml0eSBvdGhlcndpc2UuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmVydCBSaWNodGVyIDxy
cmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRhYy9lZGFjX21jLmMgfCAxMCAr
KysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMgYi9kcml2ZXJzL2VkYWMv
ZWRhY19tYy5jDQppbmRleCA2NDkyMmM4ZmE3ZTMuLjQ1Y2FjNzRhYjgzMyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCkBA
IC0xMjM1LDkgKzEyMzUsMTUgQEAgdm9pZCBlZGFjX21jX2hhbmRsZV9lcnJvcihjb25zdCBlbnVt
IGh3X2V2ZW50X21jX2Vycl90eXBlIHR5cGUsDQogCWlmIChwID4gZS0+bG9jYXRpb24pDQogCQkq
KHAgLSAxKSA9ICdcMCc7DQogDQotCS8qIFJlcG9ydCB0aGUgZXJyb3IgdmlhIHRoZSB0cmFjZSBp
bnRlcmZhY2UgKi8NCi0JZ3JhaW5fYml0cyA9IGZsc19sb25nKGUtPmdyYWluKSArIDE7DQorCS8q
DQorCSAqIFdlIGV4cGVjdCB0aGUgaHcgdG8gcmVwb3J0IGEgcmVhc29uYWJsZSBncmFpbiwgZmFs
bGJhY2sgdG8NCisJICogMSBieXRlIGdyYW51bGFyaXR5IG90aGVyd2lzZS4NCisJICovDQorCWlm
IChXQVJOX09OX09OQ0UoIWUtPmdyYWluKSkNCisJCWUtPmdyYWluID0gMTsNCisJZ3JhaW5fYml0
cyA9IGZsc19sb25nKGUtPmdyYWluIC0gMSk7DQogDQorCS8qIFJlcG9ydCB0aGUgZXJyb3Igdmlh
IHRoZSB0cmFjZSBpbnRlcmZhY2UgKi8NCiAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1JBUykpDQog
CQl0cmFjZV9tY19ldmVudCh0eXBlLCBlLT5tc2csIGUtPmxhYmVsLCBlLT5lcnJvcl9jb3VudCwN
CiAJCQkgICAgICAgbWNpLT5tY19pZHgsIGUtPnRvcF9sYXllciwgZS0+bWlkX2xheWVyLA0KLS0g
DQoyLjIwLjENCg0K
