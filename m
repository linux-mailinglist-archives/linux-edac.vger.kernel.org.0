Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A421CF124E
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfKFJdv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:51 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31548 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731781AbfKFJdt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:49 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69Unxp003167;
        Wed, 6 Nov 2019 01:33:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EnnlijSZVZFcBCN9jTmdC6iA0abMw7/Kvv7wUG4SuxM=;
 b=sajrBsUtDagU4glmkITseJ74FyovzmmbvKst6b4pmbnuAHobda6Lu0RdSXKTqlWZIsh9
 sf18ET2Ins3TcWY0cJ1PQn1JoLUoivfz8eUiabwsKY55cW0w0lwV4e228HvLSsLpH37q
 V4UH2f6VNtJRUeZL4mj6xMwdM0FNC2TfzWS1ItYNbW9cUYR4xmq/HUdXpNHiQ+IsmHAl
 vQm5Ix/QVgwGDmUHv+BPUFYOmHRmnyzIzMTPTKRKnzLbmbj5FQKhpsWUlkuwlgB3Ms1C
 geYGMBjI5Xht49e/efB/SAxdr+OjtWRPxoPiNwJBncm+J7cD8NpttMD+Lc72bAUXmArK 1g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:42 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:41 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DawAk2rno0prts1qRwkMEaeQzIWSAoJGP0+hwlAtsAv5zW7OXt+rKB0yJA54SCSUyQYjxTJaPAKrJ5R4AbbYiTV2sLfnzSEH1FjFsGJYWSLvcAEhNSVEW8cHTp8DMsldB6k3CwW1O1uCbrUUfkcjQCHthjTWuyrjknueJR9V147z+aYIKWK+d/SmqS4ZbFuzBDUjq+0lNVZ7Mka4/ONttgYFKHU7+HJZvhISeMuL1pCMoLDVs66s1+smhfKCg3o0nWB5Y7UFsD6MJj7qBsxjLiK0DqXIybRtsatFJjz18URam/no6xilW0AoBY0IUFJAIp4F2kjYusVA8HD59TH13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnnlijSZVZFcBCN9jTmdC6iA0abMw7/Kvv7wUG4SuxM=;
 b=Clx3OBRBUIB2jsQa9eSYfU+ScMWlFUDwGoHvap35LwiT/XzYjJ4w1F0iwNIrHFhKvcSgisHgEVBDwZ/O83NB4dRWEymokdIAlqf5vdn0sK+K6roK7q/nzgbaGqxxAHIlQgoWwlOK8avZFFWBBZw9Xgo/3nH/+zWCfKnaCZo8q38PA55AIMBoMyPmEkMMUKDao9CkZ1iYdYiMEsQKUK6FWqwfi0cgdlIbUrOiQ5eGRRYv1ARNEC4o7CPfLVeOq766EWGBYmqBrPwQr0/5DHYv/8BLhs7KP6+X3RN4KadfHyRMuJdw3/Xgcg7p5ljocB2uUQx9sqE+fWHGkKBdxn9WWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnnlijSZVZFcBCN9jTmdC6iA0abMw7/Kvv7wUG4SuxM=;
 b=YXwbMRzrgzTENScrB9nheJ6ghWZgDKTSrkICtcGYxWQ9sQF1/IsthLSXxKmVrbzMoPcDCQk/hqSTpkUCRfE+yaAmmjuRwwFNWmwZuMfyUXUQjqgD2Nbr6AZAJHTU2DEM2mUVmPiLbwEuDkLeDiq25BlW+hmbzvCchMalrMbC2FA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:39 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 17/20] EDAC, mc: Rework edac_raw_mc_handle_error() to use
 struct dimm_info
Thread-Topic: [PATCH v2 17/20] EDAC, mc: Rework edac_raw_mc_handle_error() to
 use struct dimm_info
