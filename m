Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC291E5CC6
	for <lists+linux-edac@lfdr.de>; Thu, 28 May 2020 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgE1KOP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 May 2020 06:14:15 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:61972 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387597AbgE1KOI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 May 2020 06:14:08 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SAAACt031790;
        Thu, 28 May 2020 03:13:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=s7mtrkiD1cYRxPhxMrDG9T/iqAehPJXvXhecEReFMC0=;
 b=KEFeEvchi7DElHlT0zwu73v7pPOHtAG61n9dfH8DbEdrd8MFpNoAIj8CmgHYix7f4rvM
 frIO7M6kkhEysWPrdp65kk1XMqgMxIUIsfnxTbrXsgzCTIUBkZbMahF6SVTaF0ENDS4o
 DnQF9mqjsuf5xTP6ItmasNi3rM0XarNwTrFP6bJVVlnTm+0st35Z0OksOCrUoBD8svxl
 pyJiJpsfShAGjgJhjNB+6dPfffUcmhh7hvEGWqMNtlpN8tZ2eF6toSY9Xs0LIW2jYZCN
 8jYPvFnHJ0SUIssdxSw+8YmzFZrb3hyYIezFRxPMdYr/2MzBndGHW3HFYj1KbJZIY18c JA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 31716r2bc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 03:13:45 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 May
 2020 03:13:44 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 May
 2020 03:13:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 28 May 2020 03:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIwr1mdN5mzLKHrOvROdLuy0mXXMnF/9BDQCpGvujI7YT4HS1F9N/6+kgtnB1k8JSRgSqqnwkF/Uyp0W4oB2BnUb5zag3jjPoEWmqMjkJy6YWbFsXYbEJde4L54k4zjNFvR5m9dzOvIVeF86fgTH2c1g7AJbWKXXH968J2ujje73wnlIOk2xljy+MF1Y1yUteA9OtbaW11upwJ1nTE6RyZC++k1T9quHNzTsA+1FKPNocv7a1yc7+/8/YnvlCo3N9cy3nJvi7phYT5z9Gz2eGKmA4CH/d3/kqXXcr3TCVjyeCNy+oGH9iSwg0es1CMQ+M8ifJOWdwFLJ4gVRlnwAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7mtrkiD1cYRxPhxMrDG9T/iqAehPJXvXhecEReFMC0=;
 b=EuhXzngug+vJu02sjlTUdFvxV/qog3iqpNTpLKchtUFjcOhUcKjnh9xPX6Ao+TWhXpy+3wzuRPvNGmfB7gwmr0KeVkKYvJmV6qrdW9w7jF6oJvDCTYdKwwtT2HAjpKuBGK4HEyvR7OxqKX3AQ/d6kdU+M75Xv1c/03bn8/tg5nHeRGtCEQecub0Wkcp6AbOD/Woh7RsDlSZguYeXY8YEZNIZxApT+FAxxI0cTOl6qsxMUhYSrOG4NMbgh+SGWD3F/j8mqt1bwFX3bmdJ5iiHEQMNmag2sAgDEUu9udx6ytTg9JpJKOj9w92TACotq4n2RtTk1rOJb3j7T/GpAaNPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7mtrkiD1cYRxPhxMrDG9T/iqAehPJXvXhecEReFMC0=;
 b=Yh2JDjNwNXVGlYrojzPTmgzDe0hiRmqNsDVDJ/Gi+X/qDWqYB+HDGzFFDrA7NbholsiUZ2MQOENulFnkIjtRyLGNnCJGnDb0J/X7Z4fzGrNEzNd04G5SNLxRR82YFs3wDH9ah1jbrTfKrxR6eJqo53R6GVeKF//yXQoF2T1xiss=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2856.namprd18.prod.outlook.com (2603:10b6:a03:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 10:13:41 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 10:13:41 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
