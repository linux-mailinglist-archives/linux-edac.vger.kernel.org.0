Return-Path: <linux-edac+bounces-3375-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B7A6AB5C
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CD9980614
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1A223311;
	Thu, 20 Mar 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IiU6msvZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11011060.outbound.protection.outlook.com [40.93.199.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB617591;
	Thu, 20 Mar 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489207; cv=fail; b=A5YzFzH8h82z6kru+ixr2BXHngn7tjjeWEtgYN2NvI1n6a439kgZRSeYFTjaltRbp4d7SAj4teJXuZ+0w/BqjET5Acfz+h85QgS6pXESSgeaNf59fJColiA7ArJP4QbsvnZPsExUAboadVqWOQJg+y/z2hETbbOS2Mnv5i/BxRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489207; c=relaxed/simple;
	bh=889gja+tVuFKeDX5ixH0Rwe5VOigh0XkpqOocHzqDZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CZquyBG6AD00s4nRqSq2zP6EKaIbqZj5k+W08+HdMYcW+KAtkSgI4Pqja8EN6co0CL03GbD5YrLEKBNcg2H5peENSwXDEwTj389s/mhWpWeiz3szfmxKgqV11LjTGwXwxHK7kq3RaAlGlkqg/Jrqts8qlqum+dCHEeap6Trvocg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IiU6msvZ; arc=fail smtp.client-ip=40.93.199.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soQBDGyj3i2jQMSNIPjPAmtnyp5gvNw/E037CS9U++e9R1VAtSX00Ye3NbJEL99QuvtOOucdZMhxDxlOXbuyU2Ui0OlnH19szuoFzr5tUEn1mUpvOQhNmnmefcUPnsSWDJ9MMGu/8y//uK7PZA9OsbTvLFAp4vX/fy3vkXVN6wuxUqgxICYGCLgymDcbi1sz6jnmm08d8BYBq/hzGjENd5F+dMygHhv5i6dsoC9F8MdM6XdMYtavVIJP+Xtf29UF1VH+YShluSvVlLZQ1TIgsDdhYb5crsfovYYMwTeNonjo/pA3Z47xka0pvkSNTBoy1iRx/v2Vh17zWvZx/Zbymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWMmIsD7Hq93yEQ+2l7UvzFucV40/ElJRlJMry1EpDY=;
 b=HW2GT8gbWzD67/GTKU9u7WuyOTmFEjzHFt7HoCKHGotK8F+wd2cFs9iJtQLuTZl6R/zQrsXSb9kDAz7jJXGnFlooLJ/xoCJa0B69TBF4fyrlkRC5Yyiim9OmJFq9M132Rj3/pgC/ucNDR6p1sliXcnotqczuQPO54wX1Bacum/M+nw8tXTDLqRiseneVmrusop6MLMgcRVJ3cIwgLCTa9xvno5omxzp1AY7ACUSTUaUsyITdDbhW66Ej7NZ+YVp0qqLC11bI24IujvbxzefYLCc3UvaOOenh3BV3xCjhPKBI0M2LeNcnPGdoij9XJuhYW5ASxcMneiqP8EoZ52UwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWMmIsD7Hq93yEQ+2l7UvzFucV40/ElJRlJMry1EpDY=;
 b=IiU6msvZwFbx3NczHcyRkyiz9RuW6lXW4ciey1qbAqb9F+/g2hdbPPx3jMc9TfDdWq4qrVOiONtmAOYg+z6SmoGsFqRJ2Q1VsIaei7TGy3n4PTYZRdCmUpX7C/+c7bWjhcTQvpBFGUrVdpkqmsWjN0gs5M0VK4ic/4+cTCLBUYL2/GV1vhrLYn/tGYRMvhcIzq1OPUxbYWeWV4/noaD67Hly+17XMFX7tlkeVP1tUf5yV8s8ahK89CVSONovO8L8SJ6jBZy/diA+mydF+Wwe0BA2EEeam8Od6H54Emc1khjGhTWTE076qw7xVIXraJOg2fu5A0wKHtVaLYJDCQXa4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH7PR03MB7003.namprd03.prod.outlook.com (2603:10b6:510:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 16:46:42 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 16:46:41 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 0/4] dt-bindings: edac: altera-s10: Convert to YAML
Date: Thu, 20 Mar 2025 09:46:18 -0700
Message-Id: <20250320164622.6971-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH7PR03MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd7ffe1-1d2d-42a7-5dc7-08dd67cecaa4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5xjEGc8UAPs3vCOyWFht5Y6fyRe6vqTrmRJkjQwfhHG7RFUZwM0DlrqEoNQf?=
 =?us-ascii?Q?67zJ0fjLiO/ZGf9uIo1ZjfPBcC3JUDq1Xd2ESWhOs3RLquJOyunw1TMAarQu?=
 =?us-ascii?Q?TiLn64/FmeAS40AYI9HKgKgIHwKbUG+eNn6p99sZs0y1pNPlVtGrkF6jfjoS?=
 =?us-ascii?Q?bin2ymlQSc1dVsu8KkDYbkF2hHIya+ZsbkOC28Mw/AzYlTr6/R+2AmVK1lqD?=
 =?us-ascii?Q?HFZyXOcO2eQYF/IqJH84SaiMESnbN2V3jr3Ai5DdMU9pDONY8u1EnMeLj6uT?=
 =?us-ascii?Q?od5xWBMm6p5mjik/RdX8ahS2XLxSKtAktlT0uvTuGj9v8ehV/OAmbvvzmtj1?=
 =?us-ascii?Q?3llS/fm9jnTrRbnyQq4Lg9I8+qY7Uh+Ff0iGcjEZFulOwgy7pSpmnSLxtPPW?=
 =?us-ascii?Q?LXJSE5hwRjIuMv1mUeyD3qeH7Uv9vec5dHU6R9iL4LS+5qOgfWPc4VdToF+Y?=
 =?us-ascii?Q?R1q9oBC09NlUcqui3wJD33eL32knZ1+vFFHD7oEofryYjRl1L2gQvPmprS5K?=
 =?us-ascii?Q?ItETmu8qGLLyy5zqzrwZxD+aZPV+vQSbijpbFmVbKrY79UgnB3q2W82NwQd8?=
 =?us-ascii?Q?J5bpwKRwbG2hApsWeVO7kLGdzefsfS0SGuUSMxFA1xpkt8YudEAn80CSDLvl?=
 =?us-ascii?Q?BFGBuvzEjPNMuMmxA9VH4jiHfzF9/CQm+AxpZWEhFULleOrH0f69NRfDYBzp?=
 =?us-ascii?Q?F21rOFYEuTXVuKod/pG2AEBPgWIvzVwbCQUhoA9ary1cIAiNI4RFe7qDJjs0?=
 =?us-ascii?Q?mCypZeoYto7fPCrqtPd7hiXY6UezoMCLD6mT3hHwi+8U9cb/HlKCQvbhleuE?=
 =?us-ascii?Q?eKfAwxZ3s7EgcROY/rYW01aD6vhzFvu3pRmjCT8Be+aOANm1XgmH9ua1zrq6?=
 =?us-ascii?Q?Faq2NEsO6xqHaFlmIX/lGW04MxfTwUtYBSANpO96uxObtITx/A2k4jQC+Mva?=
 =?us-ascii?Q?Mp6cXlX9DdjwjFqRDxgSOJTsXDSj8jf95sCMpX6s8TDjIyGwOFba+lnd34rC?=
 =?us-ascii?Q?a+gROm7bcm2DOdLi90/XDHThCjv4I0GpvNeWTz+vlPV8A14j+DHKBh6iLp7s?=
 =?us-ascii?Q?oWJEU0fQ9GqNZBUWoDsGhueEnKt4CafiRe5owa/1CVjaNcjoCDvnpFIIhv3E?=
 =?us-ascii?Q?/xxIJTDkxn8+Rs/kc2Q7xKYqxxp5mm51P0DAh05993Y912jdFhuZqbvbQ6D3?=
 =?us-ascii?Q?TOzRBGnPVpX08QG/wDH5aYkKO8fmq6t6+FhaLLSw49rtifyV4tmU113hdnuI?=
 =?us-ascii?Q?kIyLZSASnyfDPy5UfIOot9pikIrNxfRlerRJTRSJZrZC5XZ6Hv7EOPR5Q6wh?=
 =?us-ascii?Q?yneVcszrY3MMsTfq1y4PKxf677/JYTbO6zsiWZn0LUd5w88vNGnaB7M6eKgh?=
 =?us-ascii?Q?ThLzDwsRG+4220UDNLI028M/HLPfFLymgJ32wMfUnxcNcRifJhtS8SB7BWCr?=
 =?us-ascii?Q?buPjtElU83w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Y9QJLwsGkJ75MxVwr8O4f/INQP6T9qx4O5iE88YK8DxmpSiwPlTndBtkW5w?=
 =?us-ascii?Q?LfGRq9a4Kig2N6M2PXsrE1PkAsETXVE69JCSzrVa0+1p1461FkfnJH60uf9Y?=
 =?us-ascii?Q?LeSkOPTRHk/B+FDWN2AZAyBVli4/IgnC3hFNMWHn80bRPD0sNsG9bSflAQ9O?=
 =?us-ascii?Q?I7ACQjhzCktNRSnECj5Rlwia3gtxNOui0gJSuNuPz2W+NUMcEKqoovHbfX8L?=
 =?us-ascii?Q?d55UtYy3o+XnDxq6aTg1DiX24RVPPnHi14T+2D5LaaSWVlGZrauI8O0bg1Mq?=
 =?us-ascii?Q?5RuX/o4CSgQg3V+on67G8GBSMJH9EQ29iqkjlE0UdMp+E9J4rZWHsvG/JvI/?=
 =?us-ascii?Q?uOfx+CYlyjtjklXvWt0WRRtsQRnOgK4xI/738LF9Jrr7KNsiuLPfSJdjlTFp?=
 =?us-ascii?Q?PxKAW/p/mkZgxflDQTdXnp1ENBhGJXXSlsLmGXF7zBYHQOMOuNtlbIKLQfpE?=
 =?us-ascii?Q?jItk8ikR9EW6iZJQQElcteckvGnR8x/RRW56y+920apbU2wLWkQ/7yzNnbsY?=
 =?us-ascii?Q?gOkEzEkte6eIi/GCyk1O/8mTlO965X5ENU+iMcsGfiIHlSDSnB4+uvpt7UXg?=
 =?us-ascii?Q?LkyPJRVJiG53hyKJ0syCEkK1iArSd1lEgrQJFMs5U0vR6CXv3UE5CneIdxBi?=
 =?us-ascii?Q?4Y2pygH0QfHGe81t+r9e3RhUNqG/5U/yExeR97PeFS719QxtcFZWYHvX0UFL?=
 =?us-ascii?Q?dQwz3bxMmeKbbvreimkGxBOPuncRbQzZArjO/eqCGQDorW4vComFUngZSfPC?=
 =?us-ascii?Q?GjY3J5ti8iqnqk90s0I3LHP0qpku/UXd2qHacd6fRWivtiEyJAJXenJb0u8h?=
 =?us-ascii?Q?Tt3fmyx0rT9F4Ejxly7MQl/3MTg2GUzsAWRoJmmZo18jfai16+YaeOsO/0p0?=
 =?us-ascii?Q?4zgU33SDOqyZ1HX4a1j4hJRXvrhosuT1K++d84151LSm93/0vUSFH5jXrnow?=
 =?us-ascii?Q?shYUgFhSIGafQLUFJAn4gVdd2VGeexlbfNg0QWcIXthk2WldUpBkyjv109Z9?=
 =?us-ascii?Q?yA/eUqMigRtA7w7VAYC/LgGRiVua2XWUsHWysX/IOaYNELLNaBQM6jk5//E5?=
 =?us-ascii?Q?WRESQDGmGAraSR9026Zdwxd3BieZDMUXV9yM5icVmkep2b7RhhXJWRqk0ezS?=
 =?us-ascii?Q?F5O7pqil+9H2LrHgozZBfNCmmziTabouylsGk/GVRkaqSxWaSWh4/CTZrb0n?=
 =?us-ascii?Q?IZ1tkfTaOUzJoGnLFsHzWeZ4C9Vv6laRzUT+9sgzNp8WePV5L+rh74lkDgzP?=
 =?us-ascii?Q?nc7bvWUxr6uHOBuX94rF+P+7P0zUCYYWCciyZSsKh9pte6w8Ogw3ohPuq6EP?=
 =?us-ascii?Q?mTVPJp1haOPvHUFxsHAQZUHvQQi0XpHMdzo5Bh+fE7MZhGe+zSo+DXqtmMab?=
 =?us-ascii?Q?kSt7Cwadl849giS4JcgEOW72qrzvRWD+JHPbK6OiHVI4zMXvwmRbgZDy4t5O?=
 =?us-ascii?Q?lD2B0rcL2kyC0FXeAoN2rv/w7MoOqMrj2iw+9Z+1a2x/kwSYFdWWqbWoXS8S?=
 =?us-ascii?Q?+scNk/qlbn/X8sdbtZRi0i+9Z6TDQQGSAdlHhBNLuKv362fynmbQouvJdTxY?=
 =?us-ascii?Q?QSWH5J7UnMvidY87WLtuCxkL64gKRTSsaXqF9GpC4Q9mIr+zjz12G8lpSKz8?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd7ffe1-1d2d-42a7-5dc7-08dd67cecaa4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:46:41.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDNJ+7HjOQbeCID0QSzbPjl0pdCFb/Gk+U3d5nRowD3LHC8GtgXJ7IV0pQA0Jdq8rkU+RWWB/2AVK3sTWg4UjiLU2OWFWmWQ3wOKiHQ9YhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7003

This patch set creates a YAML device tree binding for the Altera Stratix10
Error Detection and Correction component referred to as the ECC Manager. The
peripheral subcomponents are the same hardware as the Arria10 implementation;
so the YAML binding does not change compatible strings of the subcomponents.
This more accurate hardware description requires some minor driver and DTSI/DTS
changes.

Patch 1:
  Convert text device tree binding to YAML.

Patch 2:
  Update driver to allow the peripheral subcomponents to be child nodes of
  altr,socfpga-s10-ecc-manager.

Patch 3:
  Update Agilex DTSI to use correct compatible strings for peripheral
  subcomponents. 

Patch 4:
  Update Stratix10 DTSI/DTS to use correct compatibles strings.

Matthew Gerlach (4):
  dt-bindings: edac: altera-s10: Convert to YAML
  EDAC, altera: update driver to reflect hw/yaml
  arm64: dts: agilex: Update eccmgr in DTSI to reflect hw/yaml
  arm64: dts: startix10: Update eccmgr in DTSI/DTS to reflect hw/yaml

 .../edac/altr,socfpga-s10-ecc-manager.yaml    | 228 ++++++++++++++++++
 .../bindings/edac/socfpga-eccmgr.txt          | 150 ------------
 MAINTAINERS                                   |   5 +
 .../boot/dts/altera/socfpga_stratix10.dtsi    |  15 +-
 .../dts/altera/socfpga_stratix10_socdk.dts    |   3 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  18 +-
 drivers/edac/altera_edac.c                    |   3 +
 7 files changed, 248 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml

-- 
2.35.3


