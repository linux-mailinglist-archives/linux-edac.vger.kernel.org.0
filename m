Return-Path: <linux-edac+bounces-1100-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3955C8CD9D6
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1711C21288
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9782891;
	Thu, 23 May 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fCVaVZJY"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90767D417;
	Thu, 23 May 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488835; cv=fail; b=g1Py10tge00jfPLIa9w2c5ESUk6ypgQRIkym4RE6GkPbg5JD769nOY0PM+XA9+FnITZPo91boujYJiC8r+Psua2zjp8la/gbVLK4Cf6fmMW7+gFbwnrpTs7UZaiFZ27FbTpZS+L6gYuowWC/SKgPIKOzLCBqzSm8tfjYcZSV6PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488835; c=relaxed/simple;
	bh=PgkbVHPBlScz9BhoWsFj8e/KoHp/yjzfVPXFcSbqXpM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gbrPj6eJuap3sbil8+qLKtsKa7IZGH7W/yHKtzTw6DqOIVtY3AZ1AKsoj47Lh0gu626PEiV+igvLv8Nka8HpD5iqsBV3u5EAVJadQD4hK+r6FDruTs5Qo2Mcjp5RK9T7t1kp1wYkNzHWFqFHRRXlUPmnvcRxuiS0g000n+GJcb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fCVaVZJY; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSpdw6VvMI1RxW0ecqMPF7WHW1P2u9Lq5motOGqWar+RQyoAF7AJjG1hzezyAQU8frp9eS0lDWoCUXFKvd73ErXnb0qZ4aQytOr/IhX3zxu9ZvDABCZOQlxGk9QNXBZrC5XH+KIaA6IjO9IofpxItJKzxjNiK41cO8nlB3AnLgK+ipbRCuHGUVFwpdJD8oUyLKx3rTx03P3rkeFkiBZrLms9IMU4RyKCGvYYjG9rKJ0ISWJ2a9xiz1pnIguw++jiz/yIWotdRFAAzccmPTJctsy8fl3MQ0cpvMbS0341e2/9QoSIIIfKtOPLWv+IEHZeV3/LaNy1ovnzSGS/JuLYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEPEXky4v++60/0WGIMFITbM1JTL7iICDg0nKF+p35U=;
 b=B4IUwQYstfj+CyctLCyN3IXXcYUSgXFrM4s2l4hjclsH+WvrWQ+rGCD37WU98mkwxNnqbGdBS56H4kueoatmoaFfUlgaokItkFM68k0mVpL5HLPlL1Cy/DSVoFuNZTKHeqqh4MylfQusTXwiKqtpj7xNYQfhHXIP+IXBSf+x/RpzDOKv/CU0ESI1n+cVoCEFAURfcOJ+zUi/ceT6Rbv2oUedyDCmjo/J6s4DFncWZoyaC845NE+FGxTXdgobPdNEJaA1l+FnIJ+fXEvGHwN4e3CenAA+5jVX3/QhUJMcvAG2xEDhGui70yfbCtjgD8xifHtRT4k1lNpK4mwRQXp5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEPEXky4v++60/0WGIMFITbM1JTL7iICDg0nKF+p35U=;
 b=fCVaVZJYbETHz50oNJxyj2KNX86ELwDWoN0nU4FutL75SD5BV4vEDCrIAYSCyiogoeoKzVXhY6/A2I98myyQIjRBQn+aSGnEZZaOyX6yU6emJGv3EotkyXISqAvq2r94BmsUMmVmOPWz/21b2ULtsaj5r4nVkGoMuE7AxWmv/8o=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 18:27:10 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::98) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.33 via Frontend
 Transport; Thu, 23 May 2024 18:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:09 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:08 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 0/8] Enhance AMD SMN Error Checking
