Return-Path: <linux-edac+bounces-4767-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7CB505B7
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA3D1B257DC
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C6352FDA;
	Tue,  9 Sep 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoNY9bDC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE530215B;
	Tue,  9 Sep 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444312; cv=fail; b=StKCIMXTxKt8Df5VATG6EYgMNQnN7xTvI7uC4jW5uARS5QFmhlW2sizfDeUrir+38os1N3s8XZ8aYhVbydMUCN7wH59FjIatnjklHby3cLhfuGHFXOtgy9uiakGKhg7mjeD33CC0CWBG/AaTGmQ+erhD1WjCYo/bctBZ22eja6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444312; c=relaxed/simple;
	bh=QNnot6OdTndSuIJhu6/hI+rR5NW5oxpRwIrIwsfANFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdHXzuhuaMPxHDM23ZPeg0KTRi+mokvzMRn50vFRLmgsorIZQdGseUrugIi8JvTF5gaEyj0Ys0Hy9rZFPabNDsTiEB3UtZ7LYHErknpk9iiZYamJsCHmTIpBHnzBkKyYq0KBo3gwA9ROJoRlV/mzMkrIyAoS1eEuy1eWOwrK8e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoNY9bDC; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erf8jM6CIqBt9qGRnroH67tWjbOZ0nnCeJeTP5QxeIYHUMe12E2L4973nP4Kaev1K5Vag6AHrcvxL3wCHSz2gvj9veh/ZL5jq067UOowA/yE8s8sKZcBzuAvEmTV4h+ZK3EwDvv9bIGh/NWGXx93F4XgyJiRXGPFlqqo+PX38oq9tE+XuQOFUTMXfS0Pdh/vsTJFKI2bhkw2D4ZmxFsHchIydkw065tSvLfFk8ZgVUQ2Wl6/PGu9OaoyhSRNYGm579GLm3Vkfidn5hklclSfX0VV/xZDFO7rxm7ftztl+4UmpcLf9t29j6dIu4nFIbg8QUImUcj2XXAWnbTorIQ6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWU+KWaDH9whVs/F/vTvxorGY2iy4KkKmz74wFVw3iQ=;
 b=uxbD8Yct+zf3ayuUWSF9DDKV3CBy4p9JXJyMD2S9xZHF/vx7izIpZSv93GuvOnVH7SY2NPQsCOXIG8d7ZEAiCG7Vrh3a2yQtVTQYiBATxe9+dm2dysW/FzCT2byZXM/0ESf8hh6mObGGisLcv9yK80/E3QeeuEsIfafg4e3cTxngyb1EN9zbzJLQqRUxMr7DKBMZ02Z33ekmmTczRj5oJQoUagn0Kb0pwl5kMSup+8TtxPdkflMTr/kdvnWhuexRVl6uw0Ou4tIhZfSD2GbuAVi4qj+TAFBjeTgNJEffB2hBz86Il389rV5+GKNmzzbtyw783Bg6d9CeadBsnvVHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWU+KWaDH9whVs/F/vTvxorGY2iy4KkKmz74wFVw3iQ=;
 b=aoNY9bDCNBorojt/YJxq6WOT56A8fgGYdQxEee5h49oh/a+kPyesp4kA9Z/Mcl2P1QsTl1fnjcNghUZkEP+XoyLg4l45JwJan4hbheH5GunPuK5yNmq+KF+fVEdO+sYXzQal25u0YkZTGM8larg+aiBHnZ0PbEPhq8L8UYmCj8s=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:58:27 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::9f) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.21 via Frontend Transport; Tue,
 9 Sep 2025 18:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 18:58:26 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:58:26 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v3 3/5] EDAC/amd64: Add support for AMD family 1Ah-based newer models
