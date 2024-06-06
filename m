Return-Path: <linux-edac+bounces-1217-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070918FF20F
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A9628B19E
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455519925B;
	Thu,  6 Jun 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dYlnaH+6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13378196DBD;
	Thu,  6 Jun 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690404; cv=fail; b=gAMfLVigGDhM30fG3R8FGk7MzEmvzyETa+dzhSi8EGlsVAKz+agk+832hMyFRgCrGZA9sOxrtUgQYOpsQDmE7lz4Y/vHcXzNvtIj2lUtVOScInHmA0SiTIS/HwcfH2A6ob9G8oZn5nmpfNcKXF6dyzW2YKiauqfZDODH8BxIPJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690404; c=relaxed/simple;
	bh=rMKl2Ju4rz8Eciq1vRTCKvEViIz94XdRhEk5wyS6Ut8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=es6JL3Mb970euC8mpWjRVxO3Em14k4FzenSxx9XbwUrLDvxLs+WlX83hjRUnFD5hbZ3jXJ1HhfWPd0HghlFZYKuEJLyccv6PMZU3pvCpY1ify6a37mc+O4pgyYVJxWJPk+G04aL+jC5Aq4uGkNJPUR9GvV9bA/xFlQXeODoj8JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dYlnaH+6; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJi6SJzcDn0fGZvwCUE4dueEekldwSNXZ+A52vhFpO/17eh74S+6gIRDOYBjcdL0ySk6q1/4iuWcTFcaD3oNVltZ26FFTMDRwBAftVlCE0hGBcjHRP0xINA8uWM80Ac5MDOsmWSGbKjmXnlLtsvL+7P8xTeSo0WWSbTpXStKBPffLyL6bJMw73xpctxufbnHwK54CW3/91kt/WuZvA9azBmnBdawARIhtSHSSnftWG0oM7uxsN88tbquvh/Xr61P5mkUarGiyyBzTxxZW1xjmNdcWTZd1l0STSiX98fnI5VsbvYYAt4a4ayJNgOLu2QiGQwA0pzkLeFU5kqpJYr7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1sbUM+l+XWQcadxazAjbEi0qWrlnbOUQWJosB4nfN8=;
 b=FvBBAuV7odZpUQIhAx1u/bDp6232kT/YlkIZbFD1s4ihyU3SZW6NFR83koJjaCcIR+uXaqkUZFpVchFazaNX/4IQGlGZtyiA0U45wK+QYbvBOnYpmmedYIizLeB/1s232+AJY9KQS8XvgODqmbJOxNHjExK+pEbFOEZkA277iFtuXM/VHa5N4lKMXNmy6nY+uDwS2C03Y33LrlSkpFde+ceRtR5YQkWctSDB74TGPYOkG4mfPzt1r3XW4bUsdgK5s7TeYeZIRQXslaAdZbsTm1jxFHrNu6henbLLyF+odJZgSic+1VFxzK4XDa+P4V4MLQMA42JaJUQQF+h2xYdoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1sbUM+l+XWQcadxazAjbEi0qWrlnbOUQWJosB4nfN8=;
 b=dYlnaH+6qK+jDsOzOVaSmYpLIP8OhBS0DAL/qU4m7Q8Z8s1Sk9Zy0mcQYhQdocQarYR8kJTaZaAfYgF7TbX+JBS/E9iiFokP8NjV7sCMqRjLDm1Y6aLIff2fXS5BYe7jTPwke6131sqi8hz6jDE2bLUqcuNdf+XBMNQhKdSS3hE=
Received: from CH0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:610:75::25)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 16:13:20 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::65) by CH0PR04CA0110.outlook.office365.com
 (2603:10b6:610:75::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:20 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 0/8] Enhance AMD SMN Error Checking