Date:   Thu, 28 May 2020 12:13:06 +0200
Message-ID: <20200528101307.23245-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0017.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::27) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0017.eurprd09.prod.outlook.com (2603:10a6:3:e5::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 10:13:38 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a0e0b1-1f56-489e-2c67-08d802efcb87
X-MS-TrafficTypeDiagnostic: BYAPR18MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB28562FBC121C154E170AF3E5D98E0@BYAPR18MB2856.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2UbrapilxjmpfA0TM9o9cunr9u1ZrbM2wVZeM4ugwgCFFikqB2q2+nqCfLHW7mKnpjOJUOX1Ewpt6rDgaARlP2GT1dHgGwJ4n1vzMuXcm3GFiqSMTWDKbuU4NSV9Gkacgt3xHBEesXVN0sr78wE6YQsEU6Dk5yRL7GEONLBohrNFsn/4/DGsG30w4EVCMeMLtdVwz2ICDf8425JjYTHURyw91Zt6Dv8+WNH1Dm04+yQ6mjjuVNuib09v/pjQ+gqAPRSt53/0RmhJKjlaPErMG+qhgiq2wAzxTR/xhuRcTOGnwLyZzLWA3UKGFpmkBw+Q+N6cj9+8lXz2w+b6NfZaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(66946007)(54906003)(8936002)(2616005)(956004)(8676002)(6666004)(83380400001)(5660300002)(6486002)(6512007)(110136005)(316002)(478600001)(6506007)(1076003)(2906002)(36756003)(86362001)(66476007)(66556008)(4326008)(52116002)(16526019)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +KoMo5lcaQSSo8kJE3IZAFEie/rgQfMY0/jo4SJgk2Uh4lckvvBz7sMsF90vsH9dXt5KPvvAOQC5CrFhRUshnapJTkH1R/CGaO6jrsGe0VnXe2hVsQJ3an5qgcZpFO1/67WrGHUeBhv7BgdUnqQoQJmzzRy0//km0qEjnkbUgJGGZS6bkzrsUCxGIbeV7nxR7vUes5EXSPbFbv7EWUG8+WjmyPAlA9S2FMwGzeZncV2UouNWGF6upYVO0BC6lkrbYlKkoUTwd9Wp3xXmWGGTgflzQj3OtRnOA3fFA/+IkRbe3DnaH+aoTRiEiHZp79glOtizlQHSriRaz5deBOFsACCcVBOT3WI3xFO7CUZMBb/h7QclHHIs1HVjjjd+EI3w6T0ZC1ecSVhtVQN+Ss4RCIvVDX7FpqA58x1E9V9VZqjpqZ45cyoN8N3vv+VX+ImkfoK53KJjb+RrFOk3bGalJ04GzSs2Prbqlpvb9NHU7Yc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a0e0b1-1f56-489e-2c67-08d802efcb87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 10:13:41.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaIH3lwKXR1edBmQkD/bi0+Lmx5yNqz+6XGJItPtStnCDOko0X4DxKpTjcZapbdLW5TtSefuCR/vAB3EdWyDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2856
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The ghes driver reports errors with 'unknown label' even if the actual
DIMM label is known, e.g.:

 EDAC MC0: 1 CE Single-bit ECC on unknown label (node:0 card:0
   module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM location:N0 DIMM_A0
   page:0x966a9b3 offset:0x0 grain:1 syndrome:0x0 - APEI location:
   node:0 card:0 module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM
   location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
   DRAM memory)

Fix this by using struct dimm_info's label string in error reports:

 EDAC MC0: 1 CE Single-bit ECC on N0 DIMM_A0 (node:0 card:0 module:0
   rank:1 bank:515 col:14 bit_pos:16 DIMM location:N0 DIMM_A0
   page:0x99223d8 offset:0x0 grain:1 syndrome:0x0 - APEI location:
   node:0 card:0 module:0 rank:1 bank:515 col:14 bit_pos:16 DIMM
   location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
   DRAM memory)

The labels are initialized by reading the bank and device strings from
DMI. Now, the label information can also read from sysfs. E.g. a
ThunderX2 system will show the following:

 /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
 /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
 /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
 /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
 /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
 /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
 /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
 /sys/devices/system/edac/mc/mc0/dimm8/dimm_label:N1 DIMM_I0
 /sys/devices/system/edac/mc/mc0/dimm9/dimm_label:N1 DIMM_J0
 /sys/devices/system/edac/mc/mc0/dimm10/dimm_label:N1 DIMM_K0
 /sys/devices/system/edac/mc/mc0/dimm11/dimm_label:N1 DIMM_L0
 /sys/devices/system/edac/mc/mc0/dimm12/dimm_label:N1 DIMM_M0
 /sys/devices/system/edac/mc/mc0/dimm13/dimm_label:N1 DIMM_N0
 /sys/devices/system/edac/mc/mc0/dimm14/dimm_label:N1 DIMM_O0
 /sys/devices/system/edac/mc/mc0/dimm15/dimm_label:N1 DIMM_P0

Since dimm_labels can be rewritten, that label will be used in a later
error report:

 # echo foobar >/sys/devices/system/edac/mc/mc0/dimm0/dimm_label
 # # some error injection here
 # dmesg | grep foobar
 [ 751.383533] EDAC MC0: 1 CE Single-bit ECC on foobar (node:0 card:0
 module:0 rank:1 bank:259 col:3 bit_pos:16 DIMM location:N0 DIMM_A0
 page:0x8c8dc74 offset:0x0 grain:1 syndrome:0x0 - APEI location:
 node:0 card:0 module:0 rank:1 bank:259 col:3 bit_pos:16 DIMM
 location:N0 DIMM_A0 status(0x0000000000000400): Storage error in DRAM
 memory)

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
v4:

 * dimm->label: Only update dimm->label in if bank/device is found in
   the SMBIOS table, this keeps current behavior for machines that do
   not provide this information.

 * e->location: Keep current behavior how e->location is written.

 * e->label: Use dimm->label if a DIMM was found by its handle and
   "unknown memory" otherwise. This aligns with the edac_mc
   implementation.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..9a6a055ab624 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -87,16 +87,29 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
+static struct dimm_info *find_dimm_by_handle(struct mem_ctl_info *mci, u16 handle)
 {
 	struct dimm_info *dimm;
 
 	mci_for_each_dimm(mci, dimm) {
 		if (dimm->smbios_handle == handle)
-			return dimm->idx;
+			return dimm;
 	}
 
-	return -1;
+	return NULL;
+}
+
+static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
+{
+	const char *bank = NULL, *device = NULL;
+
+	dmi_memdev_name(handle, &bank, &device);
+
+	/* both strings must be non-zero */
+	if (bank && *bank && device && *device) {
+		snprintf(dimm->label, sizeof(dimm->label),
+			"%s %s", bank, device);
+	}
 }
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
@@ -179,9 +192,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		dimm->dtype = DEV_UNKNOWN;
 		dimm->grain = 128;		/* Likely, worse case */
 
-		/*
-		 * FIXME: It shouldn't be hard to also fill the DIMM labels
-		 */
+		dimm_setup_label(dimm, entry->handle);
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
@@ -228,7 +239,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	memset(e, 0, sizeof (*e));
 	e->error_count = 1;
 	e->grain = 1;
-	strcpy(e->label, "unknown label");
 	e->msg = pvt->msg;
 	e->other_detail = pvt->other_detail;
 	e->top_layer = -1;
@@ -345,7 +355,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
-		int index = -1;
+		struct dimm_info *dimm;
 
 		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
 		if (bank != NULL && device != NULL)
@@ -354,13 +364,18 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
 
-		index = get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
-		if (index >= 0)
-			e->top_layer = index;
+		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strcpy(e->label, dimm->label);
+		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
 
+	if (!*e->label)
+		strcpy(e->label, "unknown memory");
+
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
 	p += snprintf(p, sizeof(pvt->other_detail),
-- 
2.20.1

