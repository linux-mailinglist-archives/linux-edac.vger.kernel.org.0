Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332BD31850
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfEaXpU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:20 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfEaXpT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLR7UAiy44pyTP+Qc8tFreGh9ems86s6MGpjNjB7q4s=;
 b=F5PcexzvLVer4Ine0hTB4A0z75ogBC0TFHizx6D6Gyt/g/T5xCSUCFHIxuJsxRG06wP8DgS/+jlreco1XDsQLCgKNeGYFfK7kOJ6LNukoygIIufgrFPiJIRYHqahXwOE/vNvar1HQUJzK3/OJ+3fi3ehqHjI00T3swSArkZs834=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 23:45:12 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 23:45:12 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 1/8] EDAC/amd64: Fix number of DIMMs and Chip Select
 bases/masks on Family17h
Thread-Topic: [PATCH 1/8] EDAC/amd64: Fix number of DIMMs and Chip Select
 bases/masks on Family17h
Thread-Index: AQHVGArj49LndWtr30OrnYGuWE2J2Q==
Date:   Fri, 31 May 2019 23:45:11 +0000
Message-ID: <20190531234501.32826-2-Yazen.Ghannam@amd.com>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b108e9d-11ec-401e-553b-08d6e6220565
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB2671F7B28CE917CBE089258DF8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(14444005)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(76176011)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(446003)(66476007)(476003)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(11346002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bvcSrTJK0Ko/V+ByPfB6iaitzsqvuTcZm8Xgmkt9M6YJ9QgBKBi7vriwZPKarxUmsF1NLi5jkYdi469ZM2oxPMJhJw3nU67ADCiTI4NnzFd3C7Npxb/AECdwLeun5kmxWLNEv07GhP19WgExsrlXSVZrSwNyVsdIYoOWS+O0prJb08H34CZ1OcLtL0J8cGIQAGRkTWpPYOb8OTSYDxMaa/EB4nYo0jhVfghgOZYvJyUz577bY1nI+HWxDsgCkQgGpjrHFvaVUKKiDdxAbVmwUMRB8EkYmwVFDEp8Mqfk9b55Hs0od/GgXsaG1x4nGr7XZLlrYpYF2Pzf3WYKtDlIip5N/zpyGEIIXkUHyJrxAICP8MCxlxDRD4GywnRjQ6LMu8rxkQ3JbNV1AYmGrBKjL8X2upCGA9K6BVveduHtxEw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b108e9d-11ec-401e-553b-08d6e6220565
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:11.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQouLi5iZWNhdXNl
IEFNRCBGYW1pbHkgMTdoIHN5c3RlbXMgc3VwcG9ydCAyIERJTU1zLCA0IENTIGJhc2VzLCBhbmQg
MiBDUw0KbWFza3MgcGVyIGNoYW5uZWwuDQoNCkZpeGVzOiAwN2VkODJlZjkzZDYgKCJFREFDLCBh
bWQ2NDogQWRkIEZhbTE3aCBkZWJ1ZyBvdXRwdXQiKQ0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hh
bm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9lZGFjL2FtZDY0X2Vk
YWMuYyB8IDUgKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jIGIvZHJpdmVy
cy9lZGFjL2FtZDY0X2VkYWMuYw0KaW5kZXggODczNDM3YmU4NmQ5Li45ZmEyZjIwNWYwNWMgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQorKysgYi9kcml2ZXJzL2VkYWMv
YW1kNjRfZWRhYy5jDQpAQCAtODEwLDcgKzgxMCw3IEBAIHN0YXRpYyB2b2lkIGRlYnVnX2Rpc3Bs
YXlfZGltbV9zaXplc19kZihzdHJ1Y3QgYW1kNjRfcHZ0ICpwdnQsIHU4IGN0cmwpDQogDQogCWVk
YWNfcHJpbnRrKEtFUk5fREVCVUcsIEVEQUNfTUMsICJVTUMlZCBjaGlwIHNlbGVjdHM6XG4iLCBj
dHJsKTsNCiANCi0JZm9yIChkaW1tID0gMDsgZGltbSA8IDQ7IGRpbW0rKykgew0KKwlmb3IgKGRp
bW0gPSAwOyBkaW1tIDwgMjsgZGltbSsrKSB7DQogCQlzaXplMCA9IDA7DQogCQljczAgPSBkaW1t
ICogMjsNCiANCkBAIC05NDIsNiArOTQyLDkgQEAgc3RhdGljIHZvaWQgcHJlcF9jaGlwX3NlbGVj
dHMoc3RydWN0IGFtZDY0X3B2dCAqcHZ0KQ0KIAl9IGVsc2UgaWYgKHB2dC0+ZmFtID09IDB4MTUg
JiYgcHZ0LT5tb2RlbCA9PSAweDMwKSB7DQogCQlwdnQtPmNzZWxzWzBdLmJfY250ID0gcHZ0LT5j
c2Vsc1sxXS5iX2NudCA9IDQ7DQogCQlwdnQtPmNzZWxzWzBdLm1fY250ID0gcHZ0LT5jc2Vsc1sx
XS5tX2NudCA9IDI7DQorCX0gZWxzZSBpZiAocHZ0LT5mYW0gPj0gMHgxNykgew0KKwkJcHZ0LT5j
c2Vsc1swXS5iX2NudCA9IHB2dC0+Y3NlbHNbMV0uYl9jbnQgPSA0Ow0KKwkJcHZ0LT5jc2Vsc1sw
XS5tX2NudCA9IHB2dC0+Y3NlbHNbMV0ubV9jbnQgPSAyOw0KIAl9IGVsc2Ugew0KIAkJcHZ0LT5j
c2Vsc1swXS5iX2NudCA9IHB2dC0+Y3NlbHNbMV0uYl9jbnQgPSA4Ow0KIAkJcHZ0LT5jc2Vsc1sw
XS5tX2NudCA9IHB2dC0+Y3NlbHNbMV0ubV9jbnQgPSA0Ow0KLS0gDQoyLjE3LjENCg0K