Date: Tue, 9 Sep 2025 18:53:12 +0000
Message-ID: <20250909185748.1621098-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909185748.1621098-1-avadhut.naik@amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3b31f7-ab15-4eae-0f74-08ddefd2dc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5odUCJuWPUHNFwl94rHe6kjzzjHJnzsf/AIeUF2PPV/7manwAyUcc1ouyv8?=
 =?us-ascii?Q?JkSIaAxKWbz17p5j4mq9Vs7tTlX5ZI5B6ae2vHRQ8MRX4trLqeYj6TthbwG8?=
 =?us-ascii?Q?JOpiWKyxNIRNQeibU0rr6dFPgLD1PXMDFwj3/0ebfM71VHlcxGEWjAEOnZwE?=
 =?us-ascii?Q?z5PbdgPe8zIBbiOjF34OS3+RC8eeQleudGOk0tgt94eAAScKEAmdfmhTw4Vz?=
 =?us-ascii?Q?pZU5AvVGdSSjJOC8w+2ZFYceCIq6X9pLEGMBESjokIUkmeJEWF60uT2V1jYW?=
 =?us-ascii?Q?HOqYda4bUWxDmETetKJVYQKNvFUfbUDAv2sb+y8nwEW+NabIPsTk46rsgZuW?=
 =?us-ascii?Q?2pl1IOs3Xg5c9vD//XcwxCWnsWa5CmDP7udFlq73IC2A0STHCIS19Qtg9MgK?=
 =?us-ascii?Q?LX15h/VIN+HvCASnXdognsCaZb2eY5MrPgql4g7GNd+vOoc5SqD+emvwj8r0?=
 =?us-ascii?Q?atVFy9svs9mgCnAhbhrjnrNdJZ/qQQO0IlGO008P718+kEUXpzD0Q7HyB/G/?=
 =?us-ascii?Q?6RCrqwrVYTI2zlemKbCosHUs++i752m9vkmCGU4DUi68aaft0hao9Ru8LPuT?=
 =?us-ascii?Q?OG3w9DGLq1KZn5yZbjHICsa0QvrPuEBvdmj0eqb87z64JzaJ1z2g9nr7uMRs?=
 =?us-ascii?Q?mCkfXBPrdAIg//FbmVQidaulByEXywMChZgcjDRMGNNWhwMhXx0rGDM4fzmp?=
 =?us-ascii?Q?KpHnvZ2p+t7CXpu/8KA47I6ordwc6OvPaFLcxNE7GU4S5hMtkaOFopVNDC9E?=
 =?us-ascii?Q?4tGwxtA2/JQxy9Z7gOcdV+dHMBnWLbZQ48u+/260BA4LnPhiPcNONwJKlRgW?=
 =?us-ascii?Q?41Ezj/YYMdLehZh9OxCTuvqViKYhvfXAynSUL5QdV1RO4XEeuYsTbJOs8IZD?=
 =?us-ascii?Q?c/jtteP+iwrL5MqSyyouLdKNgB8D+Gqqpvs5OLN10vP32Q40clJi91x2Y88F?=
 =?us-ascii?Q?Q761V6FsKwbs2RMAWYmN4io82cImPZ4gDjBmEOvH/tK+hpAi9/b+OVn415HJ?=
 =?us-ascii?Q?iw5/PT/F4IaWeIZIozMVoBiDp/Q2HYdjZrz5mEj+tpuVgzfuzXqDIgAt+q9+?=
 =?us-ascii?Q?uI7KbF/geazR57EIKQcbk7hzfDIHG4kHi9eNfoD8xlCXFo98Q7U5szFrgRo/?=
 =?us-ascii?Q?+t9pfGMPSh/c0ak95w+EGxJIr8kF5znX9sJWGILXX+Dt/DvVWMgzPx9yvptI?=
 =?us-ascii?Q?KqKRWEYRpYOAarLLct5MW+4kYx641V1E2YZ6ZLjib4E8sLJpTbvXp5F+ASZI?=
 =?us-ascii?Q?Gz4Mnyrnhs0kI379e70OtLZ3iQlQMZuMwuZWpdE94XlJxi0j7FJBvY1u3Edt?=
 =?us-ascii?Q?J2IR8+K4zKmF8XFIEG/DALtc0J8D5gbyWOeaBchjYLJ5wLrjslhG6sD3qOU5?=
 =?us-ascii?Q?2LhtZ0ivWya7p5mU77D+aZYkuJgA6G7A1D2InsCb6ptFBMzV7/xhcONZIoW/?=
 =?us-ascii?Q?DG8bwqVfVh/cNdckqwmbm9YtUPdBtO5NKCk/xDi2xCNgJEMJTgH9PGKqVgsC?=
 =?us-ascii?Q?ySs6ZAaxMuSUtmj+JL9qBV/6vwSHIPQG+HV3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:58:26.9260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3b31f7-ab15-4eae-0f74-08ddefd2dc01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
C0h-C7h.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
1. Remove extra tabs

Changes in v3:
1. Since ctl_name string is now assigned at runtime, group similar models
together.
---
 drivers/edac/amd64_edac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0fade110c3fb..804d3c4c3f14 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3895,6 +3895,16 @@ static int per_family_init(struct amd64_pvt *pvt)
 		case 0x40 ... 0x4f:
 			pvt->flags.zn_regs_v2   = 1;
 			break;
+		case 0x50 ... 0x57:
+		case 0xc0 ... 0xc7:
+			pvt->max_mcs            = 16;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0x90 ... 0x9f:
+		case 0xa0 ... 0xaf:
+			pvt->max_mcs            = 8;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
 		}
 		break;
 
-- 
2.43.0