Date: Thu, 6 Jun 2024 11:12:53 -0500
Message-ID: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXgYWYC/32OwQrCMAyGX0V6NqNNu2o9+R7ioa5x62GdtDKcY
 +9uJogHwUvgD/m+/LMolCMVcdjMItMYSxwSB7PdiKbzqSWIgbNAiUZqdHCNDyh9gosPkIkHErk
 Qmqt2eycYu2Xim7fydObcxXIf8vT+MKp1u8q0rJVdpVpWRtU7VBYUTP5JqWr5cfL90fehaoZer
 JYRv6RVzHKZPZPOKvkf1B/QyBr1b/9RgwTvjWksYiDtvviyLC98itmnIQEAAA==
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cf201b-fb92-4828-f1a1-08dc86439518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2RvcDE4SDBWSHJ0NDF3YjV1SFpyQ2Y2d3Ewbk9MTnlmV0duOHZra0pycHZk?=
 =?utf-8?B?MVJwMVpJWnVRSlNGTWxvVFVILzZkT015RzBwYkNTbDNTTGZnT1BKNjQvUkJ6?=
 =?utf-8?B?bDREeEpRYTl6bmJSRTJ1TFZLdjhySDluTnZIVk1DTUxncUNmZWlaSVdQOEpR?=
 =?utf-8?B?RzZQc0tNa2c0OXN4dzBsazNvL0JUd0NuVGZUckdiTEx0YjNDY2FrTEg5THpn?=
 =?utf-8?B?TzFaR0tuNlVrcFVrWTJkM3dHbmdqMCtjRHhWUHo0NUp1WEdqSU1Zd3Q3RGpz?=
 =?utf-8?B?TVFrN0ZDcmFsN0FzU3plVDRJM2pwTTN2QzU1TlMyR3dqWFhjWXEvSHFUVXQr?=
 =?utf-8?B?ZldRTitZWXRnVDVCeE5aRGFXbSsvSEtVb3RiNjJONHV1Nm5qbW1RckcvUzJZ?=
 =?utf-8?B?K0orRkdSVURrZkNCRmN6OTVrbGI1Zy9RUWRnNS9nQTZCcG1wOXpMZUFDUmo0?=
 =?utf-8?B?M29iQlJLbVoxMFl5aDJqMTEzbE5EL2FRUEUvZm82T0dFN2hFaElWc2NtVUMx?=
 =?utf-8?B?ZVJ2RHJpeEhQNUY0cFE0WEhxVlBzb3dDY0N4RDAycFU0a2V6L0dmMlR2UjNp?=
 =?utf-8?B?Qm52c1FPMVhHRXNqb0V5WCt4Uy90OXgvNVNCSXNPcEM3RmluY3EwRlR6WUYw?=
 =?utf-8?B?UXlDaitZQVlacmt1Wm9qemxETDBwNHNCdTVGeGZVV3kxazNBZ1JRVFlBRjBL?=
 =?utf-8?B?TDlzMVJZdUo5M09Gc1N5aDluTmVmZHd1U2x0ODhCcVIyU3ZYQTd2S2FEU2po?=
 =?utf-8?B?SXNYWm1iVU5TRjBJNktpT2pqY0ZzUmE5YjN2RGxwV2tLNmQyWEJXTm92VllE?=
 =?utf-8?B?dzk1TUZsREJmS0RGSE9YeCtVVE9yNkZSUzdYeDF3a2taUGpIR0VkMGgyckNK?=
 =?utf-8?B?SG1RNzBoYmlmcWVBMEpwdnJsQnB4ZDlabWlUTnlOZjYzOEVBUEFhTFRsU3VG?=
 =?utf-8?B?TGhiT1lqWDJTZkY2b0pLUlV4MjlQR21KWFRsaUdPS0UzWWVzUFZ5RDA5OFZJ?=
 =?utf-8?B?WHZsbnRrdHVrQkJ1T09OQ0JZMksxZ1NKcUZLZEZ1cXNiUHorMkE1Yjl5d3l5?=
 =?utf-8?B?eHJDSDMzWUs5ZVV2bW44dW1FaDhHWEdsek5KZzhLd3ovUU0yalozd3lFSUtz?=
 =?utf-8?B?VGJPK0hEdzM0aUVqYkNST3FxbEtHU1N2MkkwNmwyKzJkMXI2ZzRic2l1dW80?=
 =?utf-8?B?V0pIQWphd0lCeUZGL3ZzclY0U0YzUUtJQmJ3NlI4aHdDTkYzMnMrV1MzQkVu?=
 =?utf-8?B?ektDWTZ6amR4blc4QTJwVHBFTGlieTZiWUt2Y1hFSUtCTnpNTXVwM0ZUZlJ2?=
 =?utf-8?B?ZWJLSC94Sm1PaElMYVBxSkdjbERqZEVLUWdscE8rWjBaNE52RDBvRXZDSS9P?=
 =?utf-8?B?RjJvcVdZOUZRNXlSNHJvUVA0eHVoN1RPbHpZcGRiS2g3RUJjdGFyd3lnbUNk?=
 =?utf-8?B?R2FKSVZpZ1BoaGsrUE8wemV3WmtjSTcrYUwrcHB2VnBuVC9QZkNwRmpwQWlJ?=
 =?utf-8?B?d2ZHWHdRdklyOXBwclR3NUE1U1NjT0RIdG1tMU9lVUx1Z2w2cHN4S29kT0NS?=
 =?utf-8?B?WlZrKzRzT1JkR1ZhRDc1QU41dGJYdkovTmNKaTdMLzJPdkd0bTM5MVJUbk1n?=
 =?utf-8?B?cUd3T0NSdGxDOVB4Y1E3YmZmdjV1TmtycFU2bkd4RS9KOFh6aFh3a3Zadk1N?=
 =?utf-8?B?WnY0RmFXQzNTY2NJTmNuSmxVODgzNWcyU2JYcUdQOGRlSTRzMWZKQVd3RDc0?=
 =?utf-8?B?WGhRdlI2K09qSGJWQy9ad2IrUUtvY29qcWdiQlZacG91NHNuZmRXQjJheEZ6?=
 =?utf-8?B?cStYbkYwMS8yOWNTUGIzWlRSTVdnMTY3Rmc5Z2FsZDBXci85bitCNlBVTHRD?=
 =?utf-8?B?Y2JFREdlZ2o0VzY4K1B3bTNWYk5JdkVWMWY0OWZXVG9tMjFmcXM3Rjljbjhv?=
 =?utf-8?Q?mzWVfvCg7jQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:20.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cf201b-fb92-4828-f1a1-08dc86439518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

