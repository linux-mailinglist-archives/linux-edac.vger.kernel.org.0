Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31363DA4
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfGIV5S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:57:18 -0400
Received: from mail-eopbgr690059.outbound.protection.outlook.com ([40.107.69.59]:63872
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729747AbfGIV5B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHVwckEF35iOrFCII3mv3LrZqfjHW6HxFdFak1/ewvc=;
 b=EViXgRQURrL9FQnX1c6N9jbeX0zqqvJDvYcVwxZROEakARwOXA5DeeWzwgm8t+BU5vhejAAz0nRX8k1OCmv9bXJDhSgPEu0XBfmIbcPnS4zSNsWnoblc5pKl4om6Nm4JE1pgVrdGQa36CYa5WaZ+mDnULgkXCsChZULajAZT8Rs=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2718.namprd12.prod.outlook.com (52.135.103.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:57 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:57 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 6/7] EDAC/amd64: Cache secondary Chip Select registers
Thread-Topic: [PATCH v2 6/7] EDAC/amd64: Cache secondary Chip Select registers
Thread-Index: AQHVNqE6xKfZtgC1qUiNE6fs31rm+w==
Date:   Tue, 9 Jul 2019 21:56:57 +0000
Message-ID: <20190709215643.171078-7-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 77f57db5-6a47-4337-b4e1-08d704b85cde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2718;
x-ms-traffictypediagnostic: SN6PR12MB2718:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2718A643FB5EF36D30FE409AF8F10@SN6PR12MB2718.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(199004)(189003)(6506007)(53936002)(386003)(76176011)(26005)(2351001)(186003)(2501003)(256004)(6116002)(99286004)(52116002)(102836004)(6306002)(2906002)(6512007)(68736007)(1076003)(6916009)(305945005)(5660300002)(66066001)(3846002)(6436002)(50226002)(66446008)(66556008)(66476007)(66946007)(64756008)(71200400001)(36756003)(71190400001)(2616005)(8676002)(81166006)(966005)(25786009)(316002)(81156014)(446003)(4326008)(54906003)(11346002)(8936002)(14454004)(486006)(478600001)(86362001)(5640700003)(7736002)(6486002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2718;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SCZE2SdySCk8r9Y1V0ErbePWoDhNroH2f6CiZk1NvetQXmC0q5gjhiSduiuRw5UHVbJ7xOCNN8EyLUf/MUFasraJNs389XiqmTjv1exlEEvO/eKL+IZsh80S575YPE5NkwVrKGF+7uMblEkh8UkW6ZMXl6/ky39a+VTAGoRiVQWiVJZjpWmY2/ihXqWqgdsrwE7bC6jrWSyCifL9fMQBKCqZNJCkZRkSsHj/OjXXjCu+JQBLiNAwHTIuTlO7jVRaY9dzjcybcpn8uEQebK0TWW3R8n9na4mYiBHaKKMf1cGvPmBrtZiFvsnv7Mni7WcAaUcAMLZJaU8F2KPjDsO1b3iJ1VfLyw57f9w1UPkLvMZTl4c2zbvckdY3Cx0neKcYe8hciKcWuuAse90ht9ph1FX0eusheM9/+iLC0DYau5E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f57db5-6a47-4337-b4e1-08d704b85cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:57.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Family 17h systems have a set of secondary Chip Select Base
Addresses and Address Masks. These do not represent unique Chip
Selects, rather they are used in conjunction with the primary
Chip Select registers in certain use cases.

Cache these secondary Chip Select registers for future use.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190531234501.32826-8-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 23 ++++++++++++++++++++---
 drivers/edac/amd64_edac.h |  4 ++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4058b24b8e04..006417cb79dc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -943,34 +943,51 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
=20
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
-	u32 umc_base_reg, umc_mask_reg;
-	u32 base_reg, mask_reg;
-	u32 *base, *mask;
+	u32 umc_base_reg, umc_base_reg_sec;
+	u32 umc_mask_reg, umc_mask_reg_sec;
+	u32 base_reg, base_reg_sec;
+	u32 mask_reg, mask_reg_sec;
+	u32 *base, *base_sec;
+	u32 *mask, *mask_sec;
 	int cs, umc;
=20
 	for_each_umc(umc) {
 		umc_base_reg =3D get_umc_base(umc) + UMCCH_BASE_ADDR;
+		umc_base_reg_sec =3D get_umc_base(umc) + UMCCH_BASE_ADDR_SEC;
=20
 		for_each_chip_select(cs, umc, pvt) {
 			base =3D &pvt->csels[umc].csbases[cs];
+			base_sec =3D &pvt->csels[umc].csbases_sec[cs];
=20
 			base_reg =3D umc_base_reg + (cs * 4);
+			base_reg_sec =3D umc_base_reg_sec + (cs * 4);
=20
 			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
 				edac_dbg(0, "  DCSB%d[%d]=3D0x%08x reg: 0x%x\n",
 					 umc, cs, *base, base_reg);
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, base_sec))
+				edac_dbg(0, "    DCSB_SEC%d[%d]=3D0x%08x reg: 0x%x\n",
+					 umc, cs, *base_sec, base_reg_sec);
 		}
=20
 		umc_mask_reg =3D get_umc_base(umc) + UMCCH_ADDR_MASK;
+		umc_mask_reg_sec =3D get_umc_base(umc) + UMCCH_ADDR_MASK_SEC;
=20
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask =3D &pvt->csels[umc].csmasks[cs];
+			mask_sec =3D &pvt->csels[umc].csmasks_sec[cs];
=20
 			mask_reg =3D umc_mask_reg + (cs * 4);
+			mask_reg_sec =3D umc_mask_reg_sec + (cs * 4);
=20
 			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
 				edac_dbg(0, "  DCSM%d[%d]=3D0x%08x reg: 0x%x\n",
 					 umc, cs, *mask, mask_reg);
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, mask_sec))
+				edac_dbg(0, "    DCSM_SEC%d[%d]=3D0x%08x reg: 0x%x\n",
+					 umc, cs, *mask_sec, mask_reg_sec);
 		}
 	}
 }
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4dce6a2ac75f..68f12de6e654 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -259,7 +259,9 @@
=20
 /* UMC CH register offsets */
 #define UMCCH_BASE_ADDR			0x0
+#define UMCCH_BASE_ADDR_SEC		0x10
 #define UMCCH_ADDR_MASK			0x20
+#define UMCCH_ADDR_MASK_SEC		0x28
 #define UMCCH_ADDR_CFG			0x30
 #define UMCCH_DIMM_CFG			0x80
 #define UMCCH_UMC_CFG			0x100
@@ -312,9 +314,11 @@ struct dram_range {
 /* A DCT chip selects collection */
 struct chip_select {
 	u32 csbases[NUM_CHIPSELECTS];
+	u32 csbases_sec[NUM_CHIPSELECTS];
 	u8 b_cnt;
=20
 	u32 csmasks[NUM_CHIPSELECTS];
+	u32 csmasks_sec[NUM_CHIPSELECTS];
 	u8 m_cnt;
 };
=20
--=20
2.17.1

