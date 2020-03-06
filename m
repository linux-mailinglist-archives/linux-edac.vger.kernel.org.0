Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4204317C17C
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCFPOO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:14 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16902 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgCFPON (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:13 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6JCY006235;
        Fri, 6 Mar 2020 07:14:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=FApSnbcyXXt9820eLb67t/lE16LV+P+asS2t1A3gsrY=;
 b=YtrqL5TiL2FF+aWbKACOkfSrrlNL6NZU0IhDcRv85RnDzrqgvol+KsTJ0IgFsHfTjBt7
 Rz6FFHc2vCErUHxt5b41c6NhPjR78O1o97p4RcmmU0VeR7XquwFlQiZmiayu4uwFAvXu
 vs6cBhvmQ1JtXVguvvIhlWSXGriPN+NmrHHzuw26fLWQ/jNhvf4k1K4EQiLbfLBVZMvx
 YDk1wqOFKdtzQQE5IRUZYdM2dqi85ocSUPOPUe7ASoQCGgO0GOw853o5DFrzJbxpTPgO
 0TnoF9rc87lICZ/wC4QtJ8Xqq5o1RO2JBE6t8bZoBgZCWLKUy72yFDbKQBJ/HKmbDl49 KQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:14:04 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:14:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:14:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhfPR3fpCNi46oSQuGoO/TmrJo/TxL9/gWqpD1WggM0cixpdvK7fWZTdAG8w0NL9ifyUfyqLjh3BkHMxD7TJyGgRiMZ1KSf+7agY59L5vOv82Mv65Hbo9abv1+mqhIqww+naoAndanJgN0YUYoYnKRwSSqU45yltK2z5czL8xxwuvT28gX96WvN+17MFgetHRbcxLHH9DYoi4M1+PBU/3mbn8o2f7Zxnjyzzifp711NyoGbI+Eavu7M8eWxx2PCY/AAQ7QM9vN17IXZKbWzOiogI6uy06NIO6iF1nVx877kG0O+ulEucNRkVbu88oyOFY5V5dWzsSATea31sBAyNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FApSnbcyXXt9820eLb67t/lE16LV+P+asS2t1A3gsrY=;
 b=P+sQx0foUH0eK6b6YvqlWJhW4vANnbF3XT8/JhUn37NxUlcZtCFzm97f/skJJd3XTS68BF9/U4W/QhbosMGAsiViLr9A7hUSec2gYnZvG+qwvSWplD3NYsmVqOM0neE/IYDdyKelY9N/TmDk+lsuKYlWZVal1ZuTEEDnA4pWBoX1ZecPk62UhLkT89nzrUmzdugKTgZ/hJDRMeSkspkktMt9jry6Yhh6xP0/uQzyXZ64F9D1jybHX9W5CCG2onHJXIjjnAMUs/Fu94wxEu0SDDaCAFMAcpnrTgqNUfPv6Lr7rAB7KTEnwRfbF7T2QjEqQlDE1d7bWo/U2kCKeTMw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FApSnbcyXXt9820eLb67t/lE16LV+P+asS2t1A3gsrY=;
 b=eMaYQEYMgD7delHE1eVoml+1hWoORV4w0wlvO3wdleYCEicpNuJv26LCQjFgIJ7ZEzyDmxOeYXdPU/isyEEA2VcLWu+r5N+sP8fBrk1g31GFDiOHbn+wdFUn7wvuh9Vdyvq9hB9/eaTplKT4+c69G1DF7qFi4Ektu9KeAud2DOI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:14:01 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:14:01 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] EDAC/ghes: Create one memory controller per physical memory array
