Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FD9576B76
	for <lists+linux-edac@lfdr.de>; Sat, 16 Jul 2022 05:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGPDbv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jul 2022 23:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPDbu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Jul 2022 23:31:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31F32B82;
        Fri, 15 Jul 2022 20:31:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYi39018705;
        Sat, 16 Jul 2022 03:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=L1EATft3q4IZmxHKb16QE8P5/7MEGB37Bojf20P86xQ=;
 b=X/mjbP+a3+m3oxRmI6CMBvXHvlNEVfKlx3d0+BRHCTlKeMtgxeDzWRdI30LPqlcTMcci
 Szl6vwwvxGctl0pL2dYgmoK8j8g2zQKKXPpi8HAoUCwXZb9USjx+P9TXpXe7a21Lwvib
 djtrGW2lVEHVBgpJwsR3ZefPYr4GMPu4nOgKwwtIoszuQvq/rdiuQ5YNKN+yZeMhLOaa
 uvS60tQZi6fMJl50wbOnHfINg/rV3nRIhkiNt/ehEmxjnFyVR7gT9oTQq/tJ/jgLTjpm
 +4fh4WUV7Rkdi0FViimbaOWutITG4twFjDVFLyPGwMBUNJncjgfvZh/6rRs7yFaXAaEr Kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727ssw5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 03:31:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26G3G33R006898;
        Sat, 16 Jul 2022 03:31:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3hbks09emr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 03:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7Wg6YCeZ8bsBs36Be+ahDb0J6J9S24bpauZq4krITdAMM7rQ02fDwsFY7pNdKv7GUh5CPwIJzqoA9WcJqApnrJg4nGlnr3AcZcceE9fcJPTXoW+v5xWcihe8z6t9RkjkyZC1t5SNUNntQkEVNkF/b5fOMz1KpLSXjw2J/ru+SdMX0QF1QHmYnDZL3BQA8/+TysM0xyE1lhZZpK/ejDM4eZdy9r28lo03EAuW8b0bMolAYAUDExjGf4mA4f+EcmQgF+wD+TZiyN/jybjBS/uoVk+KeL5+PyX8AyCycKfY9K73rB2cmu6rChT/SSuvLfZOGpE6CUwJ4Z4Aqgm42r9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1EATft3q4IZmxHKb16QE8P5/7MEGB37Bojf20P86xQ=;
 b=FLaZmZVT/ICMEj6aVBwh4xXefBLBhLza0+sXI2vqzxIGTs6thirCxn0oTwi1WH0lfevN/4wkSbDZKW43IGeFKG2LhX7EXEou6jKihHW0zimNcMpHzG9+ookHnsadvyOafsiFadbyc3XQ6U907mHE7J1EU1zG6AnlMO3yeRBbTdGH0RlyBvd/fXzQVG3MzgAAPNXIeluMZf+qmcMrz0WYiPEobj335cJt4HVFf6NwFaQl9gugJqymmk6W88rwxxrEx8xWxq36H+4zDjqkiUTn8KKL8ek0hvBwwUpgBAZQwQ5jl6ambB2ZMvWrYI3/coZFALeIvCQYD69aXAC/sYFWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1EATft3q4IZmxHKb16QE8P5/7MEGB37Bojf20P86xQ=;
 b=Q9pLBqpSwqYwl0shsHUi6YbKu7sKN3tm/uzHUvLHlwKpCzPm7qP7+gkxqozeZGAlxnLXmrN2tFNOImvs4Y4l9HqagqAm9DkDiK1kxURwW3+sh+V7EtUC/fZbodROYWB3Mpgp4wE+lPUyJyQawnqp4i3K878ezvrBWRejFZ7U2lM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Sat, 16 Jul
 2022 03:31:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.020; Sat, 16 Jul 2022
 03:31:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v2] x86/mce: retrieve poison range from hardware whenever supported
