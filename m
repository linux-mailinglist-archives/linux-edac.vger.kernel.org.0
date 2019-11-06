Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642F0F0BA6
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 02:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfKFBZQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 20:25:16 -0500
Received: from mail-eopbgr800054.outbound.protection.outlook.com ([40.107.80.54]:39808
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbfKFBZF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 20:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzgIkQUDFUUgmhlVBoyD/6Ob1v78eu5gcyWaCp98+qBvVIqwbcUzlEwZXJlKzb3up5UYIgjCyAc4rNYVrB+f4h7TJcik8aKgt5wR/b1PFn3sM2WUWH/LpaTFLp6MYRzC8wtq9KyV82GOwY5jpXiY5wpIC3POyC0+Urce/fVV/vL0hRWvQRnKOL3ftHZUGbNXPTOep0anCXjSoIJhUiSbcwgdvTJiuOmTiWvL2Jc1HrOfwzEgefp8YRiAroEWG270jBmjEawzb5RT72hLmywnSE6hshmzgXyMIbez/InNKdZMGIMuaZi++pW9w8R24vJFL8aXM924XN3ddqX/6vb+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFnFpeiHLxHuwwAQPvDusAhpZzbpRMDC5IDK4TU+I44=;
 b=B23gOIy4Hoi+/ZfuImj2Tj5KOXKVqcehk6D5AfIl/f5tFqM4NbcZ8bhoszvGMYNk2401mX4aJHaCQWxyMk58Ggk7TakS8GQGipw0+iN01KHry3Yu2guozqHSIL/keDmEJgaUY2gwNuyJ8mNQCQfWKWttK4tqLu41K3K5MS4Ppv82f1Rv0PoNELmrDPYAowjeDAXcUE5LNs7Do/e90nQO0QWWKKDdBOPR2QaIR7m9XXUpEZEq6z012EPcUdHSNjpJh+lnNAgy2APkpZ+uw3aO2i1Yo+0CsleJ/NTGzSmhu6RzAjOittXWyuDUM7NpOjRAKMgk8MWf7GtY2ET7Dek8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFnFpeiHLxHuwwAQPvDusAhpZzbpRMDC5IDK4TU+I44=;
 b=L9gYh4X7BMHjiMZZUgKQFfMs1dImR4ej22nDWT7LqX96zq7IbwaqzWLbHKv/RVvEFepMOt7k8IM4K1kSWR+PcgN2keiNS/CEI2yeos55q38VscRmnZ+8pXuTzKN8SBrpYzlsK9GlAFH4vumStlSzES+cdlpjR55EFc73PFOFg5Q=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2701.namprd12.prod.outlook.com (52.135.103.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 01:25:01 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:25:01 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 3/5] EDAC/amd64: Save max number of controllers to family
 type
Thread-Topic: [PATCH v3 3/5] EDAC/amd64: Save max number of controllers to
 family type
Thread-Index: AQHVlEEC70osO2cD0kWlJdLy5vMoKg==
Date:   Wed, 6 Nov 2019 01:25:00 +0000
Message-ID: <20191106012448.243970-4-Yazen.Ghannam@amd.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7b3fe88-c0e2-46a3-1828-08d762582485
x-ms-traffictypediagnostic: SN6PR12MB2701:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB270196987C4F4CEF239657B5F8790@SN6PR12MB2701.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(6116002)(81156014)(36756003)(3846002)(6486002)(6306002)(476003)(81166006)(6512007)(66946007)(1076003)(54906003)(2616005)(6506007)(4326008)(76176011)(71200400001)(71190400001)(2501003)(7736002)(11346002)(305945005)(52116002)(2906002)(256004)(5660300002)(446003)(99286004)(186003)(316002)(102836004)(26005)(6916009)(64756008)(66446008)(2351001)(66556008)(66066001)(8676002)(386003)(25786009)(14454004)(966005)(478600001)(50226002)(6436002)(86362001)(8936002)(5640700003)(486006)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2701;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHcyY+4U3xAbTCLc24NS/jT7BvmYnz3V1RnjVr1PQQn/vGkoM2xW/FyR9bXjr+41C3739Im4m3SMK3oJgMvCKIBgbHVCfsCVYh/phOxd7rm/KMlK0FQIjbhdhqqc1JIHv/yFkAfLCujK7bJL5gXW3pqXhPdmM0dZYQ81P7P/Fmw8iYi36mWolRfWkQPsMHXHz/LN2xh5ruL7/EJNQRjhKssvSgcTmOVbGXsu0QUrAQ6EyAaw7WoTAc6/+ZpuqnScPXa7rB4d0LyV6Z89Su2iNbHfQEWLcImXKj039Sgq1WxKnmbknheT/sG7WJDrI/aQfV3RLrJpRYUupfhjMOMD2GHy7A6z7fsvy7hwu2m5JojuU1nLe9FeJRj9f/q+R6kluat5foFbCsFyLFWyhTbaCh2OsNgMwL3Bw88m8+4fqws6zj8ClYdYkkJkjgFqPx5OUFXthNdsHuoFppvE3sCaldKjwXPZtJYJRQtdA/Oc2rM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b3fe88-c0e2-46a3-1828-08d762582485
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:25:00.7439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SONIPVr05ZeV3AsR6ZhZu1xv3yvQwCiJ9y8YFDcjuOm7jPP8fxH4qEkN4i60q9kOCcxw32quat5aK/GB43BQAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The maximum number of memory controllers is fixed within a family/model
group. In most cases, this has been fixed at 2, but some systems may
have up to 8.

The struct amd64_family_type already contains family/model-specific
information, and this can be used rather than adding model checks to
various functions.

Create a new field in struct amd64_family_type for max_mcs.
Set this when setting other family type information, and use this when
needing the maximum number of memory controllers possible for a system.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191022203448.13962-4-Yazen.Ghannam@amd.com

v2 -> v3:
* No change.

v1 -> v2:
* Change max_num_controllers to max_mcs.

rfc -> v1:
* New patch.
* Idea came up from Boris' comment about compute_num_umcs().

 drivers/edac/amd64_edac.c | 44 +++++++++++++--------------------------
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6e1c739b7fad..110ed0d27998 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -21,9 +21,6 @@ static struct amd64_family_type *fam_type;
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
=20
-/* Number of Unified Memory Controllers */
-static u8 num_umcs;
-
 /*
  * Valid scrub rates for the K8 hardware memory scrubber. We map the scrub=
bing
  * bandwidth to a valid bit pattern. The 'set' operation finds the 'matchi=
ng-
@@ -456,7 +453,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt,=
 int csrow, u8 dct,
 	for (i =3D 0; i < pvt->csels[dct].m_cnt; i++)
=20
 #define for_each_umc(i) \
-	for (i =3D 0; i < num_umcs; i++)
+	for (i =3D 0; i < fam_type->max_mcs; i++)
=20
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Retu=
rn the
@@ -2226,6 +2223,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "K8",
 		.f1_id =3D PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
 		.f2_id =3D PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D k8_early_channel_count,
 			.map_sysaddr_to_csrow	=3D k8_map_sysaddr_to_csrow,
@@ -2236,6 +2234,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F10h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_10H_NB_MAP,
 		.f2_id =3D PCI_DEVICE_ID_AMD_10H_NB_DRAM,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2246,6 +2245,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F15h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_15H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_15H_NB_F2,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2256,6 +2256,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F15h_M30h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2266,6 +2267,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F15h_M60h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2276,6 +2278,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F16h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_16H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_16H_NB_F2,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2286,6 +2289,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F16h_M30h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2296,6 +2300,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_DF_F6,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -2305,6 +2310,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h_M10h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -2314,6 +2320,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h_M30h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
+		.max_mcs =3D 8,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -2323,6 +2330,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h_M70h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
+		.max_mcs =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -3402,29 +3410,13 @@ static const struct attribute_group *amd64_edac_att=
r_groups[] =3D {
 	NULL
 };
=20
-/* Set the number of Unified Memory Controllers in the system. */
-static void compute_num_umcs(void)
-{
-	u8 model =3D boot_cpu_data.x86_model;
-
-	if (boot_cpu_data.x86 < 0x17)
-		return;
-
-	if (model >=3D 0x30 && model <=3D 0x3f)
-		num_umcs =3D 8;
-	else
-		num_umcs =3D 2;
-
-	edac_dbg(1, "Number of UMCs: %x", num_umcs);
-}
-
 static int hw_info_get(struct amd64_pvt *pvt)
 {
 	u16 pci_id1, pci_id2;
 	int ret =3D -EINVAL;
=20
 	if (pvt->fam >=3D 0x17) {
-		pvt->umc =3D kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc =3D kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KE=
RNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
=20
@@ -3477,14 +3469,8 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * Always allocate two channels since we can have setups with DIMMs on
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
-	 *
-	 * On Fam17h+, the number of controllers may be greater than two. So set
-	 * the size equal to the maximum number of UMCs.
 	 */
-	if (pvt->fam >=3D 0x17)
-		layers[1].size =3D num_umcs;
-	else
-		layers[1].size =3D 2;
+	layers[1].size =3D fam_type->max_mcs;
 	layers[1].is_virt_csrow =3D false;
=20
 	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -3669,8 +3655,6 @@ static int __init amd64_edac_init(void)
 	if (!msrs)
 		goto err_free;
=20
-	compute_num_umcs();
-
 	for (i =3D 0; i < amd_nb_num(); i++) {
 		err =3D probe_one_instance(i);
 		if (err) {
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 8c3cda81e619..9be31688110b 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -479,6 +479,8 @@ struct low_ops {
 struct amd64_family_type {
 	const char *ctl_name;
 	u16 f0_id, f1_id, f2_id, f6_id;
+	/* Maximum number of memory controllers per die/node. */
+	u8 max_mcs;
 	struct low_ops ops;
 };
=20
--=20
2.17.1

