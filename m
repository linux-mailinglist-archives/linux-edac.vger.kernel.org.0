Return-Path: <linux-edac+bounces-843-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C68907EB
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 19:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A02228424A
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F2132484;
	Thu, 28 Mar 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bvFZ9lOD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D112F391;
	Thu, 28 Mar 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649112; cv=fail; b=s3SMMKsR+1qvlh9ifzaZr/fRVhleD0gC2HKyY55rdsJ4GeRGs8iL61GvPa6kJbLq/4po0TVbCX74znsKoJ0IXicOaLHd2Mf8f4dADrfV/bNBrbLWgyjYUEiLr4tTmT4Sdp7KNfB4XGtiK6UA/0D33U77t6vBIAqI8YSNEU2y5yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649112; c=relaxed/simple;
	bh=JNhYmKBUnMoBrfohVEozKaFOpmhMZ1PUZVhcCQUQBmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt90oYvyLundrJ1KV1dDBn+9/JVyJBmrM2d8Cw0tJ1uy0iRR0tMJd+wh9sqysdcIT6XXw6VO8BfVXaEIMlnBpXsZRRALQ4LM24icCR9vyviXc/24eXWIy8Qqnh/FVHbTgniKcNu4NUIAikr5Qib0fV1dAz+eUJkBt0kBzWaxql0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bvFZ9lOD; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE0mrxAcRERhISgvJH7Hy/LC4cK0XNejgkLG3bvmww/sy4JZkkjBMjmfB+Mzxit2Dro8nO2mv6RGrOf8+FUqjVqNDW2e5wUpEfjraMtTg5mgAhppmXa2uGyKkC1HSxu7f4b5ZIcN5APUf6HMatR3NV4JgZsJKgjquHWQ/f3VUJ4WY3guYlweIox08SnsKnd0+Vxr0wxv9snwshDCultzTxtqZZz7vVodFMqaBbV3fKgzzz0ZWgF8tTaVJW0Va5vjfg+A7PPMFTOFSktAtD06wgJaB5Ev+eGWFGbennc7n0KDv1xYfkW8f1ZiS11nC8UqCl07XNYAjpnLaeXPuDlFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM3RVu/Yq+xz+WubqeZNExCSlS0NGkq4s08Xy+zSjsA=;
 b=XujRBn8n8GBwCTAm1MkMjacPVrKZR5ujBpCU9ModET1ORlxAA70sHtvOD2VHCuSyakY2qvWQlzQbHRMIMQEtB4lrfTZXjwQ55RW7KqwLZB7MAOOWOCaupfuhGZMlP4yL/RjJxOzoeHfo8CuYlVmbhjVu8BFB8y1n86TNABZpQWfWVc2mVVTA3+aFTHXX5OMkOfKSC9CqWWC4HtIpJNErbv9QoHy7iAcELJTRqPa/PVID2NQXmiSBoN0/NU57xeF84OMM9nJQ54ZU+F8STdKpnT7NpKCUA3YYfxriieIRnOnIUnazv7aVl1jgONRI9CbwzDGXZXb0ysFWmwoHWMdfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM3RVu/Yq+xz+WubqeZNExCSlS0NGkq4s08Xy+zSjsA=;
 b=bvFZ9lODC2Xri8OlhCYgD0tP4Qv3XXNUXXp80H2UVK3ToICdYcS7lzvJDFqYxeARotza4650V1gcLJZCmTVoiSf5E1g5SxaULnU5bdQNerqiWDwxlUYkO5mN/2deCbA2N8fadW2Q21OPkImQaOhj9UC+Y6VtnUgGfi/zAqy+s3w=
Received: from CYXPR02CA0031.namprd02.prod.outlook.com (2603:10b6:930:cc::10)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 18:04:58 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::cb) by CYXPR02CA0031.outlook.office365.com
 (2603:10b6:930:cc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39 via Frontend
 Transport; Thu, 28 Mar 2024 18:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 18:04:57 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 13:04:56 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v5 1/2] tracing: Include PPIN in mce_record tracepoint
