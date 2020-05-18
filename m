Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC611D7490
	for <lists+linux-edac@lfdr.de>; Mon, 18 May 2020 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgERKAI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 May 2020 06:00:08 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:11452 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgERKAD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 18 May 2020 06:00:03 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04I9uBrt013747;
        Mon, 18 May 2020 02:59:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=M+Uo44nbMmJHX33Mt5rIxPzo12kvpZVZaJyPrmz1OFQ=;
 b=GZXnvljLHeAeSs1mEUR+G5DZo6VjtSwHdjaE5X/li6DhqOjxY5G0WzwIXSbLN1zaBhXZ
 nH6lLhUjz8M6VVICYyi0VYfs4e3N+8HDFQKaZL+08dJAoHhg4zwL9uQXX2hx39l82joC
 yTHzRWzD76ShOFUFGPZNUQvcCrQKAQoZir4ZSKz+qa2IZkDZdYye1VbbDHdnhDWJU6M2
 ZaWtk8ysFcZ1P/p9ufNwJitz4Vg8jWqnmxaV6NuUaMQvVqBTPZzk8IVy35hV8aXjtLyA
 PWonMNl28+Q2ePCyMDpY0pp1GsoZpdgEdnoU2H3INU+SFWR1e4qZ/fSuy1X1KpEGmOXo sQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 312dhqekfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 02:59:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 May
 2020 02:59:40 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 May
 2020 02:59:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 18 May 2020 02:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brkYqb1brVZH2u/DPL5D0DCwtTtna8h9tYwm6LxEuhpeLXY4XspcKzTD27tvXSW19tTzz2/AwHp5oL47QpWyT6odVA3O9Zh0tN95TpZ+FK6pAwVKcCfkPzAYsQunVhyTerdCzWKrvPxm2eHeLRgWfGBzAbKs5b0RI4tiqUIR22FxTjz/Jn4PzmtI09YeAsBeqrHHn6Y5J5JxV8wrWgxAtV3RxzMbLSgPcRQ753vjMOGbGqWcJjHSl5lvDj3yvzweQH+3fc2WGoRw1pZRz72yWlD5Vrwptc16478cJg81gKXRuxXZfJt6BeLKBOePCNkRx5nTdm90b+Rh0N27cLn/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Uo44nbMmJHX33Mt5rIxPzo12kvpZVZaJyPrmz1OFQ=;
 b=nACARcGr2PVrBVUBlK5KtoMYiRqZJyDqphZd4GaqD+S36+gEQoIIr+0C72yL/CNNqaRVEsj/yhCrWY81tObNhRRW8IgTbsjUW4JEzngPH7WdCRkv/En2XvrQQmKui7Tu5iqgaIxn0Ytiwfr+ThML8w2G3t4Z2uA2QWvDpNFWaCbvgsIsbq2NUDyok5zXNsg5vy0Py9NuXPNsAm9su8mpPLnVynN+8a++3BoBiSjXDgyp0f1pahCoQJYXiVC1cs8sy8NQyd2EwXsWpM6NhYzRLdF6EcS04ck8uqRRsBufEGv4cP+4VctJ3If8L8So5VQicluMNeqDGO12+9VOJJ8EgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Uo44nbMmJHX33Mt5rIxPzo12kvpZVZaJyPrmz1OFQ=;
 b=JQdLafDbeKpG0Iflh0ncL3XhO1AsVzHhIB730yb4R0YquiOkpp0V+Kgw0Roc7zEJCIAB3/44U/wghfvYZq6kK+RwmFMiAGSLMmQwleH7LtZtEPjrfrnrbVCZhAgBXmPVG+2Dou0vv7cgwnhs1nXb9Ff/bbzs66F/8EeHa+/3J2k=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2712.namprd18.prod.outlook.com (2603:10b6:a03:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Mon, 18 May
 2020 09:59:38 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:59:38 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
Date:   Mon, 18 May 2020 11:58:52 +0200
Message-ID: <20200518095852.28010-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0402CA0021.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::31) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0402CA0021.eurprd04.prod.outlook.com (2603:10a6:3:d0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 09:59:34 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a9dca0-1eee-47d5-3595-08d7fb122c5b
X-MS-TrafficTypeDiagnostic: BYAPR18MB2712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB27121EB974CBF4591EEFB78BD9B80@BYAPR18MB2712.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jx6QZy8Tt1/qPbFfuVkj4o+k1F5fWTcxXSmjQb08y5ESPzkyWHGTr7VDtlgE+4xx9oSJgc2WguVMMCXLg2pMkHsfJneWq6Wx74/ZYX2Td0frnxciKhEd72p9EL5vNjQO+/R/wW4QqHvj4iX8teMyGJaDOcxovO0KRAkx1EQ7U4FUO7cHn73pRzfyl9+2/VkQ16p58wtfzCKePquc7j2TduS1wBVKjCeu7JjSnJlybIQib/tHenGlIxE2BZH0YI7r1FsdOBIYeEMvx6RpojEkp3kAsBXG6XaEbooBf1TNH3iyeW2dAuRnFu/9zcBCz13VpSXBe0WvU5jHXeFF+TUkfxpqBFFMFN/k4GEIaxCMtWFoDa5aog+QhjY+AY7e8P3dX2AMCfYEMJo51zUgj3ErHItU7OJQPXVfSfxXKHIZBj2haEFJ9vfosJjRSdIJU19Ds7JKmQiGrQvunlpXx/DPMcwDjg95XTNQkl067EaEwCkWF8++NyunHWKQZ0SZwF1BJQYmJ1jIkUUmR0AQ9funTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(366004)(346002)(376002)(396003)(6486002)(110136005)(316002)(54906003)(5660300002)(8676002)(6666004)(86362001)(4326008)(6512007)(478600001)(36756003)(966005)(8936002)(2906002)(52116002)(1076003)(16526019)(66946007)(6506007)(66556008)(66476007)(956004)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HggdttvV4Qljl6n8uwEli4n34Y1GIF92grNOO/jHLWK+7FFuQUMZ2z/oscwJY+XsUAX0Fk/bPxRKA5qGllyCiNbbSVXW1AbL+jcL0Ii2B+st8nKKQG0EmN0JGegDypifggxKlGbGpcZ0b/bdbxQIT03o5PNVvNG0zXapnrUWkKngjLhqqdzKLlvyDG0s5y3nW3TY0aj0+ox96OQs5G+04E2fquSuvKmNeUGUSspkH6qZiHJfpGNR8NL9TSdPkpwoqk/WPJ92vd89XEYUh+0DigjIg5wSF4mOh4xnZRyLRhlUJEtRnTL5XyNqQyf/ZnvnNj6xjlCfA60iKCanDWa0ZDnBGXXVSxReuAaj/GPv1aYiQzNbQoCNI7FozT1VVuwxIOpySBPojQHSOkrMiKmun1lNVDcdZ+snO6OtJvu61vaWPKWTi53o7KSBo8uncZht+xKRir+Q5P+ZK6tBnMzuORGPKWGmYsj1l4vJXYVVCdM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a9dca0-1eee-47d5-3595-08d7fb122c5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 09:59:37.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9YZC4bg1X9d70praCL2v/485c/mDCHoFTpZYU2u7cdwMCsYWL9/xeVw2nFMlmyRBJxZqT1GgZHKuaXLeQ3urA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2712
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_03:2020-05-15,2020-05-18 signatures=0
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
This patch is a self-contained version of:

 [v2,05/10] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
 https://lore.kernel.org/patchwork/patch/1229388/

 [02/11] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
 https://lore.kernel.org/patchwork/patch/1205891/

It applies on ras:edac-for-next commit id af8a9a36af01 ("EDAC/ghes:
Setup DIMM label from DMI and use it in error reports").

v3 changes:

 * shortend function name to dimm_setup_label(),

 * let args stick out of find_dimm_by_handle() (line length 82 chars).
---
 drivers/edac/ghes_edac.c | 43 +++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..c7d404629863 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -87,16 +87,31 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
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
+	if (bank && *bank && device && *device)
+		snprintf(dimm->label, sizeof(dimm->label),
+			"%s %s", bank, device);
+	else
+		snprintf(dimm->label, sizeof(dimm->label),
+			"unknown memory (handle: 0x%.4x)", handle);
 }
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
@@ -179,9 +194,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		dimm->dtype = DEV_UNKNOWN;
 		dimm->grain = 128;		/* Likely, worse case */
 
-		/*
-		 * FIXME: It shouldn't be hard to also fill the DIMM labels
-		 */
+		dimm_setup_label(dimm, entry->handle);
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
@@ -344,19 +357,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
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
+		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strcpy(e->label, dimm->label);
+			p += sprintf(p, "DIMM location:%s ", dimm->label);
+		} else {
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
-
-		index = get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
-		if (index >= 0)
-			e->top_layer = index;
+		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
-- 
2.20.1

