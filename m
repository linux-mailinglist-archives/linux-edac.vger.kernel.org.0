Return-Path: <linux-edac+bounces-5229-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0FC13C74
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C27E734A825
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935A2EA493;
	Tue, 28 Oct 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="h+zoBvog"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03013B284;
	Tue, 28 Oct 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643508; cv=fail; b=rOtH4IE+mtpYZyGxHASiSVwhmBGgArMBGD5ln8bNlFzztGFgA6bGmixDJT3RYRtaAj3DOYmzy8xqESxC21+WAXOgX/r6w95mLOLWrR6IprZuJUbGbxg/gG9R60NvNRC/Wr6OC/dIyb7Q1WR6gdnUZyu286GfuuKXfhdZH7rfJMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643508; c=relaxed/simple;
	bh=T/hsNRUXASS7jGHE7Anltl9DHzNuXhXo0sk+yfqmkc4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rE/d7lpe9rT7/WOOqi5fOnLxKzI9UTF49nL34cO0DOLq2D/bYZ4j0UM6aNKqfu9IfpyuZL+NwkWllrafSPzEpZl3/9O7mAM86Ly7Xr7qRgI6Kg4ufeD/3WxweohpuslW1mMq91J3FGRFFGv7ti+AKXd6msw5p3YiMiGums1z/2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=h+zoBvog; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjaFoSH2XYVhz/sV/Q8ntNlYjNwi4mQEpDuGt/VO2afQkSp79XYw8OUMdTe+GgsMYixhzqezfeI52JrhLMUhqv4vaKIJTzrMyx4veKJsxd1OiBLJiaBtec7hXl0KXyUwJfsiytsx2uGD3bK0m11f13dFo1Ttf/X8hXM9sUy6911kmetpxdCCGWP8XmLMV01Dd2b/SMK/mTezUZdi+9fPiJOAk4GJSosPAGPZzAD1A2RoiRcd/Dba49V/6JM1WtOaXH2p0ev5egjV6NGYXMRhjn32G7j2k67vHqunh8cupn+xFBSD3sYORXezY9v4cHXLqPrPI0Btnrj7tm0wukfpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QJpbLEaz/Wa8ua5/lwRY4ck+RaME1A8DOSxWQnffXY=;
 b=X/rgMhWPaHqyzJcf2CmmYuCGlM3hSotzxUm3wwqSlkApjBrrJh2zKEC7Zg+oVcKw1Hb+H9ymaG+hK3E4/rL8NSO9NuhRvuudS4rX5a6WM3dqQXHm87+KWryNLx/4qjFgZw0Gpw/SRc4mADbb+yf6S4vw5/xGZu03J6KP+YBxOQ9lkmDDy8Tms3Ehu1xG8O5iwbnhwB1PiyJwo/NkC1ouiyEAv6IUgCt/xwQpgGEiI41KOwaVH0lydbY+XF7MyNlfMNLQmSYu8KZJ5uzLBTmqf32NzxTk3rUt8CgnvNw56C6Q+WFSl48tugazYuCeZv8FcgfSWFPWEgkIRC99UexD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QJpbLEaz/Wa8ua5/lwRY4ck+RaME1A8DOSxWQnffXY=;
 b=h+zoBvog6l4cJ6huet1QoJJCM3vXIcpffcOJzuJVS6PlWuZ+bz4UXXVpgg7xmEqBQLsryvNhT+AYgsyP/IGnvZEO/t9sBHLeL1BP8QmQYcQRgWk8xWgTwn248b3ilNzoxFbzT10FXcZzToLhzo6yLg0c+oEkt3132E0eqWi6K88J4SU01cYq7MWK2SHU1+HeG7fqnGeMbN7oHD3dZwPDkYOvz+8SgWJwctzpaOaTzRkmZjGCIRJQ40xG5lU0OCeJXkZZf/t/Wgccr5hOEL0NAfwkldz9orO1Ik0rpAe9MSpe8W0SSdhw9/oeXOGv2f95p55u2TOf+mTzCH2YIM2MPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 09:24:50 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:24:50 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	matthew.gerlach@altera.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 0/6] Add EDAC support for Agilex5 SoCFPGA
