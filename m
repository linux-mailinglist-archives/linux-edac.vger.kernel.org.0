Return-Path: <linux-edac+bounces-4685-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F16B3535A
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 07:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B804D243257
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219142F0C46;
	Tue, 26 Aug 2025 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LARQm7QL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16C2F0693;
	Tue, 26 Aug 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186180; cv=fail; b=LHuS41RDWBTBz1JGBvuu3NaiAYNsTN9HuXadp9HR1J/tsNlD8RNRVTDbjSQ9vlpHGIrkHaYwSuhmqdqhuZDrGj+28zo4sDvqtoXQj2QzR+2mJ2M+q5AbSDeklF7ra0V5ftkOCTxggB6V1VQ6bWashDz6GmDgvxJPfS0Ry5kTkFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186180; c=relaxed/simple;
	bh=Vez8BzG1oP9sCigc5wncTG4q6hxQm+ACqOBwO7N4lIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9cNcQJ+hL514fifc1FUW9RBZlUem4cmVpWduvREfnQZJVoDdO0hkSUD9HXzvKdB7RAxmzejzLZl0Gc8+U1ZjR6TjzsF3KUDPO26Ae9vvIaq0WukKkAoLLDxH9vsZLnqR3yLuwFeRynT7LnlzDF6rlMLrg6eRqBCSoHHcWo1cYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LARQm7QL; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3fqY9uwxBn+tKv6r6blp6Of9TWpDyQfc7ILnuSAdsf0qy9UNyMqU+9zuQDsEPW7aKmspdPfI+LM4AmKNmp02pl85W/tHjK2mjDTnZSWfxQb0g1TUpsXRUEafrLMJ7hy4fVpNxaUuj+E2e89aq0VEU3MQ3QERs89fzKe9mWRE+NyVR/aAqhEkwMaVxXqu9WDE6I3r5wYbGM7W6+hbXKnbfG0RBXbT0JFUadg9tk0Td+1YG6lUJidb0i4xhpO+mYYEhR6dX5gY3xZX5MjghnkPzBNF2TbcXvFyo7a0f9Lbuehswgetbx6+WZsFXXkh2eTB6GRPvLr4bRvXmeg1SlRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD9kjndkPJXMA57cjkQvMqJYkvfQRX1CyhBx8CDcBIM=;
 b=SV1+tXTTujuFebr+76nFEB4r4GetxMkuz8lD+FM6nTy78oz2xxia4c4ATvagF5er7Rinux178HaPv/k+2Z0GtXEf71+Qva5u5MbIWco0TFJi8ETnvmqyyZCggEAdXsKPvznHKK6SNx3slFcO9izcyauKWTFBYRnr0/8a7mN75Zz5NRl+/IqS7xM3ybb//PU7eg+v0tp21LMWAGw7SgUjm+H1K5/Fa8hYcOlr8wy76gU/0GRJShQXg/ERPp61JBaQeiyxfdZCQa8Wg51MaM1XLAzV3FVXXbtL5LuV4WPDS+yjzxDQNKtsybj+eDtcZj07iEHOC8UP1U6aNJW6IfSyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD9kjndkPJXMA57cjkQvMqJYkvfQRX1CyhBx8CDcBIM=;
 b=LARQm7QLKpx8EcXvlanT+SxVUs3fuV6PiPOHYDDBx0vl8Ym10tGYTGshEVBWQQTu35bDx0BbzysqQ3pf95VmPcxqO5vh8IY+bCwMLLnMe7wL0Cw1DL+xMOf4B4VvsyQ1vEnpgCvNvIMDPnnh7ZjSCH5PFQlx61J04prgwsGvDGo=
