Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDBF1265
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKFJdS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:18 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28584 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbfKFJdR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:17 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UQxU002783;
        Wed, 6 Nov 2019 01:33:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=AqbSREJcrO5nwEtUWH5vMsLEAS0gOaUFemX+87Ba9RA=;
 b=Lu6pg/4QG8zeCrMPaiqjoDYhZ8GFWR6P2vVk9bZvBnSFSfpOrDie+Hk+TWw6ujhG2afi
 ql5cqOBdrtR/Y/qvDmp7sxH1N1OL0xjHbk6q4e+/YI1c/OiJposxr2u4BPiR8Tf0n8Vh
 NwrdTNFzLfeHdtCzeVfzoYqRgo1eNndpWC/sTUNFjmEtKIFpQ6Y6yKIYJvc2GaWA/oB5
 8kDWcCsyQDoUmW9lMs1ljf4xGi2T+/bfNWqscaYP6imiyzidDWOJ5IWorRi8f3/24tIa
 fevW9bxbL2Z6RLG/bjCSKGMFErhBDQTgd6SKbI5xOV4ab3fwto1yhTpx2Sz5r6CvYyZ2 jA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:06 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:05 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1A+sEaxCiq64mc4VIzptnBlMqfOkKa1t744xICe9WxCjo+8uEsM49/VD3u5j2/lxruMqMYxw9aQDtpZdJ1/ykQMs1JzpFMEpKl/6Iutz3+RdsC0IAniBkjgPvCHSEIonWwTRWcxU9ZDLLUW1o1Q+T49JcunYh46k9pSVJuE2Z4XPvwq7u8ETURMCwIwTsxc3fNn7zLr8q+8LeSyGHyhiilG+0B0WZzGwsp5UGaNbONTV7RykWqFum+nxi4ybPv0Cg0IWuOyf9MszPGc+/ZS9CT5zgwwHEJvOMtWGaQzRL7KNK4csUdnJzskIrPSZVVkvkrMo7+FkSQ9mM0CQ+1EWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbSREJcrO5nwEtUWH5vMsLEAS0gOaUFemX+87Ba9RA=;
 b=GdpP39+8KT5tXIyzdHLQelfpI/0k6E56wnN6IGtCIznLFMruQOXZ8YKQ3PLHSEb2TDR856KVVpS8wYCw0Sh85F9Q6pvFwtrq97rO1sWDCMhIJIO35dEEWptYaW5BMlQUfYk2Kw6bUwqIi6EB3sraI+cky9mMW6AC8a8xHbhhIFAxpYOfag22PftNrUqURZ1hdU6fo+qzCD4oXpCmKVIcMqExQWoYCrRDWannJ/FzqiGwMru6iNbqOC185jGRzrmo9QgbAr8EFw7Yd5nH6lwQboMPg3Pg50hGX+CqbK4dSNcv6sOS7eKSQCPQNb0Jr86hFZCEJy/iznfoOsMLcIjazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbSREJcrO5nwEtUWH5vMsLEAS0gOaUFemX+87Ba9RA=;
 b=MEqb3uURY3x0ePXIazTWdcr9HcJrDERXEVJnHA/FxHW3niaqlCtijLW/I4QvXcp124bAlnZAYCTfxt2eWlNYctDlTUUIvLH9vWnrua65EXqKfCpoUWE+8LA4J6wwUZV4v2qmwRpvWhtOyiKHXTG3HWXPvTMgo4TE56nAJsiNoV8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jason Baron <jbaron@akamai.com>, Tero Kristo <t-kristo@ti.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v2 01/20] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Thread-Topic: [PATCH v2 01/20] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Thread-Index: AQHVlIUvhVbkmNwWpkSXfR2CjynYLw==