Date: Tue, 28 Oct 2025 17:22:26 +0800
Message-Id: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0010.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::7) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CY1PR03MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3bb368-f4be-4b79-84d7-08de1603d83d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jn/AGlyZOIwQ5PXY3DFvC5WIOVJN8b/dO/C/pLpgDf1MkRDAJzXE+iUwnXGR?=
 =?us-ascii?Q?/QA8q5P5WYS4l+mzcJFdJh4ClpCLUagzf0HFw/dRj4SszsBVEBBduCKKK05m?=
 =?us-ascii?Q?JaeoPiOcvLec01xgb7LE2VFjwba7uO6K9Xc5mwtQzwJ4RgvPUpY1THBKpnbE?=
 =?us-ascii?Q?9M1gIFd2ybYU4JBWq31eFp5YpRnfn3I1pnjyAEuhlB4rDOdY0lsjMfGbJ36E?=
 =?us-ascii?Q?QhPtFJ6uN4BChGBzhEfDNt3zkRmSlnTM8S+R7XL7E6kHtbV/uRhls8VV86Y8?=
 =?us-ascii?Q?LhH56FevPKYHnBQ4rViWKm95ZAChZFtMTx9Qmn41Y2+2BRUPPbOvzoPp1Mnc?=
 =?us-ascii?Q?albqUugESqYxfrf8EsTG2NScTSM0yp2PU9iymDV1zLGkY2IGzZlzErxHsklr?=
 =?us-ascii?Q?zDtxclkXeFJ7LZZOEc58xnAHONTYCq+DM6oqBPZfxWxC+ubsGNo3CLCoeqf9?=
 =?us-ascii?Q?alQ78pH4padKXzxzF9iOy8kP0CESJ93hhNyppRInS4agEF/LBVEpsULTJ9kf?=
 =?us-ascii?Q?VnlSYlqBe4G+bxODYhGnCMOvRHvtaDt0dCxZSoGj/zSmk4Txns8CEsJmxTcW?=
 =?us-ascii?Q?kSkULHrJZQRtUKmu5x/Bkw1g+TCZD9k/QS5Nh+Pvx/nPVJDkwZCBuFiKLbdu?=
 =?us-ascii?Q?iFpj3LNQ+ZDWWrT/Fo74BmhjYwcbINOPRI9+c6L5a3tVwOF8zkAsAFjwdGCO?=
 =?us-ascii?Q?pZH43adkIgN0lHjOk+Ep70loZNJBkQZJYmzoJ9sgFW5Lg2d+kZEzZOQLiPC6?=
 =?us-ascii?Q?jiSe6j82iNQQvJgLvAaKs4p221tu/j3dN9q5xsRx/5eKVxF6XcXLvThGyBfx?=
 =?us-ascii?Q?Xr/341T7VhhL3u9kCXqucKq7oFnxuKLWxMf4oK+vbhSqbCY50LfpdqbArYZP?=
 =?us-ascii?Q?7wczODdXYvmZEJsdHZBhPYz8d+EGYJqeL7jzaxy/YwdVs9ecP4rwn8fXfTHD?=
 =?us-ascii?Q?N7g/3MHzPWS+EnitbcRZLcNQkNKExPOrNUsy+y2FVEzCBhP4IESk1+A18jid?=
 =?us-ascii?Q?OwTi6dGtbZAgVMefUUuWJJWS19ooQTjJxBsAWf7ncK84zi7gsEU0eP3PaDuA?=
 =?us-ascii?Q?YIfhnyDA0TkaP20VIQa4oMYI0GH7hMyO96K1QxXa8LuDhVcug0mOxOxNco8e?=
 =?us-ascii?Q?ngGuYcXVPw4paiLSmMKr+FOKAj9QI7DqcucXGb/9a2MIua05WUJYNhL6wH04?=
 =?us-ascii?Q?ogC6CjkXoCaItgqZ+eu8P2w5AOIG/BLoEdSgr+xNQXUIZgyEjSlMQXUSV7ix?=
 =?us-ascii?Q?4x9P5Z+y/0++TOLZIuL647Q6OQ8x8mXUr1Y//XtuV6nJNH/RM/DpUjDbzOcl?=
 =?us-ascii?Q?KCDAkkfqE3ZV3CwxYBRwAKMNZ3cOG+D+t8S9//pgxNgAmji4xzP4j+j31Qm5?=
 =?us-ascii?Q?YTNQPz4gOtQEeHU+xz60Npa4SG4NYabiRmn69ps06ZHSlxhtsl33Aem5LpPW?=
 =?us-ascii?Q?BKDi1viWSyx6jX7y6lFdyZUEG76/j1bC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FpPmtEydf1NLQUdsOtRHMYZiFUvFmsGqjfLt/tJoJQ2hN3WoPtZBvMNnsfpu?=
 =?us-ascii?Q?Npx/ia7I/Dls6Sf/sPHmsO0knhTb9JTtK+TAMhI51OPkO5NPGFDwVFUek+i7?=
 =?us-ascii?Q?8YMzyXA1VS7tyQpCUd43EULRNRxeYwLW/ktWsvYuqJ9sDifTjgE0f4srs/Wp?=
 =?us-ascii?Q?WtIN27wWaFvqMInpthv1UHk6PuwwyMQcLuNoqYlVyWtXLeQiKjLKK9Hnsfxl?=
 =?us-ascii?Q?WfkAOuB2UOhPRTf+3qW33UK7pDvbXJyXnbsQREEkhLPVT5vmeNFrgo2vO7iP?=
 =?us-ascii?Q?pOqU1nYBtMytjBoE+3NCXArXOyjCYfDmjz5GJHmGvSTRqBYZc7OJXZTXwYe+?=
 =?us-ascii?Q?UmTPXB7kizszGyhTS1ZvtnEJpTjs7aQFUaTqNt5NcetTO8GqwsDT7yQiUUmH?=
 =?us-ascii?Q?LaxDvxoXe+lTAJKo701OK4Y51UtWyOZPfTCzpFRQwLyjvHVTwHCOLVZG5y/w?=
 =?us-ascii?Q?BC3GD/XDul0d3Q9aZ95Syga+4Av5pm0DrikApAuOQTeNSC5oI9SzEYP9uJOR?=
 =?us-ascii?Q?iQQSlfhBQ4d7b8SYgUIH4iOQ3uz6Eb3m135MjT39HbMblK4Z+zO9ayiH8lfZ?=
 =?us-ascii?Q?tbc2fZYOq97Z0c2iTL++fjr/zUJwnsehH+63jxslRFqQ3q94+gLd9xH0qDKR?=
 =?us-ascii?Q?/MDYFCz58/U6nfk0cVCMnVGuvX0857wjuXoLBfui4ZIHMcDZzkim2CqXnIYv?=
 =?us-ascii?Q?yHeVDNx/8D9Vl6VT9iN7NPlgSFGwFGAB66xez8WZbynPZ8Da22dIY+Xemgz9?=
 =?us-ascii?Q?eKqHOLOsxkZGPw0WOHeKxl1E4wvLv4ebleiIke8iVrJL/rn88+RdZWRzORun?=
 =?us-ascii?Q?ooudqZl50oqBE27tNWGSY/VvGq6duZPdEz4wGP7dfromgHPKYX5D/8wB6Hgb?=
 =?us-ascii?Q?xnGw720oFzHfFBelwmgomxr51WLnja31RYxBEBThrzmeCb8CB0RXkmGrP7Yz?=
 =?us-ascii?Q?n3FNUHXUL7bAWf56Y7EpNbBclWTxxXvO5QMi5V2Uk4mhOWp8BlorLAd20O3o?=
 =?us-ascii?Q?6BfBBLER0zIWcIsXLoOUh5c8VDPdJTxiZuK2LyRdTQeVbhxxz+mFVguJaTR6?=
 =?us-ascii?Q?eX4GNPd4XunhwSG6mTuuZLaeApwGGBhbL5F4/hCPL6JnGPFZ5y/sNgYKwn3X?=
 =?us-ascii?Q?f12qVOV9ue7Akkt9R+76u9QnRqtS9Em+xLVPaTVAsJHl20/AgXUdppj34wLw?=
 =?us-ascii?Q?NA44UBi0h7UmlgbTRKx/EcluNxEiNYsxvblh+iX4ui8KDQEAoCErNpnvw7G5?=
 =?us-ascii?Q?r7jgXyUa6seF0IqJ88Y2tNgaeQXTmTPsfJU+2H9rdDnjxzhNHKzgpLaRHKKH?=
 =?us-ascii?Q?LkJywnZGDrCuh/B6lo76fFkpxKcazibe1c5oQtmMInScMSQZKN+lrAjpRW8c?=
 =?us-ascii?Q?IEl0N/TJvXDP2fs/ZWOEZhtE0UB19OTzqOx4iy9dznY1YElZWBpO03vkeQO3?=
 =?us-ascii?Q?VKK9hVPVum5qEBR+lBUtbttmk5+e7Cb6HEE9hjd336ldK2bT1MBVaRBZ5XtR?=
 =?us-ascii?Q?fSQWVjGZfUp+4BmKFIVLaWqSm7K89bDQF05uYMr2mrY/eaDNQVYL1Ombt/7I?=
 =?us-ascii?Q?OHTYNgtLHPw1Bzknx9voixoThENdAN9Yf/864tL95KeO20JWwboxy+TQ+bua?=
 =?us-ascii?Q?ecOOGH499wxSntKX17UMX6W2EUKO9+aqSiMCY+mpkCYb?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3bb368-f4be-4b79-84d7-08de1603d83d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:24:50.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brQ0ha4mv5bWf/CcfXmnrIm1CJQjdzNtPGA6cP6FnklBTlobB52lkXo5zChGq7LOiNVdM6VmaJCYJrXrKDt8ZzqGcV2jQygHgDAm2AeietgbqxtFPD/RU50jDDBFcolZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8121

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

