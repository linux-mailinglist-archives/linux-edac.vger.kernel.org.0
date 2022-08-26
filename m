Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287045A32B9
	for <lists+linux-edac@lfdr.de>; Sat, 27 Aug 2022 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiHZXke (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 19:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiHZXk1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 19:40:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBC13F52;
        Fri, 26 Aug 2022 16:40:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QMY2X8026459;
        Fri, 26 Aug 2022 23:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=/yxFakVAOjBhe9QLi5z+ZODKIZrHJdhqvi3lhhB2Mn0=;
 b=g/CL0XOt+uSSlJjbi5iSrEZ0E21F7k9BbcC3YTBuuBZ5zCZtGbSkMYNyVOZH6dpwhwId
 7Rkx3uQkdAsWhb7NScMdx+gHLPzCyqWNiKqC8ncfRaPEv0qEKJ9mqRXBSbgAcHVNp/hZ
 qnbXJEBnEIq5TAw3W/s1Kh7Y6u2cXLhAC7Ouma/Cb0TwZ9gwCYQyrNEtBzRIdMVqOaJ9
 XjLLYF1flLO7M3HUtR+CITu9DPz2Oo1MNT5HxZmxeczu9TVleSg7Ns8aSPoQ6GEJAe4d
 p3gVZrl4VgURzDYj9UnBok4i/VgsmSsrE3KxOslR5ni5fGf81jSdyUQJ06WUcwbvO9nJ Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p2905r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 23:40:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QN18gj036289;
        Fri, 26 Aug 2022 23:39:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6q30qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 23:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe2noeVL1WVxtwCUwKIx6gSGi9h4i46senCEXpNSRABdfWH7mCnUf15t5PBbNl3XnhokbGxwJqo3/bVkMblzMlI/10xKYSNCQ7OIQ+GUPKv2vwWFrvFOYIZoJsiAE6bU9lkNfPKs1Bj7I2Y9DWM0BxhwN0VlAUuoEpYGP4/a0j+Q25xwpJ7C6xrSYvubzjLrumg+fsILcf4JVaoBNT971ysqYJkiQbTjo2mklWPdpEsnXSREb5b9gH1BlhYkVPMnHMYgtnVXJF2+Rt4VmvGoM2W1SQNgYVUHJ/CGs9LU+ROpdy0YgXgewth0flzKzDrU4RFxjpJuM1o6xDepmXVoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yxFakVAOjBhe9QLi5z+ZODKIZrHJdhqvi3lhhB2Mn0=;
 b=RVvAJLHiLnPepnBawuQt83hi5AqknYzYZx7BhlaWZlgYeWhGuuIiy05CyA8jf+ovVJCg4LAGm94tZ5EizHGOfO1yUhPj3nrQFSY715r1P78qJNB87g+/VCDjWnR0rE/MqzUM48ePLbg6TruKja1AgKliS8jkm8npJ9ZSkBDEOmAoHVN63JQG1wFS7vLDwdZu0b5gHilrrXtvtlHgFJmU6QfFmpDTkyLOVmPUzfTRrm6ZypOAbbe0eoZw0ymS+oY0jRSM7rBT0SxH+KOaTob1Px4eHlJSAOvkrDQXiK46BKvJA+Vh9uZI8AShQ/nF1P2m03lugrdVqqCbdgMzCitCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yxFakVAOjBhe9QLi5z+ZODKIZrHJdhqvi3lhhB2Mn0=;
 b=nthRPAnUOwslq0ynlyhIobBmeBIM93MoEyQMNdjkt3ZNJFxYv2+Za1ZFgZtp6xa/yYHMD7IUCuphNQjvKUM52POIWdztqzO4hf8yAd7xOmsdA04PKA+/3fTxQ2Pffjli0hnT3DHY9HcSppD8RajRE08NWT6C03ltTUAVzvtrhrA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY5PR10MB5915.namprd10.prod.outlook.com (2603:10b6:930:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 23:39:56 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81%4]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 23:39:55 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v8] x86/mce: retrieve poison range from hardware
