Return-Path: <linux-edac+bounces-3646-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DDA972A1
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28994401633
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B83293B44;
	Tue, 22 Apr 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LcSWyoJe"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD723290BDA
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339040; cv=fail; b=q+ieWXw9XoIAOeZ0hwxjnIKJpUeXT2olujP5BhvRTDsCi19DE49vNTQkkC1qWQ2/+0QhNXO6VHdjYX1gIP09SU68zyHEjNI1Q5fA7EfZAha21l6KcioS8ZoFvnYbmpV/KrpHPof5nkmTUVwWKsWGKd2DtJI9AidrnGytOBKYTZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339040; c=relaxed/simple;
	bh=v2HEiTvs6++KuR5pe+txlCPV39z/6Cicfrqcdi+KTYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKLDwFvP+ImasDdxvNeqK9FmLvWH2SOuWHluYOjM/Za44N5IGzi70BMiMuqC2SnMPelwCkf0wqa6/Tvy6ORBExCqlK+2KoSzgb/wE9k35+h1Uy30LdOpq1BXd+cqQbww9lTozEns5A2SzPNaR1EOrOjOKFmE+kNRfWnLE+Z4Sks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LcSWyoJe; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQcw+Kn507HQgWP6kjqZyqjesFPgEArM/xG28X1rwHKx+BJyVvoOFgHrsgut0sGyIVUc4QXIq1EQxgW7OIWYHpKaicv2H3AEM9BYaejHvvW0z7JcTzJ0IlUlkbRSLAg7+Kzw/rcLWopWAzrZ2j720FW7qP9h5mwHu2TrBejx5uCg+jzpLYKFXNjpMANCclFoWHNt/6zrapCmYqu4V+cFOPLBBoU45CEK3jXWYXPAUdbNLvwWZJBuVXxJcIMqN+RrmclMDDYY7tNqMMIp01+O4sMps0vJkKJaKXbCKqfqB0EGddWcjK0m5Ux+RN3fbWLe1rWKcmdIWUWVMq2meTVkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1AFj1HqAxzVXcZr7ByPof5NnZqndVmhAbgWnJre9mE=;
 b=LK3tUR8fa8ONnkrFEoBd9clwzkvnbTKhhIJLLSaQaldLCuOHUXSTEIc9kQGrKQp7Ch2xWGGQFWMG3xzKpjA4gb+IwGVBx7HHUdSSwY4saOFUfAiep6iltx4A/+Q1L/tU/3xJ3++sqAlckj73zWbuvXsoGvtsGYns69Fv5VVKNcujvgmLjTUAP/3DEQXILA46ge5VkHLFWPPNxu/Va4e8mgghdm9f/bbo6o6cnhJ+lmvPWMXaFJw8LYfDmRDTi9z3PFSqUpUaOixq9zPsQ80/nl+SLbiXAsDHmATrn66asW4kqsO2T2Z0FJJrSTfd4S/livQRZPsRvgh27CpBpmtaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1AFj1HqAxzVXcZr7ByPof5NnZqndVmhAbgWnJre9mE=;
 b=LcSWyoJedoZsfFtZLL3bkVXKp1A/li8bFIrr9G7u/Wl9+DNx7RIuaY9SCPYe4ThEf0k2MJZn768M/KdSUSVkXwF2FJ2x7MnYHzzQpuiwDV+Fg8qis25FvbnOjsasW0L+rLWpKV20kAojzJ7M2I97HzBsl4MI5R9BGAibnlXKPh0=
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Tue, 22 Apr 2025 16:23:55 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::31) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 16:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:23:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:23:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:23:51 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Apr 2025 11:23:50 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <linux-edac@vger.kernel.org>, <git-dev@amd.com>, <michal.simek@amd.com>
CC: <radhey.shyam.pandey@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH 0/6] Add support for Versal Xilsem edac
Date: Tue, 22 Apr 2025 21:53:41 +0530
Message-ID: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 19896c33-df65-49cf-8a1a-08dd81ba13a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NX4DfY8JiOrcnfAr9Vpr0OsduSRNEnpvdn6XkfgwapDbGYw8c8M331C7GI8C?=
 =?us-ascii?Q?oeh8rMzH0NK+tN+qqfZmN3Q1OjIVIUcqeY33ingw7Im4duEW8ovu3GT0mE+j?=
 =?us-ascii?Q?aGCWuOna113K8HINhe+25C01wt8ZS9CWQ96a3UHyWBdfkpTR2wbCzYe4L5Wa?=
 =?us-ascii?Q?YOBQb4N4c8BtXtW/O0Yerx2Z+v2wErE4+IOErozKZzpYr2lohvugx10jo5CE?=
 =?us-ascii?Q?OehoQuwlGESOcytk/e9OK4Pc6suTSmOXSM+gOgQpKS7SdbLT3HdbDsd8OfrE?=
 =?us-ascii?Q?NKYXTTWWu6jomfxUTk7DeAdBZpQd8acmDLSH1sAZc9e4VvAyiekAIla8DX9q?=
 =?us-ascii?Q?9H1rVGtWZ7I7j7scPc3YekwmM5JzbhSC8Ja6idQFCwjCWpq+7zpdzTj54wse?=
 =?us-ascii?Q?S2m8MhsrhmYuC2MXKEejGW3fpVVfOVpP83UmGp9Q006bZgCmy1GiIB5H1ykq?=
 =?us-ascii?Q?EtovvbCz6kaLI+MB94rQjvTe004eE3WjQnESUDZRUhHqEZ89b9tm2QaoQGsH?=
 =?us-ascii?Q?jAa2Pmcm0JtqqAUPe4mXYNvGEFcxzrBz5aLQxHz/6frCFtNvREH4h/zcnpvB?=
 =?us-ascii?Q?JEngZg2kL3bYzmHOdWLlTdQR+f7Yn4UNvarwDdgoianOAEKMuS6H/hOPb++k?=
 =?us-ascii?Q?/z75uplpD/ElqIhoJblzFSqV40jJIXVpfFyTYkzHBqP3ms9HWfBzORqH1MZb?=
 =?us-ascii?Q?zbW3ZJka4HkZ7KC9Dsk9whXv6pDbPAzyA1Ezpu/zbs6LdnRTr2Icj2BYu0dU?=
 =?us-ascii?Q?RwKhC4jNhYOO/f3AxfoDkU/xxpP8/+LPVmtG47sXCs2Hc3FRrn5PnYuIgdR0?=
 =?us-ascii?Q?0LAsuYu+oVRuHAKwS6eZQdPidD5wxPPMw4VMP4Mqh487F9T6HKOa+I0Dx4Y9?=
 =?us-ascii?Q?Bbg1GlbGTumhgVok7ECCbPCvzpweUZ5ldNunjzRIU8QA3NoENdGeRiQ+e3+5?=
 =?us-ascii?Q?QyrxmCBxFOGj3TSL4pekd2/gkq7rTPO0LAWgQsaT5Fi5a0nAkq6cz2T9U9NU?=
 =?us-ascii?Q?L+uft79nDBSxRuXkkCeAKFPDvCYLbKujebtaUlWQ0tA4IBhWuSkhi9AF92Id?=
 =?us-ascii?Q?zE2dYbYrHiLY+q+/dVgFEpzofZsFhr4sCqa429RFU/2pK603KoaP2q/j2o/J?=
 =?us-ascii?Q?EG13h66C4Hep0Cp1GmICTKbRW7R5jQU2iCWzttHKYrPRDJ7RX/JlCIoz5VuJ?=
 =?us-ascii?Q?QQ1NUHjz4ztSpY/aKKpmxpYNpq1/kkTy2b5bG4mi4cGWhnxI1sx+CpUO8kKK?=
 =?us-ascii?Q?apjNkRk7oWlZBlj+P9KBKzA/4HriOcoZB9jK6YS868PY8x+Z10Mz4XS7QtFV?=
 =?us-ascii?Q?R5zhFmleXHqaAavH2Dy6jaW0D6UKjA1rFBAgaZFhjrx1T0S7FF4isAkrWw6J?=
 =?us-ascii?Q?m1Fe4UiduBCtxn8cankxn++2MchGNRJ/koCVN3z+f8oUiKc0r7DwWpH1d0Uc?=
 =?us-ascii?Q?SSahn0I1jibjX/sJbt/le74sYhtoycpE8W9bADVH//lB7DYBimVvxSbXEUMb?=
 =?us-ascii?Q?EIJCQpL3vQ1K1bdDOnq11lb2QMyTvPt53Oe6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:23:54.9525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19896c33-df65-49cf-8a1a-08dd81ba13a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

