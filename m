Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63366DC883
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408745AbfJRPbc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:32 -0400
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:25120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408746AbfJRPba (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNQc3BSBxm+q46DenpSj1at9nMR9pSt+GJZTxeRqvirF2CCPR8fB4+gOnYgLSEhO8RBXH2fKngr/Yf8vc5dgHQxGnBERPBqcNkToNS1eg5nk9kJL0X8Uds9fPTkyQ+S+2nWNZ3Imir3NabBRLcx9RndCcVa3xJKDmQxOLqv85SPQsAuMKXgOA00xuMHh2hnahB65VYXYHaA49LrH84zW3LkJRP8QpNzYvVZMfInFGadkV5FSveKY04raQ/OORNgppGKxuBKt6jocI16bbc6WGcJ1PqEObCxfYpC3swk7jt/Yb5m1+pOTF1euwQQaDFwEPuPS7J6UxY3j4Aj+Ad/ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdDnu0mZPu9t0RGqUjxBqXtlbVQYMmOr6qufEl7SIbs=;
 b=cVph4N2aQPuEgL8WV8bg9LXH+Em1bmVk25q0LSDWYO1tNA4bP0Bt9RuAvXFsN0sxjqrMD46qRrcYz1eo4X73DV0qzQY19CyzhAaIeuTwh+EVtLzWxUsWqu/Qat4L2ogsr5KeoOwZas9uSWvjSqsAtBdGzz7xyoK/Wxh9oWSPU6hSlSNj7K2RZZB0Vlev9Ay5dBy3J6a8JqoTdELymu2KFWaT3w3jdIofOgxp2O8oCft5RKjYeJdlx3AxBlVYUNyYnRW7dvFcmBMmGHqs1TNlf6ZHLH3KmlXIawDFU9Jqak5/QbomO+wPaUiNnS5h73riwh4JXb0INO3Lqa+PwBABAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdDnu0mZPu9t0RGqUjxBqXtlbVQYMmOr6qufEl7SIbs=;
 b=OewSOiedztjwZb+iwHVRzYXeF+k9dGXBfiS9bkgnXI1qb8/i38lyPysdgCRyijDaYXiwa7xweZxGiu0guDyv/ld72QIu1wxws4F8QBJbyq/uP74Dh48ORF9hqBVJP19LM3puP01eqaGH2D4aAyk9daqNypypjvvskDsfsXluyHI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 15:31:27 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:31:27 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 3/6] EDAC/amd64: Save max number of controllers to family type
Thread-Topic: [PATCH 3/6] EDAC/amd64: Save max number of controllers to family
 type
