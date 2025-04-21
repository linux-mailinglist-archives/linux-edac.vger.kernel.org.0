Return-Path: <linux-edac+bounces-3595-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA8A953E4
	for <lists+linux-edac@lfdr.de>; Mon, 21 Apr 2025 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C510E189515B
	for <lists+linux-edac@lfdr.de>; Mon, 21 Apr 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BED1DA61B;
	Mon, 21 Apr 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ESTtrhZk"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B64964E;
	Mon, 21 Apr 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252096; cv=fail; b=UNrKUoxXKmvCIYiTWjaqVIBEeIINCJ2g7eIzyR51fSHEj7E2ueOJpvbknSEkHwYIjjpc8OFwqg2uX87Pbyps4NevnSy3n1Z3buV1Bzi6REOqiFilQ7XiOCs6dfLWra9x14f0K8A3fAgVw6007MPRO+aaCTFobr7CYR7EZsCtpTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252096; c=relaxed/simple;
	bh=BNPKmLA2vTC5Nh4mzzSUI8xuaHck4gv8yvpF9UzpISo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SrLTCh49FxjSiIWkCJXug6szP69OsblwzPaQrXfNRa8JgZ1v1M/2UcYIjFqa9kKJQP50WuHoPgozuFUCKU4viMOZmX8+RqNP0nZMUzYMjY2XsJP9Ag9tJJgN7Q36NVLgWWx6S8Dm3K9tMZeQ/MTHQ/DKrGcdvLzQX5na2+LYuVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ESTtrhZk; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7me36mOMsiHy+Gva/msVaF4IxnymFSM95er9SHb7JlkB1e8SsJXCzoY7L2RWXZBkkCkvmn91AJCeMOcUkaypZ6PDy6g9jVUDmriLmI0BsSwraHDa52ilIPSZdDJBLpm0mMwVkN4CxLHVG+/uuTU00Y491vBTnLi5VXLXXQD2wDoxfKXjU8kvezdf356swXUr3Me0lt7am+5Z2nUgS6SwQMNifSGk2vKfk+8xQ2l5a+yoiu+5n8745uW3l7ho6dAx7CPOgFAoZ4egKUBmUgWd4ItpF9hkICLJrSTnjzpD0Q08C6iy4F8V/sswZ790g7Qyyhhn5AjJMb9KzFgeplaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxFhBXf0xaEi2MXv6yRV9SvB6soRPnLGh+M3GK42/UE=;
 b=mWYm2QzxClzW9JDylWEvRl/ypZcjKrKIK7rtdxI52dQI4b0Jte6nlMNUHR2ihULpXHzqjxUdENilSunISfx7NXsTKOMxxr+A+tjdCYkEcHE46ZlgwSjpyxponeCjqQiXM636+kwYrYkIy11KD3G5jzAbtKIzyg9tFSNjJKrWIgEQz8sFe1jlMT+rdsTg4t1jHUMuPMunS2Y3/OC7vPrppV0xnrxYDjQQ0pLqYiqXrmU6HcLE0VwW+6erWkFimufsYO0IyH9gkS9gdNsDbsyoLr41qhs+nQRyRDx9lvby9IN3rxyOd+tNux9stQ4hLnZsqECAFlIOsbP8QzrYWSTrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxFhBXf0xaEi2MXv6yRV9SvB6soRPnLGh+M3GK42/UE=;
 b=ESTtrhZk6WXdWtMmIFnG/l90iT6FndNHo1Rw8UvR0dh0GNI6JCfTq/QM9U4PUUZADORbetlbaWQsEsU0+9xWD6E1RMvliYfYDUTV3w+2eVvNFwkJy173q5yGqwJfTujOOi4PiVUuMyf2aq5rgJozdzebRryQIoFWpxPF91TcXHZRPL9z9uLKdTrkxAJtwb/oMHbPbZHPadHJfeEcCLbA6vGqX4IZbITmk23WHNeiJCEsI9nP+bweR1Y/2IiFv1fYSLPNtkGr5JeXaX8JeFLb/HWBFDsfUkKyPoYWefAioz7U9rJxjSfi5a9QtjBf/XWeRNK/aVar6OUnSsg3YFIFtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by MN2PR03MB5103.namprd03.prod.outlook.com (2603:10b6:208:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 16:14:51 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:14:51 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 0/2] EDAC/altera: two bug fixes
