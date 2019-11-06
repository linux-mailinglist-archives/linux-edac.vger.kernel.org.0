Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA3F0BA8
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 02:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfKFBZE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 20:25:04 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:36833
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730054AbfKFBZE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 20:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEZ0eTi/sEk4Vg3r2hQc4IuMZlgHT+pdEsq1Lvl9bdi2ex/TG/e48HP/PtTY8jGVZtzqVptKVeCfRwNFQnDxVOSg0DqLowVVI8Q/twWQNzJ7+OsT5mmCdQi2o3YCx+Ktdn9t0VDrYjPiBvA0mm+G6DNG2IZauu0Jp1xeps94qba8OMTNFak3rMrnxSmWe5xwNiBRC1INfqiKDS8MexPKAHE6SIgqASKplT8I0gqX8DJbxCe1Saa7Gf9iQ3DRm28rvQFU70jiN4szXe7o10QdgqvWnA53j/o46LjzITNXFGQu5ekrsNvB62ARK6f5Ep5ZDqt8rL2+lPCU3hud/UlYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHERqkCl4oWJ5edRkO+YBZo8QaAqpmfQq7g/2YRQIx0=;
 b=HYkGTGttWUfRTH6t3qpdukn4+/FUzMeBiZxqYNDcxzt5Ey18MJuP5Q4nWSY43ICcGZF/PcnbEPUxZf5ClgAaGSsJLnEks8PIpHopXeWfGm2W/p6Rp9+3hyRvgfn7JSAZSMqQzh0R+zBmm/nzHHd0w1aIwQO8TFVYWgTd6wM/jSV1ZvXx3RTtab7UiKdtiCmmKv6fZ6axtMPrvT2k9Uj+nyOwrVIYiTwQkNLJrSbzYivv3OW+D+K3AOIG2Yx0TrNJdfOaE9yCPevmF7ml3jSfGij7lzdodI/sXJGjZaTYFZykJHcB3VUFN9s0FTtAaIxe45kaO2GtU7lwZXtDRkVIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHERqkCl4oWJ5edRkO+YBZo8QaAqpmfQq7g/2YRQIx0=;
 b=MfW3qRK8Qh4amsR+AmkRkuk+pAL+5KE81hn5HJjcvO1Go2rvgOl1fwncvf5GI0HXHo/HfTSRsp1aYGjVCw/VoP44BvNJlqbIBqzY0LolNAPvWUNSn5zj5wk9aHLQTJLR7WUH3CxKOxcPeNlgcH/ZT8kESF8P/zlaeEqvbsmqsR4=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 01:24:59 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:24:59 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 1/5] EDAC/amd64: Make struct amd64_family_type global
Thread-Topic: [PATCH v3 1/5] EDAC/amd64: Make struct amd64_family_type global
Thread-Index: AQHVlEEBJDivVc3XwEWsaKCwbdqNsQ==
Date:   Wed, 6 Nov 2019 01:24:59 +0000
Message-ID: <20191106012448.243970-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 86458a82-ac4a-43d9-4f56-08d7625823d8
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2783BEFF87B7931D75117981F8790@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(186003)(5660300002)(86362001)(386003)(4326008)(102836004)(6506007)(1076003)(52116002)(966005)(6306002)(2906002)(5640700003)(99286004)(6116002)(36756003)(54906003)(14454004)(25786009)(486006)(66556008)(446003)(11346002)(81156014)(6916009)(76176011)(305945005)(7736002)(26005)(6512007)(2616005)(66066001)(2501003)(66946007)(316002)(64756008)(478600001)(50226002)(71190400001)(71200400001)(81166006)(8676002)(256004)(2351001)(8936002)(6436002)(476003)(6486002)(66446008)(66476007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uTfBlvGrkTGh/pIBKSiTnNjm/v1XTyCVjwrYVN2ZfIoj4cNKk3/N9DWGj1GrQPeghj1ayTEEgp78AAH75cV564he+Yi+Q/CZ8khPqJ60bCwkMh6ynph0KYUQ5Dqz6KAKcybTeaods6tyG7dBXzhtGGLgAwsn92tVksYKmw6rJXWjCF5Hh4m+0v7i0hTX8YmAm67IqdvJCbbR0n3AJu/81TUfDcn1kx2ZLd7RPVDzyKDVJXa8HQxr4d6gPWmiL5kiOvft274818zdwjpT52yRB0Oy5HBTcDkkCVhmdvDuew2YSyhSzz1SIw+fvHfUsheiV977+r6VK0JzZm7thC8p8FZ25YxkL7KqaciA4Zq0K74/vrD4vwdtgK/6ApxqA73rlzqBZEbeb6s7w1LxG++ol+z750SJfFRO/+k7e36OSe43CBhDMQC/8rKwRR9AAEpjsi96pRc03ytDAvfW4bT+ePTxQJMFJdDMJz1Tv8UC+w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86458a82-ac4a-43d9-4f56-08d7625823d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:24:59.6705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3HTRXLVtxyzRhvzBuGdzbtDOpg8HuUyU1r6QjOwYNDXB5jQiFhZONJi6WAlLesNivlzuHm8gbl0l/csJ+Uz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The struct amd64_family_type doesn't change between multiple nodes and
instances of the modules, so make it global.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191022203448.13962-2-Yazen.Ghannam@amd.com

v2 -> v3:
* No change.

v1 -> v2:
* No change.

rfc -> v1:
* New patch based on suggestion from Boris.

 drivers/edac/amd64_edac.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index cc5e56d752c8..83c659e38084 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -16,6 +16,8 @@ module_param(ecc_enable_override, int, 0644);
=20
 static struct msr __percpu *msrs;
=20
+static struct amd64_family_type *fam_type;
+
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
=20
@@ -3280,8 +3282,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci,=
 struct amd64_pvt *pvt)
 	}
 }
=20
-static void setup_mci_misc_attrs(struct mem_ctl_info *mci,
-				 struct amd64_family_type *fam)
+static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt =3D mci->pvt_info;
=20
@@ -3300,7 +3301,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info =
*mci,
=20
 	mci->edac_cap		=3D determine_edac_cap(pvt);
 	mci->mod_name		=3D EDAC_MOD_STR;
-	mci->ctl_name		=3D fam->ctl_name;
+	mci->ctl_name		=3D fam_type->ctl_name;
 	mci->dev_name		=3D pci_name(pvt->F3);
 	mci->ctl_page_to_phys	=3D NULL;
=20
@@ -3314,8 +3315,6 @@ static void setup_mci_misc_attrs(struct mem_ctl_info =
*mci,
  */
 static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 {
-	struct amd64_family_type *fam_type =3D NULL;
-
 	pvt->ext_model  =3D boot_cpu_data.x86_model >> 4;
 	pvt->stepping	=3D boot_cpu_data.x86_stepping;
 	pvt->model	=3D boot_cpu_data.x86_model;
@@ -3422,7 +3421,6 @@ static void compute_num_umcs(void)
 static int init_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
-	struct amd64_family_type *fam_type =3D NULL;
 	struct mem_ctl_info *mci =3D NULL;
 	struct edac_mc_layer layers[2];
 	struct amd64_pvt *pvt =3D NULL;
@@ -3499,7 +3497,7 @@ static int init_one_instance(unsigned int nid)
 	mci->pvt_info =3D pvt;
 	mci->pdev =3D &pvt->F3->dev;
=20
-	setup_mci_misc_attrs(mci, fam_type);
+	setup_mci_misc_attrs(mci);
=20
 	if (init_csrows(mci))
 		mci->edac_cap =3D EDAC_FLAG_NONE;
--=20
2.17.1