Date:   Fri,  6 Mar 2020 16:13:18 +0100
Message-ID: <20200306151318.17422-12-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:59 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d6202b-7cdc-4b5f-c67c-08d7c1e10021
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB240067E271A39E5BEBC03E7ED9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(966005)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPDmo+5+BM4nhO04MJRyxoFLlol9sAc/lhZ5XIzePLYpLpP3TKEojiO6IGtR6kVjuwvOcIy9BiZykxusuTS04zF7eJg4Z/LVYPo6ehJhxWoG4QtfSazf4KtprA+OGISqs8RzyZiNSqAjDYFhWoc2f7q/QwN8GaqyYN9xkfFqCkjrOsqVdZNHiFgqh+CTJbhGn8zKyu8Qeh5o0is56CCHsRYQ8rxP+w3k7TuRgDKg7EfsHAnygUb945tJzhDMthQVBDI8Jdg5eidIqoj3BZdM7ZWMAqG7ADu6zT/t7r27NWNqeX+rZ69YHkU8U9oWEsBfqRHKY+EMO+8k5qddOW6WA/MLiRJZjDCJnjYMB3rzeBCNPZctohm57koW5Y7wMjq5/fHz8ykBKoXGZH0EGGh509LXdGFFqQ9hyeNbXh6ZLhq0ldz7GyLBGHcHmY5Rc6UWqfD5EBXbn3kTNq8wjDM7Ge+fq97tguHWkPpzb8tJKR/aSvTNPJPcP094z2kobqFkhkRDQNWhV6dd+MLbTkPO6Q==
X-MS-Exchange-AntiSpam-MessageData: OpOjVpIAWOc4RR31ZP6b1ehWK/DS5EHKhRtPMZ+PhSYs11NLkHW5IXe+MUNWtiPkCcBHo5TbVbo13cVx5YCtAwGlcJ0i05awWl0hwms+9RmZAY89Rz6yokPD9l6IBSymxYtf2kL9TqTa4yumNBTHIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d6202b-7cdc-4b5f-c67c-08d7c1e10021
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:14:01.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqtycARQwgW+iCq0Z2QYAl7/lGH607uv6S/52++NnZti8sd/9ca7GW3tQStxqYJ3od+qtOGz/NWFH0qJWpl8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The ghes driver only creates one memory controller for the whole
system. This does not reflect memory topology especially in multi-node
systems. E.g. a Marvell ThunderX2 system shows:

 /sys/devices/system/edac/mc/mc0/dimm0
 /sys/devices/system/edac/mc/mc0/dimm1
 /sys/devices/system/edac/mc/mc0/dimm2
 /sys/devices/system/edac/mc/mc0/dimm3
 /sys/devices/system/edac/mc/mc0/dimm4
 /sys/devices/system/edac/mc/mc0/dimm5
 /sys/devices/system/edac/mc/mc0/dimm6
 /sys/devices/system/edac/mc/mc0/dimm7
 /sys/devices/system/edac/mc/mc0/dimm8
 /sys/devices/system/edac/mc/mc0/dimm9
 /sys/devices/system/edac/mc/mc0/dimm10
 /sys/devices/system/edac/mc/mc0/dimm11
 /sys/devices/system/edac/mc/mc0/dimm12
 /sys/devices/system/edac/mc/mc0/dimm13
 /sys/devices/system/edac/mc/mc0/dimm14
 /sys/devices/system/edac/mc/mc0/dimm15

The DIMMs 9-15 are located on the 2nd node of the system. On
comparable x86 systems there is one memory controller per node. The
ghes driver should also group DIMMs depending on the topology and
create one MC per node.

There are several options to detect the topology. ARM64 systems
retrieve the (NUMA) node information from the ACPI SRAT table (see
acpi_table_parse_srat()). The node id is later stored in the physical
address page. The pfn_to_nid() macro could be used for a DIMM after
determining its physical address. The drawback of this approach is
that there are too many subsystems involved it depends on. It could
easily break and makes the implementation complex. E.g. pfn_to_nid()
can only be reliable used on mapped address ranges which is not always
granted, there are various firmware instances involved which could be
broken, or results may vary depending on NUMA settings.

Another approach that was suggested by James' is to use the DIMM's
physical memory array handle to group DIMMs [1]. The advantage is to
only use the information on memory devices from the SMBIOS table that
contains a reference to the physical memory array it belongs too. This
information is mandatory same as the use of DIMM handle references by
GHES to provide the DIMM location of an error. There is only a single
table to parse which eases implementation. This patch uses this
approach for DIMM grouping.

