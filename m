Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4F5858D6
	for <lists+linux-edac@lfdr.de>; Sat, 30 Jul 2022 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiG3GUd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 30 Jul 2022 02:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiG3GUc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 30 Jul 2022 02:20:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85811470;
        Fri, 29 Jul 2022 23:20:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26U3Cv7K030767;
        Sat, 30 Jul 2022 06:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=jnIALAS95yQhVzX5xrpsAsaqKcdjlzLMNaXQycX+4ck=;
 b=BeK8laBIlogO1Jfxkbyl+iUsuL+HVh1VsCeA4tWMABT4vaaT3S9LRNGENfuuatzjoK/o
 cBxTYcQI8pRAJLiln9bRGbnPRzDhe6T5h4LPihWBaMnrFL1L7A7fFD7piQaaEaFfZLi3
 CsUev60mYDvSnv67H69mYbEEsyd2WOX7PuHKWo1zTb1sA5HTjj5jUrdjXvE5zaM1uBYi
 7PQGNCbVTvDAxwuJMz5HV2yxilAUcHFHsZXkLlSCeETmscvzfRUj0bKwVa8GDcGv+/Pk
 6cF7euERNO5SHTrvVvy9OWeYlndFMZskZWeYz8HkM7W/iQ3NvwiCPCTqQRSaA8bvZ1/E nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9g3dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jul 2022 06:18:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26U1XIYW007473;
        Sat, 30 Jul 2022 06:18:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu2ytvak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jul 2022 06:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFZihey2SLZiCUvcSAfl2a/R1aPIpSiG4AVk9noptxdE/Yzl4BkJfdJFQie2e+b+61b9g6O8sPrnBRbqwh/7kWKz6mqG5UMhOUE7VTxt/Wv0Dwo7Y/C5zstsr7zCQVs/fhMZ1OPaqQtle8bIICJL2FhMgcE2SYDj/nus8ETG9MNvRYdF7mwXIM0uWmEj1mIK0k6jz4UAr1db2lD55VJnBOOvutq642CRalbT4mA3mzWgxNZC803rhBDUYIMweJLjVM6uf55+FyP8hzAReS/ZdMls8lF96TKQ+EwuqJxbj7eITYgqHtiTabB+323haowDRtI6w9nElUsfOEAXUlRtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnIALAS95yQhVzX5xrpsAsaqKcdjlzLMNaXQycX+4ck=;
 b=gfQHEwwRW6K1C+knfL39HQdpuS7AvC6gkg4EKHL1cgSN+jQK863YAuHmCz1Z/LV6rr+knK1J/kKtk+0a+Fps1WD6jkwqCHnBDE/3e/NKe4EeCtoPDghjhoNSnOw2cMsbzFfesop7DVsrpJZjRfctNZ6AIEToxzmHi7eA/Ty5L02IrP1tq+Nosh8CS/0liNhskKj9Rx0opG9bmIFWYeXpg+MxTu+hmQrULoVAlEPP5aV3gKhwtZRb/1FNAhYxuHxwPqSgO+7qReZzhtBu7lGTlTMLTd4i5cOnYymoNZ9yr564Ngp1359M+bQl5IiViXw9tND5mpDsRvv87WnirOYWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnIALAS95yQhVzX5xrpsAsaqKcdjlzLMNaXQycX+4ck=;
 b=B88nP7R55grCi8wzgOQe2L9S5tVzmYhMhvsRGX/GSbnskwqvWSEVj/JMdg3Z5+HQ98lCyze8nkm62vp4kqMsp7+h9ALSEwp0MZeSmVgmOI2GmRa8PYZ298YySc9DHWAw32OftL0l7Zbtko/wElAEiCnnxG8oaRqxM+vwd2fX77M=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 30 Jul
 2022 06:18:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.011; Sat, 30 Jul 2022
 06:18:13 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v5] x86/mce: retrieve poison range from hardware
Date:   Sat, 30 Jul 2022 00:17:57 -0600
Message-Id: <20220730061757.3441537-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0073.namprd12.prod.outlook.com
 (2603:10b6:802:20::44) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991b9366-6182-40f1-160a-08da71f3484b