Hi all,

This set implements more robust error checking for AMD System Management
Network (SMN) accesses.

Patches 1-3:
	- Pre-patches in AMD64 EDAC and K10Temp modules.
	- Required in order to avoid build warnings with the
	  introduction of the __must_check attribute in patch 4.

Patch 4:
	- Introduces __must_check attribute for SMN access functions.

Patches 5-6:
	- Optional cleanup patches in k10temp.
	- Not required for the SMN access issue, but I thought they may
	  be good to do.

Patches 7-8:
	- Minor changes in k10temp.
	- Fix W=2 warnings found during build testing.

Thanks,
Yazen

Changes in v4:
- Rebased on tip/x86/urgent.
- Reword commit message for patch 4.
- Dropped stable tags.
- Included additional tags from Guenter.
- Link to v3: https://lore.kernel.org/r/20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com

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
 arch/x86/kernel/amd_nb.c      | 39 ++++++++++++++++++++----
 drivers/edac/amd64_edac.c     | 69 ++++++++++++++++++++++++-------------------
 drivers/edac/amd64_edac.h     |  4 ---
 drivers/hwmon/k10temp.c       | 62 +++++++++++++++++++++++++-------------
 5 files changed, 115 insertions(+), 63 deletions(-)

base_commit: c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
change-id: 20240329-fix-smn-bad-read-2ee9ddcf3989


