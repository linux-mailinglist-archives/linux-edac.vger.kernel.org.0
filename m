Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF09163D9C
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfGIV5E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:57:04 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:26896
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729772AbfGIV5E (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVaxIWuTPFwsSJ3AeUaqtXNnlMfU7YLbyT55yEwH7u8=;
 b=Se1E5gMyH1DrMzbIUl5JFd6B+j0HkKknd5RacLLSiUE7fO4LrqUfF/TudfIqCG0tL/Ak90Gw664UoZz0/I2l397U3wg7WnevaSr7xuZ3T3ZETjicripwFDGpiVxflDS+Uhq7WCiTstXcaJwHWDVuNECfNlsH0/GflZ+QVeVkMjM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:56 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:56 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 3/7] EDAC/amd64: Initialize DIMM info for systems with more
 than two channels
Thread-Topic: [PATCH v2 3/7] EDAC/amd64: Initialize DIMM info for systems with
 more than two channels
Thread-Index: AQHVNqE5t+N1wkgV+EOHHNw1+vPo8w==
Date:   Tue, 9 Jul 2019 21:56:55 +0000
Message-ID: <20190709215643.171078-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 66a4a0f4-fdfe-4897-355c-08d704b85bcc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2814;
x-ms-traffictypediagnostic: SN6PR12MB2814:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB28148A38E247EC51676EED65F8F10@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(26005)(8936002)(4326008)(6486002)(54906003)(6916009)(6512007)(6436002)(5640700003)(6306002)(102836004)(1076003)(966005)(6506007)(52116002)(386003)(53936002)(14444005)(76176011)(6116002)(68736007)(81156014)(25786009)(99286004)(316002)(50226002)(36756003)(186003)(2906002)(5660300002)(86362001)(11346002)(446003)(476003)(2616005)(81166006)(256004)(486006)(2501003)(66066001)(66476007)(66946007)(305945005)(3846002)(66446008)(71190400001)(66556008)(64756008)(71200400001)(478600001)(7736002)(14454004)(2351001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2814;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t0ASMCset5vKbO6bxPhOmtm0rMjdJk/lN3sOKTdV7wMZGvFZvCRsbVZLgRpVXG11PErcq7oGfikkOFcRgMcUrHOb9PjFug2wR3SqyRn3ZGcTS8iyMLzyCFeQmhHPbQQVJ1B5GgHjBIW2Q9p5ICh8bQALpnFctxLaDiKJFSdxwu01eIcV20t645u7MMA/nlFMBiEJsCuijhEnUfgP0d/8FWHxjj4ITQTJLEqvEH4dp5wnn0qiGeEdmQ2xp0lZ5SS2j4GzcgjDKyihHBD2PgVMIUNzqA4y7xKFUEi9Q3BdzRHpbt0OSy1uhLNIMgWTECzymf0qaGJ7C0reup/8geUvdKWkW8NKjpDkQVuIqUy2q/2jXi99O3GDAV7iM4dsmO5mmWSz7ddANokWyKpMwdrHMOaNEUPixRzZ/etL9WxWs1o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a4a0f4-fdfe-4897-355c-08d704b85bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:56.0585
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

Currently, the DIMM info for AMD Family 17h systems is initialized in
init_csrows(). This function is shared with legacy systems, and it has a
limit of two channel support.

This prevents initialization of the DIMM info for a number of ranks, so
there will be missing ranks in the EDAC sysfs.

Create a new init_csrows_df() for Family17h+ and revert init_csrows()
back to pre-Family17h support.

Loop over all channels in the new function in order to support systems
with more than two channels.

Fixes: bdcee7747f5c ("EDAC/amd64: Support more than two Unified Memory Cont=
rollers")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190531234501.32826-5-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 63 ++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 125d6e2a828e..d0926b181c7c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2837,6 +2837,46 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt,=
 u8 dct, int csrow_nr_orig)
 	return nr_pages;
 }
=20
+static int init_csrows_df(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt =3D mci->pvt_info;
+	enum edac_type edac_mode =3D EDAC_NONE;
+	enum dev_type dev_type =3D DEV_UNKNOWN;
+	struct dimm_info *dimm;
+	int empty =3D 1;
+	u8 umc, cs;
+
+	if (mci->edac_ctl_cap & EDAC_FLAG_S16ECD16ED) {
+		edac_mode =3D EDAC_S16ECD16ED;
+		dev_type =3D DEV_X16;
+	} else if (mci->edac_ctl_cap & EDAC_FLAG_S4ECD4ED) {
+		edac_mode =3D EDAC_S4ECD4ED;
+		dev_type =3D DEV_X4;
+	} else if (mci->edac_ctl_cap & EDAC_FLAG_SECDED) {
+		edac_mode =3D EDAC_SECDED;
+	}
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			if (!csrow_enabled(cs, umc, pvt))
+				continue;
+
+			empty =3D 0;
+			dimm =3D mci->csrows[cs]->channels[umc]->dimm;
+
+			edac_dbg(1, "MC node: %d, csrow: %d\n",
+					pvt->mc_node_id, cs);
+
+			dimm->nr_pages =3D get_csrow_nr_pages(pvt, umc, cs);
+			dimm->mtype =3D pvt->dram_type;
+			dimm->edac_mode =3D edac_mode;
+			dimm->dtype =3D dev_type;
+		}
+	}
+
+	return empty;
+}
+
 /*
  * Initialize the array of csrow attribute instances, based on the values
  * from pci config hardware registers.
@@ -2851,15 +2891,16 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages =3D 0;
 	u32 val;
=20
-	if (!pvt->umc) {
-		amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
+	if (pvt->umc)
+		return init_csrows_df(mci);
+
+	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
=20
-		pvt->nbcfg =3D val;
+	pvt->nbcfg =3D val;
=20
-		edac_dbg(0, "node %d, NBCFG=3D0x%08x[ChipKillEccCap: %d|DramEccEn: %d]\n=
",
-			 pvt->mc_node_id, val,
-			 !!(val & NBCFG_CHIPKILL), !!(val & NBCFG_ECC_ENABLE));
-	}
+	edac_dbg(0, "node %d, NBCFG=3D0x%08x[ChipKillEccCap: %d|DramEccEn: %d]\n"=
,
+		 pvt->mc_node_id, val,
+		 !!(val & NBCFG_CHIPKILL), !!(val & NBCFG_ECC_ENABLE));
=20
 	/*
 	 * We iterate over DCT0 here but we look at DCT1 in parallel, if needed.
@@ -2896,13 +2937,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 		edac_dbg(1, "Total csrow%d pages: %u\n", i, nr_pages);
=20
 		/* Determine DIMM ECC mode: */
-		if (pvt->umc) {
-			if (mci->edac_ctl_cap & EDAC_FLAG_S4ECD4ED)
-				edac_mode =3D EDAC_S4ECD4ED;
-			else if (mci->edac_ctl_cap & EDAC_FLAG_SECDED)
-				edac_mode =3D EDAC_SECDED;
-
-		} else if (pvt->nbcfg & NBCFG_ECC_ENABLE) {
+		if (pvt->nbcfg & NBCFG_ECC_ENABLE) {
 			edac_mode =3D (pvt->nbcfg & NBCFG_CHIPKILL)
 					? EDAC_S4ECD4ED
 					: EDAC_SECDED;
--=20
2.17.1

