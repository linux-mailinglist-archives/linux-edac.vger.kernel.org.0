Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E911B43B2
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgDVL7i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56962 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbgDVL7f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpHUF031930;
        Wed, 22 Apr 2020 04:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=c3VCTPNGha8txuWMZs0ZsuMZ6FPrtsFxHmkSjGZrUbQ=;
 b=pmVXXhidGfv0y7yT9Uv1w77HOG03WuFVK43Fbu3rGPlWCzrnIrc4gcRehuCbCAXcmK3/
 ylJf37GQ8It9stQa9EOAkfSG5wJil3IL1XJIP0VNj4LfoZr7HR8O7ouCJyoaisGkjTjD
 ppTDaKBsN+1ZGVj0/aILun27OjJXIhKuahHaH2ceCdo+kXrYA83zTKzOgNYSW0j2P8aY
 FE4S2Ff38wPMSYKKMaSP1qF0tSLFXXuX2B8sZcXtUFEym2QsDJwVCtqYpFAk6AuGw9e+
 SrGzt9gvqWT8HCcQQcz9UvMQznVqP7Cd3GXhIyeu5hrIjJpJ8Vt7EVvDkSV6dLJ32BdO Bw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 30jd011w4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:59:03 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:59:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2pUZvrnz9Dt0yOWqWT3N5srr0/Dh/KUjQI617N3TxaM4xxAx7g+9o0fuVhtA9gXQpuMu/Edo6XUlg0NUcUbGVjgSuxEk0LZAs38eTLwnbi4neJqupiowL6Vh3RYsryyKP1PPBc+SD8yWqnCL3N3v0hApgOYIU3kixeY6Q5XcWcHoGn9vQQE/rIGW3xhsifJcAcciZY++nPzYS0G41ZbVPzvS9tQ+svNdRGzKkqVW1zdeTGeuWvrZP4d24YIrOCFUS8G5BUSVbZuPkUw4+9s55tQ8EnnvE6wqOBV7+vjQoZauWaCrHnr0CXCw26bMu3R5eDPnCep90huidgqOL0qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3VCTPNGha8txuWMZs0ZsuMZ6FPrtsFxHmkSjGZrUbQ=;
 b=KHoyDPMSsaODL2ECeyMoaI/FUMJLbK2RqWaPZqUArVfJuJSzn+jITa0s7YDJzE5mG87mBZEZnZov0MKDjSegVMWNAFiU3M4lTNbBbgUqEi8h7slyLK+NmHwo1mHt/40cMuHSImVjGmI6z7aMABY5iML6Wu8tNJCdYRrgbRTbu3W7hPN75t8dqaxZzldI5eRGb4LrnaQSKB3iEXgs7O3K1D7JHBtw6+g7CdwL0X34052iZK3+Z0ON8vFeaGwmj8WqmzA4xTQcv3dhlLyRznPPdDiA6JQpREpKO/nZ873bAwX3OByBTpHWWTXm4obs2Lb4djrodNl03dMcRJZYPJ4Z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3VCTPNGha8txuWMZs0ZsuMZ6FPrtsFxHmkSjGZrUbQ=;
 b=dy5CoDa4Panh9Es3bO6tPZ90P5OacR+AT3wq/gKBO5gaZ+ST9RKgXyR8BoZqXOXSEr5br5bMG7knNXNMiPLclLrAIMn017mh1GjBcpFGwrtLX9oT+4I5oaY2dzg3xUen5NkaRi01xxItACWb6Zw6JWEgmIIbD5LhkI+4VmEV4Sw=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:59:00 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:58:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/10] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
