Return-Path: <linux-edac+bounces-3999-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA142AC4B9F
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194EB7A66EE
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43742494F5;
	Tue, 27 May 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="isb2aVAC"
X-Original-To: linux-edac@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023142.outbound.protection.outlook.com [40.107.44.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3931F582A
	for <linux-edac@vger.kernel.org>; Tue, 27 May 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338583; cv=fail; b=vBI9PlUmvJ+/zOAfw1FEcB5RXRIZfsJRxiw2WwB89kWNeDMczQWCn+UVSq+V/28QszggGO99GmkGAwoWehvvCYJ5pmo86/2xD93eGyJcBhsSHwnp6zc2yr7puhmXMeI3rDN2D0K8cfZvmsJKf3/6Yc81R0IAHZznt4tgsO1iYjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338583; c=relaxed/simple;
	bh=iaXo1Rot9RC7hIXnIRqIN6qnfBlGwAng2fBH5LGfk14=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u8AClg/h8QV/rTNhuNZ4elLJxL+7q/IvySWz7ClIykd9p2fAkyNqvPf5gWDs1nwuqNWVCRADGyuIpMdUy6CR0GtxMo3aKfK8H8AJVQ3exXCRYrFwUksd/HPiqJJTfTyhn9xz1e/rsh7QvqRxvas2YxAHw1/jwuE856OIK52d7M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=isb2aVAC; arc=fail smtp.client-ip=40.107.44.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzTyFThjaazCISkBXVpiyZbyCUeV3bhqkBf8OgHa52Yzk6oTZAj5sIwL4L73oFC/69v4Ik9aYhts1PEGTztKFpo+YR6g5bFKzwudZaojz0zC4lIbhtx3HorRq86lQRRyfKLwU6rc9qknMRCywHhiivn/zp/DwN8saYZO3l3lFAAS7GcAz4QUCCGVlGYs0VAiE9Dpyby1BoshWVjRURf115awFq6jDV4bH8pY5A8YDcNjE6lIPTxLGQRo1+0irQAut4SJ08qHPDIOqVjvEX8OirZQrEwEkxlvziiB2dZPALRnriMI3/qD35wDK0/4c7WBeZJ2Exd/Ylkb8RRwMSLBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU5fd1Da81+C/f46xjt04uYbkKsXKMpQxgtSOyBrOVU=;
 b=JstNnQiJnjUY/qHQUefXvmDny3TGJ/MkQv2Fayu9SBGt+THCZX9YFByXkdJQRFluJvMdvXK9mhH/gCO4xcXTp29jJaIggR1JMyl+1mVEcNYtAhvsO/OsaD4INQ5lhVDlXg35j7j4otrsRcFTYpd3k4wdQZ5VQKao33BMTws4z5wNUeUHjcSBtmOvvXi0Nm9JA/NqtQoDNrz3b+7SYHOSVNbUFWEnKjkAAildVBuhb1mFnOG90noOuHjNfsXrTXO4L0ER00dwqU1Zuw29KxLtuA6pu6uHRKFjqv7S3IUO2jAKPc58MhpnIcTZc/tikD2nWn5TpV/9GES9TfxMrm1lGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU5fd1Da81+C/f46xjt04uYbkKsXKMpQxgtSOyBrOVU=;
 b=isb2aVAClZOg3jvXRUCVftnjm17ebaL0zlWmccBDMzSJ1NEZJjEoGwfp4SUt4kDXXklnLwOI1DfpMuWMULi0nv1WJfgpCcgXkMsCK23yMpYn110sd0Qx3mmmiqwby+Nzh4PgD+5fCepvViAzvfdG4fRUUgb7R2Dx+VSLUJMG9G1zn402epfsz4pMsWWQZpiXybcdBmW/VUForFqfrftLNd+AUPU4sevaOqYJv9rpeByJ9adM948rQfH9zIvPMUUM5Q7+/dD/dnRCqDmYk5jOwI9IM8RBOL3W1CIBzjGns1ziP9vMvDn5mepMituSnrljwQ8F2KLBVcgPZKpYfFnbXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by JH0PR06MB6677.apcprd06.prod.outlook.com
 (2603:1096:990:31::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 09:36:16 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 09:36:16 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: linux-edac@vger.kernel.org,
	ak@linux.intel.com,
	tony.luck@intel.com
Cc: angus.chen@jaguarmicro.com,
	hunter.he@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH mce-test] run_hard.sh: Correct test name printed to match actual execution.
Date: Tue, 27 May 2025 17:34:48 +0800
Message-Id: <20250527093448.157-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|JH0PR06MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb04975-6a9a-46cc-2239-08dd9d01ed62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7L+FIncqeTiCqxZOrB9TVvFndIdgeR7kH5tHu+ywruSJlhnTX9Q0Nbnxn42s?=
 =?us-ascii?Q?DCOq94+fMDwnTa23PsCKLFIZ4l/rtwjLLPHSIs/DN6RMmW1Iw9d+vX02SckE?=
 =?us-ascii?Q?+T630c1ulsAHqhREi6IDE/CGqQwPr3o/GBaperGt6tlMAdhWAvsVciNBqFIx?=
 =?us-ascii?Q?2Mr2F+HHBeDL1jrnoqop7GRQ8Z3MgaE/ZuzEPId5oqI/YfqI+XLK54zFh2iI?=
 =?us-ascii?Q?D0HykoIje1V80peBYWB7R4hrLL6xQd8pHH0ilVFC+GxHYj7E/Kj5ha3ldTUp?=
 =?us-ascii?Q?yYBcorSfd0LZHCNd3JhKx9xTWU+SWlKtLk9iSqKq9W+ssWgbbr2yFDreCM5Z?=
 =?us-ascii?Q?8ztrVqrm9M0LAiIMJeWx2MEM70X93CN2DX1XDUZI5wWqkuFhnb06nI8QDMOD?=
 =?us-ascii?Q?VGnMm3l11UUTNpm8NpV2ZInQN3rkFo36d52Phuz9v+0r9YcWKtrobLBsWErY?=
 =?us-ascii?Q?A7gBxmGJAnfaW2HeRP9Rqpf0bTheNhMdLo7K/ijvCLaRrJzNZb3yk2MH82Av?=
 =?us-ascii?Q?nfbAuGU9UwFPsOMFWmypqObEKgyc6poX2RpPlpMQ/RXvSZ+GjkI/GzhaODwd?=
 =?us-ascii?Q?FYrB5z9WxR/eSXNg53WEVs2wyV+iRtirH81Wp1h+9Xv0vPrjiQQwd0sTSz02?=
 =?us-ascii?Q?753do9/qSXkw8TpaNN9lgBDWN8GeL4DhO8hCZt4jVSqPEpsI4YED4rY+ffeD?=
 =?us-ascii?Q?/3zmArhgRdbwjSJeisRh1jpaMzdoxBgzcW95NLGHBgBdK7LENe3JVmAYTR/I?=
 =?us-ascii?Q?IJxEllzdEaB5PilJaKQ2mTHsUpeXVYJX7e+QbUvl/Ic+Ou35MuRhJtCmQLu4?=
 =?us-ascii?Q?jwnE59kX8w8AKxFBBpW51P0gtLvyhnKdz4AKGgKCLJy80uSE5ul4RZGSw6hO?=
 =?us-ascii?Q?Onxdio4FPvYnY7jw50A3jfJ6grXRDLTjTvVXEjNbj/Lcu7LFwqpjZjafLjm5?=
 =?us-ascii?Q?cHSHKR8TrMkF9QRZ0MXqVD/wj8diAUcuhvByZYlgOE62r+X5mq54D9nAQgaL?=
 =?us-ascii?Q?ST6eNMO+5bdtJefL28Vgb0f+S8IpEswUBJgbqKziG3UA5XVTa5psphp8q6n/?=
 =?us-ascii?Q?KqhlmXgWPBragsZyjldMWAAmXEumht5On2c0IqtcIpKDAqrH3W4pLkEmuza4?=
 =?us-ascii?Q?IZwAGrGXXQtOl5wfnPOW4cXkEdyRXCdbtJQCaQ26LmQN5MSF5wXVM0DuNz/X?=
 =?us-ascii?Q?unaa4tPgXzuz7vd04jzjo35mGEgjE6dq04mpQ/gO5Jrw+GJIP2S1xLdvNoRU?=
 =?us-ascii?Q?4qMFeVd5WaMlH3Ps690AuHWxHmTaf2TILYLyD4qYTaGuDqZAw6cZXHsMDsDI?=
 =?us-ascii?Q?O+yIoJOJ/dViAWyY5teT5SR5kxXWGTs1X87sWqoDBfveYQOecV6FIVQtpxZU?=
 =?us-ascii?Q?twdC5KYMzSvR12XafYHpdsGQGEXNGEYWpy+n2zqkT/96q+WfUcLJNAZXd1m6?=
 =?us-ascii?Q?ARMyeSZps2c+DiAY/cMSbynPAXA/nbSEXleZka/KESFMaiIFwvPZVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etUGYEX+pMkhL4cLWJQZ1Zy2mda+mO2VaDkk7oamzBkOe6ioZrEyOYLEjfeF?=
 =?us-ascii?Q?zAl2YRMjC5NzRL0e7bdHkix9ocIsZQg8X+z0bAgPYRxb9FgMkZJu7V6a5NUY?=
 =?us-ascii?Q?88fW6fQeXIT921KCPRkVWpoc/XH0EQiKei1gLdpa7LY9SDdgA3MNUgUm51jq?=
 =?us-ascii?Q?dJECeudtLdluLnjs9gnsgiuJRRRysiq7nTSj6bK6EBzcErogqCuy8rJOCJjY?=
 =?us-ascii?Q?xywXD+vKYf2L13dnXjiFVeHu6rS/Drb2y7+rsEUNNhygDB6VfYWpD0+AncIe?=
 =?us-ascii?Q?4upv7aX5o5GnuQ5+HZKa3g2SwLIGkTMnNPzYwvXupv8nUa7Tp/GKhQbusLTc?=
 =?us-ascii?Q?QZa3o0+H7SEv4erz+wDCwzBZH2XL4G0PJcj8BgSCBJqJwEW+5TUeGxEOINid?=
 =?us-ascii?Q?HX4jH93QhpcAf/ZLeu555w9mFeRRUK3PAbItwGnb+jABwIH+4xLWlKsw/tL1?=
 =?us-ascii?Q?sVkgcoynYfuTxaWB36Ll45bbivSFIf6tH1pSnzdUhMTqgakWPhIKG3PQM66o?=
 =?us-ascii?Q?1FGfjTpc3ZQod6ZCoa1DeFukZmR9jgUQku4tJslmgK+om60Z1raVnDd7h+Kp?=
 =?us-ascii?Q?IxDeQnJkUzLHyGBg7PRrrPFk2ZIRtkNUzwJw8gO7awQQFpRhdRQbY2pqY9EN?=
 =?us-ascii?Q?EsBAAIP9TYEhJLpg46Cz25DoU+Ve1n94mPuRm2ThEgBlvspibPjaHabR35EN?=
 =?us-ascii?Q?gRs46dbZDhpspEDpQhwlOIvwszJAv3blPCPFHQ7qnLIbFWEYzAe/SLRM++KM?=
 =?us-ascii?Q?Zw2HMb/8ZzDDq0Pe7z2s6BgS+4RrH9X42E4LrhH69uWWb16jO272ZuODgtcn?=
 =?us-ascii?Q?8zGvX4eSvtjkvfXALrxs9fv7Ky5KQKCvB05U9Krt48PoGE9FTQ+qiIP5gYp2?=
 =?us-ascii?Q?OpvZ5RWow5bLn7VXfvWZxxYZwQ1roI93WIpbrwSHRmjcYFu7AHeRycIUBQAI?=
 =?us-ascii?Q?95qv0VCAHe6/uqaUshwFFwk+QHOa60DkZvlZ63lzHePM5lPLwjLUneLh1lm1?=
 =?us-ascii?Q?2CmcL4SycZfzBL4Ikt0N14Bmjf0lvgiJrqpyC4dy+cNedtogE+aMuEiCYr9b?=
 =?us-ascii?Q?yt5z7fM8aTB/FFwsKiSEiOyictL8tYVAJBFBxYwQVVeOcEXIBQq7fLQBvuui?=
 =?us-ascii?Q?bTXOJeCCx0gdVEJvGiQZ9J+OK2aAU7U9PnkVvXE77b8KQts4dPbe+BxOwtyz?=
 =?us-ascii?Q?33NpYdxN/a72yTQ0lCaPzk1D2y7wuxLlmWeACL8GzXyf/NbbMK2NlXRWfWH/?=
 =?us-ascii?Q?LXYTEA678mxA4/BBdR5Xocwk0BHDUdF+mTfJXuWJaxIGbdKjowYX95HfmFi8?=
 =?us-ascii?Q?3afK1tTTmh95kb51Bs+IQ7wvXEXxhTf86wU0oBbTP798Z9QvVnZ33KCZwC4H?=
 =?us-ascii?Q?NTyOoibS3F8RThiGmQ87bfHU8WQvluD8tNBK1HT9s8spBdx2UOzUMwhQKBOE?=
 =?us-ascii?Q?SuT9wuNr+9sl+rj/ph425dlMR3pYncn6nLaGsgbLJrdTeeV2Z+H6z+1nCTYa?=
 =?us-ascii?Q?O1+Gt45i0hkVleoBP/P7+NiI1XsoUXsZ6NilFfDgSp8gCvHGm7CVoKACThlY?=
 =?us-ascii?Q?IyKbV30hea0cMXA9vrvL9o3iXs4U1H/N/LZse99K?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb04975-6a9a-46cc-2239-08dd9d01ed62
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:36:16.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSQYCJ5+VU6x3Rn/k53lZ3TMIT/xtXi9jI8eP0Va2F/VErIXpmo823s/bK3gTh07Z5TQaWvElU2aBwOuRijvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6677

In run_hard.sh, "run_test ./tkillpoison" is executed,
but "Running tsimpleinj" is echoed. This patch corrects the discrepancy.

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 cases/function/hwpoison/run_hard.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cases/function/hwpoison/run_hard.sh b/cases/function/hwpoison/run_hard.sh
index 548acb6f6c35..c8c32ee7e8d7 100755
--- a/cases/function/hwpoison/run_hard.sh
+++ b/cases/function/hwpoison/run_hard.sh
@@ -21,7 +21,7 @@ This test is hard mode of HWPoison functional test.
 EOF
 
 echo "------------------------------------------------------------------------"
-echo "Running tsimpleinj (simple hard offline test)"
+echo "Running tkillpoison (simple hard offline test)"
 run_test ./tkillpoison failure
 
 echo "------------------------------------------------------------------------"
-- 
2.17.1


