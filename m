Return-Path: <linux-edac+bounces-958-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6AD8B2183
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E3C285F47
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCB12AAC5;
	Thu, 25 Apr 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PzF5LRYG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C71BF40
	for <linux-edac@vger.kernel.org>; Thu, 25 Apr 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047590; cv=fail; b=GKxFb10O5cNGiZrTI0CzrdRCbzAF0LC7Bm270AARyXXxzXjr3bBxOQ8/B7Q4TgyLv+kCiH1uhfzJIYIqJl8KKdK3AF+nN6uxaeuPW9Ba4Ch481Vx4FsPTUB9hnYTGcUm5PgFVWUp8+ILn1u2qDBeu2tFN7nv1hjaqfmBGomkfbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047590; c=relaxed/simple;
	bh=xpqpn3sxAuBamWfHSlacRyQzmAaGHuQ+n1n2fuknR3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIjpdR2JSnAgGqp2LyNHFEDL6BaJg0DvFoT9Yf8cFZ8ohulaYt9uPqWslNp6qRElktBnrVUIvuPie7GAzgfTDrEKH5EQUiBB7x/3dov11jlE5icy8ofzTXx1Ee/yLvTl8G1noPYZ0AvREuneA0ACnn9oVazr3A0/9gX/uJEXWcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PzF5LRYG; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixzoDnpqFu8NDde+qUiPieJYrZuCtD3R2oss5aTenhOl9K5bQLwzHeTa1UrK+zWDSplRVt5dBRcn1LtBerIGSv2pBvJllspw+zllw6pHqVf8AHMyMGKVp4B3wTqcUHlCxIrnEkSqz74w8Gv8pUPWXJTEK3eEZVDtUyxHaMWt5ootc+aKgAIgIhSlM8ywGWd3mjhW3h4axZTI0Gupy5ThBoeWxBlMCJ2bDF4kIgxSQZFtDstKSVim9NzW09LSYzklAZIjAg8PufNkkn6rsFHtco64U6hFJ4UbthmpjxNzdJ41rJNakwI3GKHmWJeD4/0B7DbTMTPotpkCRlYcl7dfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21X2fPM7+FaL/foFCUFYN7ydWlzET4Eb/cpIA1qbY54=;
 b=Jh4eoy4azuQouwTNWwImnFYd440kv3jkQVJShXhzaGgbSQ0DaSQZvB0Vu0rY5IcMwJDXbPpUKflPld667fCdkmDa3Hy6x0hJBBebPJzZVrlbqguHkPDwXNZ6yMGYyXEJLhgAAcwQTmnwKXQA7wiOqIECEuGFzSuLk6Johhm4OekJByovkwZclnPqjX8eBFJQJfTHRxPNkokpWKzPM5JvGBoEESfeXUboNAl/SjKrnzx3qXKDoOHuqQSODBLTU9gKNb4XT2wE0tvxoAC2y4oQAa0BTInfnLnkRdexKqNxKN0YRUo0y594uo+Uv6tuWaX64bPLpxntq+l8/L9wKZ4BXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21X2fPM7+FaL/foFCUFYN7ydWlzET4Eb/cpIA1qbY54=;
 b=PzF5LRYGAuLcAX9uVzcHHoQ2cUWxt9ie1ttUdxp6ganPAX8S4j+5mubP1QHXlAPpyHl5QKFt1GrCuvIfHbEm0/8X7fnle8vERkUYoD/pDbHGxVK/0yd5CpKHNWuUr1A02OTCsApACmGrhndSPInhZYOnjKP1+tF+ra6mibOopBo=
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 12:19:46 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7b) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 12:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 12:19:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 07:19:45 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 07:19:43 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <rric@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<sai.krishna.potthuri@amd.com>
Subject: [RESEND PATCH 0/3] EDAC/versal: Driver updates
Date: Thu, 25 Apr 2024 17:49:39 +0530
Message-ID: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 093667f0-1ce0-4f25-04ba-08dc6521fed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VN3SE+ixm7RfHyCb9RjCeZyk5oHvZM83lhoOL/76+X4+008c651dFftcWXF?=
 =?us-ascii?Q?wJJ+drSGOo2fgUNPpT2m9oqTtKM8LC055jtTPx3ebf1EzoWbHXcS5uiPn2D3?=
 =?us-ascii?Q?4auRHZvah5fCwUgygUfcdL1i9SNu8GJFsQm8Wd1O3vMvMgdt1aVloXIowawJ?=
 =?us-ascii?Q?1QSaPwBmrr6ZvIEq2evLpy34MB0jC9OYWwCPRl96AJr22OI3y3xRVCcmvUpc?=
 =?us-ascii?Q?sPmE7DQNqoxN4q1qbTKuBT3PsNXMVV4/nDfqd4CpkzwG3tVpWqES8Ljd27oo?=
 =?us-ascii?Q?N3hzK7Y1/DbLQChaSE3T6+lnWc44JtP+SxkHQEbw5V/qwFZhEZ2+EiiLvp4+?=
 =?us-ascii?Q?wFoZbJ6BC9RCY9k4TzNRjMvjSe0vDW7FXpgcYuOqV4+/WLq0+l6LGq54sF4q?=
 =?us-ascii?Q?ZdqumKJRGssnKS8oD9OYXl/gzMHhppFf4r1A8u5o3j+NeCCiEUK2KIQPFcFn?=
 =?us-ascii?Q?2V3SyW/hU2c+g9fb034/3qbplgF7EtSLbvBgnM6c6G8MAdvBvPWBjJHU7iq7?=
 =?us-ascii?Q?brA9aFQrXkD5Q6CYLNDOdc3yZ81RKGbpfAKoEn3A9qCO/mpG8wbg5kRD3h5a?=
 =?us-ascii?Q?LSOHrYGuyFS+prA8Rjw2zToDL3pn47/tMDMglO6wjhkMJLpeMpSrR/xsvYkt?=
 =?us-ascii?Q?AosSzYfvKY5ewuco4WX0T7KuLlbLGmZElLYBtlTLTQocbVMX8OnCVmheCJHD?=
 =?us-ascii?Q?ap3O+6OngEz5SvLR/A4cRRcr22dsOnajVbEZRW5KYemHLBoXyzS++mT58gnZ?=
 =?us-ascii?Q?+nZ4RFVeE6zIQFM+IsGXr09pFnX/6wdJzcmDh4R8RZMNgOOZRnocpreFWbbz?=
 =?us-ascii?Q?4HKELc99Do4Hl1GV4Krf2zgs0Jwta5Uhk3fgg8vvdnG+DgjrSkOnhTNacTJ3?=
 =?us-ascii?Q?ac3QsLzmpB9K/Lbpe7JH9e/bH5nVCL1nQBgM9TsfZj+7hkJJ5rIB7GkNWoQa?=
 =?us-ascii?Q?nfRVy8Vpj3WpRdVFE+vlwMZmVmt9irYW9RVSaYCdCoWyhTVdEin8Ts5Wkt3O?=
 =?us-ascii?Q?Zg8atNKw7BLsBCiwixt+j9Cnjk4kwYgR8kIMRXzreqKlriaANG7zBeTZv/Bt?=
 =?us-ascii?Q?zZnd7HCsr7rHF0iYs6ZlqBahBghwr7tx47WjHF6txxdHkD9dSkLI4YbLgOln?=
 =?us-ascii?Q?ASouOoCrSBLVdgjigS22nber11hZuaobMYGazmC0MXAgafq36o2swA/du5ZK?=
 =?us-ascii?Q?v99JMwo0jNdwndBd+J1NBVX5dZOaPIdMrgyVdSp8jpGnMoE3JE9Nd5/+Reud?=
 =?us-ascii?Q?FeE/03D2dpz4/RMK0HmUJt+HAITnuf1ig5uT7cvEssPDdOOKuHNA7kHa2n1g?=
 =?us-ascii?Q?bRne6fXeY7o4p3X7r72Kg/EBpSnrTUuMl2OH4VOjZSxTDFQTUObHD3KEuuBA?=
 =?us-ascii?Q?U/El6+Dtm3gq3hZZKVIGkSoSMIJH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:19:46.2711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093667f0-1ce0-4f25-04ba-08dc6521fed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465


Include a NULL check for the user-passed function.
Eliminate unnecessary NOC error registration.
Avoid sending cumulative values in the EDAC.



Shubhrajyoti Datta (3):
  EDAC/versal: Do not register for the NOC errors
  EDAC/versal: Add a NULL check for the user passed values
  EDAC/versal: Do not send the cumulative values

 drivers/edac/versal_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1