Received: from DS7PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:3b5::34)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:29:36 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::b9) by DS7PR03CA0059.outlook.office365.com
 (2603:10b6:5:3b5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:29:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:33 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 00:29:29 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>
Subject: [PATCH v8 3/5] ras: Export log_non_standard_event for External Usage
Date: Tue, 26 Aug 2025 10:59:12 +0530
Message-ID: <20250826052914.2066884-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: e87a436b-97c8-4fb7-0e7b-08dde4618b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+rYhPpiFFlJTTdja61MDwboC3Ie0ebuTBhpgHtpOeB6boWVger6WGmXBYLO?=
 =?us-ascii?Q?I+MkdsJ7E3kzajNgi0FLKK3vNy4FZwbBO55QQyG0RctrMAkmRDOHKrd8my9j?=
 =?us-ascii?Q?9CMK8oqArkYMJd5dRwivb68F98c25fMZF+oiUnWyin2bX4xsDGWTGdjOoJnV?=
 =?us-ascii?Q?zZUbBbeBtDiNlIX4CbV74TI/DqJZfJOVV+QlgyGac2w48MSB5K8PqpiJdATW?=
 =?us-ascii?Q?sPz6fh2pX6mC/aYtpU/kBxGwH5tZCMjn6ZrDkvCV1bKb9rbfqjC6oPPrn+3W?=
 =?us-ascii?Q?VqE5oUE8APKlEtfFPKCZoUmz3SzYDU1L0HE8YkU5k5nvk3X1jENoFK0btdJb?=
 =?us-ascii?Q?yrlgqsdqZfleyzkJEpO5pWcdu7Vuwr/Kx/NqYUlykI63k6WlzC2whucqEguw?=
 =?us-ascii?Q?mK0T9T0EWA3N7aKh3iegS3QT0Yros4t+hTZxdQHo3GJcNgI1+lQcpKAX62sD?=
 =?us-ascii?Q?kCcjrA9ZgzyM8dlMFOHBlBDMllola0RDwdUydHVtuQVhOPv+pHICIVOnsamA?=
 =?us-ascii?Q?oszCHHyVOXwfX9uA5IB+ihTPLEri1dFVNzAbyP/tf16v42G91DRut4rt8Qcd?=
 =?us-ascii?Q?EZc/UbVUXMJcGzr7fUZ0TUxT+tfv7KyNSMIb/gcvNKSCQvm1zDX43RMhBo8I?=
 =?us-ascii?Q?M01IWesNcyCgKg+GDAyDDj7lTq6xvTaQyPDWmR0GbdD3R4Rf2tLW/7B2KTRw?=
 =?us-ascii?Q?oe2LoFbmY7tzpTaOvOkfMVpZF9dBnKtB8Tdfb8AmffpfvF3Udnr316HtHolW?=
 =?us-ascii?Q?JPmTPH3KSR0tDMNza7zOEG76yA+iVgtEGb2luu/sGeJi9leetNyCxttO7szs?=
 =?us-ascii?Q?4EkURV8oIABGn0Ynxh4fxvvjbccTpNjAtqx51AhFzj/vd+PPnRjz/jvC1a++?=
 =?us-ascii?Q?ob7J4+rX1CW58dRp2SpaNzr91dx6mPXLvxiRIjIUpv5yXUGlWP61il+PtntB?=
 =?us-ascii?Q?LWl/R+InVR/b+8HYW9iFN6jmo+55Qw9pL20gaMj5wMyNbKUTfzWAJ+mCgELE?=
 =?us-ascii?Q?/8sOjPMIGK/huH+8mSxPrFFtQQEz0wWU0SdxbjxBgHb3f9lOLD/T7MeG7XJM?=
 =?us-ascii?Q?f8ebVekF2sRizFDhvFgzbAU801FI/BVR+48Jbsyi0++upiVswxa9en4tjpan?=
 =?us-ascii?Q?goyJMwZbffNyzdkU8ap2ZkPtwKwASPrxE2rxEk2cMv3SEdoP5QEZguTbPto1?=
 =?us-ascii?Q?anq58xbGQRZzk3JloqWBku1UTA5oYMsgOY3157XnHDw8HCBOOEFrtfQJop0h?=
 =?us-ascii?Q?lXc2JEJVueSOwkXQg/uhxvpWmqNT0kO3Za2nkFn0tx8Bfe9rvx24ZWaW+oYd?=
 =?us-ascii?Q?sMgAyg8D9pxMUGzhtKeGIRFAZQvUVEFzreFpCPaA9G2AY/+g0dULaoB/DSjX?=
 =?us-ascii?Q?mN7tkj7DrCGIy8UsP7NjnFX5dZAKqMqSncDFvqQToRd5h78XoYQiKCheHIMB?=
 =?us-ascii?Q?BYfvmmx0+NvnMX/s8eD//Nxt5EzShLilrF4saYxS71IuAOyiCmJhVvO53T0n?=
 =?us-ascii?Q?IFH+cd5ZzrdsXpq0icjkze+e1sqA2TyPWIdr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:29:35.6617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87a436b-97c8-4fb7-0e7b-08dde4618b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

The function log_non_standard_event is responsible for logging
platform-specific or vendor-defined RAS (Reliability, Availability,
and Serviceability) events. Currently, this function is only available
within the RAS subsystem, preventing external modules from
leveraging its capabilities.

log_non_standard_event is exported so that external drivers like VersalNet
EDAC can log non-standard RAS events.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v6)

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
2.34.1