Date: Mon, 21 Apr 2025 09:14:45 -0700
Message-Id: <20250421161447.41886-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|MN2PR03MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fa3b85-7d00-4d0b-d64c-08dd80efa521
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2Qx7+LbVXxtMDczX5JtEcIPmJvP/R7QISd63DURZ0zqtqPkeKp6++ehszjF?=
 =?us-ascii?Q?pLnWZfqLT/aGtHLTsXAlJh8YXTVwD4z6jDOs+F6ZcSBDG9goszAhGAdi1KCs?=
 =?us-ascii?Q?UBAH1Koew2zxi5e64XnCXaWI0b+V54SA1MsJfdu5Gac3Pu9oOBj53zDIxfT+?=
 =?us-ascii?Q?HPJKhHDFhlBRFrRe/z6fH/jTIvV7WLtWyWp6wig8GiUPlX3DwR7XftI7mBmg?=
 =?us-ascii?Q?9i3wrBwjRxy5RZigS7JvEkgrPGjqKedtGA+yfpUPFt9p6K7+HwsCOgTHgzX9?=
 =?us-ascii?Q?Adj7JBozcbwd3VNLWVfAjw/tYaaeJufFOaajJjJaBPxhTXG63XGa56J94asC?=
 =?us-ascii?Q?X6lQ2Sct7tDMryeZVFKx6WIIPeg0Sw5Rko+J6KGj/tB/pOg3K+LnaS2SvKU8?=
 =?us-ascii?Q?shR3iJVzRODUMqf1gLLLhxETPvwPN90Sbi2DdvxGF9PmxupyckyaT2AC5nSj?=
 =?us-ascii?Q?zFKdpkKDMQVLMX7/uzRK1/2gsyOGDFQu7b1y7VeZpsjs777RxTgiYthPhrY7?=
 =?us-ascii?Q?1ii1mL1MXY1LEC2zA1V0p6TqRSLrLhCINEDD3mDCJ+59Pbc2McZIsDo6giU/?=
 =?us-ascii?Q?fAJBs08ztbT749fy7AMPN/qJVfEn9aRAMUfTb0cLJC9d99/4HQXTv2j0GnZY?=
 =?us-ascii?Q?GkWst7YurAk8AQewdBXnjMOg/Ng2DYjckziiEcbirlSzGyKKZrri0lUFEtGA?=
 =?us-ascii?Q?cNI3xsCTij5II/TxQ86M+tTdeFUdRiQB60Cj2/WFjFqw5HZnyRPz3lyFj8z9?=
 =?us-ascii?Q?5nhVM+ePaVADCRXHQYmD4/QZPBB1Fl0ecu6IKyAsEitIrYrXfXKRv2gSdjOY?=
 =?us-ascii?Q?N9RH48cv8fqdjBg2I/q/urCqP8Z+elASQDoK2cJ3Ss8L6Muf4Vr4oXmJ1iS3?=
 =?us-ascii?Q?TS4Nmt/F3lX9FMEaWVBBbsiNNoO6IOW5k6qjUXMJeADm4dsBJQtX+5/aBEXB?=
 =?us-ascii?Q?I+T4RiIc2+qEQ/VSsuzm9P1JpyhmDwzeRLSJ/77vmfVwJnsrTwyCx7ZaLC7V?=
 =?us-ascii?Q?gH9/XMScQ097gJkfZM2XJqUdmIB279UDdkTtw+ITHz1MBFI60gIUPjL+9ScM?=
 =?us-ascii?Q?40KtShwJTCsP/leuASwZOdXyibqT9Hskls6KfRwlwOlwUotLXVVA+TZs7H+I?=
 =?us-ascii?Q?VXPd+50ysQz56+T32H1KAzzFRJWj2wKhf6RldQEZfyLUvzHXeyhE3DdAE1uG?=
 =?us-ascii?Q?LJJWp6B9ZZnL/cAThWO/jD03OQVOpbZj7Pr7LFrVsta4OlpjWCI1pg0yw/bg?=
 =?us-ascii?Q?aj4sZEDpc28KwjxHMfQo9mgUTxO15dTbogNlxsf7RNFL+kcUCUporwJ3FQOF?=
 =?us-ascii?Q?YhnfieTZpIWAUghOohShszuN6rE3pBShQLxmSrnbHY5sXDL31QxDolwYYXEK?=
 =?us-ascii?Q?AKP6v9JStBIWae8I+sclWtJn2vgD+OQeqTh4/vf+OFj0/+2XZZr7f54EfvP8?=
 =?us-ascii?Q?EfYocHh3vo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StHLS6RdD7OpKVZZ3z5E6pAKfXauGb89ZgAjQPTmA4p0LTNaWA79ggI3Jd7d?=
 =?us-ascii?Q?7pTIvVzdUhg0PI283m2c+UKPydqg0dK8FtztUkpnephy5yZPBcOEknOXy0dy?=
 =?us-ascii?Q?WLNUa306a+nGr19+hTmA05KS9/c1E5LcMIZmBA2NpQbqgzVJzerrjwu1E637?=
 =?us-ascii?Q?4rfHOv0Gnr3T2abjEhdZnvr/HWyEGoZNIYq8YSlDr/NvfgqCrW2jhSqcS/Q6?=
 =?us-ascii?Q?1VP5x6dahIriv0lOkPgwcc5RxcEk82uaLpRkSw6fVOlDYt2HpdzsVbXcF8lT?=
 =?us-ascii?Q?bxRZsSPLrOhq43Gs8wORI8ZKnAF+tE/TjL9azF7hqN1T+aZmyujEHnLfQeUZ?=
 =?us-ascii?Q?U1y3OMUUn6V7mDC9XrHiNm8oUueq2igazHm7GhFE31BWZ73+5LAlE9k9PmTO?=
 =?us-ascii?Q?n74MFtAp238QX9dOXR2RDC8JUiVJ8InhS3vE2IweUZo6Tx12c3mOGfLj8iYy?=
 =?us-ascii?Q?5FR12cks57dq2Z9j5+PJ8r3WR1usbyGrdP2gdzvJk21qUVaV3Nmkl2KytE1n?=
 =?us-ascii?Q?yOoPZA460uE4zqwlD/g2u6xIrjiDcA/YdWcxKrTmu5+anBS38Glxci2ElwqY?=
 =?us-ascii?Q?LVYw2+kd/Tf873XLkBWhrJ3pzUUB+evlFH9PG5xus7yVQlY+uVzqLiEK2M/+?=
 =?us-ascii?Q?C8DESp49x18cAfN57n2YWztbZbx4VB9kQ20H2PYeKrJKSt+Zc7tPS0fsaxaw?=
 =?us-ascii?Q?g46nLQQiLGilFQF3RKrHeBowGiPL7lq9pYzZNVV3irxFz2nPu/vJjPeqQ8VW?=
 =?us-ascii?Q?LXFQNiIZPzVRpdE2uK+NuZR2aOzB+zIMGQJc9wVEd9rAZqJP3Cqh6xJ4CiyO?=
 =?us-ascii?Q?uvq1iO3rw6V5kWhTj1XDK3MSlKr4t5MmsfON5SBLyisIKdcMwQDTCb1rakkQ?=
 =?us-ascii?Q?ZB9SHhvx26fEYPdtPoTKZMG5uJI0r0+MAGCOUw3OrgZCRk2YoEpywkqusOIp?=
 =?us-ascii?Q?f+8rhTQvcHcK+2mqKmZs1AIhuypZFxNo6O0yNdH1Sex1mfmfcHgmxH9MUHnw?=
 =?us-ascii?Q?X1HN7SeboXW+9l2v0AVKJDIn4+QTRSWamWaeyVhE+rUplpn6h0N+ypZYLVO6?=
 =?us-ascii?Q?/i2vjfoOwDFhQkHCfBHzFUNwH/ZdPajN6FAb0xcoDqkEE5RWtMMsKTleb7Kf?=
 =?us-ascii?Q?iQhL0zaqjxZSyGNDBQTeZzcGAFmr0kZirPsXlzBn/t+g/stYLta3lFm0pPFw?=
 =?us-ascii?Q?AcqmX1amD3MG88r6QWVisA3vYXtU9SqD7H0ZgCbOfub+DW4z20s5baxdSVHt?=
 =?us-ascii?Q?cu0TMJ0yz7M0IL6vIRRXJcOQWv5XHTvSSWU2W38L6S9A93N5vA1rp09mnrdB?=
 =?us-ascii?Q?NNVwGxDZZZUWPr9SbnJpLebLlRbfeKdeJ8UUVz6zSoENlafiXYmV2FoT+TGq?=
 =?us-ascii?Q?WfoocZHUn9yuv43NYb85ori1WbCfJ/lK9a3GRuRb8jdgP5SfkXFXnAEvhZdq?=
 =?us-ascii?Q?4WAyddsu1z7MxOCafIqcvSENmsjWaCuJMIKtPUG5qrOeiG7a42sxtj/GUMjx?=
 =?us-ascii?Q?RuJxpTdxAAhMlAxD95k1A9DXyTmCwgeAaUGqi7tFTv7/MB05HACyJDIMYgrR?=
 =?us-ascii?Q?nvSwzKoRGXunIjCLkKF7AfQC6TuTOagbUPfWpmLGHjwIPj44LMqsVYN+zncw?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fa3b85-7d00-4d0b-d64c-08dd80efa521
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:14:51.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJhSKYaTKSJADGUfX2p4YSWXmjFxfDIJ5c1FM1pLWAVtd9nl3Vbiti92JtqeiK7jIj/JlhsJDkXG0sDPqwtX9rzSO+OufSsC0JP4Vbvzm3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5103

This patch set contains two bug fixes for the Altera ECC manager.

Patch 1:
 - Test the correct structure member before using it.

Patch 2:
 - Mask HW interrupts until handler registered.

Niravkumar L Rabara (2):
  EDAC/altera: fix cut and paste error
  EDAC/altera: Set DDR and SDMMC interrupt mask before registration

 drivers/edac/altera_edac.c | 9 +++++----
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.35.3