Modify the DMI decoder to also detect the physical memory array a DIMM
is linked to and create one memory controller per array to group
DIMMs. With the change DIMMs are grouped, e.g. a ThunderX2 system
shows one MC per node now:

 # grep . /sys/devices/system/edac/mc/mc*/dimm*/dimm_label
 /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
 /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
 /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
 /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
 /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
 /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
 /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
 /sys/devices/system/edac/mc/mc1/dimm0/dimm_label:N1 DIMM_I0
 /sys/devices/system/edac/mc/mc1/dimm1/dimm_label:N1 DIMM_J0
 /sys/devices/system/edac/mc/mc1/dimm2/dimm_label:N1 DIMM_K0
 /sys/devices/system/edac/mc/mc1/dimm3/dimm_label:N1 DIMM_L0
 /sys/devices/system/edac/mc/mc1/dimm4/dimm_label:N1 DIMM_M0
 /sys/devices/system/edac/mc/mc1/dimm5/dimm_label:N1 DIMM_N0
 /sys/devices/system/edac/mc/mc1/dimm6/dimm_label:N1 DIMM_O0
 /sys/devices/system/edac/mc/mc1/dimm7/dimm_label:N1 DIMM_P0

[1] https://lkml.kernel.org/r/f878201f-f8fd-0f2a-5072-ba60c64eefaf@arm.com

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 137 ++++++++++++++++++++++++++++++---------
 1 file changed, 107 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 64220397296e..35b38cccc6da 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -125,12 +125,44 @@ static void ghes_dimm_release(struct list_head *dimms)
 	list_splice(dimms, &ghes_dimm_pool);
 }
 
-static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
+struct ghes_mci_fill {
+	unsigned long *map;
+	int index;
+	int count;
+	int num_mc;
+	int num_dimm;
+	u16 handle;
+};
+
+static void ghes_edac_dmidecode_mci(const struct dmi_header *dh, void *arg)
 {
-	int *num_dimm = arg;
+	struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
+	struct ghes_mci_fill *mci_fill = arg;
+
+	if (dh->type != DMI_ENTRY_MEM_DEVICE)
+		return;
+
+	/* First run, no mapping, just count. */
+	if (!mci_fill->map) {
+		mci_fill->count++;
+		return;
+	}
+
+	if (mci_fill->index >= mci_fill->count)
+		goto out;
 
-	if (dh->type == DMI_ENTRY_MEM_DEVICE)
-		(*num_dimm)++;
+	if (test_bit(mci_fill->index, mci_fill->map))
+		goto out;
+
+	if (!mci_fill->num_dimm)
+		mci_fill->handle = entry->phys_mem_array_handle;
+	else if (mci_fill->handle != entry->phys_mem_array_handle)
+		goto out;
+
+	set_bit(mci_fill->index, mci_fill->map);
+	mci_fill->num_dimm++;
+out:
+	mci_fill->index++;
 }
 
 /*
@@ -181,17 +213,29 @@ struct ghes_dimm_fill {
 	struct list_head dimms;
 	struct mem_ctl_info *mci;
 	int index;
+	u16 link;
 };
 
-static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
+static void ghes_edac_dmidecode_dimm(const struct dmi_header *dh, void *arg)
 {
 	struct ghes_dimm_fill *dimm_fill = arg;
 	struct mem_ctl_info *mci = dimm_fill->mci;
+	struct memdev_dmi_entry *entry;
+	struct ghes_dimm *ghes_dimm;
+	struct dimm_info *dimm;
 
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
-		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->index, 0, 0);
-		struct ghes_dimm *ghes_dimm;
+		entry = (struct memdev_dmi_entry *)dh;
+		if (entry->phys_mem_array_handle != dimm_fill->link)
+			return;
+
+		/*
+		 * Always returns non-zero as the mci should have
+		 * allocated the correct number of DIMMs.
+		 */
+		dimm = edac_get_dimm_by_index(mci, dimm_fill->index);
+		if (WARN_ON_ONCE(!dimm))
+			return;
 
 		ghes_dimm = ghes_dimm_alloc(dimm, entry->handle);
 		if (ghes_dimm)
