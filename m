Return-Path: <linux-edac+bounces-4378-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EDB0924C
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F5F7A2524
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFA2FCFD0;
	Thu, 17 Jul 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHYYyM6W"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CE1F30CC;
	Thu, 17 Jul 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771398; cv=fail; b=XwSY7KTgTiKqwvfFqiF4TvygrwCTQLr4HipsurLxGeW9Zjbc+nOIYPvFCIoi6fhAyChI3UHSacaiTNr/4cDJBWfJ8W7l0G5+da/KTK7ub/uqItOKEOnDefcgqhp6zR/iZJtyHxxRW7aZKluHPKq2HYpnqmcF8krVoQUOAK7SOTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771398; c=relaxed/simple;
	bh=uyQHc1ap9VD39R7xbP1dWlm3c0kErXrMN8K/8ADi1rg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBwrX5vzgXeZSP2uW+sQHflC/hePxjQ+Pj2hFCjy3aLUMT3AcAmdARC+iAqXi+lNWn7zatTa7YSMLF1V62Bhg+aA4U0VKRvgDiJahgF/gIPhEvg0A1R3yJMiR0QBvi2Z8gxYdhRlVpKU1mFoLTaxPebMzf99+yXMO2qfzuvG/Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHYYyM6W; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF2MZWJ/zrxIsJ/oUHA9GghDa6gblywCa4MYXFlVBeCm919gAfFR2HpOal1uaaWg1VfpC/r2sAUgxSei+qng6KuaWmeYZR9Wu3rrLNT+AW8NB32qEPQ+5ke8zBMneVre2gejTc6A+GD2kVVMt436S7kynQri4+Ob6PyXQimwn1lrSgn6pCOVZ/Nn539TIxz0B/kvk06JobHTVuGT0Nf0ylQtofKcyN8L3bnoKNh9POZZsNOa/RyMHOFv+NpfZlJz0IuCznsZRa7KpOH1LpaWhOblOmuMHWvet6pBcO5KfYrc3Gaojz9CDlrVd5myWTw1m5l/K6Um7xt25BGY9bBB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFPGsuUJajMZ2dXTYfZwJ7mnp5haB/6Qe6qDLUdeurM=;
 b=SuuHPMxUY1hXi9fAgHykDv1DxZCqkdbWOgIbrIIcujf4pJmfgxj22msofW0taeqt8V+/eCIQUzoSZNpQ+TFUMdxkrqhDGpxn+pFg3vRlUFgoWs+7HD65DHuiNrKVFwfVYmz+8Ce1r14fjzuqOQDHcpjad0XnhLDDkHA+5K1MniTCGbl6+D833U7gNdr6lcQa4b/RFt7jHxC3RWdPBysxRMmBLbeFr9p9i745dWZnlFIIXWcpW9ueXlOutyi0a25NpSA7sDDzPLUv4S9F7ybYExStrmAireWva3VnQp+v3RCzkp447KBJk8RQiqRWik2hLnU8BmW6S4mttpK8OmoXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFPGsuUJajMZ2dXTYfZwJ7mnp5haB/6Qe6qDLUdeurM=;
 b=HHYYyM6W0Plo+rnFNoGRU0EX3Uc9A565sAiLaOC/D0rg2+KyAOADq9strqbjIO7+P+JFFwde1xKQrAyzpFmGilNXrbhPT98vS5gaim3CuqfenFv3U5TyZ6T0BbaSBxjThBa7txJJKPjKNIsfhb6Y/08D+QDh118e3RNEeJj8ehs=
Received: from MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Thu, 17 Jul
 2025 16:56:30 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::66) by MN2PR14CA0022.outlook.office365.com
 (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 16:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 16:56:29 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Jul 2025 11:56:28 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH 0/2] Incorporate DRAM address in EDAC messages