Date:   Fri, 15 Jul 2022 21:31:04 -0600
Message-Id: <20220716033104.903163-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: DM6PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:5:334::8) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a588b70b-714a-4fbc-84b1-08da66dba51e
X-MS-TrafficTypeDiagnostic: PH7PR10MB5724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9b8LuCPYu1y/WivpCXN4qTSSICO+cZEFIXubM5kzs7LaduBXK6qAG4tMsxpklBlVUNiD8jvqSEXgM+KS/ulMMRBSVUYJf4rD9CV8zfmSi4UNmCd8VRQDTmD4xS5chSoChSuPaeQcH4EK7SXUwAQn37psTInu851+/kgvnTWlATdkfxHwlNaQT6qmeQsXXniUzFa2aGVhJjyXI2NVzjHBsaGqfU6Nv3c4aImjJ2TwqeOqUfG8VpXotyoc+94u6/4958v4kTkYdH+rjhmAx7I0dG/G6E1mk/sBNQ8iQc56Hr6xI9xiem88+JwAwFO2cAj4TobE54diCnmpBYLdVDNqEOB+2j5VQibq/M01rhmjFea0FVXHCUl+hUYezeAukX2lPQ/gQVBU5uOL/bgdmGjWMEoIGjB04VIa5lnQ8VD96ycUiepbiLghkP9RMy/pTr1rlVGssCKhvxV9waLt4Pu2fugq/xAdt4qTcwf2dKv6F+K8Dok3ZHNqPUrIn5mDclHv4ybDkKFWLlisDbeXDC5KzWl8XnrZtXH3GZT2vX0uFAkhA/y9ue+SbjTkMsQpXaz3CAKfJg++VAUnuIPh2v840DXfpIqYzCkChlZkz+6PuxJT2IMnD5nDvGxSVr3eJwkVV4FCdxtLG96NdLhH9cstCj3V4+CEcA5KeksWjO+T8ialj3mcbwVpFo6ih2v0xyVwTMJ80jqZk8p+eqzoli+hqoUJ+YQ95Ybve9iY1n+wi/8HE0kZ3FPFzrMnJ9I+uyzJIzaFQlzStRsmAn5xmP9g/z1RvAdU89x/hwzTozY2idsS4Wu5QqYG0Jo2q36bmvEaKx1waM4azaUknDmDiYBCpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(376002)(396003)(366004)(478600001)(966005)(41300700001)(66946007)(1076003)(6506007)(52116002)(66476007)(316002)(8676002)(2616005)(36756003)(6666004)(6486002)(86362001)(186003)(38100700002)(66556008)(6512007)(7416002)(2906002)(8936002)(921005)(44832011)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E9NiN0iWPu+hzoAqOPDxj0xDUD3kIr3ZWrDp1VgECZqckyum3IVPaqME/CBH?=
 =?us-ascii?Q?OQWK9Ox4Dq9ijZ0TuLkrRH+GXohaD9HtH/xAHb6h2s0BLsalRSuCM9jIIuW3?=
 =?us-ascii?Q?lgZI++7hXh2x0STgUro28I6YDmP15aF/9vMPQDDCXc/V0G/mnKcYSpSrhqeO?=
 =?us-ascii?Q?PEmChVmYBdVH3kzrR1JTiRDyq4TJohXp1zoRpKj5KgHIudyX7+ppkMj6gg4P?=
 =?us-ascii?Q?g4Bxm9c5zMtxs8I9JBuDhJuW5WbpktXqpKyWwncsMPh/NFamWe0+pRcyZyBJ?=
 =?us-ascii?Q?e4KcVyKA/kaAjkeZYgf9ayC030IeaUSeTbnOQ8pqekz5xm/WHQJf3Dxe0D6+?=
 =?us-ascii?Q?dMhgNQm+pIjNdzMKVfAMFUO+aehwiZ+ZFI7SaMfU741AmsSFQ5ZrsX9KClaO?=
 =?us-ascii?Q?LmMgC0iRdyxkKY0w/9hcxHXpky5ynC1lL03DikRrdy/1A8XmYlS6XN44Bljl?=
 =?us-ascii?Q?H+pek4+s5ZROgGFx9tkcibdWMb52GqBa6Nfd4cmLldLIJEzolsBPz7z0Kt3B?=
 =?us-ascii?Q?TuaD+7o9giUnTvAPLc20lmpdduwgCilpdCKE+FgQLhhj7sh8F8RTXbnAFnWx?=
 =?us-ascii?Q?6xCbRol6CgV9JsHm2oBM0w/LRLn5jBJNkOzGABC4f2INS8F4BiZUo9S/VKDa?=
 =?us-ascii?Q?rzJNjAr+IgI6pdLc6UMryHWjEzjvrBhQR9svz0XqgDjy8Xq8FGAPK47aewBH?=
 =?us-ascii?Q?9OtaumdDHMiB7v4172YtxKqyXIM8BX9Yow7aRjVZoqzXayHnQ5l8BVIsPldu?=
 =?us-ascii?Q?Uc3vxH09N5XAOyQU5k41heMd2b2z34+DsAh8KeOMnP7fC30hc+QdH0hWhNNl?=
 =?us-ascii?Q?ku0xAu387LMY5f2QsXQIyGLYQiowObo8bbK5mIB4Jtp3S6Ki712k6LH0ZXpj?=
 =?us-ascii?Q?BR51hmb4DHVX7EfeA/qLaE6UmllRwxDdqd6Vd+94ZODR8IJ83uqf33N3Qtq5?=
 =?us-ascii?Q?c9Eodno0zJDt+Lj2gaOlt/ZrtCvPOVPL7LMZLMh8SNhf9KjBt7nMA4/pykq9?=
 =?us-ascii?Q?iuqC9vBlZ9J7vFQjVd0T9l6RapHCsPwOkhOE4/UghieJxLN1pSnVsw3v87Oc?=
 =?us-ascii?Q?AzQFutFB/qeJn9/ItxLNF+AX8cyB0w8iMA7imA5vMNi/ULzf0YvaRTwytK2x?=
 =?us-ascii?Q?d38QQfJ5x+9lchzJ7/izp0DYJ69A4Kkhgg/Mujy+dyoR/CI2QaDfYzyFssYU?=
 =?us-ascii?Q?O24jctYLSFQ3Ge86quJmkrFkCKQBzVW4yf8UUbHh1cc8PUfnMGbT0SDubbDI?=
 =?us-ascii?Q?iApzubr4SZQAjDvongG2AD4v9DJXy1I6gEKvqdvSlQploYZt0eyNaKPMpyyA?=
 =?us-ascii?Q?sZ695ve0u7u0Miz19AfmBUCsh6inv+tjtK/fsEymUAE98SRgOxny0UKEXsAS?=
 =?us-ascii?Q?DhynMfnuhdKQtuflEyXtkRrmvyaNi7xYZQUUqTqiAF+zWY4/ByMf/84fiRbG?=
 =?us-ascii?Q?rgSUQJbWU+itZYDuSxLDh7ZvnyboE0HPnzuYEYMCAZ4urzS6EatfWw5jtg4Y?=
 =?us-ascii?Q?OFrqYayte0sOVB+DGdrOXL/GBD+sLRjv7GCYXpxtRKGB62iJx32/ewdMPLxX?=
 =?us-ascii?Q?/OLH6LPS68HcXlrD9XzsNGK99wF/k8Voo5Iw4cMNWnyWFW/Qof8v7JuGMng7?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a588b70b-714a-4fbc-84b1-08da66dba51e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 03:31:18.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FFcS5Uu7QB3ZIL0HV7Zu1f9H/MQaxjN1kEWRJOPwaTN8SvhXsYyTlnXHbd/f2nIslxrv5atIj5PDV3lDaxKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-16_02:2022-07-14,2022-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207160014
X-Proofpoint-ORIG-GUID: EAT_q41K-K4raXivI22RYD6DMGqGdOkb
X-Proofpoint-GUID: EAT_q41K-K4raXivI22RYD6DMGqGdOkb
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

v1: https://lkml.org/lkml/2022/7/15/1040
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 717192915f28..a4d5893632e0 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,6 +29,7 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int lsb;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
@@ -37,7 +38,10 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
+	lsb = __builtin_ffs(mem_err->physical_addr_mask) - 1;
+	if (lsb <= 0)
+		lsb = PAGE_SHIFT;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
-- 
2.18.4

