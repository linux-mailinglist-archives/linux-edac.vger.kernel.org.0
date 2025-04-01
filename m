Return-Path: <linux-edac+bounces-3452-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173DA783A0
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 22:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC9F3AD49B
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E29221B908;
	Tue,  1 Apr 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Butpq/X0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B32135D0;
	Tue,  1 Apr 2025 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540570; cv=fail; b=mfTw9Bkf44rgY9MhhjEXxm7oJ4kzyIiuGtlz+vvtFrvKxZHbDRzJ2UkJWAgWcocZc033pQI9aewkjqkthYSgCECOywM5juI3F499JeWVrREk7cFnapARPKbfdF5ueshrGn3CfYtM6Swfe6CWdfjyI7Tud8ekiR/FH78pzE1adYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540570; c=relaxed/simple;
	bh=e7rE6x4juQdjGa6N4NU2b0eSzvq4TSqRnInVxon7Thw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=BAH//5rsaDtnOgWYPNJlPVF0CEYCj0hYKfHBpmOfWjOXOs6E33jDl0SdptDqTJrIhOihoFj+OUoVC+SH5iLmgEAAPyNzF0vjewC8V+HDjhyJ2XADkWZ/ZNu5irpPvLqM3Qw00fRJ9LiQwPR9pSSiVqIkom3xSTMBKn9PhYrlIEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Butpq/X0; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/GnB2GbLo4bSgS8hSpPbK/Q99Bc/h8Iec3j7h45x/fDpBjd7/fgv20Hq1Dzhz4VjwV/jX+a5MTlMqF2f/ncC9aUnFwgp9Q7arOj9eBh6Fwmj9WE2RspoyRI0mPu3RDCMYTX9bC7Ay+Lpjv7utT1jMfB7wFMMUAtlfK4ltLy4rjv3zjx84HXJvDZrtZey5MZFnfa3NTqYweq/49fL5wdpG3d5c+L5H9THorFBBLyhlD9JVPxKLr3VK11dMOz5vEU4GC8skrfhMLotR77dbz5mdANrG7s/9D+K3Jo1RRBkE2mZqle1NKpSCWo9W/dt3IkCz3jbRNlfPx0PXImgyGXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24gNanj18222vAq3qRKy3YvicYj4gigYdKifreRcxco=;
 b=wzVOzKqI5g1GRdrI7ZSr5l6dGWTNR7/CRI4LBkvYPJqNeKMfKATTo2mboowFQelbff6hptMDuC4l4+J7fw3hizMkrcwH2/yixVwrG/OKgtQ4g8oY5b+M3qmYY1Xhw99R383w/yKIFgEz1e8/gnxdyvlzND5cYwZkhm0yaoRq12DA5dWRu8BkrVe9Cb3K2VAYuim11JKx1v998nBoA7VB4wXigok9fPf8M5rVz6y7PKU8jtiHN3UTtrZNWJEFQqGaJL968uYOYIlQ1zw1VAXkrdZQzmSBy8laD7OxPOUvoS8T7XgsEhp/vTF6VbSKnZvqr1G5bW6j7nfUJIT28Xay9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24gNanj18222vAq3qRKy3YvicYj4gigYdKifreRcxco=;
 b=Butpq/X09d3Z5KwbBpbODEgzqbH9+f0oFdLFZ5TmnbEjq7FWck+ytJOPCYV8BXva27k7/HYmWvNNm2hQuGGGHnugUzoUmY/H4UIEakz6L4rzgKUnv9N+Wm4/u3RmF8K4xpKOWkLLKgXDI4Pf2h8FpGjzSH9hTisbhh+9AAHCWXg=
Received: from SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::20)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Tue, 1 Apr
 2025 20:49:25 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::a2) by SN7P222CA0024.outlook.office365.com
 (2603:10b6:806:124::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Tue,
 1 Apr 2025 20:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 20:49:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:49:21 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] MI300A ATL and FMPM fixes