Add sysfs interface for Xilsem scan operations
initialize, start, stop scan, error inject, read ECC and
configuration values. Handle correctable and uncorrectable
xilsem error events.

Rama devi Veggalam (6):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for XilSem
  Documentation: ABI: Add ABI doc for xilsem edac sysfs
  include: linux: firmware: Add XilSem error events
  firmware: xilinx: Add support for Xilsem scan operations
  edac: xilinx: Add EDAC support for Xilinx XilSem
  MAINTAINERS: Add maintainers fragment for XILSEM

 .../ABI/testing/sysfs-driver-xilsem-edac      |  104 ++
 .../edac/xlnx,versal-xilsem-edac.yaml         |   42 +
 MAINTAINERS                                   |    6 +
 drivers/edac/Kconfig                          |   16 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/xilinx_xilsem_edac.c             |  779 ++++++++++++
 drivers/firmware/xilinx/zynqmp.c              |   91 ++
 drivers/soc/xilinx/xlnx_event_manager.c       |    8 +-
 .../linux/firmware/xlnx-versal-error-events.h |  663 ++++++++++
 .../firmware/xlnx-versal-net-error-events.h   | 1125 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   29 +
 11 files changed, 2862 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c
 create mode 100644 include/linux/firmware/xlnx-versal-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-net-error-events.h

-- 
2.23.0


