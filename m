Return-Path: <linux-edac+bounces-2788-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764C8A01EDE
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 06:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089193A345F
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 05:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B01D5CC6;
	Mon,  6 Jan 2025 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jV0yfIQO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82F1D5ACD;
	Mon,  6 Jan 2025 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141688; cv=fail; b=SFngp/eDxy6hLygmnUiFNo/dEA4qGSIPjy3DeCkTSC1WuijKfVOMDTyhnKw2Spfs4/Yi4uGlY45wJ9LJpJRoD5OFgOvREcUNx5L3IGQSIh/ZBZhrtdmGYyu73j0QiifybLCOSjmT8SeHpwSr9ZRHMD1t72g/Gij36A7vdLXHorw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141688; c=relaxed/simple;
	bh=wSNAaz/gMzeNKwKnm7nykcNykuZzRMf0AKWG/gluEVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBtxFyJsQ4tsDnwwzVjOz+FKB7bd9bw4LWNKPjAIsd6HzKrXJ1csn/JqxmMXGGz+LgXd3zNV+1URFLpfsUKlMPPFMyserVA6dSkDuCzMdwx9LpG8NSMFOTVC+Asokam9yJLhDi98W+qQ4XNIsK/DuNli/XmmBUeEnXVmZDe4WyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jV0yfIQO; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPkGvg35Li7C5Pt1m/0/2HFojZpG3ZW+AN0KOwLIGBLMrPIw6Opz8lRg8Q4Xouj/dyzlZXYNQTSeSyM5u63mkCCtgFQZ0GEbGovgHx/qZ/3otsMq4ucdxqIns9Z0uWG9IQWi0dBkehn1f/ppxvZLN9KDILL3pyv2WxG6vXQ5CpRTYXd3H2yMunbURy0l+Sq/3tU+0iTmX4l6ASAVj+0atJgBX0h5QOM0CH1REmm59gXC3UbJYXP1PIVK2JX/NJRC58W1FhooTLOrctgFk8ZE9ph2S0/Mxg6xsxxP2Jlo8yxbJhKvqK93q5/Xc5RF9J2F2Kv+VpMxTsxElTpBqOK/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYp2VX/JPPeV2Sy91YjxHMXY4R5oPcNDEZHlRI+V9nk=;
 b=lS5wcKs8Qa+CzQBh6OBjCfWEApjrUs5C/duHfIWN+jvgMei/EmpWSqtVr+2zvD6PL3Oz4GKyGF/kOnV0LoaC9jYtm8UkSiI+9DVlrhhcc5AoCwfe+DIJ+Uw2tJgwsvXd4wNzWsH8s8jeV3LMGu3Z2LojPZu7ud2SFYIsSEAYhMe263Qb7Y78l5o+V5YDbAWOJ15fRibV6JdwcLxSYVWBXetU+l+lexuT90VCnx66Ag+hrwgCZSWCxyMN32Gk5GDCKOtZPk+sezJvy92bL5ys3OHNq1ZgwLUFCg6rNJVFFxP/k4Y4raE1FQYkfAOtDZTY7etgvOjzagl+6B+6QO/J5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYp2VX/JPPeV2Sy91YjxHMXY4R5oPcNDEZHlRI+V9nk=;
 b=jV0yfIQOSguhPA1BDd+dfQRRO9H6w6IMebTOjFzWv7+/xa+N/xCK8BdSvEbPiR7KMFYfaNldFWoojlXalv6Be+9tHG3Y1EfLy0zwNswDFurO96g9SNZEhHfIBi8db+lEn6KanDIZLm5F3DpOKLedfFk5iMxAeF41qtQJU7LpBkc=
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 05:34:39 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::e3) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Mon,
 6 Jan 2025 05:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:34:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:35 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 5 Jan 2025 23:34:31 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v5 2/5] ras: export the log_non_standard_event