Date: Tue, 1 Apr 2025 20:48:59 +0000
Message-ID: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADtR7GcC/x3MywrCQAyF4VcpWRscexHrq4iLdJKxs+hMSUQKp
 e9udPnDOd8OJprF4N7soPLJlmvxuJwaiDOVl2Bmb2hDO4Qu3DDlDdOyLijbWwlVYlU2ZOl77sb
 hyiODn1cVX/7hx9N7IhOclEqcf5ySnYUpYqqKxSk4ji8AzFr+jAAAAA==
X-Change-ID: 20250308-fix-fmpm-extra-records-de44d3956d9d
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Muralidhara M K
	<muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-419e3
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4ba885-6b81-4dde-0c3d-08dd715eafc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEprQVJUejA0OER6RGQ4WFVtSE5zalBuaU5wMDg1aXlkY3NJUklLSTVGSk1S?=
 =?utf-8?B?UFB0enJ6REJnUkl5QkxIUUxiTFZ2ZGlHRjdFVTgzbEdlN0FLMW8wbkpwM1dL?=
 =?utf-8?B?U1c0dzNBc2JEN3l3K3l4SUprYUJOZFBzUVJsako4ZUlYclN2WnFyVFBwb1ZK?=
 =?utf-8?B?ODNSQ1pGRmdBR3BYRCtZMXZ0ZU1HcTRRb0xTWTg0blRQOStzZzBBaDlyak9q?=
 =?utf-8?B?Z2I4dkJFWnNSZWkyOXllN2dsVk9HRUhCcXFESitCeURQUmRaZWppMnVNQnB5?=
 =?utf-8?B?U21MaElKYXZjVXNpaE9hSjhraExMRUt6OEs1U2Y3U1UxSWJET0tkV2FQM05t?=
 =?utf-8?B?dTREV294Y0U3TlU4WU9aWkVRYUVJdlRiN0tmRDBMamxWdDNocHVpcE1nVXc4?=
 =?utf-8?B?NC9aWFFEckU3ZFVEUVg4Qk8wQ0JORHAxeVpaRnBkMHNoOE1RNlZsQXhhdE5Q?=
 =?utf-8?B?M0ovUE8yU1RCTUc1YTltNW1aOTVzVndYVHlVTXhMbWVVemlEVlFTN2Q2TTZC?=
 =?utf-8?B?WGptWmVLKzI0THl5SkZnR05ZTDYwYjZ5cXovM25KN1NEeE52cGxOOThTMldm?=
 =?utf-8?B?cjhhM2NCaWdhR3FEL28yRzJQSW9LR3E3NkJvWFZ4YW1lOFlCZ1hmQUhPYVhi?=
 =?utf-8?B?R1g3Z0Y3M2oraFJFOGEzUlF6aWRSVCtRUHpzazZzR1dQSG85dFI2U3ZIMk1k?=
 =?utf-8?B?V1RZWHNwNkYzaG9laFdnRXFLT2ZhZXB6REhtRUMyVUcvaUducDFFNDBFOFVO?=
 =?utf-8?B?T2Q5dVRqYVBsaHpRK3ovK0NlTGd3bitIVG1JdzhGdUg5L1FWano5RlprVHd3?=
 =?utf-8?B?TUx1bE9EZDRZaGFGL0FJMkc2L010aVdUYUZLYTdoQUM2aVdGc3U4V3VZL2hZ?=
 =?utf-8?B?bFJlWWRUdlJYZDdKQ0ZUSHpsaEorZ3VpNjFUaGJIeUdkOWRxR3pCVXZvRDRL?=
 =?utf-8?B?TjZhWVR3YnlJMWpSYXlMSGhBakFVMiswaktrazlrMFMyME9sVHJKbXlYb0g3?=
 =?utf-8?B?eHpIWlZ6dkJreVJzY2JzMkQvN01mZzZlMVR3WHlWblU5QndkRFMzRHduZy9h?=
 =?utf-8?B?NmxFd0hPc25XTE8zMklmRzhqZVZWNG50UXJWUXJ0VDNvN1ArSnNmWlp6T2ha?=
 =?utf-8?B?VlEvcExoTjBpQ0pacEtRQ2FyUTVKWUdsRkVndjI2V1g1L2xoTlk4T2xTbjZB?=
 =?utf-8?B?azFCOTNEaWs2U1FRZm5FWHQ3ZC8xTmlXckJHTkd3TStuaStwQS8vckp2Z0Yx?=
 =?utf-8?B?aWM2N0RnTnBUN3J0S0lOVTh1RkdrbHZ2SUhISWt1YzNJbDA3WUlCYUYxei9j?=
 =?utf-8?B?Qmp4KzdmV1hOSm1mWGN2Z0ZUL3JoaGtDR0R0NlVtZngrYnphOFZUbHZXY0RI?=
 =?utf-8?B?M0hVTFB5TDdOeEY1VjZFWVlPMlBqeXRLVnU4V0hCTnFNR1NVd3lxZUN2RmxD?=
 =?utf-8?B?NjJTM3VmLzVRSWJ5eVBhb1FhK2JzR2RXaGEzVzlTVlAyRGJOcmlRWXQrODRm?=
 =?utf-8?B?K1NicDA1bS9qMnd6NkVCcmNVWmVEMy9DdkFrWE9GQ2dkbXpPYjd1aTJPTGR4?=
 =?utf-8?B?VVkwTVU3T253T2xlWFF0RG96Ty9VdGxEbkQ3VFlUaGlSSXVoMkZ4OEFRWEhT?=
 =?utf-8?B?dXRWMGdSNld2V054aThUd2tCQStEWWphdUpDVldpNUd1RG9Hd0V3S3hUbUdD?=
 =?utf-8?B?eS9CT3VqbXBxUmdBYStueFdOMHBPUEYrQllISUhSOHY4dHBTNUxta21tTEtG?=
 =?utf-8?B?eU1PbG5rRlVRZkpqY0FaSG9DRGE1WkUrSlFibVY1Yk1qMmQ5NzRGNHc2L0V6?=
 =?utf-8?B?U3JTOGtlWngwVGlrbjRhY1QycXUzWkd5b1VxTjVpb0sybXFPR1pnOWFXOWdp?=
 =?utf-8?B?K3hQdUdieFBzRE13d2M0b2RoeVpOaCtPVEU3QmY5Q2FKNUl3R3B4djlzQjNX?=
 =?utf-8?B?ZnZNOEc4aHdxVE40OW5TeTk3YXR0Zy90SlpoRDJvb0J1Qnk3bGNYdUY2NVlY?=
 =?utf-8?B?Yk1FQlZwSVBYRm9mZnJPWlRiMUlKZFVYQW1ZZEN5MTFCZ1BpTllVMnc2VS95?=
 =?utf-8?Q?I/BkHu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:49:24.5750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4ba885-6b81-4dde-0c3d-08dd715eafc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

Hi all,

This set addresses two issues in the current MI300A solution.

Patch 1:
The row retirement flow is updated to iterate over an additional bit.
Without this, only half of the affected addresses are calculated.

Patch 2:
The record keeping flow is updated to match only on unique address bits
of interest. Without this, multiple records can be created for the same
event. For example, for row retirement, there will be a record that
includes column bit 0, another record for column bit 1, etc., even
though these are part of the same row retirement event.

Thanks,
Yazen
 

---
Yazen Ghannam (2):
      RAS/AMD/ATL: Include row[13] bit in row retirement
      RAS/AMD/{ATL,FMPM}: Get masked address

 drivers/ras/amd/atl/umc.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/ras/amd/fmpm.c    |  2 +-
 include/linux/ras.h       |  2 ++
 3 files changed, 35 insertions(+), 2 deletions(-)
---
base-commit: ff719e243db5de2ca595bf4e2ab6ad530a08f378
change-id: 20250308-fix-fmpm-extra-records-de44d3956d9d


