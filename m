Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79E5E0D53
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfJVUfW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:22 -0400
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:26304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731110AbfJVUfV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofHJFZ/bD9PTONAAJiIWiDSJao76I8UGG0JcYh315ybdwBUVP7m9/22gn1mqEWdtbIPch9nAqskEW8z1Cs/OZpoPpNSr7E8sDNFUQqtp+DrXTereduxTgE9yWOEBd1ymOoziyw4o+xULo45tYP4ZTORjLEQWS4ltjBM9YuyF+2HBGQ6fSK50BG1XbwDSwhcxROiboFwjJKTsjrt6n+vYcwPyd/tGqnp2TEhb8Mgm+iiROldFUx3ewIZ8Yn2CvEmcP1NAz2QoQzdhKnp0jYPdV7rPeysB/QAuOCAr4r8KA+MtkrXf2hRl0M/inz0Ou9YX/Dqvk11dOlg7u3y/bP8vLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO9bVOotzprOucOpMOuK8V+3gINZ+LiG3RgkAEcvtb4=;
 b=CJ6C8iQs5SDmJ9fEb/2i/Ay8ImFGztzqLMpfjNqx3BbQe6jr0fE82ljZLiprX5SkJtNKGE4LhuN3OThGkU3lgoLwicw14W0LNIZ5lAWkPD07aC4bg4NR8w6ZtlgqYZE5ZD9Nzb84FlR/NfLs1J2Okk6eNJhi0Dd2aTMzQ8JgMAArGAVATchCD0aMULft6hZBOUBQEUOL+816LW8HO3vGZUtzva3RgPHMn6SDA/kIY3/C0KqET1lpIh4rPZPhrmqbD6zmuim3YR+42idnv2cg9M/VGTf+6GUyNlmYav+AgCyoooA7DO+AVYypRrEuHjhshvBidbbTzAvgG9AkF8l2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO9bVOotzprOucOpMOuK8V+3gINZ+LiG3RgkAEcvtb4=;
 b=BH1174rJLXQ32oyYLu8FEZB2mfV38ok5HvEdwiDa9llbVnu+OPV6L1lAMr1kK1NMJJXUoNSy5M7IVrGSPIH+glYvoueHJ+8MQ/s2ZTJIdw9IlAGk1+iAEYu3g/1+CqJusSr90IpV05CiD4zJ6jOTGpyypsQMt+E7UkhjjY3ZcXY=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:35:11 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:11 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 3/6] EDAC/amd64: Save max number of controllers to family
 type
Thread-Topic: [PATCH v2 3/6] EDAC/amd64: Save max number of controllers to
 family type
Thread-Index: AQHViRgzk6Mt/xzuLkO1rf5vfT5Wag==
Date:   Tue, 22 Oct 2019 20:35:11 +0000
Message-ID: <20191022203448.13962-4-Yazen.Ghannam@amd.com>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0024.namprd05.prod.outlook.com
 (2603:10b6:803:40::37) To BN7PR12MB2628.namprd12.prod.outlook.com
 (2603:10b6:408:30::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58befb58-9e51-46c8-9b0e-08d7572f55c6
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB272435657835375E9C28886FF8680@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(36756003)(54906003)(316002)(2906002)(256004)(66066001)(6916009)(52116002)(71200400001)(71190400001)(76176011)(2351001)(2501003)(6116002)(26005)(99286004)(186003)(6512007)(4326008)(6436002)(966005)(1076003)(102836004)(305945005)(5640700003)(7736002)(6486002)(386003)(6506007)(6306002)(14454004)(3846002)(478600001)(2616005)(486006)(476003)(8936002)(66446008)(11346002)(446003)(50226002)(66476007)(81166006)(66556008)(64756008)(8676002)(81156014)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2724;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBRNYlc9Z9YPSBLx05NWqHGdcuRliO7a7m9TKreWGYq3LrQ7OM83Yfxa3XqXqd70HNp7moJmUhtJ6QPg202jMr71nQ5HjbxvCnSpzwn9//uobE4+qce/kV6kAuIuFjsQFSrru957Q+JnNa0/MOGQw+KuZVxSQatZUE6T44cA1gMCMUBP6pKiwKFeGObr8znOnPG9wzGTyL1QE4AODaZT9k3UrryPzEcSMaVc2L/wvPq4RzuJbsTt2S/TYqf97Snuk5mKksT+v6K4N0ImgmjECgcHTZ/s5JFKV2RWOm/fY0B6pukEEY0rktbNCSUDhhrl6lcJMH97ngST9hVP3uv0v0M4jPktuB7Tz7Me10QUpPz5Z9wcIoor7YNo3IYBD3b71f35i1w2aj6DkCTxdwLg5AQMo82XfGgDYQL/5j0cjo26MtrP53c7Qg5RMekLG3T7unrDg+CRPdCzIKNZUEekhZkG2L5qLcYGHoSKrDr38js=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58befb58-9e51-46c8-9b0e-08d7572f55c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:11.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OQMKXQEBLJkJyM2lZqFGZsYXs3Q2PQ5y/+QY1qPVogTj6tz8sVOKrgYNaHPUEQZ9I6GadVhPlz0cacwl/LJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
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
https://lkml.kernel.org/r/20191018153114.39378-4-Yazen.Ghannam@amd.com

v1 -> v2:
* Change max_num_controllers to max_mcs.

rfc -> v1:
* New patch.
* Idea came up from Boris' comment about compute_num_umcs().

 drivers/edac/amd64_edac.c | 44 +++++++++++++--------------------------
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index df7dd9604bb2..2d8129c8d183 100644
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
@@ -3400,29 +3408,13 @@ static const struct attribute_group *amd64_edac_att=
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
@@ -3475,14 +3467,8 @@ static int init_one_instance(struct amd64_pvt *pvt)
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
@@ -3667,8 +3653,6 @@ static int __init amd64_edac_init(void)
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