Date: Mon, 6 Jan 2025 11:03:55 +0530
Message-ID: <20250106053358.21664-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcdc4b1-0b1e-43b5-9b70-08dd2e13d07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QLURh6QihqiJ4p0hg7vJQjMLSomdsIXTjrmkSIbwT06Eixq4fXbfKDxeEAbi?=
 =?us-ascii?Q?vY2VwABO41w+GnZUqj59dwmKZNRD2QUlCXSLe98CppmuHJtafik3WGenCfsH?=
 =?us-ascii?Q?riB+PRa1vxsPec0g1XNELW/YB133u1/xh9Sr+0VcQVgnZsGP33p2dXAv4VDU?=
 =?us-ascii?Q?IaWysBg0fuXhkh2d1K9ecjBtkj2z7J6DuHIBkfazAeIBbRmyaWBPKZuGVgC+?=
 =?us-ascii?Q?IdL18AgHRyEcVjFqAfWy7TuP3yEgNLaHzTGRjyVWqJdhYZ21Wo8kbhrj/k1/?=
 =?us-ascii?Q?3vPre9ZB18ON5SJ8t8bStQvegA1CFBwxgjFr06Hfsy2fq9pP59Vc4+fr9xd/?=
 =?us-ascii?Q?O1RFWyQ5fZEP5Abkc3lmiRJqRbkOyZtYRd6JNeQ0cCBhVQ8m/L8706+doMSo?=
 =?us-ascii?Q?Ag1THib2Jw82waAxdb53IsGq0fvCeSeP2X+Tn4oQVVbTd6rJ9boPuVeOOodK?=
 =?us-ascii?Q?jUKaINUi5Sn5hS/kOatgWOYdJax+efhaF3fbBVvoS82XJ7u+AaY32zE/xcAd?=
 =?us-ascii?Q?V/xo49bcQZ2KfcS+fqrRSIDAlxvSOAHNigRbiCdExl8McrXfrpEPANBw6eG2?=
 =?us-ascii?Q?uZd75O2DL9noNIeJunETpuitV45RK4UVDl9GFMxBsyA1vIyj8WMIqf4hOtYC?=
 =?us-ascii?Q?W6E2JD5UnCSwgdKqbS2XImu0Gyw8X031gjujVrqikSsK7BswD4vVN2Ix2Vls?=
 =?us-ascii?Q?204DVDeO4jvjpe+4QVXu1EBFX9uKb3a0Jp+wx6tj3eBt/3eIG78OeRd5db98?=
 =?us-ascii?Q?t8b/ra2zdUq988r+AOSK/JvZ/eTOmmCmIdOPn1hswGKCqWK6p2HGwlZiphQF?=
 =?us-ascii?Q?31K2BoH8beK1WjPkPbN64itH/n3xI6l18RtNevZ7qCCaOyJSCLlM2WUGi4Y1?=
 =?us-ascii?Q?+dxo57r95i4kf8CAfk1/84Vk5ZgsUmZ3zNyCOR3mVxNMsGopouVnY7cAxIaM?=
 =?us-ascii?Q?u43zAViZbFUJXtfauxhkd/A6AYHeHVj32lC4yWvUYybJlpd/vlTHWiNsqJfZ?=
 =?us-ascii?Q?e8f+rzrR/6o/clOrs42Vi2f7GMspoPTafopy9GLRXA/wkK7lfV2e+0Wlb1Am?=
 =?us-ascii?Q?6FvC1hX0HvAvhwj/fPh/Wgapq3xGnlKn9+d9KXoWoHDL1zTpacSvTui+Hvww?=
 =?us-ascii?Q?ttnBsE171XEh9GDwpWfek/5elIj2YHZ7hTmYM0yQZTIiNSs3+PpWowvdrdOQ?=
 =?us-ascii?Q?jNhoK68qqfML5DUrWqrB286oD+15NE+BNPvmOIfln4ImCF+6QF+NRkcWvJWT?=
 =?us-ascii?Q?9ofJ6Luh8/9LtQSBxWMHfyzljX/OExjniro3r18sRd3oXrWf8xoyGfyNJzhT?=
 =?us-ascii?Q?AMjOVrO3OHA5SWYsD83T3VmgkUm1kvwmnKHNZEY2EbAZmAjt+2wm2Cn6+nCO?=
 =?us-ascii?Q?N9nWmMeLFCM1teVpeEL28PAjj85jf8L7eV6nXWSlN/Nu7Bf6p+PMvrN6qdRM?=
 =?us-ascii?Q?sHsxPvJ3VbyZzWx6iFsN/H1thRXk8win2V+pBUL9b5gWXhezoEJR1CUwDxc4?=
 =?us-ascii?Q?SvCRc6bstqJAP59lgab5VdpqdeSHvJoo8U4h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:34:39.2039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcdc4b1-0b1e-43b5-9b70-08dd2e13d07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

export log_non_standard_event.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v2)

Changes in v2:
- New patch addition

 drivers/ras/ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..ac0e132ccc3e 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -51,6 +51,7 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 {
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
+EXPORT_SYMBOL_GPL(log_non_standard_event);
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
-- 
2.17.1