Date:   Fri, 26 Aug 2022 17:38:51 -0600
Message-Id: <20220826233851.1319100-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:5:190::42) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb9ba84-9de7-42b9-7d34-08da87bc47fa
X-MS-TrafficTypeDiagnostic: CY5PR10MB5915:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9BofbVO3wdvM8yMjU1gRA39BNdnMcWzrwBvxWV1l3NHTQ9osJ2vxf670GA+kBFYkf8iYUVI1nR0UGMLRCy9T2PkdxHCLDSZV6zncwuxD5wjVrtcIM6MkslJFtLWmAig67y83IPKzwzltxzzhv3i2FgsiefO1EMtGDpOhJhHLKuWcY7Ei+c7+Ww3I8Ke7J18vAUjyczRMWyC9chKtM1B4j9RTe78j2U5SHYnQwd0ZLyXK66dDps9J3F+N/s9P687AIELv1Js33QdHNLpvT2pX3ZGHfnKqlJOc4V4GOA58pWxkRPgc70DW3arOmLY/Mdw1bmfDVUCulLL0Sk2EBO51Ht9lW423xR36OaeickZvgQEIZS2KPbO++VVBHSylTZrXD0k2g8OGuPfx+FVwkJd6R5rwmFC0ChkNSkRVuzq+CJmBoSpckEoVxZwktrFcb7y/bHkIoGscICG0BSEnau1DDkTQ6Q7xjZard/jBWzMt752Er9RZIYNSskMgcPLcFSqCqu3OVvOMzqOXRdzkjFB2Zka5afsFpN98hTVI0P3w3AefRrhxxCu2rgLtxJiUR5hNINO8P/TmdCDF61szSlssm/Yusz06td4I0r6Zq+qMjs5w3jSB2X52rd1cQG69T2rAGvrDK+5yc9S0EnE1bjFa0jdMBA9ZIp0hdpMy8WsbY4INYbaRENpJIC8lE9Q7ew/3mHYIwYQeaUGRQi5wB5sbzOfj3ZbptXdz6mbWMOJhfoub4R3SZpqfDSOMTAa3d1KQL0QMNKEvrsQ/CeU7HwALwww8CdqKPlxzTZaqLBljyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(136003)(39860400002)(376002)(83380400001)(921005)(66946007)(66556008)(38100700002)(36756003)(66476007)(8676002)(966005)(6506007)(6486002)(44832011)(8936002)(316002)(6666004)(478600001)(41300700001)(5660300002)(6512007)(186003)(1076003)(7416002)(86362001)(52116002)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6nBADBX8M1O7rd58NBAHMVilU3sFoUSif01Nxy1JI2i1b6UtwNjPwvc1UXS?=
 =?us-ascii?Q?hgV5GpBk4mo3daKPznCAduaCRcJZRelKKBqbqWbRrf046V4mA6J7kGGZRtIP?=
 =?us-ascii?Q?6KPpwpvwYdNHvtrsr6bONae72kvk4AqdhCygr1ewgDm3Ka+3GyRohRBtfLJe?=
 =?us-ascii?Q?wJCRcgYMNKLY0R6BKGMn7KGHTrKim9L4MurG1EZmg248NeOebKoZQSlHQ0xk?=
 =?us-ascii?Q?OUVwKKqJXbxidB1yrVLBV34jM+ZE9+BEkJkK1vgT1CbJmsFOJfAhcowgNqc7?=
 =?us-ascii?Q?l/EO8/d9V80cnmMnslH5mGP3oTDyMkSISzDgbDkCcdeWLNWI2xPZqO/1eVZb?=
 =?us-ascii?Q?5CoKsZVRrIfSp1mGa6Zp43tiCGpjeHehfbhWpuJg6dEIPL4AMBSCCLw2w6Ud?=
 =?us-ascii?Q?Ho8v+nlIT1FlwNbZUyp64DM53IPfos+ZYRuFjkn35sfsXhXVLJRC62/zDVWs?=
 =?us-ascii?Q?670ktjCXKcbzjvitV82yfMgL8J7gUHHOqgA9Mg1ZmFE/UlDowZHq3hDiTzQi?=
 =?us-ascii?Q?0AhgZUMUSbEhe90qcuLprjsgbbHlDs776aBdjaLiYpzO0P+GB9H0XCbEoXZx?=
 =?us-ascii?Q?hFz1RyhZHm/4DJLSa5BeOBPSFa8FRXf3+JkwQeO5KOAGYJczjaBca4oE5TYk?=
 =?us-ascii?Q?BukQgRuaZFRau7f6PKNKiSple9+POg1zbF/ST4bu+HkQW9OH0TFCwxyXYg43?=
 =?us-ascii?Q?wP9i+9mbrFawdiy1nQOBAesHnjsorKtzlnPZODP0Wsw1yRTViVYkbV8rVPku?=
 =?us-ascii?Q?lw/D2SiLfNEaYdK1siHwLkb2uJ9j+iN48j2cUqulkgpqUfKOQrhKZZTnOXuY?=
 =?us-ascii?Q?VnEz78JBjQxR0J+yDa91uboRuVCs+OB/bR3AJxUDhW9FRB8W0NhybL28Y2wP?=
 =?us-ascii?Q?zr3K2fxarTPwvBG+GDMZoXLBThnYXttKMflb5mrGwoazOk7cVS9cjCzba2FZ?=
 =?us-ascii?Q?VHLudDJHUkPXgLtZHO00VfNb2qVq48tdsmROU2RnEVtRNc6Uz0cieEWHcrzS?=
 =?us-ascii?Q?lIXIxROi16CW700YypS9fyfCRQWwEnViBAi4xRW17oHXRoafiVqZAoUrXLRK?=
 =?us-ascii?Q?4z12ambgQ9atYoMifce7xNHuLkdCcY6zyAitbStoWUVQdvNHYN/tiHBjDgoA?=
 =?us-ascii?Q?M2MvBz1iTYWLpQ9D1VcPRH75lw73k8dQJOW5Zj8fs35aQ1/R6Q2HP+ZYr9t5?=
 =?us-ascii?Q?RL+ChjaL3+gngoHs+pS3VKrrG4DKeHh9E33gaOsBhLbHa6tz/DhPGV/PVItk?=
 =?us-ascii?Q?2BwHM0tD3PfMuGo1agmaWmkoQ4R5dEy6dvEXgGlpwDKMVOAiu43aZBDMWcWv?=
 =?us-ascii?Q?an/hBLQMh9JPQ9tjgH/4p6fRBOvpkcJTm5RxA+RBmtXje0fEYNRkS+v2P/fl?=
 =?us-ascii?Q?MVjaH315pCTrK2js+zhgU8pEhxiRWwaOWMPGYEGigLcZEpLHBUn7QoOcAIuC?=
 =?us-ascii?Q?p7H7mGNucynqLqaUEn8BmuPgPj1tQ0PGgHpJhTBiHQTMv0McwmsxpRVKJlY/?=
 =?us-ascii?Q?o5vx4qbm+XwH8HUeWvfapFZYgA7kVmktzLCymI4PHjbLNDTaZZTDZeOOncrR?=
 =?us-ascii?Q?tz+26unD+6973pWXyRk//f5kchR26wILM6D03WMVMgbWWa9f785wnGhLAlIw?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb9ba84-9de7-42b9-7d34-08da87bc47fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 23:39:55.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGH31lGHvcKUh21fYslJIyqRZuga/6Z6v/F5RYcd7sES89zBP/CJHg+JPXv9lHKxqb7WaVrR5mT2NkS+2WrXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260092
