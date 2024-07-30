Return-Path: <linux-edac+bounces-1588-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C8941F88
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978B51C23288
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E8189B89;
	Tue, 30 Jul 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H+RyT9q6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E71482F3;
	Tue, 30 Jul 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364217; cv=fail; b=S87GkBg94Wu0Yii4tgnLM18Xufykc+7nOsGRPiG0HXn+n/oIuhyPdNuyDblyv+QwjyWB8umXvvtUgdeUG9lCJbUsmO4UGM+g5L7YxMf3iJI/45ZwiM52AQwIXEt9OfpM/bw47+T3s1KSgR+EHabP8wlgX+FfWYUJzjWD7sDTaDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364217; c=relaxed/simple;
	bh=W6WDVrBvO0qxsLdYp0qluUbMBQGsKUzo1aQEidGbESg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RdkyYFUlLQCMKwID8WeQalFsLefR+co0U4OLCT4t0jfTkPgCFPh94zH6R3Yx3x12dFxR+XBj3Ttg9tlch6DYASX3rWscsJHwBa1muUFWBW4Q+Q5jmAFxqAIu2XJTNQVRZqLOmprDRkPjUZ6iS1gRMZzWYAaaTMqlmwSmULK2ZEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H+RyT9q6; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYxdVqVfGdHmJ93it+SS1OZ2Pb3alW5FSYp+GM2dONBek6duGgEyCyghUktRpMNwA33gnzR4tcxCuPA9gdXG1cIbzxNOWs6+1wAE//e0GRRKOXlMtNS++Hbhx5urYu3n0ZBqz9XfD+GTbsShBez8aMCEgbRpuUNL9Q1BPzx1sseb61W44HEvdHfwyOvjBQfLAU3ecq6bTZwrc5f941RyVQxUDi3gDE8OiZ9g3h/qN2GGMfIjPNxQ7CQd9/6vi6SbFJgXD46A+W88nYO+eNomvXYUW1sqUtdXvSNjeXXD771W6ry2gFEo5+nCcwVBC6HgtjnXHqYVo3rvpjcj/w3IbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMRSvJO9ttdjs6mXICfbuM46QUmX7jUNJC2zog5VxpY=;
 b=a22eybF7SO/dgO9jhR4Z1Q5EEgXWx08NMgD6fTdKkM5ZWh4aCO5ORUs6cu2eiqywoKglEu3hiXPooFWgNXxzbNo1ZEWlXoxEtW0ouOs9GVkLOzlv27N7c2tuRm17tKUJblz5+agXjt7WJLI6Ec+DPOCIR6LLUNoG3qYOjjpxDo2WRLMRJtjfkdxc+un8yPrns0gJkc69Y82Ohn0W+Xk+/+yv235MoPiyQqrfI472nbvE0rFPPhU1LT7xVwuv6Ur3XRU4tPpc8MS9qeEzERVEMRtiD9nQnP7awrFrvhSaJQoi+9COF/lGweHepH035hKFNZJKZwGOw6oNnjDs4RVXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMRSvJO9ttdjs6mXICfbuM46QUmX7jUNJC2zog5VxpY=;
 b=H+RyT9q69ZgaBrnHjL9vtXuQUU7D/CvlreBvXpLQ4UR/mb/GwZngE4vmNujeVMRrFsYqV2zXPhXq5C6U4K/nmGfbGXsu4BfZoMzp/9Hl7EJlnifZ5tm/wSFYBGDLcTdC4rDeK+Y4Ppm9qoTiQ2PMtF5gMQT7MzHt1hAdVr4J1JE=
Received: from SA0PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:d3::12)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 18:30:12 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::85) by SA0PR11CA0007.outlook.office365.com
 (2603:10b6:806:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 18:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:30:12 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 13:30:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v3 0/3] Rework mce_setup()
