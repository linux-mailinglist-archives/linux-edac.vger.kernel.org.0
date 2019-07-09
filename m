Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD463D98
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfGIV5C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:57:02 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:26896
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729746AbfGIV5B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyPHsgtURL6T+a74kj4wNZwB1aIvnfuOaPlWgEPFECQ=;
 b=CCCPEdMoQuZFKOfQf0DSHIhLPSFSP2TPFz10s8EMnSZOvqpbbPavQorFGufShLl01+Pe7a44H8HOmZ07243813H3p+wFqMpo11WhyXry0eOSzA7IsbU1TxhClgCS2WxoYd7UafzA/hCU2jt2PW9EunTVAN+pf8K6t6renaIJpvU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:55 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:55 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 2/7] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Topic: [PATCH v2 2/7] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Index: AQHVNqE5pOXYz88VFEqxtA4lZ5p0QQ==
Date:   Tue, 9 Jul 2019 21:56:55 +0000
Message-ID: <20190709215643.171078-3-Yazen.Ghannam@amd.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f184685b-6f8f-4565-48b8-08d704b85b75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2814;
x-ms-traffictypediagnostic: SN6PR12MB2814:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2814E53D9B173DFA81389C1FF8F10@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(26005)(8936002)(4326008)(6486002)(54906003)(6916009)(6512007)(6436002)(5640700003)(6306002)(102836004)(1076003)(966005)(6506007)(52116002)(386003)(53936002)(76176011)(6116002)(68736007)(81156014)(25786009)(99286004)(316002)(50226002)(36756003)(186003)(2906002)(5660300002)(86362001)(11346002)(446003)(476003)(2616005)(81166006)(256004)(486006)(2501003)(66066001)(66476007)(66946007)(305945005)(3846002)(66446008)(71190400001)(66556008)(64756008)(71200400001)(478600001)(7736002)(14454004)(2351001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2814;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PY1YMuK6rQ850k7LRIMHxlZzvOxH02ilE+ly/4nWG0abjgNnQCkZP3ggi8qOIqTFy+citXAd5ytkFqZBOiiPS6P5ErIL9HJLzozxA6LVG3U00yU37hCch+kyG14A1pq2hNQMSwkP/qpjsRWlL6CJIJXDsS2uHdKpl6SYl1W8+WcxKT9E3ww7btBFqOpG8vi2q3u4xl7hP2ov80GLBE3AR+n8XhT2X5zwOFlTvhjeqCQFME4FocjNFKp10cWtcbQW2uaJrRbQNrKZcwYrhlaruWmaOx+VpeiC0TP6EESqWBrGwgPi+BcBvrsIvKWEpgMm4GCnHyGxzcFHaBx1Y9WNH9Wklfu/48q/d1Q7TESRsNUKeVdwwZsa8Mg6oNSCxvpAg+UonWbMfwwgBzi2jqaFrsJMY3BfvgAqk1AqVeLq7PE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f184685b-6f8f-4565-48b8-08d704b85b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:55.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Family 17h systems support x4 and x16 DRAM devices. However, the
device type is not checked when setting EDAC_CTL_CAP.

Set the appropriate EDAC_CTL_CAP flag based on the device type.

Fixes: 2d09d8f301f5 ("EDAC, amd64: Determine EDAC MC capabilities on Fam17h=
")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190531234501.32826-4-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index dd60cf5a3d96..125d6e2a828e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3150,12 +3150,15 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid=
)
 static inline void
 f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pv=
t)
 {
-	u8 i, ecc_en =3D 1, cpk_en =3D 1;
+	u8 i, ecc_en =3D 1, cpk_en =3D 1, dev_x4 =3D 1, dev_x16 =3D 1;
=20
 	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
+
+			dev_x4 &=3D !!(pvt->umc[i].dimm_cfg & BIT(6));
+			dev_x16 &=3D !!(pvt->umc[i].dimm_cfg & BIT(7));
 		}
 	}
=20
@@ -3163,8 +3166,12 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci=
, struct amd64_pvt *pvt)
 	if (ecc_en) {
 		mci->edac_ctl_cap |=3D EDAC_FLAG_SECDED;
=20
-		if (cpk_en)
-			mci->edac_ctl_cap |=3D EDAC_FLAG_S4ECD4ED;
+		if (cpk_en) {
+			if (dev_x4)
+				mci->edac_ctl_cap |=3D EDAC_FLAG_S4ECD4ED;
+			else if (dev_x16)
+				mci->edac_ctl_cap |=3D EDAC_FLAG_S16ECD16ED;
+		}
 	}
 }
=20
--=20
2.17.1

