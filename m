Return-Path: <linux-edac+bounces-2037-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1699C6E4
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15392283768
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD61885B0;
	Mon, 14 Oct 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="Inxq0yys"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF0158D6A;
	Mon, 14 Oct 2024 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900646; cv=fail; b=gIr1N/tKlEyxxP9366tXbMM093Mj/oNl2zCxQtIuWXj37gheosIrWV5njctIfeYOuUDMXuXSIkPVj2IhW+/NapAaxI8UHzFibfXmhr4mGCr5BkPP26fartXN7M86ENV2UrwA5FyYYrLJ4BzOgU/ci+wcZ68D7AeOxFgPegfg24w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900646; c=relaxed/simple;
	bh=B98+NgXVZVmorWSGvKguN8XN4c352R1UfUTXjD6XDLg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hBMpy3wq8bjWid7WiagjOe4lilHAAh0E/e0qGZ9jFMSFSif2o8uzSf5eU5PJMqmwFy0d75RW+1HNYFyMa14G8pCaicrTN/FfoJt2VLvrPAnbZZVeWnE+BKVmyKChtYl1mBDdXpaKp/P4ZNOasd7Lf/Abk69AI1g38Zqx6kCQZ44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=Inxq0yys; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYZzXumn2Kqu5li6+MoBu716kaIb3QIeRm12/7PRDjmZnr4Tcmz2O5hxbeAGHBhVXMtzWLSZtX07LJKpsT1+9RclrxxLvG/+ixBXw+UtMsUtShCiIwmSVlvIW7nnj5rie7aXZuH07pOf26UMrJ0wnsmBlYGoO6jxhYqPmy7Uwagik+i4P2hEdVWzpFfCoY5DKjUMakL5Vw68mtjPT+r914/cKTVqx0vrG63puNB71utWVUS4NbO3qli8C7Oevi2JDNvCy1ysK/7C7NPPdOEXgcretJXOsxW0iTbSHQVNofa6k0P3ARiZ2wvM1Bvm986rk14aFv01uIYkzVKij1N55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1215Hyfc1PgN7TIdXyAKQdu+oBRVoVN1uNQGYxFodw=;
 b=MToxGTtVDH2I3BxfSo5hlDMD3PLoS7glNWKmWVUo0K/+pOpQ4hWy9MG9MUe3mV9dRLHwaX6bwz5A6ltpg3o4+oc93eDULVDNlqi/fWXTqx4H+VqhWLFayhx7IpKYoHBgKmb6JdLylJaGarz1bLUxWUDYSIZPE1pOD0aceUOIb30p9jyxnTbODMU1Ltf6k3TPIXyvzp3tmJOxvjqLcPvR5yqMm1T5h9dZ0LElocSwrdKYgsGUV2QRjcxuVBSdwpVuF4t5BbJludpytMSoNfan8eOSctG4dVq2+KVYA5dx8NW8Ws+NqwJysgvJNOxIp0vfc7fC06dcamiw3LY7kkegiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1215Hyfc1PgN7TIdXyAKQdu+oBRVoVN1uNQGYxFodw=;
 b=Inxq0yysbR5iXZHrmvg4c2pvtkiP7lLltB3HnRF/EPto5Huw7WQoufwPFGBdeGrzr6MAxt4CkJ2nCtnImjNDARuDcdpvj0QHqXjQCgsqXwi0l3WSJadeEm393baTMD4SXvfpZeiONrG5jIDm5io4k7MRsnopIGBpcT/IIfyPo46vA9fR8WrW7VAbwHAD8eV4qTYTTPMqWBsXrVVxc+pVknPAMPFarc35Dge7ZHtmEudDFobaVv/4SohiHWWUBbqITqFOWdKbaafbILrMPTnkUWT6VURN56QCsUrvJg4N9Sgyojqbfsvbr2Q/iRnk/HPNgo1BJ8Ewg+IiVm/um7JwWg==