Thread-Index: AQHVlIVFwb2aXU0xH0qyG8z+r78p5w==
Date:   Wed, 6 Nov 2019 09:33:39 +0000
Message-ID: <20191106093239.25517-18-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 049bfead-8f4b-4850-3b3c-08d7629c67db
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165A24BFAC08040929E5E82D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTD6XD9BvPWk8Hb2P+HMCTXFCer41accr/1O3VUMwJuYwThjk7W7aLON9MgWv4Wlt/2nxUyUqJsH5DEs3Em+tGjy2vh1Ost2hp2HIEl5FFx6DXZ/Ce2/4PvLu6uUfY7MNnE6pRk6UtXYa+t5bkVwO+8OOzDzyNKhwso0MJHFZluhTMafizR6Ms5VttDXNQ1GPNM20kLunC4jinIHzyTxKHlJvpBkn2P7U3ZBGlpoTjCjAimLciVOYkLG7HOOnihcx3YR995XMR9Qfu+3EUTm/nMXcoNzuzaOpESp7uDsz0F5v6NiM2/v0RJDEhBXh50vq2DjGQAweesF0QK+JheLmHGaL4xPZGZ51YPNZF57ZQmBqLY2sVJYNrPSSej/KZMCWyGRVYBmzYgv+6c2mjXYr7s8S0bUchQWbyUFKR9ndcU6689kSB3JhYjFy9+wzkI8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 049bfead-8f4b-4850-3b3c-08d7629c67db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:39.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hz/+YDEyuGa6ZnQxkPo48K1wP5HKnt4OCnkvRPKtbmJPBo/u4R76amNxGhUlydBQxpBnW1gQACLOBcCxgMiTfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The error handling functions have the pos[] array argument for
determing the dimm handle. Rework those functions to use the dimm
handle directly.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c   | 28 +++++++++++++---------------
 drivers/edac/edac_mc.h   |  2 ++
 drivers/edac/ghes_edac.c |  6 +++++-
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index bbe37af487c3..e4a11218009b 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -925,11 +925,9 @@ const char *edac_layer_name[] =3D {
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
 static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      const int pos[EDAC_MAX_LAYERS],
+			      struct dimm_info *dimm,
 			      const u16 count)
 {
-	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
-
 	mci->ce_mc +=3D count;
=20
 	if (dimm)
@@ -939,11 +937,9 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci=
,
 }
=20
 static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    const int pos[EDAC_MAX_LAYERS],
-				    const u16 count)
+			      struct dimm_info *dimm,
+			      const u16 count)
 {
-	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
-
 	mci->ue_mc +=3D count;
=20
 	if (dimm)
@@ -953,8 +949,8 @@ static void edac_inc_ue_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_ce_error(struct mem_ctl_info *mci,
+			  struct dimm_info *dimm,
 			  const u16 error_count,
-			  const int pos[EDAC_MAX_LAYERS],
 			  const char *msg,
 			  const char *location,
 			  const char *label,
@@ -982,7 +978,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 				       error_count, msg, msg_aux, label,
 				       location, detail);
 	}
-	edac_inc_ce_error(mci, pos, error_count);
+	edac_inc_ce_error(mci, dimm, error_count);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1006,8 +1002,8 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_ue_error(struct mem_ctl_info *mci,
+			  struct dimm_info *dimm,
 			  const u16 error_count,
-			  const int pos[EDAC_MAX_LAYERS],
 			  const char *msg,
 			  const char *location,
 			  const char *label,
@@ -1041,15 +1037,15 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			      msg, msg_aux, label, location, detail);
 	}
=20
-	edac_inc_ue_error(mci, pos, error_count);
+	edac_inc_ue_error(mci, dimm, error_count);
 }
=20
 void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
 			      struct mem_ctl_info *mci,
+			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e)
 {
 	char detail[80];
-	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	u8 grain_bits;
=20
 	/* Sanity-check driver-supplied grain value. */
@@ -1072,7 +1068,7 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_=
err_type type,
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
 			e->grain, e->syndrome);
-		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
+		edac_ce_error(mci, dimm, e->error_count, e->msg, e->location,
 			      e->label, detail, e->other_detail,
 			      e->page_frame_number, e->offset_in_page, e->grain);
 	} else {
@@ -1080,7 +1076,7 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_=
err_type type,
 			"page:0x%lx offset:0x%lx grain:%ld",
 			e->page_frame_number, e->offset_in_page, e->grain);
=20
-		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
+		edac_ue_error(mci, dimm, e->error_count, e->msg, e->location,
 			      e->label, detail, e->other_detail);
 	}
=20
@@ -1244,6 +1240,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	if (p > e->location)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(type, mci, e);
+	dimm =3D edac_get_dimm(mci, top_layer, mid_layer, low_layer);
+
+	edac_raw_mc_handle_error(type, mci, dimm, e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 02aac5c61d00..2c3e2fbcedc4 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -214,6 +214,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  *
  * @type:		severity of the error (CE/UE/Fatal)
  * @mci:		a struct mem_ctl_info pointer
+ * @dimm:		a struct dimm_info pointer
  * @e:			error description
  *
  * This raw function is used internally by edac_mc_handle_error(). It shou=
ld
@@ -222,6 +223,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  */
 void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
 			      struct mem_ctl_info *mci,
+			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e);
=20
 /**
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 74017da1f72c..6eebaf28e31c 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -201,6 +201,7 @@ static void ghes_edac_dmidecode(const struct dmi_header=
 *dh, void *arg)
=20
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
+	struct dimm_info *dimm;
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
@@ -439,7 +440,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(type, mci, e);
+	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
+
+	edac_raw_mc_handle_error(type, mci, dimm, e);
+
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
--=20
2.20.1