Date:   Wed, 6 Nov 2019 09:33:02 +0000
Message-ID: <20191106093239.25517-2-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab27e4c-34d4-45bf-a12e-08d7629c519f
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165890062B74EDB54391F2FD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:154;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(30864003)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzuxCEANNhAaLeK9lENWrGHTFhW+WXXtbTvD3B3KGq8Y1rzH+b08Rc8g185XKS4DMYUvU9ieqECOixq6Ta+KUXMmDbitnrjK1/pK4l8kknDlYykNoOPVxR8N1gL5Sn28I1BjaBFRIWMWYArRPKrBlHNoafiJklhuX+nRlu5uVVpTmjWLorTMK3M5KlsV5ZN4MKbQYPaqwbwftYK/FXrCHY18lkgp6AvL45KgykgmcM/aDqriW2OLFyGBa8c268cqSlUX4BP7CYyqJ2fniCO8OmacX0Ou7XqbuNZQCdoTEhms1+/M+iHtpl8KixeBoZbj/Hg0PHYxlj7+9yz/efRuSlXryql83esoKDg31W7vzyn5S2DX9xz5xDmk1iGA3JGSpwABMoa5lTO8J3fiZcni/eoknbGr0G0HivkNhxzL/oA4meR2nOhi1L2A8+Zu4FWT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fab27e4c-34d4-45bf-a12e-08d7629c519f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:02.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gv5+XaKLkYmXLv7GrdqocHtEHXPDTVPjjv6TjcJcpziGGldT8x/f7+sOVnZHQVuU3ak2PZMBdMDRK/utLT0PGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The EDAC_DIMM_PTR() macro takes 3 arguments from struct mem_ctl_info.
Clean up this interface to only pass the mci struct and replace this
macro with the new function edac_get_dimm().

Also introduce the edac_get_dimm_by_index() function for later use.
This allows it to get a dimm pointer only by a given index. This can
be useful if the dimm's position within the layers of the memory
controller or the exact size of the layers are unknown.

Small style changes made for some hunks after applying the semantic
patch.

Semantic patch used:

@@ expression mci, a, b,c; @@

-EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, a, b, c)
+edac_get_dimm(mci, a, b, c)

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c    |  7 +--
 drivers/edac/i10nm_base.c   |  3 +-
 drivers/edac/i3200_edac.c   |  3 +-
 drivers/edac/i5000_edac.c   |  5 +--
 drivers/edac/i5100_edac.c   |  3 +-
 drivers/edac/i5400_edac.c   |  3 +-
 drivers/edac/i7300_edac.c   |  3 +-
 drivers/edac/i7core_edac.c  |  3 +-
 drivers/edac/ie31200_edac.c |  7 +--
 drivers/edac/pnd2_edac.c    |  4 +-
 drivers/edac/sb_edac.c      |  2 +-
 drivers/edac/skx_base.c     |  3 +-
 drivers/edac/ti_edac.c      |  2 +-
 include/linux/edac.h        | 88 ++++++++++++++++++++++++-------------
 14 files changed, 74 insertions(+), 62 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 5da85ef7966d..d92cd99081d2 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -106,9 +106,7 @@ static void ghes_edac_dmidecode(const struct dmi_header=
 *dh, void *arg)
=20
 	if (dh->type =3D=3D DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry =3D (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-						       mci->n_layers,
-						       dimm_fill->count, 0, 0);
+		struct dimm_info *dimm =3D edac_get_dimm(mci, dimm_fill->count, 0, 0);
 		u16 rdr_mask =3D BIT(7) | BIT(13);
=20
 		if (entry->size =3D=3D 0xffff) {
@@ -543,8 +541,7 @@ int ghes_edac_register(struct ghes *ghes, struct device=
 *dev)
 		dimm_fill.mci =3D mci;
 		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 	} else {
-		struct dimm_info *dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-						       mci->n_layers, 0, 0, 0);
+		struct dimm_info *dimm =3D edac_get_dimm(mci, 0, 0, 0);
=20
 		dimm->nr_pages =3D 1;
 		dimm->grain =3D 128;
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index c370d5457e6b..059eccf0582b 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -154,8 +154,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *m=
ci)
=20
 		ndimms =3D 0;
 		for (j =3D 0; j < I10NM_NUM_DIMMS; j++) {
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					     mci->n_layers, i, j, 0);
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			mtr =3D I10NM_GET_DIMMMTR(imc, i, j);
 			mcddrtcfg =3D I10NM_GET_MCDDRTCFG(imc, i, j);
 			edac_dbg(1, "dimmmtr 0x%x mcddrtcfg 0x%x (mc%d ch%d dimm%d)\n",
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 299b441647cd..432b375a4075 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -392,8 +392,7 @@ static int i3200_probe1(struct pci_dev *pdev, int dev_i=
dx)
 		unsigned long nr_pages;
=20
 		for (j =3D 0; j < nr_channels; j++) {
-			struct dimm_info *dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-							       mci->n_layers, i, j, 0);
+			struct dimm_info *dimm =3D edac_get_dimm(mci, i, j, 0);
=20
 			nr_pages =3D drb_to_nr_pages(drbs, stacked, j, i);
 			if (nr_pages =3D=3D 0)
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 078a7351bf05..1a6f69c859ab 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1275,9 +1275,8 @@ static int i5000_init_csrows(struct mem_ctl_info *mci=
)
 			if (!MTR_DIMMS_PRESENT(mtr))
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-				       channel / MAX_BRANCHES,
-				       channel % MAX_BRANCHES, slot);
+			dimm =3D edac_get_dimm(mci, channel / MAX_BRANCHES,
+					     channel % MAX_BRANCHES, slot);
=20
 			csrow_megs =3D pvt->dimm_info[slot][channel].megabytes;
 			dimm->grain =3D 8;
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 12bebecb203b..134586753311 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -858,8 +858,7 @@ static void i5100_init_csrows(struct mem_ctl_info *mci)
 		if (!npages)
 			continue;
