Return-Path: <linux-edac+bounces-607-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEF85816C
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC6B20EA7
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C212FB21;
	Fri, 16 Feb 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hvp66r7e"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B112FB14
	for <linux-edac@vger.kernel.org>; Fri, 16 Feb 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097716; cv=fail; b=C7z8PNqRyDTiwTjGLzR6zm9IJPsFdim4L308C1uVOBQATy5EPJjKzxGpZsTk/pa1Jae8+467TJTigctb2IYhBbkoYFOW5NBZjVocESB2QewrPs+ZMislZAlizIcrDC5+pMxRcmzParpqiMdbaZNVEShdTwfmPDQxVzP587fsmEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097716; c=relaxed/simple;
	bh=cC8NWJAHyqIGgJahKia1I/OKgYTbZI1eLy0WsBqFTgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H+hJszU9bfPl+ybsHIPweG14+QYRMPtHfF39Dqflh4j1rs+ELNE9kX7QY8UONXy+hnAg1p9vlSyK2rdh9pSospPICR6RGRdPmnCjXvUXagF2pWrZC9ryRY4X015g94sDKduuzDadQZSvE8K+SIc/7T6xGHKuDNYYxYbjbeW8v6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hvp66r7e; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCXgHnUyNTeDfr2bpeN9Pz4confPFYkHxhKncwKr5tRWPQFffFJ+emkcCXRCeeCRhd6U3u1MWUNVy3WHvTs56+VWYTI2AOi8/WLNxEl0RFYbQTdA0hBT2RJptGwopux8HSaAf7SMfsdKMfjhIzQfQu0P5En2RO0z7qs5OTJVx41NZQJctgUVF6pYU6+CVdhqimgdwonDJCjWo/xj7d/7wBX6ZxnsvaVU+jzt6wQfi2E3Jayq+i/fSsh76vJuKNMNDnxua4lMIOevpJeejHDP6ECAmEKMfGGx/HnNpyVsve/fx2FdCeR7HBFsiiDh0aZZ1qL5xK8JoYusjTXzgM8ABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1iy9RDcO46uIsSXiG+Jz+yCvPO9Es/yJuwgEkhYgHA=;
 b=NJPL7qTwsLL5TIFTL3MG7VNSVT0qzhUYWdurT54Jk4HLzKjNdjM/x8WDdfq6AaTzwo4WuZJwI0lceUcnF8jXfLhEWyk8Co1Lcaextiv0M8BFy/9n2G2J9iZYLRu8kir22FMStAHHc4q3c23eHnPVP0Rh9PzlSjtauStIHz8SwzFbT/TGrZ1Ec6KUGClZnzFw3ShAP00/vnWRocKrejKMmff8YTbb5F20L6EVUCXFwWsELKxC/I11C359HOrZvWTYJHQ3UGBf5k4XChrqxNhGGK96V/7wrte74xipSKO837GkOdkHhJahG2ySmMycwvMbLW27y+s5VXOjKmcpyO+1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1iy9RDcO46uIsSXiG+Jz+yCvPO9Es/yJuwgEkhYgHA=;
 b=hvp66r7eUoe19uJT51KQdwnPEsBBnXfQ0bB48A6nfooLPmeqGRq2YYZByoDYKu5ZkZDCqU25k/Q5akljnwy/StN2Y9M6eUamfBhz5sMxNfgztqSyS0aLuEJdtwDhktiPk1iNB7BpaZiAlh5TIJL+ZfZgi744sEb0Ad5HSsU59e0=
Received: from DM5PR07CA0112.namprd07.prod.outlook.com (2603:10b6:4:ae::41) by
 CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.14; Fri, 16 Feb 2024 15:35:12 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::3f) by DM5PR07CA0112.outlook.office365.com
 (2603:10b6:4:ae::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29 via Frontend
 Transport; Fri, 16 Feb 2024 15:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:35:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 07:35:11 -0800
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 09:35:09 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@amd.com>,
	<sai.krishna.potthuri@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 0/3] EDAC/versal: Driver updates
Date: Fri, 16 Feb 2024 21:05:05 +0530
Message-ID: <20240216153508.26569-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH0PR12MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 39092cee-675c-4f12-215a-08dc2f04ddb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	33zGCH3Ro3IngmgBBDelTkO32l8wCfLdHpHeLus3ZziAoRNyw0SlXoeW/7SCD3d6Ze6MjPkG+lPGo5Qk7iPXNeewYyou4xEPrsFvTo0VrCiVQLVntjkfBsUrFrf8GQ9qRtj7srz1H1WrkEzzLo2re8bhEsBlyM8bGJ5+/d5oXPYhgRUtqx2kjs4+LhZJWuBKD3d/DgfI3GdZE30b3OPqfpjSwjY+EhiOHyIWiWd0xJvASnbE85fgQo3ETU8dUa5DLwNwi4mM0Vta2qvFSVc4xKhCOr8onc6+OfMb2J4bdX41xkikeCjePAhLeiiZuAT1njsc+keGysHv6ypMi9db9ModC2PHkcu1xI7U2+Eqrj/BDTIHcBl1dBHKnoZXK3QRpNNOCSHzjczFg0VPoKwbVHuPyf12q7t35ffTqIWJjRSkx/Gq1wTEyzLaKDbYoFV5Faudk1JeGNEaoiSgmbnFh23ay57PJzRj/YHnCRi/DZKa3sgLaByd291Iywm7hKm4krf9ujja23LXzo5onF+bOA50zKYfonBLqGj4UhYy8F6c4VIUVuGMAw6iQpZfYLEJ3E5npLI7NKE8JfK0V6gHdJqb898YKKb4bNFn4B6E1b2SzcPEBUyJY191cuYOtW0Y41M8qRknTEKWAfM8liLE1XDQfFNGUwpLJleAb03Q8II=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(36860700004)(64100799003)(186009)(40470700004)(46966006)(70206006)(4326008)(70586007)(8936002)(8676002)(426003)(336012)(2616005)(1076003)(41300700001)(83380400001)(6916009)(316002)(6666004)(54906003)(478600001)(36756003)(356005)(81166007)(86362001)(82740400003)(26005)(5660300002)(4744005)(44832011)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:35:12.5087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39092cee-675c-4f12-215a-08dc2f04ddb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121

Eliminate unnecessary NOC error registration.
Include a NULL check for the user-passed function.
Avoid sending cumulative values in the EDAC.

Shubhrajyoti Datta (3):
  EDAC/versal: Do not register for the NOC errors
  EDAC/versal: Add a NULL check for the user passed values
  EDAC/versal: Do not send the cumulative values

 drivers/edac/versal_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1