Date: Thu, 23 May 2024 13:26:51 -0500
Message-ID: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGuKT2YC/3WOuw6DMAxFfwV5blAekJJO/Y+qQ0oMZEiokgqVI
 v69DkunLpau5XOuN8iYPGa4VBskXHz2c6SgThX0k40jMu8og+Sy4UoaNvg3yyGyh3UsIQ2JaJz
 rB2U6A4Q9E9LNobzdKU8+v+a0Hg2LKNsiU7wVukgVrxvRnqXQTLDVfjDWIxVHG642uLqfAxTLI
 n+kFsTSMx2RRgv+H9z3/Qu/RlSh4gAAAA==
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 258d8799-f0a7-4308-8e9e-08dc7b55f506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVhaMVQrbGxHQ01YL2VnVlZQNDM2RC80SFlCdHRGdkQ1d09zMkZ2L3FhMHFV?=
 =?utf-8?B?eWE3S0hRbkdLd0JYdHRLWEdpaUl3NS83Ymxsa1J1Y3VJMzg1OFFGMWVjWXFQ?=
 =?utf-8?B?RkZSQjR4SmRwK3h2aU9sOUIyUWlzZ2xGMkZlSld0QlRKcGJITkU1MGRMelVp?=
 =?utf-8?B?WTZ5Z3pkV0JCRUVFazY2TDZZMjc3WWMxSlhlRGlYQjBvZXhlOGFPUG5QOGVp?=
 =?utf-8?B?Ym9NWHh3WWJkajNQT0xqUVRpeEZ5WlMvb3RCQ0hZRVZ0S3FXVjR0QjZrcDJ3?=
 =?utf-8?B?MmFTOUxVeWZveTdodHpTU1crWHZhcFl4YlZZaVVtODZwQTAzKzcwdExoQ1Fz?=
 =?utf-8?B?azZydllqUURNQmp2b1VCZ2Y0Tkg1bnVpV3JHQUZDbzNlcGtNckQvRnNlS1po?=
 =?utf-8?B?QlBTeVRPclYrOWJRaklZSnkzYXU3WnM0RVh4Qm9zeVpzSnBMVkNPMy9nbkpv?=
 =?utf-8?B?Z2VEVWZJN2k5bHp0Wk1MbTJRTjVyRUw1cHFXd3ZZYk4wUXpnd3doVlFYNWVD?=
 =?utf-8?B?a0s5Nmg2S1hkTERCUmJ2ZmNDQ3U4TlJiNFVSeDZGMkpYbUtRWVo5MjNaSUhs?=
 =?utf-8?B?NU1TSU5XYjkvVjFvWmlTM2FiaC80NmhKbWVFZm1mblMreSt4VGc5U3BYQ3Ju?=
 =?utf-8?B?bzZtS2k3UWl2M2tNRm9TblV1T3A0UXowd21DeHB6dUc0RUdXN0JBWXBCZnB5?=
 =?utf-8?B?ZWtJRW53YjNHYmZOSllRd1BGNjFOUWN0ZnZRelEzdXJaUnRDcHFVVTQxTjU4?=
 =?utf-8?B?MjkxQlFvMHVtMVh2eE0yNHdPUnJtR21kdXd1RWNKa0RIa29STzNVbkpvYy96?=
 =?utf-8?B?ZjQrbUI2Q0c2TUdjc1NLRHNHeHBiQ0M5OUw5NE5LYnBVM1NiMXZHTVNrYTR3?=
 =?utf-8?B?Z2lCUkF6UXliQXVTS3RrWVRmYUV5OU1PcWZxTWtTWHRNck90cGkxeGYyZ093?=
 =?utf-8?B?R3VQQnU1bjQ3eG9TVUNqQ1cva1NKaVJ2WE1qS0xETVR6dTBjYlNIaHgyckZj?=
 =?utf-8?B?UWhMcGIvakU3eTRURktlc2ZuYU5VMCsvMm1ZRk1LSHl5c1RhRkIrNHRPNlV3?=
 =?utf-8?B?dUh2VDcyT3VSdGc0c094RmhiTzN2TFNhZEI1b2N1MXd0L0QzUmpLdG9meGwy?=
 =?utf-8?B?UitYWUdIL09kUjlBelRoeFNVWmswNmZGZmdGTG4yemN2a0Y1VzlDTGNKMHJo?=
 =?utf-8?B?dmtWSUh5c2UxRkFOODA4K1RnMWxBV0Z4dXlxOStUTE9JQWZ3QUMzZEtCVFVL?=
 =?utf-8?B?ait5ODRJN3BCSmJnV3RxV2xvNHFtTjJwT29teTk1ZUFNcTBKWGd0dXUySCtr?=
 =?utf-8?B?RzBMcGxCS1JJM0xBS2pQb1ZFeEFPb0drTWZlbFBvQzRacnpheDhSaXFSRDdD?=
 =?utf-8?B?cnkyc1VodXRvbm1IQkxvZlpZaHB6Qmc4N1ExSUxQdXUvcnk4eFc0aWpEYW45?=
 =?utf-8?B?d0NBZ29TRU5lMjlxY3ZzU0JNRlNvcXBtVU5RSVp3Sm1pWnhMTEN5Q21mQ0Qv?=
 =?utf-8?B?RzJKZ3hWUEZyTEk2MDA3ZkxZZ3E1Zm56Y2xMUWFTTlJ5ckdSazRMVVhReTNL?=
 =?utf-8?B?VzEvRno0NjFybU1SS2tqZ2lrZ3E4aTVMTjIyT3hJNUZxN1VSRXhaeXFwZVFK?=
 =?utf-8?B?SDNIVXl0Nm44MmJTYXdLaGw3cWJjY1BJSndtT3E5eFNJaW5oRk50cEEvVE00?=
 =?utf-8?B?RUs1WmpzZEJkc2Vyb3FJUitGeEVzM1l1bjAyc3JwcVVzSkxGREQ5N2xPM01B?=
 =?utf-8?B?ZTVTR3dtWm4xclhMVXNsMy9BeTFTZzlXNDlKUklQWU1DUk9EbWVBWktrV0Fy?=
 =?utf-8?B?OTJsTEhwb2JXNTFnWjA1dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:09.2427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258d8799-f0a7-4308-8e9e-08dc7b55f506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