=20
-		dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-			       chan, rank, 0);
+		dimm =3D edac_get_dimm(mci, chan, rank, 0);
=20
 		dimm->nr_pages =3D npages;
 		dimm->grain =3D 32;
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 8c86c6fd7da7..f131c05ade9f 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1187,8 +1187,7 @@ static int i5400_init_dimms(struct mem_ctl_info *mci)
 			if (!MTR_DIMMS_PRESENT(mtr))
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-				       channel / 2, channel % 2, slot);
+			dimm =3D edac_get_dimm(mci, channel / 2, channel % 2, slot);
=20
 			size_mb =3D  pvt->dimm_info[slot][channel].megabytes;
=20
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 447d357c7a67..2e9bbe56cde9 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -794,8 +794,7 @@ static int i7300_init_csrows(struct mem_ctl_info *mci)
 			for (ch =3D 0; ch < max_channel; ch++) {
 				int channel =3D to_channel(ch, branch);
=20
-				dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					       mci->n_layers, branch, ch, slot);
+				dimm =3D edac_get_dimm(mci, branch, ch, slot);
=20
 				dinfo =3D &pvt->dimm_info[slot][channel];
=20
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index a71cca6eeb33..b3135b208f9a 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -585,8 +585,7 @@ static int get_dimm_config(struct mem_ctl_info *mci)
 			if (!DIMM_PRESENT(dimm_dod[j]))
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-				       i, j, 0);
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			banks =3D numbank(MC_DOD_NUMBANK(dimm_dod[j]));
 			ranks =3D numrank(MC_DOD_NUMRANK(dimm_dod[j]));
 			rows =3D numrow(MC_DOD_NUMROW(dimm_dod[j]));
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d26300f9cb07..4f65073f230b 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -490,9 +490,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev=
_idx)
=20
 			if (dimm_info[j][i].dual_rank) {
 				nr_pages =3D nr_pages / 2;
-				dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-						     mci->n_layers, (i * 2) + 1,
-						     j, 0);
+				dimm =3D edac_get_dimm(mci, (i * 2) + 1, j, 0);
 				dimm->nr_pages =3D nr_pages;
 				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 				dimm->grain =3D 8; /* just a guess */
@@ -503,8 +501,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev=
_idx)
 				dimm->dtype =3D DEV_UNKNOWN;
 				dimm->edac_mode =3D EDAC_UNKNOWN;
 			}
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					     mci->n_layers, i * 2, j, 0);
+			dimm =3D edac_get_dimm(mci, i * 2, j, 0);
 			dimm->nr_pages =3D nr_pages;
 			edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 			dimm->grain =3D 8; /* same guess */
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index b1193be1ef1d..933f7722b893 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1231,7 +1231,7 @@ static void apl_get_dimm_config(struct mem_ctl_info *=
mci)
 		if (!(chan_mask & BIT(i)))
 			continue;
=20
-		dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, 0, 0);
+		dimm =3D edac_get_dimm(mci, i, 0, 0);
 		if (!dimm) {
 			edac_dbg(0, "No allocated DIMM for channel %d\n", i);
 			continue;
@@ -1311,7 +1311,7 @@ static void dnv_get_dimm_config(struct mem_ctl_info *=
mci)
 			if (!ranks_of_dimm[j])
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, j, 0)=
;
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			if (!dimm) {
 				edac_dbg(0, "No allocated DIMM for channel %d DIMM %d\n", i, j);
 				continue;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index a2fd39d330d6..4957e8ee1879 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1621,7 +1621,7 @@ static int __populate_dimms(struct mem_ctl_info *mci,
 		}
=20
 		for (j =3D 0; j < max_dimms_per_channel; j++) {
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, j, 0)=
;
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			if (pvt->info.type =3D=3D KNIGHTS_LANDING) {
 				pci_read_config_dword(pvt->knl.pci_channel[i],
 					knl_mtr_reg, &mtr);
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index a8853e724d1f..83545b4facb7 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -189,8 +189,7 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci=
)
 		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
 		pci_read_config_dword(imc->chan[i].cdev, 0x400, &mcddrtcfg);
 		for (j =3D 0; j < SKX_NUM_DIMMS; j++) {
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					     mci->n_layers, i, j, 0);
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			pci_read_config_dword(imc->chan[i].cdev,
 					      0x80 + 4 * j, &mtr);
 			if (IS_DIMM_PRESENT(mtr)) {
diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 6ac26d1b929f..8be3e89a510e 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -135,7 +135,7 @@ static void ti_edac_setup_dimm(struct mem_ctl_info *mci=
, u32 type)
 	u32 val;
 	u32 memsize;
=20
-	dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, 0, 0, 0);
+	dimm =3D edac_get_dimm(mci, 0, 0, 0);
=20
 	val =3D ti_edac_readl(edac, EMIF_SDRAM_CONFIG);
=20
diff --git a/include/linux/edac.h b/include/linux/edac.h
index c19483b90079..696bfb684d92 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -403,37 +403,6 @@ struct edac_mc_layer {
 	__i;								\
 })
