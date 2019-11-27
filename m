Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571F510BFE7
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfK0VzK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:10 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:21434 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727900AbfK0VzJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:09 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLnjjZ004644;
        Wed, 27 Nov 2019 13:55:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=zblNwhgK943Hgha95nwD0IXT3BeNX7wq9g2d3FpPA5Y=;
 b=bRwJa9MihSWbyhJegGD9ki9+urRF1BDiHN7auzO69AVr4rmvq8t2YtftCXzULtSEF7Dw
 t/ApT2gvQcLcVsTakrEl+ixD8U+jp2wdfX6bOfk0of3S7bbeBa+hFu9vQFSHYHqmnyYr
 J22DFbjzVQyyJZQaisRZ7T4T+xz5yZI8KS9XErKf3ttn/UH8xkuHMlVpkGBBwbU3IYd0
 gdXl7L8PM5keBKY8quNK0/X5Y6NVn5987PewrrVIzz9qans52A3jU6L5JB4XDI7Uq+pF
 8/nF6iosZAOMX2l10TJVr71dgJvbSVWN5g7CMVvoCpifiontTpJzQ6/eZTOBugCqAwJu cg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mrdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:55:02 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:55:00 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:55:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOuuZqBMGiQG4bfV0JLmaBILB+CAdWmyI/UzjPJSwe12IoGT+qREhaJRgPP3Yyx6IfcerFbvBpA1N4FYgO5pfTkEVga9eAotyjnqKICzVZfUqObO2g0okIIGiTZ4Z7pzAs3lVm61pkY/whT5WTnOnlkfEkz4txX+jWOxZjAtgY8U42J8uJXQENMejnIzKv4vjZIzg8phcLVxPoSgC8SY5QuC5KMIAccifrlTvGT07oskleyT6DikGZEZbv0lWo2IwFtu683/QcctBv8pJS+pI+dgH3pVuVFTRrPtoieJ0vKe2+4HWHlLPuOxoQl9+0JZDwG5mkJLRl57kWj078mFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zblNwhgK943Hgha95nwD0IXT3BeNX7wq9g2d3FpPA5Y=;
 b=EqkRNO3kyWDDvQpN5Qz3wZN35jaCsDsxzi3CZGvAE0Uh/dKh0JM2+BdeXkJ6pbpAk07GRQEvRDUEAPhCohPW40owe1ANxV9MDhsTJX9K1/xxh/qDABEGHJWm7iTRvfLGXio6tTK0UDofUyk+W8mbYFfdvGV+pL9x2x6OPn2mCdqJsC+j/tAjWMjZqwRNujOeXEA/df6THWLRj6fsWxobin2FX5K4LBfGlwAS2Y9l90zwgy5EPU4rtkFAf06/eqHbGCib/dQuigwROX+LtsXUokZTU8O0TjNW7kP/SdY4TdLOCubf6JjKawHwjhPzg0Q9oq0++PUmB95DRn5JdM/82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zblNwhgK943Hgha95nwD0IXT3BeNX7wq9g2d3FpPA5Y=;
 b=ZrOMFi4HHYwr9DQnePCArh+Visaa4jckd1nlD655DPkZLQcmtYGVFTK8rVoJltV4pMAY7+0dSo+8FFPCotYHZBir9ttA1D43QaAGWE42EsBdxQDjgSZr43bKdUJkVRshJl4cs9wEvMFPricLYqi+q/vuDWv9z/u7TwMh4UydEZU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:59 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] EDAC/mc: Remove enable_per_layer_report function
 arguments
Thread-Topic: [PATCH 07/10] EDAC/mc: Remove enable_per_layer_report function
 arguments
Thread-Index: AQHVpW1PPv76c8WWxkmI+Jh3f+ItfQ==
Date:   Wed, 27 Nov 2019 21:54:58 +0000
Message-ID: <20191127215415.11230-8-rrichter@marvell.com>
References: <20191127215415.11230-1-rrichter@marvell.com>
In-Reply-To: <20191127215415.11230-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44a15a19-9db7-4969-dbc8-08d77384724c
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB247742E661A7B468639B337AD9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIinO73FivnfZreF8yKdR8jHfHl73meQMgp77b+ySpOeCURvOfPE7r0esW6rLeb66yBPEW9/OEoWYerlF/TKJRFr8Q8qqg6+7XGOqaDUQTIIH0/1zNHD1QfzMwINeLkfa0uAsMe/NEV57aHp506sqRAnUgWzfcAkhsz0EqKutgtwDDYR266yZzX3wxV/MWGcvkfmnJvzYNgXkl3nC/gEsq5fl0t0daRvZ/MEyWCKSrFXYgZE9VZicaKeunAt1ZBq/RMcibsH/+Culjkv4BqNVtkD7h2It4vRlc+BNaQWXARryPcl6oQP/bt5dtDGa3dv2NFOEs2RkNmN7cOnyWnkHhBx7bQfKyL3Gz8srphiauV06UsXoqgIA3zVxYxDQV1hVoVNCQT4qhm3C2WFHnJGl7KF/rIh7xLcPVMxqRtWzmEvDovAi4Jn0oHY19ytsFV6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a15a19-9db7-4969-dbc8-08d77384724c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:58.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z51N19HePrV86CZ3fCnQtM0VFKmgK6uLxG8VM9g5KOqxwnUmZcwbsOHSiBHl+u2vc8fIw9GZnLzXo9wouAB+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Many functions carry the enable_per_layer_report argument. This is a
bool value indicating the error information contains some location
data where the error occurred. This can easily being determined by
checking the pos[] array for values. Negative values indicate there is
no location available. So if the top layer is negative, the error
location is unknown.