Date: Thu, 17 Jul 2025 16:48:41 +0000
Message-ID: <20250717165622.1162091-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1004b1-946a-4dc7-3fb0-08ddc552e076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWZaSTBjYkNocm43cms0eFZ2NXlvSDdjOW4wMS94THJOaG5jdlYvczU0TVND?=
 =?utf-8?B?UGNIMlBoQnQ3V1hzUkg1Q0c1aUs5NThjLzhBOGlHQWdqVmJXMHhVaHgvUVhG?=
 =?utf-8?B?MEVHK29QK1dLTUF5bnh4WWk0bUlNUWI5WjZPZzdpb0E5NEMyMnF0czVaTWZk?=
 =?utf-8?B?VkhvbjhuZFZydytvd2pIQWplUjIxbGplTlI1WkpPNUtSODZwVlBzcXZRTCtE?=
 =?utf-8?B?eWsvTDVjSGduUTNva2NaeXh1L1k1RGVZMHBNSCtnWUQ5bW1YQUdFb3A3dmJ4?=
 =?utf-8?B?UG55WEEvTlVjMGw5NDJlaVNPTVN0ZFE4N0NYY29tMXJXVEZ2dis3MFR4MG9j?=
 =?utf-8?B?YUpncURBUHV5KzRVNkg1TnoyaGM2eEFBQXRIRm1SRVV6KzNTaFYxLzBaL0N3?=
 =?utf-8?B?eTFBWHB3cjFPNE9pMUxWaElJM3BvQzBKdkRnNDg0aExhL3czOXpETUJGejFL?=
 =?utf-8?B?T3g5L3BYa2ZBRDVackZnZkpjOWxkb21ZbUZwMnlJTU9NT3RGaDZnVi9tSjFG?=
 =?utf-8?B?YVQ0MG15aTRGRGpiRW1BT0hzRXRFUTBja2FRSUt1emZDb2hGZTNvVi9POXgv?=
 =?utf-8?B?cXdLVW5TUW92YXppTXBuRmRrbzltTFI5U2VpMS9TVGZiUTZqbG04ZTFDUXND?=
 =?utf-8?B?MnVodSs0L2JuS2ZZczY2L1E0VkppekNJb21pcGtaL1ZQellDVGpmbUF1aXQr?=
 =?utf-8?B?QndvZGcrWGZzS1k1SFBGVEV0QU9aWUZ4Y0E1YVpNQXlqMXcyNDAveSt1R0Fy?=
 =?utf-8?B?QnUxQmNISXNKQlJTNzZQZHlUUUxOUVYwN0Rna3R1M0Q2eVhhaFRIVjkzTy9V?=
 =?utf-8?B?MnhsMTNtYjIyUHoyTHBERVZpa2pEUW5LeEJ5Umc1SFlqeWE3YjNYczJaSjNq?=
 =?utf-8?B?T1d3ajVYKzBCMzJDWS9rdVpocXNTV1VKZmR3N2lLR2JYemZITzd4enlVdnBY?=
 =?utf-8?B?Sy9GT3BoUkRKc3orSXVEREs4c3d3TktlcmxwTWxTREd5TWtSUzJPeDBqenFG?=
 =?utf-8?B?L3NqVkIzNCttQ1JDenN0bEJSbURPT1pDQUVsNnZpY1pxeHhlL0t5VjZ3aDZl?=
 =?utf-8?B?Tkkvc0FXZmtCUVdycjdIWWpCaGFwbU1LQUl1Tk9lY01wWGxQR0NVTDRNdVpm?=
 =?utf-8?B?WnhFcGhSc2M4bWkzQjBDZDFEVEZOdllkUUhNbzhQQmpTZVREZHFLNFZCMzla?=
 =?utf-8?B?elhkS0VCMUhmU21udlBBK25XaUcxSHF0NS93RUpiKzRiV3V5VVhQTTRWV0lt?=
 =?utf-8?B?WWg4MUdEanVwRzIvWmxtZ3I0UjdtUWIrcGtkZkUyY211ME02aFlZdkVtUjlG?=
 =?utf-8?B?TTROcmFpU1U0djZHc3NWODJzeEh3TlZXSXJBNURhWGhFeUdMVkpRQ2hTejk5?=
 =?utf-8?B?clFYSEdsZXBSc3Nib0JlbWF5ZmwvcUhES0RSYVE0eWR0N0luUDRrd09OWEpE?=
 =?utf-8?B?dXFER1I4MWtEVTZiUGE4cXVqM0dGT1RtNzlDQVVvTDhVMGs2UU96Z2hkaUJl?=
 =?utf-8?B?Sm9CVkJQVG9HUWl6RkNCTzVEVFU0ditPaGQzcU5sSUVkLzlhVXEwS1U5RUJ6?=
 =?utf-8?B?T0ZtY244WDJqTllGbmh6Q25SZWd3RnFrRXA5MnRCbU1uZ3ZkQXZtT1BJb0JG?=
 =?utf-8?B?MW5sOXQ1T0J3ckxEKzF6OFdLaDJaVnpaNllJYm1hUWhWT0VhcTRHeWc2c3JF?=
 =?utf-8?B?L2R0Qm9Fbk1Fd0dnMHV4Ly85Mi92b1lka2VKMXR1Q0VuS1FTcWk1bHRBNHlC?=
 =?utf-8?B?YnQ3dHZzUXZFOThUZklySEdJaDVQY1ByRlVtN3ZNYjlMNTlaUnJ6bXdHYlJJ?=
 =?utf-8?B?aENETTNjdS9HRTNObGFURytSd1h5UXVCMytXajZRZWpycUIxeFJyemQxNDZo?=
 =?utf-8?B?VkYrY24yUmxsNVN5SjhwZmp0RDJibFFyT0doazJLcmQyeVN0bnFjQkFtcy83?=
 =?utf-8?B?OGc0Vnp0TjA5a1dXVy8xSlkxTjcrTkxyMHVjcERSbmRNcjB3elZMaHM5Umt0?=
 =?utf-8?B?Z2NMU3hSRGVvbGlMZndGR2tJUHczcGQrWjUxREFNMkdWQUFKQWx5RWVpV2Ni?=
 =?utf-8?Q?N2Bq9F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:29.9652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1004b1-946a-4dc7-3fb0-08ddc552e076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