Date: Thu, 28 Mar 2024 13:04:34 -0500
Message-ID: <20240328180435.435076-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328180435.435076-1-avadhut.naik@amd.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5c80bd-dd6a-4d27-0429-08dc4f519441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CiJrTZbVcM4qAqidwVi92hZL6EEpFr30eEM8BRIWE1umxCT4/dmyvvp9oBXfL2O+UJY5/nXRjJLglqS65Ppqc05bSur7U0LABmSqiyL6upZngw1dmL4TthNbGdlIyZKJEFdDE+B/wCRmbDWPlCFVcvNpHDOd9X/boNUWrOroci4qtol9Vyz1WZa3DwvFj7W6Ei7l6aRlk+xZQDLvZLqXXD5adPxFQe0hAYX//5DfZT17IbHZJ3KJvar0JNqdUYG58srxo8d3VcCQ17/MCDuZ3e5+zl8O9Lzg0B/Fy5TLcndzQ5rrhDIgD0y7VAHktRsRmJQUNfwIo8vM7y5jy78PAn71T+4E6fq78xN6XVKh45ZPJkP8qIYYKHritGz2sqkYxM2+QQ3XIh588w+MTOTd1e9s/KT0l1lJ1NoNGRxCZeUe7YBxNTM7gNIWqkqAuEgQlWUOcUcXXHd9qaQ8VU+DWtafDrZGeR8CrnslKhfZKQnpPOBmd5RpWlVINp2A0LM7acr/cxOSx3eBFd3tZwpiELv00xhaF82CQqwrQQ6V3uWOlDmjfvOtg4qHHVmry2W4Qe4gxUlhk+QbvnPAlpq/oh+bU9AUKZrM81eJ+ofipyodqffNX7aezHqwh0q2Z2ILtnoxiWZOJChWIwJmKqdk6B4baHGKy1XKM4mudtRSh5QHw6JeANtQlLsmoPEscZVs95Ar9k4waA8OryXlt1nRA+jJWKMe79Z62kEPwU5FCuEa8u5iGrlZQiYGvnKdDdaz
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:04:57.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5c80bd-dd6a-4d27-0429-08dc4f519441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

Machine Check Error information from struct mce is exported to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of struct mce is not exported through the tracepoint.

Export PPIN through the tracepoint as it provides a unique identifier for
the system (or socket in case of multi-socket systems) on which the MCE
has been received.

Additionally, also change words which are not acronyms from uppercase
(ALL CAPS) to lowercase in tracepoint's output.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/mce.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..2e339ac9d706 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -9,6 +9,14 @@
 #include <linux/tracepoint.h>
 #include <asm/mce.h>
 
+/*
+ * MCE Event Record.
+ *
+ * Only very relevant and transient information which cannot be
+ * gathered from a system by any other means or which can only be
+ * acquired arduously should be added to this record.
+ */
+
 TRACE_EVENT(mce_record,
 
 	TP_PROTO(struct mce *m),
@@ -25,6 +33,7 @@ TRACE_EVENT(mce_record,
 		__field(	u64,		ipid		)
 		__field(	u64,		ip		)
 		__field(	u64,		tsc		)
+		__field(	u64,		ppin		)
 		__field(	u64,		walltime	)
 		__field(	u32,		cpu		)
 		__field(	u32,		cpuid		)
@@ -45,6 +54,7 @@ TRACE_EVENT(mce_record,
 		__entry->ipid		= m->ipid;
 		__entry->ip		= m->ip;
 		__entry->tsc		= m->tsc;
+		__entry->ppin		= m->ppin;
 		__entry->walltime	= m->time;
 		__entry->cpu		= m->extcpu;
 		__entry->cpuid		= m->cpuid;
@@ -55,7 +65,7 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -63,6 +73,7 @@ TRACE_EVENT(mce_record,
 		__entry->addr, __entry->misc, __entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
+		__entry->ppin,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-- 
2.34.1