Just check if the top layer is negative and remove
enable_per_layer_report as function argument and also from struct
edac_raw_error_desc.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   | 42 +++++++++++++++++++---------------------
 drivers/edac/ghes_edac.c |  5 +----
 include/linux/edac.h     |  3 ---
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 2b12320ce2f1..38a9a68eebfe 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -946,7 +946,6 @@ const char *edac_layer_name[] =3D {
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
 static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      bool enable_per_layer_report,
 			      const int pos[EDAC_MAX_LAYERS],
 			      const u16 count)
 {
@@ -954,7 +953,7 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
=20
 	mci->ce_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (pos[0] < 0) {
 		mci->ce_noinfo_count +=3D count;
 		return;
 	}
@@ -971,7 +970,6 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    bool enable_per_layer_report,
 				    const int pos[EDAC_MAX_LAYERS],
 				    const u16 count)
 {
@@ -979,7 +977,7 @@ static void edac_inc_ue_error(struct mem_ctl_info *mci,
=20
 	mci->ue_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (pos[0] < 0) {
 		mci->ue_noinfo_count +=3D count;
 		return;
 	}
@@ -1003,7 +1001,6 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 			  const char *label,
 			  const char *detail,
 			  const char *other_detail,
-			  const bool enable_per_layer_report,
 			  const unsigned long page_frame_number,
 			  const unsigned long offset_in_page,
 			  long grain)
@@ -1026,7 +1023,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 				       error_count, msg, msg_aux, label,
 				       location, detail);
 	}
-	edac_inc_ce_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ce_error(mci, pos, error_count);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1056,8 +1053,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			  const char *location,
 			  const char *label,
 			  const char *detail,
-			  const char *other_detail,
-			  const bool enable_per_layer_report)
+			  const char *other_detail)
 {
 	char *msg_aux =3D "";
=20
@@ -1086,7 +1082,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			      msg, msg_aux, label, location, detail);
 	}
=20
-	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ue_error(mci, pos, error_count);
 }
=20
 static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int cha=
n)
@@ -1136,16 +1132,16 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
_desc *e)
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
 			e->grain, e->syndrome);
-		edac_ce_error(mci, e->error_count, pos, e->msg, e->location, e->label,
-			      detail, e->other_detail, e->enable_per_layer_report,
+		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
+			      e->label, detail, e->other_detail,
 			      e->page_frame_number, e->offset_in_page, e->grain);
 	} else {
 		snprintf(detail, sizeof(detail),
 			"page:0x%lx offset:0x%lx grain:%ld",
 			e->page_frame_number, e->offset_in_page, e->grain);
=20
-		edac_ue_error(mci, e->error_count, pos, e->msg, e->location, e->label,
-			      detail, e->other_detail, e->enable_per_layer_report);
+		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
+			      e->label, detail, e->other_detail);
 	}
=20
=20
@@ -1170,6 +1166,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
+	bool any_memory =3D true;
=20
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
=20
@@ -1188,9 +1185,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
=20
 	/*
 	 * Check if the event report is consistent and if the memory
-	 * location is known. If it is known, enable_per_layer_report will be
-	 * true, the DIMM(s) label info will be filled and the per-layer
-	 * error counters will be incremented.
+	 * location is known. If it is known, the DIMM(s) label info
+	 * will be filled and the per-layer error counters will be
+	 * incremented.
 	 */
 	for (i =3D 0; i < mci->n_layers; i++) {
 		if (pos[i] >=3D (int)mci->layers[i].size) {
@@ -1208,7 +1205,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			pos[i] =3D -1;
 		}
 		if (pos[i] >=3D 0)
-			e->enable_per_layer_report =3D true;
+			any_memory =3D false;
 	}
=20
 	/*
@@ -1238,10 +1235,11 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 			e->grain =3D dimm->grain;
=20
 		/*
-		 * If the error is memory-controller wide, there's no need to
-		 * seek for the affected DIMMs because the whole
-		 * channel/memory controller/...  may be affected.
-		 * Also, don't show errors for empty DIMM slots.
+		 * If the error is memory-controller wide, there's no
+		 * need to seek for the affected DIMMs because the
+		 * whole channel/memory controller/... may be
+		 * affected. Also, don't show errors for empty DIMM
+		 * slots.
 		 */
 		if (!dimm->nr_pages)
 			continue;
@@ -1277,7 +1275,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			chan =3D -2;
 	}
=20
-	if (!e->enable_per_layer_report)
+	if (any_memory)
 		strcpy(e->label, "any memory");
 	else if (!*e->label)
 		strcpy(e->label, "unknown memory");
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index bef8a428c429..cb3dab56a875 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -355,11 +355,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 				     mem_err->mem_dev_handle);
=20
 		index =3D get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
-		if (index >=3D 0) {
+		if (index >=3D 0)
 			e->top_layer =3D index;
-			e->enable_per_layer_report =3D true;
-		}
-
 	}
 	if (p > e->location)
 		*(p - 1) =3D '\0';
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 5c1bdef30757..d441026eeb1c 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -453,8 +453,6 @@ struct errcount_attribute_data {
  * @location:			location of the error
  * @label:			label of the affected DIMM(s)
  * @other_detail:		other driver-specific detail about the error
- * @enable_per_layer_report:	if false, the error affects all layers
- *				(typically, a memory controller error)
  */
 struct edac_raw_error_desc {
 	char location[LOCATION_SIZE];
@@ -471,7 +469,6 @@ struct edac_raw_error_desc {
 	unsigned long syndrome;
 	const char *msg;
 	const char *other_detail;
-	bool enable_per_layer_report;
 };
=20
 /* MEMORY controller information structure
--=20
2.20.1