=20
-/**
- * EDAC_DIMM_PTR - Macro responsible to get a pointer inside a pointer arr=
ay
- *		   for the element given by [layer0,layer1,layer2] position
- *
- * @layers:	a struct edac_mc_layer array, describing how many elements
- *		were allocated for each layer
- * @var:	name of the var where we want to get the pointer
- *		(like mci->dimms)
- * @nlayers:	Number of layers at the @layers array
- * @layer0:	layer0 position
- * @layer1:	layer1 position. Unused if n_layers < 2
- * @layer2:	layer2 position. Unused if n_layers < 3
- *
- * For 1 layer, this macro returns "var[layer0]";
- *
- * For 2 layers, this macro is similar to allocate a bi-dimensional array
- * and to return "var[layer0][layer1]";
- *
- * For 3 layers, this macro is similar to allocate a tri-dimensional array
- * and to return "var[layer0][layer1][layer2]";
- */
-#define EDAC_DIMM_PTR(layers, var, nlayers, layer0, layer1, layer2) ({	\
-	typeof(*var) __p;						\
-	int ___i =3D EDAC_DIMM_OFF(layers, nlayers, layer0, layer1, layer2);	\
-	if (___i < 0)							\
-		__p =3D NULL;						\
-	else								\
-		__p =3D (var)[___i];					\
-	__p;								\
-})
-
 struct dimm_info {
 	struct device dev;
=20
@@ -669,4 +638,61 @@ struct mem_ctl_info {
 	bool fake_inject_ue;
 	u16 fake_inject_count;
 };
+
+/**
+ * edac_get_dimm_by_index - Get DIMM info from a memory controller
+ *                          given by an index
+ *
+ * @mci:	a struct mem_ctl_info
+ * @index:	index in the memory controller's DIMM array
+ *
+ * Returns a struct dimm_info* or NULL on failure.
+ */
+static inline struct dimm_info *
+edac_get_dimm_by_index(struct mem_ctl_info *mci, int index)
+{
+	if (index < 0 || index >=3D mci->tot_dimms)
+		return NULL;
+
+	return mci->dimms[index];
+}
+
+/**
+ * edac_get_dimm - Get DIMM info from a memory controller given by
+ *                 [layer0,layer1,layer2] position
+ *
+ * @mci:	a struct mem_ctl_info
+ * @layer0:	layer0 position
+ * @layer1:	layer1 position. Unused if n_layers < 2
+ * @layer2:	layer2 position. Unused if n_layers < 3
+ *
+ * For 1 layer, this function returns "dimms[layer0]";
+ *
+ * For 2 layers, this function is similar to allocate a bi-dimensional
+ * array and to return "dimms[layer0][layer1]";
+ *
+ * For 3 layers, this function is similar to allocate a tri-dimensional ar=
ray
+ * and to return "dimms[layer0][layer1][layer2]";
+ */
+static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
+	int layer0, int layer1, int layer2)
+{
+	int index;
+
+	if (layer0 < 0
+	    || (mci->n_layers > 1 && layer1 < 0)
+	    || (mci->n_layers > 2 && layer2 < 0))
+		return NULL;
+
+	index =3D layer0;
+
+	if (mci->n_layers > 1)
+		index =3D index * mci->layers[1].size + layer1;
+
+	if (mci->n_layers > 2)
+		index =3D index * mci->layers[2].size + layer2;
+
+	return edac_get_dimm_by_index(mci, index);
+}
+
 #endif
--=20
2.20.1