X-MS-TrafficTypeDiagnostic: MW4PR10MB5677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40W5j4FIACbVRnJQL8lv+deMAAXzWdaKhjKUWhF5y1nDr6nW3vo8qwQVKHPIWZ42xPJ2ZI1sr6367/xEivIbSYWXYoVi1Yxeece+SPZo3sCnZ8zUtWXSsf1SaZecjnqBMS8iQ92lk3n/vp6HAePcRu8Pzkfk7RaPRnbRtDFfsu8qHX+9VW8biPBigjdJDHNBXwVPGPaSxfx7X15nKIk8JiGy3PSgLp/OtIEEgxgyQexST6C/fAGY78hcHjTVOcHQk1QuMNx40nmcFGr0nsZuvdY4gfkZxe2JvPrIIGHh4fyyIJ7fFxNdgFyaDDAXWShz5HevzJWEntEXG9ss/5BYgMXvs49oCslXCBXg5hl3gLWTwXFJM+2pcmTX2pNioAd0T0QcR5jVYO5g/r59I1BdTYnkp0G7G9VjA/qjNRrFK4my2O+Y9mrSa+4GDJNVk1oevJp+yJcvDJ5i/s+mLtFG/2qD7GzQFvsXyEgVDekTX0gRAPcIhhojW3ba2z2BEMVLZn+MrhpGOYqVFo5xW2Kl2+5wMuW35qktiiQ9Br9SaQfejlChXLSmQ8jO+XmXwT/8yAJGYNWpuisLaM9oN7xntUTS2DlsNdhstLx6sZTEoAfyY7KkxGIzbPa4oH04sqIeFgaTMNRelzd1yE+aHaYE1vK8UOyvfR0ikiUIi43V6s5fx2N3gQxYrliRT1mG7kqX3O3UOSzXuUgYEyPkT8mh4lh+WhWVAwRC37fdRYCo0inYTSUxc0WDWUYc9IAunWucj9uFZR9AYaVut+/0trXxY4CCEuQiDUctq+UFxy0aYlWONyPljseAZcEipGzGIymF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(366004)(396003)(346002)(41300700001)(478600001)(921005)(7416002)(2616005)(6506007)(83380400001)(36756003)(316002)(86362001)(186003)(6486002)(52116002)(5660300002)(66476007)(66946007)(966005)(1076003)(44832011)(6512007)(8936002)(66556008)(2906002)(38100700002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IilPN7hAiTThnx2jhpcDDyZGfNoydCqJ4PFj3u68t2ETIbz8uMlqwhwfcQ0a?=
 =?us-ascii?Q?e1VXgLcOgfmAw0K4FdGNyT8HL8ji8XbyQt8ABgo5+AUKorv2kkCTcA3ACbfH?=
 =?us-ascii?Q?0ej8lsGsTUxAVNh81+G6VEzJJCGhSkRs9TzppUmf/cLmHRXRWXkHDUIiEZcT?=
 =?us-ascii?Q?qra4OlO7PrT3ygq++8zhFiO2MuKScJEQqGvVGHT2XHvjJZrCjIqjT8DjLMRo?=
 =?us-ascii?Q?bnZ8y7NdessI4y6M7eWfWcb5AKgftjUFcALPqgV86yWvdkkN8Ph95CpaJ18O?=
 =?us-ascii?Q?fXllFDeb7HRNUxEKfhjWGhUSF9x6upVQ7Nz7huTG8q0iwPGyhwmx71HKX/ii?=
 =?us-ascii?Q?ShirN6C86aLGedkKKG2OyMpAoV0intBa8NWdCjOJaOMnkWVrL2BXILIAyUyH?=
 =?us-ascii?Q?lg5grEcYBNtnZmdori/QS6LolrlUSQm3KmqVO7EcuM+k78OYQ6CHYludRI81?=
 =?us-ascii?Q?tKdmYeEvW5lGMj78P5RPKVlXXtyIbLF0DvJ/5dwL74N017k8r1h6od362fA5?=
 =?us-ascii?Q?kMMZtpPSSQK/FU2h5H0IB99xkBvkGunHnu42nWXp3tRkjXKw2rffFY1ACvg6?=
 =?us-ascii?Q?N9xngVHypiJMZVncHASMOi9qrvPvfyxHAeRokpefBIIGdNwbDGe3EcQWqSDo?=
 =?us-ascii?Q?RHC3eDx1xDl3PAFzBWPnSPgA+AAyHPVw6sn88FYyg7ICW3TNNCSbB10mF0RQ?=
 =?us-ascii?Q?y3wpmjA0LIMiEEdNjxIl+/O+pavgbKMZhxADHyYTcSdnTKsukOfPg9xGHvH2?=
 =?us-ascii?Q?ujTdodi81XUOwGI7pcraWVWMaL0jmeBr8je2LIQnmBbnS2S2dKrv67SqIe/+?=
 =?us-ascii?Q?J4BC4mMcwOnbfYkOoRrCrKj7kL2fR3BlLX5Xk7NXESkPN0KI/D3DIF/5+3WC?=
 =?us-ascii?Q?fMzl4cFB54K+RS29yxS3aczFrP26xrGsnkQR1Kl8Z1N3XHbMil/6m9uvMLlK?=
 =?us-ascii?Q?DiTPXquHFq1WQPrSTeh/XzjB6E21748zJdrG/KAz/At+vZ1eJbrhoUSJfvH/?=
 =?us-ascii?Q?UEf4X910qwIv5OdaJPUY/ZNIzqww2JlMVnsZU8yMy3jaKlr44bYGmE9lZeV5?=
 =?us-ascii?Q?8MV9ie6IaNxQT74QYDC6UlDZrnA0bXUOu8dE5Yn722Hm3aX5zub0e4fZvWFA?=
 =?us-ascii?Q?u2hQDacUOegQoVDPOryFzCWhwLpSNsmDBQrxmT3bjQ3vZBKOBH25uvgIQAhi?=
 =?us-ascii?Q?23VU07kBcjZuKf39PxhTOhPe7/SlT8gCtymfClhw3QvjqbtHd90+iAcvG3Ck?=
 =?us-ascii?Q?DUPriHUCdtfEvitbFlPJeCmGUQDv+hnVDEBNd4yIpf9+WYDtSTAR3vU662SI?=
 =?us-ascii?Q?S0SCbRujwaqXGdQEaOjeBg0vW2/LCrB4ruKHVEFTkohOYiQ+V/HFyUyW2UWH?=
 =?us-ascii?Q?osXnKz9td2lJbhDCJAWA9AUZMdVtNO/syg7QngSSgLEmkoMHxsyqgJwXANxa?=
 =?us-ascii?Q?vquQitaLBycmxck/i7f8Mzrf2o9cKr3w1c4vd0OM6ntlWx2Ylh7rYiv2GDxU?=
 =?us-ascii?Q?bcdK9WmoKa7sqdmtiRlMSpDATN5eaBNPs/0H5cxhvIfOQLNIIbTlPUQnejGJ?=
 =?us-ascii?Q?XshdiBIvt6Q7UfYEhk6j0qZZzwg7+lFCZqp4HP/GMAJGZZ24oCnq2xZcywXp?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991b9366-6182-40f1-160a-08da71f3484b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2022 06:18:13.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imsmqcFY8ey4iB60kw+kpNGVUZNcEtrdtIVW/dlvCqioSHYJHdNW7v4Db101wOZh2cliht7cf3g2y+2peFbtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-30_03,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207300033
X-Proofpoint-ORIG-GUID: CvZsVHj-KKj-DzkY_xTV-5RTjAXiIGNd
X-Proofpoint-GUID: CvZsVHj-KKj-DzkY_xTV-5RTjAXiIGNd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
poison granularity") that changed nfit_handle_mce() callback to report
badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
2 back-to-back poisons and the driver ends up logging 8 badblocks,
because 0x1000 bytes is 8 512-byte.

Dan Williams noticed that apei_mce_report_mem_error() hardcode
the LSB field to PAGE_SHIFT instead of consulting the input
struct cper_sec_mem_err record.  So change to rely on hardware whenever
support is available.

Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 717192915f28..2c7ea0ba9dd7 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,15 +29,27 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int lsb = PAGE_SHIFT;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
+	/*
+	 * Even if the ->validation_bits are set for address mask,
+	 * to be extra safe, check and reject an error radius '0',
+	 * and fallback to the default page size.
+	 */
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
+		lsb = __ffs64(mem_err->physical_addr_mask);
+		if (lsb == 1)
+			lsb = PAGE_SHIFT;
+	}
+
 	mce_setup(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
-- 
2.18.4