X-Proofpoint-ORIG-GUID: Mz9lp18W5uFUQALxcx7M5cYclT8uSCMe
X-Proofpoint-GUID: Mz9lp18W5uFUQALxcx7M5cYclT8uSCMe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When memory poison consumption machine checks fire,
mce-notifier-handlers like nfit_handle_mce() record the impacted
physical address range which is reported by the hardware in the
MCi_MISC MSR. The error information includes data about blast radius,
i.e. how many cachelines did the hardware determine are impacted.
A recent change, commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to
determine poison granularity"), updated nfit_handle_mce() to stop hard
coding the blast radius value of 1 cacheline, and instead rely on the
blast radius reported in 'struct mce' which can be up to 4K (64 cachelines).

It turns out that apei_mce_report_mem_error() had a similar problem in
that it hard coded a blast radius of 4K rather than reading the blast
radius from the error information. Fix apei_mce_report_mem_error() to
convey the proper poison granularity.

Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 717192915f28..8ed341714686 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,15 +29,26 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int lsb;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
+	/*
+	 * Even if the ->validation_bits are set for address mask,
+	 * to be extra safe, check and reject an error radius '0',
+	 * and fall back to the default page size.
+	 */
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
+		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
+	else
+		lsb = PAGE_SHIFT;
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

