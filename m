Return-Path: <linux-edac+bounces-3704-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1FCA9AEDA
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BB47AD82F
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5027FD46;
	Thu, 24 Apr 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CrNdA0B3"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA227F74F;
	Thu, 24 Apr 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500910; cv=fail; b=bErqnIb0E9eap7hKiTfhArwhqGDhZ4TRmxmnjSKDITYc/APKwcj+WOyudyntXrD6BiENlc1YWlet/oZvTmgM6f2lyp9WYyZKqWtIVlwdfvVNLhvpddNQRV/jD4r1aV5rPfesOoDMHhAXLIL3f9m/mx2nUxsOOiZKyZlPjMNEIfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500910; c=relaxed/simple;
	bh=PIa0+lptGBkjv9k5fe7we96zxNGmG/DdbW+dMz3z/P8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8D35Gs5CTuOdT0MKclzTqHx/kho27Up8zbn6P1EoobkNuJMCak4GlJhfLa7XsbHcVjCbiK8FuD+w0z3H0fCjClM/2EQehFy4LK00TgC33xEgBZnT2Mb7PGhpBp5jZkniLnXLUku3jVhPQVU2vxtby3B7Ox0vqGc7lo6Dx0eYhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CrNdA0B3; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4V604MquwtMbt4oA3QqvnrHBV4u6MDoO8v/fTWMG6KX6kfvhAj/dQcVVJWFkZfA3uKzHmZw8mDT7QJbm8KSgiQhuN5NjBS57YUnxgtDGI83iL31cULABMShXpEjsPgAvPC7nJdX2zRC9sK5R+q71pr1dZlXQi5AB1FeI5cGmU176C7ccCn/AfxWXOKQ2cI9HT/tNDIAnhdHJWvvuiM0WY4tjiaQ+EmSvXAAN7ieUqzRCOcM6lj2Nl28MZpWKep+vEsnNAaesUK1dmjv3DBrWqlELqYmqguSFQtAzbihENm1VxhNLD60x6ZflBonUCXnzgvFiihGuYjd7M/lBLFNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ybb5LTw5SX3IB8f3+EfXY5Bxe2QzFCL4MTElQq00es=;
 b=diMA/BzsmTwmjjKNFK6QOLkxTdKwagAC6J4rGnYSwB89pH+qQS41br4do2gtETv6vS13L5o6oPSsZaYNoiHfqF47nVW8bIfEh/hz+gEot+QmAK/Oje66YKFt5NPrtowrPIlOIq2kh/lez5Tsr1RJ6HfzkJUmciHNjQiD1YVL4Br3C96glBO3ICcgMc+n978r4DjcF+kwUVEBQU2CEWbCkeJr6q7u2DaTxbfjMmjKKtCDdIZe6cyMRKvY4SZz9h/m+4hYrSMrc1lVMzi2gLG4H8ZTPp9DKzonsorSUa9XOmDU5ZlBi6Ki/Rwe5Dl3O6ShW4cQt3WwbBVu3XiS50ukKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ybb5LTw5SX3IB8f3+EfXY5Bxe2QzFCL4MTElQq00es=;
 b=CrNdA0B3+5kmd6fJ26ZBas+YBOrXr6GWJ7DE1BHj5rDD6skfc2QYnNh9ckDcW4ZMvo87bNNu2C8GVo2xuLtGqVYOWUbRSTQD3Sz/aH3gFvjonqm66ZpoF9OhFHyWsPO/xBO+ODo27YnOdefwRdnVNaGCxyxKociVZVPcpVuPgcs=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 13:21:45 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::bb) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 13:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 13:21:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:40 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:36 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 4/6] ras: Export log_non_standard_event for External Usage