Hi all,

This set implements more robust error checking for AMD System Management
Network (SMN) accesses.

Patches 1-3:
	- Pre-patches in AMD64 EDAC and K10Temp modules.
	- Required in order to avoid build warnings with the
	  introduction of the __must_check attribute in patch 4.

Patch 4:
	- Introduces __must_check attribute for SMN access functions.
	- Handles "PCI Error Response" behavior for SMN reads.

Patches 5-6:
	- Optional cleanup patches in k10temp.
	- Not required for the SMN access issue, but I thought they may
	  be good to do.

Patches 7-8:
	- Minor changes in k10temp.
	- Fix W=2 warnings found during build testing.

Also, please note that this set was prepared with b4:
https://b4.docs.kernel.org/en/latest/contributor/overview.html

Apologies if I mishandled anything. This is a new workflow for me. :)

Thanks,
Yazen

Changes in v3:
- Added tags from Guenter and Mario.
- Removed unused variable in patch 2.
- Added patches 7 and 8 to fix extra warnings in k10temp.
- Link to v2: https://lore.kernel.org/r/20230615160328.419610-1-yazen.ghannam@amd.com

Changes in v2:
- Address return code comments from Guenter.
- Link to v1: https://lore.kernel.org/r/20230516202430.4157216-1-yazen.ghannam@amd.com

To: Guenter Roeck <linux@roeck-us.net>
To: x86@kernel.org
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org

Yazen Ghannam (8):
      EDAC/amd64: Remove unused register accesses
      EDAC/amd64: Check return value of amd_smn_read()
      hwmon: (k10temp) Check return value of amd_smn_read()
      x86/amd_nb: Enhance SMN access error checking
      hwmon: (k10temp) Define helper function to read CCD temp
      hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters
      hwmon: (k10temp) Remove unused HAVE_TDIE() macro
      hwmon: (k10temp) Rename _data variable

 arch/x86/include/asm/amd_nb.h |  4 +--
 arch/x86/kernel/amd_nb.c      | 46 +++++++++++++++++++++++++----
 drivers/edac/amd64_edac.c     | 69 ++++++++++++++++++++++++-------------------
 drivers/edac/amd64_edac.h     |  4 ---
 drivers/hwmon/k10temp.c       | 62 +++++++++++++++++++++++++-------------
 5 files changed, 121 insertions(+), 64 deletions(-)

base_commit: d0c40c38ab408325e348a89619e1ed43dccdf44d
change-id: 20240329-fix-smn-bad-read-2ee9ddcf3989


