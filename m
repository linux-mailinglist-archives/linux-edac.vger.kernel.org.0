Return-Path: <linux-edac+bounces-4010-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A6AC610C
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 07:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE01BC2605
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0211F4C98;
	Wed, 28 May 2025 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="GvL8KqQU"
X-Original-To: linux-edac@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023108.outbound.protection.outlook.com [40.107.44.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FE1311AC
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408931; cv=fail; b=hha5q5cjO2UySIaMcUGnORZGwHj6I4SbKRZuY1zzZn7wzo+D3/0Zc9CN0v9xIUuSQ6NLQOSFhvRfvfYgU+4wvhsgy46fZb8nWpMKUaSVCBtDXnEeY+PUZKQkMDBU/soAcVHNasl9lldNPRR33oZ7bP33FhvQYWYHXB7qKR9bdLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408931; c=relaxed/simple;
	bh=T09tYyL9wann/FVRJMda2xmT5zaBqLVpZ0kRGdUkipM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bfDiUuvhBCi8ZGIIqdbRoM0vuYR8YEiLiPdO+NX4JkaE8JbUMvePQAU+V+5kr8gwQqQ1DUSz3IVsUoybirc1K6r0hqtDe9StgxhqFsxFHnA/9M/H1aYjUJ0+JGRVzoefp8EOTvAtEAjrrX4wk4uQCX2FJiQt+ieiGyX3wZX0Y9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=GvL8KqQU; arc=fail smtp.client-ip=40.107.44.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD3r86B64/c2x0GUCr3Zv4cOq2z4wr/9BnM86IJPNXZ8z60SmmJCPfTXNisFxM5QRC9FG27HFYY/QLWlgkunrESdaVGfVHHfyRN24MgA8cRsvyUrnXmz0MEgNoDt3LdD6aFMEngiMN9UPSHQqr9a4AJ/Ps4dzCsmarUHBM/hIu4IllJbOvDtBRzYRk3QtBVnfYx822SO9F4FSOfpzlcIOavwzsrS5xTLwbCFiX+CvSnCuC/XNKeSY4/bFjTSncyLg4vvQxlpWsutelEEMOLSa19P0kd//Fs/CleTSr2z21MA8DJRqAZOOF+icCHizFHFrPXV01xqzUpq0joE/7mo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MoYQ1kUcRFMYp3sLY2HqmUey9jyF8CjbFGMCoqrOEo=;
 b=Nu6Jo0aCOEKEAwbOcoR7beGqbH9EoIdoH2uy2eUKwaqPGre8VJOfUsMwsFujphKF3/ZwAtWILSjsr0L2pC6Q+XQLv4BoRSSjbJldcmsbZWq+/Vv8wuZkazLxWN9pJEd/SFAX70NOqqtwCkID4ONbCRLye3B3W36yCPEBqYdIS0lOgo2HwBCBae/g8n4oeAZp3ndq2xDIjMfIOdOkpw+wxh1Ix1MpXyEh2GrSJVvZMC5pnkpyzsVxxs0/VlQRSNuTVuqB9ERdPDPLMsSQotTsS+LLt2kwHgcH6nrd36y6bFi10KRvM4/Ai/kVfxNro8iuonERCMHB5z1ktdu+Xsttow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MoYQ1kUcRFMYp3sLY2HqmUey9jyF8CjbFGMCoqrOEo=;
 b=GvL8KqQUxdXjEKFEuJCq5B3O0yrTdXhxct/3HOnM8aEHJtT40LSJvVNIrVOAw2tcSxjSkEQsWWlYNWVWWRX9LnYuVtwqoMaN0Mp0kAHcxYqQ9VfLr42OK/RNXzT8iaKf9CaXIxMvW65cXVXkqHukOqhePLKyBPPRmQOD27U+WQdC4B6iSCzUA7C927VdLFLPASBRIwlW0FBxpHnwAju33rHnx3E+XUd7Iw0m0+whipJFgqovZNeyA3yXgsxu++6dBpbIlRj9k17UYeqT0U6nviaDVOKMoTgPm0jA9x8epm7YkTYXqYG80OgtVXLX4Cn5wY0LbUYcwlFEGLzo3CqlzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TYZPR06MB5973.apcprd06.prod.outlook.com
 (2603:1096:400:33c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 05:08:43 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 05:08:43 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: linux-edac@vger.kernel.org,
	ak@linux.intel.com,
	tony.luck@intel.com
Cc: angus.chen@jaguarmicro.com,
	hunter.he@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH mce-test] thugetlb: fix test case failure due to incorrect getopt_long() return handling
Date: Wed, 28 May 2025 13:07:06 +0800
Message-Id: <20250528050705.409-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To KL1PR0601MB5773.apcprd06.prod.outlook.com (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|TYZPR06MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: c419c80c-e192-4da8-ff36-08dd9da5b768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5F+80bjLRVOL+IUNrYj7HD99RqOy5ErTn5jfhPr1aXQw1vuIb6iVVke3khKr?=
 =?us-ascii?Q?sNcJwu930Xx8DiHwNEETMhQcsZXZeY/F03+B4SyVyg/XJTVO9Er08MEP6OXq?=
 =?us-ascii?Q?iITmDF4HRnBKcslAbtm1KImDhg00sNb0w2i0blUwKmtYLvY4MTUxjwK78TTs?=
 =?us-ascii?Q?Sb6wMXBotF+TOhyg8NwzbiNtgxyR2UxlFiyTxe1PNxasJmcJQTaz4qfTcHn9?=
 =?us-ascii?Q?jFfLyrZQpaguP0dasQXThzoFYan29fX9C+Sn3fbi9Ku56thhrYkQ4fhXErUQ?=
 =?us-ascii?Q?/KGMmsJa2Zc4jMeNfYvgbbxR0qNqXEqadOpHUZUOU5ZMdaLJYUNeLcQXD+JX?=
 =?us-ascii?Q?T8EGeFriWdPyxZXwyeC/Z33iUTBXEhuOPL3iJU77lto644wcbk2wCWfWkd7J?=
 =?us-ascii?Q?EsTsIw0YvEAcXedn/5nk7kj1WDXF5GxSggUXs10kJHqMeAnLUU0ZR65QRZRE?=
 =?us-ascii?Q?0yWR8au1yRTc4/xqlpl9OpwJaZG8DJkWiS/2oD5dR9nGiC05Nm8g42kXMf6M?=
 =?us-ascii?Q?WcA5m/epPedOO1ND2Dw5cah3akyhL/VW4af0vWDf+FLzKDPEELq2pKJ5O/GC?=
 =?us-ascii?Q?lYXgy7VTblPXBiUuvy11xXQRT/nsqcFXVf75S22FW8XiSKZI8fGSiNNUoTcP?=
 =?us-ascii?Q?EQc8kt2yimIXGaKEnZ8TSpWd323UVdko8USgAAxJnpB0dlkfNgfLvIYwNV4q?=
 =?us-ascii?Q?tsKMGZkXRLsyz7CVGCreurZhbhLNsQ0rES8U0R2CV2ys3ekz5stLrcm7hpo5?=
 =?us-ascii?Q?1HIxy66GnMTteDx5LGC8XHZ3gWPmSaJ6lH6la1CnnxN/CCsbcffFh4jtaJFy?=
 =?us-ascii?Q?AzjI6mFc4CzT1uApQP9vE3QTB4a7RJlavJtAQuhUtgDHaA7IF/+6wu1XLJgQ?=
 =?us-ascii?Q?5PWsbDepAVUHMVOPpF+1df3eIf1JS8KwCx2FydJKOKRVbvSe2+G4kYZpMVQG?=
 =?us-ascii?Q?mivOSLmvgBQcA+uRSi3mBKUTYKw5sOltAbNwt3Ag+XPWKZ5oyS6UZrCJjMwb?=
 =?us-ascii?Q?LmUKJQyapwMEeV0qEtrfdv33rqA/OjEHBSNRF+XQ3abNmBRMIXadHgQV2ka9?=
 =?us-ascii?Q?aXqda2sh/pOuCIpIEDJMjqiwtVCWXWJwtpr23RC3w6/n0CHDClLEllK2zmQH?=
 =?us-ascii?Q?qIazH4+Pl+YSs019mi33fZwoin9SVAqvKxikrbqHKQHEEbp7qTozKBs79kS8?=
 =?us-ascii?Q?bYK/6lcSOfTKRZwKuIv2Ibf40AcATZOUNcIO+3vAizPZHBF1jZT5DHSaDrib?=
 =?us-ascii?Q?7/DNT7/fCbE0tzRdXkOnkXWY++E3ULvl/i4g9RI1dncQJr3cZy47ejGrTaU4?=
 =?us-ascii?Q?dBb2pcahmmcy8zJPLXZYCgs34SRs45rPkijnaRPq11BMH1BrqdLb99TSoJrS?=
 =?us-ascii?Q?ywQe9Qlnp4xJBTootDD/Ja64y5AwvI1cNS5RF1yg14etDSIet+DLPaytJ4gH?=
 =?us-ascii?Q?64XFlQDY1TUP9ckoUMZR4uUI4xe5avZOXgKDjWvF6sZJE1C9/s8hEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wsCSnVsAaD8olsqNq5Sn99fki8+cerfJLhpjNxZrPASCQxdYf5oOEyb/+v/8?=
 =?us-ascii?Q?Ltc1DujxtcCwRGtty9aKxjI+ucYlLY+m6k4HJKK9uZDwKjM11Z36yuQS7S2m?=
 =?us-ascii?Q?tqc+vxVkkz5YBdt4jPHv1MmSUKF+hMLuLqjaCxHvQpR6PmLaB1gMRR8gP4No?=
 =?us-ascii?Q?929yz5g1RKizkRKoh9s5TxR/4+qdgPEA9Xkj6klcyBQZA9s9xRKd7MRriDJI?=
 =?us-ascii?Q?O6tr16LAJ3MrWlRZynRl9FVQXkWnG+SAonGNy/7wIFRpU8WbjErARuZrheud?=
 =?us-ascii?Q?GKuDOuWaTv0mXX/BJiGD2fY5QKEEAr+ZSNX4FZCstzRtjeaU6rdD+nicetFM?=
 =?us-ascii?Q?zsP2/8R+FlZDIcPxxG+kTMpXpgMrZUbVLA13OAGJ9KW2uHZP1af9TzomJ3wA?=
 =?us-ascii?Q?jRUUzn5fo0uSmo6Y+FESRAHRiiOYloHtAoaiD3HSN08netPvli5k54F028lk?=
 =?us-ascii?Q?vLs5PbI8WSbj3CmxGrp+NJaHdti1ZVazpi1NjQi6qRwi3SsuD+cHYFHHicz5?=
 =?us-ascii?Q?ldpWTVCnNxzUNCJ0IcXbLxapbIWq3pjTlu7gJqDMRhv4xvuiRMe03cZ0GtIn?=
 =?us-ascii?Q?/g0qePyT9gdd+Il0iNfBeeSCYM6qpDOoX8CwsqUpT4sQ/dfxrZnOCfMCItPA?=
 =?us-ascii?Q?CQKalEQilVkcgH+9hUVksXrhrpTCEg2jO9pqzi9h+/Q0YJhMdjktyNEnWRxM?=
 =?us-ascii?Q?33lAwOsOcmO0WeDFfmgfI4wkEC445TEit5yH/AW3vrkrh68s5rcCgc2ADZXG?=
 =?us-ascii?Q?eJSxoZ1oxG02amq1UcUQTQItAcOGodkL48wc/38lZ+NngpbEUjg8IYFMa8q/?=
 =?us-ascii?Q?ZzGBs8ArB+v0gWSEtK+txP9jKL4EnupoQUC/W3lWR09w1A/aiajj1kYbGkZG?=
 =?us-ascii?Q?ftFMVUbzdwKEIBmbE5qHfRx6a5Nq3FDp13MiMFNN7ZYbkceGNTMdRwFI1QBn?=
 =?us-ascii?Q?6oDlU+9irb/OlW0FWQEySbvtv/fhQrJN9g3MzSdZRUk6Da5p7GFHQS2kiJ57?=
 =?us-ascii?Q?qAqLJuLaVy3q2GljhII1oxBzmeDfRJq7zSitn+b3x99J2akCrx9k4rcvbNTM?=
 =?us-ascii?Q?JuEhTmHvOWjzuKyuANoe+XFj7T0srcMoLCDnNzAp207scvV/wbgEUhM1K0mo?=
 =?us-ascii?Q?Xfkn5m2SGNsjtM4ZGVlZVjUeZa75T+/XLbTjlIjQq7K/Y9/2zvhkZq1LH2j5?=
 =?us-ascii?Q?TqI+FjKVPB+FDfV8LPM7H2BJ1qcsAfclCQYoqSDVUcHoFFFD8sHOe54ePyEf?=
 =?us-ascii?Q?SogL4SQMTO26pSJpmx0jwbDfLVP1aF+aDyCpuoyCEYPSJ7nY/t4zbpnTnjjx?=
 =?us-ascii?Q?zvrA52NF7oi67AzOOQwhPXd+x307tVsxIjecOIn8lyG6HDGzEaLzlpn6PJYO?=
 =?us-ascii?Q?MN+NHN9aVoNMgELTWRziq7cmiAhhCKd8SBoPCI0069fAcmEQ4wpdAg+/Z3du?=
 =?us-ascii?Q?9NE6Qvf53SG78cXm9K+RdasYT4L2EdB6onNgejRgH37xQHdQxjEx7af0pKuo?=
 =?us-ascii?Q?xQwvTCEUtKzYvAZoih5zkBzqGkp0+ysQMlC06pWWDKOQzz0kBsCmt84mCtKC?=
 =?us-ascii?Q?b/PGPcxxCI/m1Dx37Vq1JEyyWEk5WoEtFayND/JI?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c419c80c-e192-4da8-ff36-08dd9da5b768
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:08:43.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QHpV0+nm61BEhECKYn+1t7ILnKNxhAZ1Tt6GmwCPym5VaNH2TkO6g4nnzif7tGjpVzbLyGI1qOkfxL165pxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5973

getopt_long() returns an int, not a char. When all command-line options
are parsed, it returns -1. Assigning this value to a char causes incorrect
behavior and falls through to the default case unintentionally. This patch
changes the type of variable c from char to int to handle the return value
of getopt_long() correctly and fix the test case execution failure.

error messge:
-------------------------------------
TestCase head early file fork_shared killed
./thugetlb -x -m 2 -o 512 -e -f 1 -F ../../../work/hugepage
./thugetlb [-m memory] [-o offset] [-f file] [-xOeSAaFpch] hugetlbfs_directory
            -m|--memory size(hugepage unit)    Size of hugetlbfs file
            -o|--offset offset(page unit)      Position of error injection
            -x|--inject                        Error injection switch
            -O|--offline                       Soft offline switch
            -e|--early-kill                    Set PR_MCE_KILL_EARLY
            -S|--shm                           Use shmem with SHM_HUGETLB
            -A|--anonymous                     Use MAP_ANONYMOUS
            -a|--avoid-touch                   Avoid touching error page
            -F|--fork
            -p|--private
            -c|--cow
            -f|--filename string
            -h|--help

thugetlb was killed.
PASS
...

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 cases/function/hwpoison/thugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cases/function/hwpoison/thugetlb.c b/cases/function/hwpoison/thugetlb.c
index 32098f5d6aa5..15bd88046eb9 100644
--- a/cases/function/hwpoison/thugetlb.c
+++ b/cases/function/hwpoison/thugetlb.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	int forkflag = 0;
 	int privateflag = 0;
 	int cowflag = 0;
-	char c;
+	int c;
 	pid_t pid = 0;
 	void *expected_addr = NULL;
 	struct sembuf sembuffer;
-- 
2.17.1