Received: from BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22)
 by SJ0PR08MB6798.namprd08.prod.outlook.com (2603:10b6:a03:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 10:10:38 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::4c) by BL0PR05CA0012.outlook.office365.com
 (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Mon, 14 Oct 2024 10:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 10:10:38 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 04:10:37 -0600
Received: from BOW36EX19A.micron.com ([fe80::82f9:2375:13a4:3273]) by
 BOW36EX19A.micron.com ([fe80::82f9:2375:13a4:3273%8]) with mapi id
 15.02.1544.011; Mon, 14 Oct 2024 04:10:37 -0600
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: "mchehab@kernel.org" <mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Srinivasulu Thanneeru <sthanneeru@micron.com>, Ajay Joshi
	<ajayjoshi@micron.com>, Senthil Thangaraj <sthangaraj@micron.com>, "Vandana
 Salve" <vsalve@micron.com>
Subject: [RFC PATCH] rasdaemon: Add page offline support for cxl memory
Thread-Topic: [RFC PATCH] rasdaemon: Add page offline support for cxl memory
Thread-Index: AdseIOfbJEKPvJ5+RCqFn2Wf/RSCyg==
Date: Mon, 14 Oct 2024 10:10:37 +0000
Message-ID: <a4cdc0ddd56c450c9bfa1d950a3a37ac@micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=648b45c0-03d9-4c73-9b57-4ed5d1e210e5;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2024-10-14T10:06:57Z;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ0PR08MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 488fe66f-135d-47e0-fc49-08dcec3873f1
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M9lUZML99KiLYMwqa/NpgU329T/5ZXGODfA1VHFYBPfgCo+YFsekr+PBXoIC?=
 =?us-ascii?Q?SfX/4Erfn0sA2/bsFbnbWalMKenEAAHdffBsEj2mIcqblTL2VChvgGTom6eg?=
 =?us-ascii?Q?57KcyzTOaGjF2dppMT6MFbkxwnWQdJN9/LC6bRKCfDISu1LX+jbDcKm22UZg?=
 =?us-ascii?Q?RxdpCs6N1kbSBthBwCYVXpB7fnbLqE+tkryesVvg50XVAo09swlWjMjwCgy+?=
 =?us-ascii?Q?WjFjbkqr+bPHN+pEFhmrGJeNAk3lh74pkyccJkq0G13bHDKT/jdGTYsRmwbt?=
 =?us-ascii?Q?9dzfgNEQ9SczMdiDiH3NskfA4PczhxBxJMh/v7cVcT+QLC6iLCMatmtIoSb2?=
 =?us-ascii?Q?5rTiJvV8tKU9u4DBTf92Gslypk43Hdp1pNs7XDkvqMO66Mw4hxrl0rrDeGrt?=
 =?us-ascii?Q?cxn2I7yGQKcPE4O+F7ki4A1kXVLmRMAQFjMcKIEB03MuHoNYYdvRk5LnsjVO?=
 =?us-ascii?Q?eLFWTG7PauMwmMNvF6Ol0MFoNk6iLet+iP6ggiyDiwgClgk7b3A8yUFhBhET?=
 =?us-ascii?Q?6yAm/s0DMQT+CUYoNbrb96FYsjAzjjnaAF9/Vg1AXEMjmTC9WbNVcj44Sz1H?=
 =?us-ascii?Q?gm136uJuMUdVsUurlt752v9wU51EETbN1z7XvdEr8iLl4tOgc0tP68V5xTug?=
 =?us-ascii?Q?zxNk5jI9xu/ma1ELk95HCzdmQIBuV2yG2ntDLHpKDSzZ14qw3m71XOC9AIxH?=
 =?us-ascii?Q?mQmZYc9JuL5TJknvsDxRXBogTN8iXJlnosyBNT6uDBJe/hZwe26lBOBbBsLV?=
 =?us-ascii?Q?a6MVCxvNIEt7SzbeCuoLBm7nLooRFrGahoC7/TmR7ewkr4wQ21AjxLOeOPzg?=
 =?us-ascii?Q?+pPiEAOWj3uIgF2zg2VGB8FvyVloOQUfPqEKXdv6kfQLAqPvL1+rmDXw1KzZ?=
 =?us-ascii?Q?KTRBDP5u3HzUVLWnwDabeaH2yO0GN1+zzngf0bulWU9FcJKT7coJ+81CCBJI?=
 =?us-ascii?Q?eHwXgAFlTXeewMPdwCpMFE8waR280WP1FSkN7uoQTrgf5AkcFwFf83FDd6bt?=
 =?us-ascii?Q?Bi/Sn2UoDV302gQ2w/J+W+CibCUPP7/IxIp0htJd8sc1b0MdublS3ncxGoQN?=
 =?us-ascii?Q?8bRKc1LrOw3s2Wsb0xMoMJbFL2IAoi0Pi8hiJUIthSRZxD8TZZTyJ5lKIJbM?=
 =?us-ascii?Q?CWeMYGXqGekcEyvImHtTkNpaoDQR3UAj4vGUjk9K8AtNHfcNId/9h/2eWti2?=
 =?us-ascii?Q?WGvgzy+/djmSPn+CSIzOQQDjkwi2VKN7TDegkURniAVZbf80scH79Sj/j402?=
 =?us-ascii?Q?S8c7D+tfL90sE49vxwEQcQ5Bj4wksxalVFW5aO2+0M4pD3BP08XriOz6k04v?=
 =?us-ascii?Q?9Dwao6ED3MBiLUvrqoG+ZLz5pQWcy1ymqqb8NNVlSUbhAwDM1sl5Bi71fsaY?=
 =?us-ascii?Q?JdzelMYl1O0itBws8Bjvp7zfxews?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 10:10:38.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488fe66f-135d-47e0-fc49-08dcec3873f1
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6798

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

CXL Type 3 device implements a threshold for corrected errors as described =
in
CXL 3.1 specification section 8.2.9.9.11.3. Device can set the threshold fi=
eld
in the DRAM event descriptor when it detects corrected errors that meet or
exceed the threshold value.

This patch is intended to offline pages for corrected memory errors when th=
e
device sets the threshold in the DRAM event descriptor.
This helps prevent corrected errors from becoming uncorrected.

Record the hpa for given dpa, then do page offline for hpa when corrected
errors threshold is set.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 ras-cxl-handler.c    | 14 ++++++++++++++
 ras-page-isolation.c |  7 +++++++
 ras-page-isolation.h |  1 +
 ras-record.h         |  1 +
 4 files changed, 23 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 037c19c..c163c6f 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -13,6 +13,7 @@
=20
 #include "ras-cxl-handler.h"
 #include "ras-logger.h"
+#include "ras-page-isolation.h"
 #include "ras-record.h"
 #include "ras-report.h"
 #include "types.h"
@@ -897,6 +898,12 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 	if (trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa) <=3D 0=
)
 		return -1;