Currently, the amd64_edac module only provides UMC normalized and system
physical address when a DRAM ECC error occurs. DRAM Address is neither
logged nor exported through tracepoint.

Modern AMD SOCs provide UEFI PRM module that implements various address
translation PRM handlers. These PRM handlers can be leveraged to convert
UMC normalized address into DRAM address at runtime on occurence of a DRAM
ECC error. This translated DRAM address can then be logged and exported
through tracepoints. This set adds the required support to accomplish the
aforementioned.

The first patch adds support in the Address Transaltion Library to invoke
the appropriate PRM handler to perform the translation.

The second patch leverages the support added in the first patch to log
DRAM Address and export it through the RAS tracepoint on occurrence of a
DRAM ECC error.

Avadhut Naik (2):
  RAS/AMD/ATL: Translate UMC normalized address to DRAM address using
    PRM
  EDAC/amd64: Incorporate DRAM Address in EDAC message

 drivers/edac/amd64_edac.c      | 23 ++++++++++++++++++++++
 drivers/edac/amd64_edac.h      |  1 +
 drivers/ras/amd/atl/core.c     |  3 ++-
 drivers/ras/amd/atl/internal.h |  9 +++++++++
 drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
 drivers/ras/amd/atl/umc.c      | 12 ++++++++++++
 drivers/ras/ras.c              | 18 +++++++++++++++--
 include/linux/ras.h            | 19 +++++++++++++++++-
 8 files changed, 113 insertions(+), 8 deletions(-)


base-commit: 1fb0ddddf5d139089675b86702933cbca992b4d4
-- 
2.43.0