@@ -605,29 +649,35 @@ static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
 static void ghes_mc_free(void)
 {
 	struct ghes_dimm *ghes_dimm, *tmp;
-	struct mem_ctl_info *mci = NULL;
+	struct mem_ctl_info *mci;
 	LIST_HEAD(dimm_list);
 	unsigned long flags;
 
-	spin_lock_irqsave(&ghes_lock, flags);
+	while (1) {
+		mci = NULL;
 
-	list_for_each_entry_safe(ghes_dimm, tmp, &ghes_dimm_list, entry) {
-		mci = mci ?: ghes_dimm->dimm->mci;
-		WARN_ON_ONCE(mci != ghes_dimm->dimm->mci);
-		list_move_tail(&ghes_dimm->entry, &dimm_list);
-	}
+		spin_lock_irqsave(&ghes_lock, flags);
 
-	WARN_ON_ONCE(!list_empty(&ghes_dimm_list));
+		list_for_each_entry_safe(ghes_dimm, tmp, &ghes_dimm_list, entry) {
+			mci = mci ?: ghes_dimm->dimm->mci;
+			if (mci != ghes_dimm->dimm->mci)
+				continue;
+			list_move_tail(&ghes_dimm->entry, &dimm_list);
+		}
 
-	spin_unlock_irqrestore(&ghes_lock, flags);
+		WARN_ON_ONCE(!mci && !list_empty(&ghes_dimm_list));
 
-	ghes_dimm_release(&dimm_list);
+		spin_unlock_irqrestore(&ghes_lock, flags);
 
-	if (!mci)
-		return;
+		ghes_dimm_release(&dimm_list);
+
+		if (!mci)
+			return;
+
+		mci = edac_mc_del_mc(mci->pdev);
+		if (!mci)
+			continue;
 
-	mci = edac_mc_del_mc(mci->pdev);
-	if (mci) {
 		platform_device_unregister(to_platform_device(mci->pdev));
 		edac_mc_free(mci);
 	}
@@ -661,7 +711,8 @@ static int ghes_edac_register_fake(struct device *dev)
 	return ghes_mc_add_or_free(mci, &dimm_list);
 }
 
-static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
+static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm,
+				u16 handle)
 {
 	struct ghes_dimm_fill dimm_fill;
 	struct mem_ctl_info *mci;
@@ -672,16 +723,18 @@ static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 
 	dimm_fill.index = 0;
 	dimm_fill.mci = mci;
+	dimm_fill.link = handle;
 	INIT_LIST_HEAD(&dimm_fill.dimms);
 
-	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+	dmi_walk(ghes_edac_dmidecode_dimm, &dimm_fill);
 
 	return ghes_mc_add_or_free(mci, &dimm_fill.dimms);
 }
 
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
-	int rc = 0, num_dimm = 0;
+	struct ghes_mci_fill mci_fill = { };
+	int rc = 0;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -703,13 +756,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		goto unlock;
 
 	/* Get the number of DIMMs */
-	dmi_walk(ghes_edac_count_dimms, &num_dimm);
+	dmi_walk(ghes_edac_dmidecode_mci, &mci_fill);
 
-	rc = ghes_dimm_init(num_dimm ?: 1);
+	rc = ghes_dimm_init(mci_fill.count ?: 1);
 	if (rc)
 		goto unlock;
 
-	if (!num_dimm) {
+	if (!mci_fill.count) {
 		/*
 		 * Bogus BIOS: Ignore DMI topology and use a single MC
 		 * with only one DIMM for the whole address range to
@@ -732,10 +785,34 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
 		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
 		pr_info("to correct its BIOS.\n");
-		pr_info("This system has %d DIMM sockets.\n", num_dimm);
+		pr_info("This system has %d DIMM sockets.\n", mci_fill.count);
 	}
 
-	rc = ghes_edac_register_one(dev, 0, num_dimm);
+	mci_fill.map = kcalloc(BITS_TO_LONGS(mci_fill.count),
+			sizeof(*mci_fill.map), GFP_KERNEL);
+
+	if (!mci_fill.map) {
+		rc = -ENOMEM;
+		goto unlock;
+	}
+
+	while (1) {
+		dmi_walk(ghes_edac_dmidecode_mci, &mci_fill);
+		if (!mci_fill.num_dimm)
+			break;
+
+		rc = ghes_edac_register_one(dev, mci_fill.num_mc,
+					mci_fill.num_dimm, mci_fill.handle);
+		if (rc)
+			break;
+
+		mci_fill.index    = 0;
+		mci_fill.num_dimm = 0;
+		mci_fill.num_mc++;
+	}
+
+	kfree(mci_fill.map);
+
 	if (rc)
 		goto unlock;
 
-- 
2.20.1