Date:   Wed, 22 Apr 2020 13:58:09 +0200
Message-ID: <20200422115814.22205-6-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422115814.22205-1-rrichter@marvell.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:58:57 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a94d37-ed23-4558-4471-08d7e6b48ae5
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2933E9542CE0406ACF1286AFD9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8QSFnGZoessV6gme9pFIYLttjQmN82+zSirNqq9+muSb0LRDaoM5cqc0gTQ+Vpc7CBIpkQZHsTvQ+G5E+WHhQEmGrqKuX3aYkw9KuZVSldkXXIny5uSQLCKSFIv85ofPQEOn/w4D3YIBiA4YcznixfKD8XcqUQB2NUL+PV4+RwAM+3xJk+0928rYs4nLoEJExdrvt9I2JNv1auNQdWwvBtbw11OD8MVZuc8ADIugvqN1p2KhmQoZZn5rQJifldp5mTD9F17TueXutBCFRxbH7rai9UCt5wkH2+pqpMQR+GXEl4HftbA6QU5wrZvqKAEEEwnyKYdf6EVZRDQP79Fm1qW5aO8QDXfVlx606gezyFCb2P7J6w9QyoEybQpqcArW8UGi2/XQsqY243IyvfE/PsLpT8MxhzIN00fvIxlqFZCGTKpcczo5QuW6fvHaSSt
X-MS-Exchange-AntiSpam-MessageData: 3CtpnLhCTgdLkiuwVrVnQyJrDsf3ciHWX0aelsEXbhOZgi5YKo/0/KWFtvygi2VpLA1ATskx6lTOvwm1xwdkBxTIyrl7WQPnI0Df1f9lSTQzPINGy1ko+K5bjllfGlvVWt7QvC9fzd9vJ9axc44VWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a94d37-ed23-4558-4471-08d7e6b48ae5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:58:59.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENG069KpXlPkcZ+87sdoTqD3c3Aju0NlTbspOhF5QSWtuTbUuj58M1c0K6TUVmt/pK4JW1eZJHftAjmuGf0MOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
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
 [ 2119.784489] EDAC MC0: 1 CE Single-bit ECC on foobar (node:0 card:0
 module:0 rank:0 bank:769 col:1 bit_pos:16 DIMM location:foobar
 page:0x94d027 offset:0x0 grain:1 syndrome:0x0 - APEI location: node:0
 card:0 module:0 rank:0 bank:769 col:1 bit_pos:16 DIMM location:foobar
 status(0x0000000000000400): Storage error in DRAM memory)

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 43 +++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 23adb7674f9b..a5890afa9c71 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -153,7 +153,7 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static int get_dimm_smbios_index(u16 handle)
+static struct dimm_info *find_dimm_by_handle(u16 handle)
 {
 	struct ghes_dimm *ghes_dimm;
 
@@ -161,10 +161,25 @@ static int get_dimm_smbios_index(u16 handle)
 
 	list_for_each_entry(ghes_dimm, &ghes_dimm_list, entry) {
 		if (ghes_dimm->handle == handle)
-			return ghes_dimm->dimm->idx;
+			return ghes_dimm->dimm;
 	}
 
-	return -1;
+	return NULL;
+}
+
+static void ghes_dimm_setup_label(struct dimm_info *dimm, u16 handle)
+{
+	const char *bank = NULL, *device = NULL;
+
+	dmi_memdev_name(handle, &bank, &device);
+
+	/* both strings must be non-zero */
+	if (bank && *bank && device && *device)
+		snprintf(dimm->label, sizeof(dimm->label),
+			"%s %s", bank, device);
+	else
+		snprintf(dimm->label, sizeof(dimm->label),
+			"unknown memory (handle: 0x%.4x)", handle);
 }
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
@@ -248,9 +263,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		dimm->dtype = DEV_UNKNOWN;
 		dimm->grain = 128;		/* Likely, worse case */
 
-		/*
-		 * FIXME: It shouldn't be hard to also fill the DIMM labels
-		 */
+		ghes_dimm_setup_label(dimm, entry->handle);
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
@@ -416,19 +429,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
-		const char *bank = NULL, *device = NULL;
-		int index = -1;
+		struct dimm_info *dimm;
 
-		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
-		if (bank != NULL && device != NULL)
-			p += sprintf(p, "DIMM location:%s %s ", bank, device);
-		else
+		dimm = find_dimm_by_handle(mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strcpy(e->label, dimm->label);
+			p += sprintf(p, "DIMM location:%s ", dimm->label);
+		} else {
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
-
-		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
-		if (index >= 0)
-			e->top_layer = index;
+		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
-- 
2.20.1