Thread-Index: AQHVhckbtn+w81QWL0WFYihGLnPZQw==
Date:   Fri, 18 Oct 2019 15:31:26 +0000
Message-ID: <20191018153114.39378-4-Yazen.Ghannam@amd.com>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a56fd85f-b561-4beb-a211-08d753e03d82
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2670:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2670C029A16B9D5C7A68E8CBF86C0@SN6PR12MB2670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6512007)(6306002)(1076003)(316002)(3846002)(4326008)(6116002)(66946007)(66066001)(25786009)(256004)(66476007)(5660300002)(6916009)(2351001)(66556008)(66446008)(14454004)(26005)(486006)(76176011)(99286004)(52116002)(305945005)(2616005)(446003)(11346002)(50226002)(7736002)(476003)(2501003)(478600001)(6436002)(2906002)(5640700003)(6506007)(102836004)(71200400001)(36756003)(966005)(8676002)(64756008)(186003)(81166006)(81156014)(8936002)(6486002)(86362001)(386003)(71190400001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2670;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M62KFx1eRu6ZYZIMO0KP2b78KGPUOGkJCR0RgBcisChOZLtrsgIOWsRDFV5OTCSgFdJPe2jiFMYNePNk7rZHQOwXA03im0cJKtVJCGFunMDwYkucgLIJH7202DH+lXpE7r5z17Al0evP4dGWexmRfUgYaiUDmTo5M33AK/Q/azFFRJjD78BZ7nQPnXSrG/CLt/C60gY06eCmRufy9sThg0qKsPM3syGbWm/HnnlQNY2N9xbrVa97cuucYUpEaSi9WDOdmp41FBv3FCHEZeRmLdVGCrhgrYOyRrjDzOwUIt4qYts+D/mB9heqFx3ZLWkJpRKGhOCwcZvHj19SaNo4AksKV/mMFWWIOvgF34ZZku7Lr2snFie2nM9Eae9z9219AWXMmPQakH5a5xyZdo2jFGzDNhPGQAN/Xfe8HQlVpZUbzq151VEAVVrMTO0CTeBvHS+GdIYVc10DCn1Bq3JMyQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56fd85f-b561-4beb-a211-08d753e03d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:26.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbgyUPHqk1xhNMPmQMZA0T/s695Ay6r4gD9V/NWGnv4x8CnaLfpsAemb8m5JjRv/pFFFguitDgdX2U7GUulx3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
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

Create a new field in struct amd64_family_type for max_num_controllers.
Set this when setting other family type information, and use this when
needing the maximum number of memory controllers possible for a system.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190821235938.118710-9-Yazen.Ghannam@amd.com

rfc -> v1:
* New patch.
* Idea came up from Boris' comment about compute_num_umcs().

 drivers/edac/amd64_edac.c | 45 +++++++++++++--------------------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4410da7c3a25..0fde5ad2fdcd 100644
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
+	for (i =3D 0; i < fam_type->max_num_controllers; i++)
=20
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Retu=
rn the
@@ -2226,6 +2223,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "K8",
 		.f1_id =3D PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
 		.f2_id =3D PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D k8_early_channel_count,
 			.map_sysaddr_to_csrow	=3D k8_map_sysaddr_to_csrow,
@@ -2236,6 +2234,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F10h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_10H_NB_MAP,
 		.f2_id =3D PCI_DEVICE_ID_AMD_10H_NB_DRAM,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2246,6 +2245,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F15h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_15H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_15H_NB_F2,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2256,6 +2256,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F15h_M30h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2266,6 +2267,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F15h_M60h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2276,6 +2278,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F16h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_16H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_16H_NB_F2,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2286,6 +2289,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F16h_M30h",
 		.f1_id =3D PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
 		.f2_id =3D PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f1x_early_channel_count,
 			.map_sysaddr_to_csrow	=3D f1x_map_sysaddr_to_csrow,
@@ -2296,6 +2300,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_DF_F6,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -2305,6 +2310,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h_M10h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -2314,6 +2320,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h_M30h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
+		.max_num_controllers =3D 8,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -2323,6 +2330,7 @@ static struct amd64_family_type family_types[] =3D {
 		.ctl_name =3D "F17h_M70h",
 		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
+		.max_num_controllers =3D 2,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
 			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
@@ -3400,29 +3408,14 @@ static const struct attribute_group *amd64_edac_att=
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
 static int get_hardware_info(struct amd64_pvt *pvt)
 {
 	u16 pci_id1, pci_id2;
 	int ret =3D -EINVAL;
=20
 	if (pvt->fam >=3D 0x17) {
-		pvt->umc =3D kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc =3D kcalloc(fam_type->max_num_controllers,
+				   sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc) {
 			ret =3D -ENOMEM;
 			goto err_ret;
@@ -3476,14 +3469,8 @@ static int init_one_instance(struct amd64_pvt *pvt)
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
+	layers[1].size =3D fam_type->max_num_controllers;
 	layers[1].is_virt_csrow =3D false;
=20
 	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -3678,8 +3665,6 @@ static int __init amd64_edac_init(void)
 	if (!msrs)
 		goto err_free;
=20
-	compute_num_umcs();
-
 	for (i =3D 0; i < amd_nb_num(); i++) {
 		err =3D probe_one_instance(i);
 		if (err) {
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 8c3cda81e619..0d5a9bc4d6de 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -479,6 +479,7 @@ struct low_ops {
 struct amd64_family_type {
 	const char *ctl_name;
 	u16 f0_id, f1_id, f2_id, f6_id;
+	u8 max_num_controllers;
 	struct low_ops ops;
 };
=20
--=20
2.17.1