This patch series extends the EDAC support for the Agilex5 SoCFPGA.

It introduces the ECC manager (eccmgr) as a logical parent node that
manages multiple ECC hardware instances for USB, Ethernet, OCRAM, IO96B
memory controller, Secure Device Manager (SDM) QSPI, and Configuration RAM
(CRAM) Single Event Upseet(SEU).

The series includes device tree bindings update, DTS update, and EDAC
driver changes for interrupt handling, error detection and reporting
through the EDAC framework.

Niravkumar L Rabara (6):
  dt-bindings: edac: altera: Document additional ECC instances
  arm64: dts: agilex5: Add ECC manager and submodule nodes
  EDAC/altera: Add DBE interrupt handling for Agilex5
  EDAC/altera: Add IO96B ECC support for Agilex5 SoCFPGA
  EDAC/altera: Add support for CRAM SEU error handling on SoCFPGA
  EDAC: altera: Add ECC support for SDM QSPI on Agilex5

 .../edac/altr,socfpga-ecc-manager.yaml        |  77 +-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  98 +++
 drivers/edac/Kconfig                          |  33 +
 drivers/edac/altera_edac.c                    | 670 ++++++++++++++++--
 drivers/edac/altera_edac.h                    |  56 ++
 include/linux/firmware/intel/stratix10-smc.h  |  55 ++
 6 files changed, 948 insertions(+), 41 deletions(-)

-- 
2.25.1