Date: Tue, 30 Jul 2024 13:29:55 -0500
Message-ID: <20240730182958.4117158-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be06fe1-c059-4260-9672-08dcb0c5a619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNInce9j0+gem0r4xEJHjBsFDvJ1EzyWpLt3SHOW0ntBVK3etGI7mcJfFdVX?=
 =?us-ascii?Q?a80O+H2Bp9zupYBtZ2+dregtYv16xEwcWtdkoVC+/oSoj4F26aTYZ6PA6IkA?=
 =?us-ascii?Q?BCTXYs8XerXIRrSORRiYuAHio8pKjPY8KXziWY7rJRRVnUp2//R+4j267st5?=
 =?us-ascii?Q?KdfnKddw04Ohytw8Wdzy1Ze4bPEsgnO/r4NgcOSjQjhfvmGHvJtzHJyJw7pB?=
 =?us-ascii?Q?a12QvQn+oyXIj7CZeR3EOqcrDxcwiXYGvwZYnKjdbqze9UnOxSY94xMa6sts?=
 =?us-ascii?Q?5vNSxI1PdNmgRONEAicJ80ME/E2EBuV+Fti416DOriptWpcEMy8Nqc7LbWA9?=
 =?us-ascii?Q?FOiO/xIwgAK4GaO64pUGQDpw9tbJOLtD65NAN0nnHFZVj1BNenbJKmzs9Bfs?=
 =?us-ascii?Q?3LnLYeisMJVLQk/lHlGe4A5rfr++LLdSm/XHy6PGLfCAsYiYtxNF798BjAHh?=
 =?us-ascii?Q?flormUoG0yEZkDpjEXAs3H70UdpJpcfdMEBmhgZBi/3lEYaFvewGzqqUAwEh?=
 =?us-ascii?Q?9xj4bjzzzj3jTt+CLwqgbK1ersqniG/mWH8U7la5VudXQwgSgoDCdfUsUuIO?=
 =?us-ascii?Q?b1GwEXuTK55mfmo+n3VgQPLAGwXwYtm3LGk2Lm2JAs1gXZsymRXlzTxuHpXc?=
 =?us-ascii?Q?X63IzsGAKkb6cfW5zFE+a0ae5hCNjDFEwq08Zu/HcMLYNbMTtbo8R7srWocv?=
 =?us-ascii?Q?9P7UWgLMAmRsM/ekjyjMicYP0QXfK7MfTyQnWmOrDYbGzrwJdWuCg3q7tU+b?=
 =?us-ascii?Q?N/cyxt+yU5iSa5LUPkUSuV1ci6NFbQowrUUY4WlzU9GPQ8DCJyhqBOhWIW2z?=
 =?us-ascii?Q?/PhsNjGUoAQShyeCu0V1m+1j/eu8GW55JNtsf2weAqi4HhQbXT6b5F2+RTlJ?=
 =?us-ascii?Q?aY/B701nMhTENIYizDVBP8FArhUOYGyHH8/gSriMrY2+T482mwkXoBbnVs34?=
 =?us-ascii?Q?mE7mV8KEuxpTJM4Np4ou87bTzlgKCZXstqXkEh8Zydaf7j7V6SWMFGnqv7WI?=
 =?us-ascii?Q?q81yO/5upTJ0euzPWUN+N4PY5gBT6S3u5auWkCn2hs2zCxJloOm/q7BgAmNu?=
 =?us-ascii?Q?1L75+LJHikA+yug9UQtwI+5lSnRnfUpxyUinDHjZqgbe3y7kqckRlN5EmS5q?=
 =?us-ascii?Q?q+se4m08PLhtCxBYhBLjapyFb9oMXjyNbsJ7p7tgag6w0Ou1gSZK+80WPmMo?=
 =?us-ascii?Q?9cDsdhGgtAnxvcMIWHQYZfQQsYD+JTYaHiOyzg1RnAD8UDX7TVK0sqRsdmiL?=
 =?us-ascii?Q?lcghuE32MVyfGjmV17ZXEdPwTu1RAVcMrVCiZrxtZ84u2F4yQ2jTImTICOjK?=
 =?us-ascii?Q?dTjocAs+U2tHBTIuOCpf+Ff5fI3N87rndI/5A1chm/POh1kIevTATxb4VB9M?=
 =?us-ascii?Q?IKhRUmBu4fXnD35d5lENVxgVmR4W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:30:12.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be06fe1-c059-4260-9672-08dcb0c5a619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000

Hi all,

This revision drops the topology export idea from v2. It seemed to add
more complexity than just doing a local search. 

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20240624212008.663832-1-yazen.ghannam@amd.com

Yazen Ghannam (3):
  x86/mce: Rename mce_setup() to mce_prep_record()
  x86/mce: Define mce_prep_record() helpers for common and per-CPU
    fields
  x86/mce: Use mce_prep_record() helpers for
    apei_smca_report_x86_error()

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/amd.c      |  2 +-
 arch/x86/kernel/cpu/mce/apei.c     | 18 +++++++-------
 arch/x86/kernel/cpu/mce/core.c     | 38 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 5 files changed, 38 insertions(+), 24 deletions(-)


base-commit: 1cd27e88888d54de5fefbeb0b44c26194ffa83ce
-- 
2.34.1


