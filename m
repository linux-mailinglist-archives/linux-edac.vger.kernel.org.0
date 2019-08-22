Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C498837
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfHVAAG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:06 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731080AbfHVAAG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MocxT42czXV733CA0etzGEG6vd0tmjtrZX1/l/exNcDihf98C157pLmtEvoaFSxbSbagstum1GL25AHZq1hp6J8Q6OAh8NF8/eJfRlfiMSV0kbfVL7l4g9/nHw0GUUOXsoBQ1q50j/baEnvqO7CHoyvVKtMWw/qguVfyJGmeAttfpO3qQosz7igNdojUUAr89hcjvw8L3q52u+Pd9tpE/Eq8ADHofxDh8pSytZDgieX9wSfVD12XRNBY4iquzbEOlXKq/26kDCzMn4msL/15oj0IPhHcCjb1qz+OSrKLQJUyN+gyTqH1IqYkoHJXDvq2umlxyaTZgs++c53QfruXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kN04XJ5YS3h6voXVlaTE8lfOy1LM0kDpjF+qFuClQM=;
 b=WvX3td9yDu4WBHiNS4ywKS7M0xZctVs2L0P7nMdenOAJAIzsIlh89PRfCgDnn90qiqsor4xsWM8svmCHoLQlNMS+mfSL5UqlFHx8/lsEr5bcwDZW17F01oRAPqNGx069vqxlNesz7ogzPVWiSa8p8ZQKD7CTH/cGxvLful4z8yFrGJXjASL43GYVQbLjyxh+ywwhvrgKM9VLaI1eOaDOJSHesL9mN+BdaGU/SFQc3/58BFZy26HctJeTvG2dHXvMRJEldDLU7KI5ArNMUvC6OK8Jht9FCVXoGoOsIcjuls8fMxFN1ED8gKsGxVWYURQvjhShewNh+Tu3yghOoiuemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kN04XJ5YS3h6voXVlaTE8lfOy1LM0kDpjF+qFuClQM=;
 b=q0ff6uVQFFDU2in5uQw+Gtkz6p26CVwErs4wutnm7tPYaStJTU3br1AJqc1T5fqbtnsfKoEUnULCP7eO73LiBFIMkhBU8Gtlq9VeM26lNXq8B5QO1kgXqTPo2mx8J/pbz4TJpxxfzgQcsuAX+B51hbHG49yeEBIvejpHOxyJ4/s=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:01 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:01 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 6/8] EDAC/amd64: Cache secondary Chip Select registers
Thread-Topic: [PATCH v3 6/8] EDAC/amd64: Cache secondary Chip Select registers
Thread-Index: AQHVWHyL4zxrBSGx3kmn69guUrmUbA==
Date:   Thu, 22 Aug 2019 00:00:01 +0000
Message-ID: <20190821235938.118710-7-Yazen.Ghannam@amd.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0006.prod.exchangelabs.com (2603:10b6:804:2::16)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0052a4b8-895c-43a6-30f3-08d72693adb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815D653F012F302E4F6FCD2F8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GhpIG2a6tO2dPOH7qE38vZuJ6pdz0qkvmKOFdLFRKmBpnM/N2AR1MhXfAeLdmyjbysi3jRfMYBI8bUsb/XLKP4dvMlIXeZzCZf4I1LSI/JZboXkiApzNybAHro9pzFX2ia+vxmZxQiveE78RvYmH4hGGVeLuPILOTnqUBIvlx0zXCEjeQSIV+erafwf06BMxQJqcxB+KFbFfgCqPcMJQWeEFg55upE4pJ/dpFCD7HkFwlXuIkekQElhzePBfatxW+us/y36sTVgddeMW34RqQY/MfP0mTHh0Ir3qSjB2ugQZ/LWwgdj1twMev1YlfsA0h923/+8cVn+XH7lEPmIndQNJKb/b7hUglKImZ1PHI99kJCjF3LtyX/q6s87THzFqQv8eGPHr/SRNHC+2w1fPO9DQDVZFiP2wSBD5sAGgK/4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0052a4b8-895c-43a6-30f3-08d72693adb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 00:00:01.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN9K9k6d4Iqg7mJm5JScmVlIADhO6tcE2dCIeoD/+ocZYL1e5pphzx/U57O7nIEBplbyDJT593BG4VQg1wM+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
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
https://lkml.kernel.org/r/20190709215643.171078-7-Yazen.Ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 23 ++++++++++++++++++++---
 drivers/edac/amd64_edac.h |  4 ++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index de141de7b2e5..26ce48fcaf00 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -946,34 +946,51 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
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

