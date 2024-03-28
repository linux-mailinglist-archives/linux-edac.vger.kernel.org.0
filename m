Return-Path: <linux-edac+bounces-842-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E817E8907E8
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 19:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C41C297A9
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E44130E46;
	Thu, 28 Mar 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n8ByxwyD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9B3BBC5;
	Thu, 28 Mar 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649094; cv=fail; b=Kx1EnxDlRkCp/ATgDp7rP9wVNfyvyBj648JnS2RuubZpKzlkPqEfUM5D1PVCKhajga9ELKNgCy9DrJo8QDOdgs1n+qK/GIunxi/kA1DyAlnps2z/t67y12/i6hRCsqnD83glBEOrr/3qQlDiB8r1RQVLhpp+VnOLG+FTQXDlwmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649094; c=relaxed/simple;
	bh=8vcZovj5rf1o9frm7NM4yIhboCvFN40VJp01/M+C7Hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1q9UMSxmtQnuiAA1DRM+gO0Qz/pdXiErZn7YamPURFYseU2rOFX0nxhLcBT30vRE4mnYuhqboL9/SkuHsrSRodPatEMqkIQIySuaurtAXYiM1TYQKEnp7jo0rFXpIiVnAnuwzAYSWrAkHfv5wJKqpX5Htss6NihfYVOlgOY8io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n8ByxwyD; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsaAkl8wvEgW1g/LFOkPxCzd4VAbjL1uJMFvy1KSFi/GH8Ut3rcEURPrWcHIltbdBurSGXF/5+W2YkAPF8HmdFyWqWAVVCTD9c243yC0FvtEq3o4tI1XSC+iNa3OSBzC3DFYQ8KZMjVASvgumK6fdx0EzhjQq4lhbW1Nqyp6LDDbD+jPBbeLycL913UKkkloIZuSpKRagZ2W3F6GP/sk8INoUXa5bO6kHkNV8gvF9ed2bTJBtMSCqK/XNLt/Ak3XQh+F0Tq+/H1fXbVoa/BMAfKcrr/XYLol315itgPDH7wSR/vVtvYXx7RzChFPCecOtVPcEJt8b86ixCN7vGPY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkdzhdPl3Jyd3qJuRZOrJ1KNOdLld/w2cYg7j/NkYvY=;
 b=fmf5BgqN5ZqI5NPTtsO7xSfZ5GWbUpiJyxOT8mcqNhT4m9HtjcYdps9a5w2w6HD+lcTVmYhae/q3YyeIOFoQ6nw96HmSmbDHtPyGzM331T3TRIC8MKegxelur2PtOQn26PbKZyuD+FMr9QsRakDUxyq21QbgO7jrUAyIFboyuB8cFtW3YQkixJh1xjhPtmQLJT2rS0TLJWdOLVnf0Yyl/uwIssTca1hEbXyhIaDtZaskQiQEexs0P3/lSmwZfLutv/Al9qU/uob554352mq+HUpmlCwNmWO3lM9kik76QIBrL1iNfs5Fkxb9lEMQFbAjWf56RPHSBCFYSr978yJj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkdzhdPl3Jyd3qJuRZOrJ1KNOdLld/w2cYg7j/NkYvY=;
 b=n8ByxwyDbbqEKU9DurxOskq0AgqHazqnqYQvXaoEy6zlN/OzjDQNokfq4Ed37UDO2A0i4NaGUL0ZgDA+p0UfnGnGX+MIqfNMtBlz+G+2nwgZF6EGo8bTlPjwzFTJOIqMmD3fzIPX7VQ5I57N7Gjt6ZjUVAl4QT8xCI9meZXAM4o=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 18:04:47 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::88) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 18:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 18:04:47 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 13:04:45 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v5 0/2] Update mce_record tracepoint
Date: Thu, 28 Mar 2024 13:04:33 -0500
Message-ID: <20240328180435.435076-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1c51a1-f65e-4ef3-e0d6-08dc4f518e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5VuIm86OqztppPuE3Q1v0BsaNN4YLUDCpTwN0WwXAMkGI+9Hiu7s3nNKrSWERJHqQATpFu+Fg1t/vok8Clhpuc0sEVXbO/O0xOZ26QUp2TK0OTEDOmbr+vCN/7+EF+vdy03kFgQsozdspb4PUdY+0/WvHL2WogjALwJhhoVzhTT9HW79Kp2bB/GPYUTJ26pirkFSrWC3aErD+2HGZ6lvmmX8Ac9gkA0ixmUQAU69f1M8TGVBnFoXkec/svIpkdZRl4IGj8vR14F5UqZMytjBRveKkfVkL1rqEnbrUC2DF3nHrpscbCmXg6Kaqnzv6vc0ZD3bksGUnHLjumhVTKHxYovZS0D67YGRq3wtHCxGq4RXozkOFHqccDboooVJiZ6rTkIGshDEJlxkFKBo15VmYfYEWvC1xJnikO39XKEXxl9Tu5rD6eWmrcNrBfn8eKLvhvLfiaD5jHF4AGzsU3cb4RMPvxhsy34G4+6kn3w6sXs2ZtJ5rWhxDsZvvRVDDngiyVWzNtv0tbu9cX2TWN3buoOT/o0G6FeQghgDcKBdiTcHkr8s1wcqXhox38aCavBKYEzT5QoZs196GfesZteXB/b6J6C1uhsm4s9ozmoQlsz2Ji1Mkm1ppsc6asEuCZrnM0yfw316hct0ay1eIXzjU6Zps71aNce+dSCZNgYfA1W2e95HWA/0b76ro41H1fsqchMdiLMp5nPI9L2OZOyPcxI+qySYDue1EUe02v0cdQ/GSv15ULzS2l3kwhWDOCWd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:04:47.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1c51a1-f65e-4ef3-e0d6-08dc4f518e26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

This patchset updates the mce_record tracepoint so that the recently added
fields of struct mce are exported through it to userspace.

The first patch adds PPIN (Protected Processor Inventory Number) field to
the tracepoint.

The second patch adds the microcode field (Microcode Revision) to the
tracepoint.

Changes in v2:
 - Export microcode field (Microcode Revision) through the tracepoiont in
   addition to PPIN.

Changes in v3:
 - Change format specifier for microcode revision from %u to %x
 - Fix tab alignments
 - Add Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Changes in v4:
 - Update commit messages to reflect the reason for the fields being
   added to the tracepoint.
 - Add comment to explicitly state the type of information that should
   be added to the tracepoint.
 - Add Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Changes in v5:
 - Changed "MICROCODE REVISION" to just "MICROCODE".
 - Changed words which are not acronyms from ALL CAPS to no caps.
 - Added Reviewed-by: Tony Luck <tony.luck@intel.com>

[NOTE:

 - Since only caps of words which are not acronyms have been changed in
   this version and the word "REVISION" has been removed i.e. changes are
   very minor, have retained the the below tags received for previous
   versions:
    Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
    Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Reviewed-by: Tony Luck <tony.luck@intel.com>]

Avadhut Naik (2):
  tracing: Include PPIN in mce_record tracepoint
  tracing: Include Microcode Revision in mce_record tracepoint

 include/trace/events/mce.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


base-commit: 9699768066a9b12db247d5ee9276cf298b67528d
-- 
2.34.1