Date: Thu, 24 Apr 2025 18:51:16 +0530
Message-ID: <20250424132118.17074-5-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3af865-a647-4292-6cfb-08dd8332f548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOEyHneWuj6EqeZy7GxCfIrAOrxNhb1lLIWVXoxCQgH0rBeaZ/Ku0n6KU41e?=
 =?us-ascii?Q?2eSa2fXhKxylkIFm6p00Wi6qfsqA7ccDQJTH9P8CDn7C2Wng1B7Sr2SFszfk?=
 =?us-ascii?Q?1BUK37mGRf2x+XKjNtgb5xU/RJd0oJiIpmPkc/tt51ixdxxZqMxigUjZLXGU?=
 =?us-ascii?Q?BpitxwqJMdcqQquoeiZ4ff8KAlloyf+YiYQb0Bmu4LqRCEp9b5ENOCjolkEs?=
 =?us-ascii?Q?GXxAf6h5DPDfIEPfU7igoIY+WE463uzt+JWVu+t+MrXohr/8KwNmW75t9eig?=
 =?us-ascii?Q?wtUTm5/C8ywet2eqOa4H/Gtvjnlo4tO8d4Cj3Uksl2DNKjHkx/suaMmePlXM?=
 =?us-ascii?Q?d3o8wQCsNUJtstYxwmCmr9/L3KGu22vWDio8F6Tblf2Zt43OKYpbzGs7sOOL?=
 =?us-ascii?Q?RX/ATNxPTj+5wtAPIZxzIHLe87KW39XCfal3xbvkQC22Cl5BFvO+TpXiy17Y?=
 =?us-ascii?Q?hT5s4qbmZ/I/VJdfYIJem3w/Mb30+4QENCbDLDf/9t2jrgoratDU7ofdiTXr?=
 =?us-ascii?Q?5yeBrd038CZ58TXuIsBqll3U+31S2UR5cj+mszVoYdzUtfJr+DeuZ5fU9i7+?=
 =?us-ascii?Q?LwAdqs6o6Vseu5rPsE9SuqyERf58gU5kg8/KKFHQvjkKb34IReQkacS7pmIW?=
 =?us-ascii?Q?5Vhuu/1IOJkraIBOnE4amfirOPauYhrdYh6TER1q97UCez+yDz0/xncLuuU0?=
 =?us-ascii?Q?ch2Tv9My5oQTIEPCBaU1b8ToifR6d7+7BDNW4k+hjAU8fXcvAoUJblLixxY9?=
 =?us-ascii?Q?xBe767aZNiJjpQ/quVK+Yz+RtuqbuEz0BTL8hEF29RO7PWouFv7OBRNuwOhr?=
 =?us-ascii?Q?hNB7OPaalSKlHPV56Bta4AhYrXPOpmpO/o/fPrGqqcpKoLj+nqr1KrwFpMem?=
 =?us-ascii?Q?3zO90+o/ajLhaAl5v+L8xiDYSWhcyENAq2wVUQ+PxtQa8XXKNIYp6MXqLdp/?=
 =?us-ascii?Q?mMk2Jo27QOY019tabOHZBx3zkfh255z1NDsFzD27r88nI7o8Hw/3ucFNZrik?=
 =?us-ascii?Q?kxmQ2hh4H3wkZ/pDhi+4bpHYrOauUlE7Zji4p2QDvZn69AMlfnLG3LPbQpq6?=
 =?us-ascii?Q?Kpr/Kn+OXOHWf0E7F7z4IYs3eojvaoAwLFnfM8SfAGjcesWRTa3GZuSMNu0Y?=
 =?us-ascii?Q?aiLE2V7ufq2ELNF0OCDWcRtjZbn7m+u/IWlvxsf4kOm8G+o6WQaAYKcNQ4uf?=
 =?us-ascii?Q?clgunGtEaijKQA9sUvACKm8Ef4t/Bb+z+akA29IQtyBTl88iZF+PzThyarA+?=
 =?us-ascii?Q?3WaDd8gYF3l5jVOMj+Kj+Hi8aTQkb0NW/SG/Gln1lFd09ki8SGJYY0tKHZSg?=
 =?us-ascii?Q?UxevUuBAjYgbbVG1LCLLx9ra61DPIMFbX+65xRmNPmyhfLh3qqS6DZkbFcx2?=
 =?us-ascii?Q?HICnGbHc/14A6UKIQ0RRqEldDZI1RwLTjuJtq7n7rzisi17/+10MB6kUpfZ9?=
 =?us-ascii?Q?iXlNIgcnMm5Ut82ZXq7BAGNnVbDxQ96f9B0Zv5GTKpiotHQWcPPxw0QhrvC6?=
 =?us-ascii?Q?CvHK3/HXVxF4YrAKBWQE7i5o9YsTDrwbXsAW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:44.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3af865-a647-4292-6cfb-08dd8332f548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

The function log_non_standard_event is responsible for logging
platform-specific or vendor-defined RAS (Reliability, Availability,
and Serviceability) events. Currently, this function is only available
within the RAS subsystem, preventing external modules from
leveraging its capabilities.

log_non_standard_event is exported so that external drivers like VersalNet
EDAC can log non-standard RAS events.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v6:
- Update the commit message.

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