=20
+	if (tep_get_field_val(s, event, "hpa", record, &val, 1) < 0)
+		return -1;
+	ev.hpa =3D val;
+	if (trace_seq_printf(s, "hpa:0x%llx ", (unsigned long long)ev.hpa) <=3D 0=
)
+		return -1;
+
 	if (tep_get_field_val(s,  event, "dpa_flags", record, &val, 1) < 0)
 		return -1;
 	ev.dpa_flags =3D val;
@@ -1005,6 +1012,13 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 		}
 	}
=20
+#ifdef HAVE_MEMORY_CE_PFA
+	/* Page offline for CE when threeshold is set */
+	if (!(ev.descriptor & CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT) &&
+	     (ev.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT))
+		ras_hw_threshold_pageoffline(ev.hpa);
+#endif
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_cxl_dram_event(ras, &ev);
diff --git a/ras-page-isolation.c b/ras-page-isolation.c
index bb6b777..6eb45d0 100644
--- a/ras-page-isolation.c
+++ b/ras-page-isolation.c
@@ -338,3 +338,10 @@ void ras_record_page_error(unsigned long long addr, un=
signed int count, time_t t
 		page_record(pr, count, time);
 	}
 }
+
+void ras_hw_threshold_pageoffline(unsigned long long addr)
+{
+	time_t now =3D time(NULL);
+
+	ras_record_page_error(addr, threshold.val, now);
+}
diff --git a/ras-page-isolation.h b/ras-page-isolation.h
index 73c9157..ed2f661 100644
--- a/ras-page-isolation.h
+++ b/ras-page-isolation.h
@@ -57,5 +57,6 @@ struct isolation {
 void ras_page_account_init(void);
 void ras_record_page_error(unsigned long long addr,
 			   unsigned int count, time_t time);
+void ras_hw_threshold_pageoffline(unsigned long long addr);
=20
 #endif
diff --git a/ras-record.h b/ras-record.h
index bd861ff..d4969d1 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -203,6 +203,7 @@ struct ras_cxl_general_media_event {
 struct ras_cxl_dram_event {
 	struct ras_cxl_event_common_hdr hdr;
 	uint64_t dpa;
+	uint64_t hpa;
 	uint8_t dpa_flags;
 	uint8_t descriptor;
 	uint8_t type;
--=20
2.46.2

