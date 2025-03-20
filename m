Return-Path: <linux-edac+bounces-3376-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF55A6AB60
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 17:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD804812A9
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70452248AC;
	Thu, 20 Mar 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Yke5revD"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AD221549;
	Thu, 20 Mar 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489208; cv=fail; b=ujMY2lxXAi2hHtQNBZPFqgAwwqqpoZPLcLFnnOEqAnhpGj/gRAM4TqUQ09Jar5l+oXOryTZzEYy5wWsZYpLxdsAc/CGzldR7i/YmJzOwhfOJC1wGiaJTU6ptcO0LM9KWlI5roRezdkhvbxqB4CwbqSBcJ8nWtySS0CpMPso6VxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489208; c=relaxed/simple;
	bh=qZKUgL9b1Eh0TgltJWnDknECpkuYDWSQeyqEZDHrm3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtHG2L1dLyrhrfYrNXYLREuDutPXwLOIy2AtfJ8g9I9vTcmeVKijPoa4RH9AkQa0E+ivHl8xdkg5OMYfsjjchdlF3ALl/AAAbr7v9nfvBMVV0ahCGds2KjFvZv7q8W061G4gDL4qMYwVWUB4HPfLJFwsBk2uKt0XgI1TMmj0VOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Yke5revD; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crdg2fGof84QlRF9DhzBa+FV8Q3s037AQkxdtE15rPmoj+BjbnI2uEHSitDvEkwnh1ku7IP+MXpXKwKYok6VwuUGkqzBvOXPCNApFJmaC4Wj1penpx+cpHad4ZolRU1XJ8ne4lg1GPhfYqYnhr5oHwFPbYStoQn++YVqTqcABeBWSh2jQeLjeXbHpGukvt6ltBPjlhdn5Vu2AI8/Og2EUeYC7rWLlUSCYN4x3CN5Fk6olpTA9ZqRTEM8o6u4NnKrv/sCJKgi5gchwZlmoizBBGZmgDSKFEV1L4Cbs7siA+LOCAndIMAwssObwD3cyGgUemQCviIIH1B/jxTpuNy1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZtEPtlk8E+OSJbxyZUtw8Hakg6tokQ2LJfFOoMo4k8=;
 b=VHp60Hvfje9RSeWLf5extHEH4ZpCMLWIAhYtsQpcyCDXrfjhBqfUXh5o9g8adX2GivWjU4VZXzKr3NpbSyJQ653NgL+uX/ubgRY/eGAO3Xp6fS/HH1bbYpfIlyNkd5zx45evBiPOTnB87KKumwXBftftOOOSSV+tHlw8TiWjKzufBppQpru5IsREC8YHMpcqgYJarxTiE4SR/kh+3gsAmTedDAWQpWZT8vHztr2N+bKt5OLSuuNZGuMRmRfH1JGU9M8ytTVNQC5JemLs36nUh84ulGk3F0nxuZoK4CtNtPBthqYpllLYQ96+7pqJXKPQdOaxXDpStJVhHnkqZzPVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZtEPtlk8E+OSJbxyZUtw8Hakg6tokQ2LJfFOoMo4k8=;
 b=Yke5revDK4HC8BvsZfsvmeW0o1hzZlBSvOwS8+byM+0Q/jJ4doCW9xif6Tr8+m3VwU/g1nAx09L/sbBTlIMNhxfv6cc89jESjC+UciVDRyUkzsrgD2d6UyIWgcCfOKBDOTvYXHVij7418Tp3YMdf6h417pLNNcTmvVJO7dYDyFTufbWXmni2bHdzvDvQT/vDZRvt+zfXmV8997bdxczc+EuXfgnBBrSj1uFL/2YpJW25d8mz/zlKPtPOeKsgj/53PwoXM+PVdQHfX/SwptogzoKkBVBM/Eyz4aAc5KDS4e3SgzY+WLygw0UBiZfW7dZIxq7A0NCKy9+cqmc9LP/Kqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BY5PR03MB5014.namprd03.prod.outlook.com (2603:10b6:a03:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:46:43 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 16:46:43 +0000
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
Subject: [PATCH 3/4] arm64: dts: agilex: Update eccmgr in DTSI to reflect hw/yaml
Date: Thu, 20 Mar 2025 09:46:21 -0700
Message-Id: <20250320164622.6971-4-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250320164622.6971-1-matthew.gerlach@altera.com>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
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
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BY5PR03MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7580644b-a39a-4070-b8bd-08dd67cecb92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8d7HT9Cd0bPn551FjfYECIXS7+kfdfx8V8KMy+REFfQNSOKKPlpfIGd8mKI4?=
 =?us-ascii?Q?W+gGm0nz5ls9c+NjDmWHSYiQKPAXMSB6EhWkgn7uH0rxkViu+izkQSQsZRkS?=
 =?us-ascii?Q?hxlnuNMtHj6ztB0kvqivyzUdhRLX8CIH/UgHzphhYT02LPHN5eTuq5YUbrkO?=
 =?us-ascii?Q?PUl/4Kc8+NXTYIkdP8p/q/baa/PsWGx+2jO+HAgNdX0MiALACDuVaIyCeT6n?=
 =?us-ascii?Q?lIWfezDv3WDZrL5TTJ9VAzIIkfxdk9156bt6k140WClXfsypQwMSaH905OdO?=
 =?us-ascii?Q?XWuRVs2/LA1pBtJ/1f8d1s6D1CKjDR2RJ1kMGW2PUGHm0DN0hkrquaNMOLCy?=
 =?us-ascii?Q?vD8ZdPdG9LK25wnXie8dCFc+Qke1ba7o5lq5KwSbUy4aRObgDmfSwLMec5pQ?=
 =?us-ascii?Q?hyjITSdvFnT4x5nzHWPi2Elq3BgGh/WxzIRnILfgD0jNY43llLvSNIS47Eil?=
 =?us-ascii?Q?Cum62AGHpohYbGksuE7i5Q10BxuGtz8wyui7BA1pT5RC1CS6koGwlRzrIliV?=
 =?us-ascii?Q?tA4yO2DcJmtK4qnMo3g3DRRFVZJe3W5DpVgMLlCOeJoinfhKF7Br8Q+crZ6e?=
 =?us-ascii?Q?YPylS9gA9gKWzJRvk8EJ8DJCf2b0s8483RQvLX0NmXQkIXl3+STTXxfiYTE+?=
 =?us-ascii?Q?dd8rZQYMYjUIsrMtKIJhQ/FDMXPia208h1VzHdE/iQyRPF9N+dJwA5rTB8wW?=
 =?us-ascii?Q?9UpVZiCzqnwaa5yxLTTqkRusxAFiVMUbrqIt8GWF36IzuNkGR2SBdEj31uCM?=
 =?us-ascii?Q?Q6Rt0GTG7NokiziS++tCtZ+8Uau14v7oHLI+1CgZPDf2DZmyeBXAG2rGdaA7?=
 =?us-ascii?Q?xlKsP5HcN2fUHtUIrACsdj7mMmmQRUDXoVEBzUCCzPVJHaO70+UVlRERTbDn?=
 =?us-ascii?Q?i64x1zUidYUU+9vBRdYFTtjwaUGLQJm1JDzm9j8UsmXbbdGrRbJ1AIAyW3Jl?=
 =?us-ascii?Q?pGdW0jprNwXEBV6UfdUm1ikatC0dyNCgRv77xwU1CrsanYFBaufA5TIowuh4?=
 =?us-ascii?Q?X2f/EdZMrF9ui48Zzv6aBqzarv4BnSYtdINlSoFoe27tfLPp5QvuVcurnDEu?=
 =?us-ascii?Q?GBj5vrzFth0o5koOTVTX75vRfSOQ8sVYLKvnOtvB3ntgbPpIX6rilerjms4z?=
 =?us-ascii?Q?y2CQdQXfXpOYEjtqCCErZKBYOURbesdr715AEThW34fZH/j/Cza+g0HwD4QB?=
 =?us-ascii?Q?LMXcs0JAO8EiMuTuxK/RVsHeJ7mR1IwEzkU/JWpQ7RIkNCAHhKA6DvqJLPwx?=
 =?us-ascii?Q?uyyCChu1KkLxD5dMNIPpOBGdBMyeIOEuzMBPFBQ0vN+Fr4BXDQJ4hL8yMcfz?=
 =?us-ascii?Q?3eqReOT3zzrhXRC8UTMXVQH2s9zSL/7UJ7aMRNZEo3k93zEuyhKZM0U6dEiR?=
 =?us-ascii?Q?2ZywJG1a9QZg1Wa3RpzbJvenZ+Ki+d0VFyNjJzNsRWhfIe+HaDOUHB3Q4fZJ?=
 =?us-ascii?Q?iHTlTrD3bFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oc3lOKx5HmTMgWJJqRQfkI88OEEtgG8gpN3C98ZoZQ0CsUU+v94Xa++IyIuL?=
 =?us-ascii?Q?Rmb3HSQRextTG++dMxMSgMvEokyCk0SarOmzM+O7zM/v3E19+1DzpHMESy9t?=
 =?us-ascii?Q?GYQ477YjppKOLFfagr3Lh9DVnJ+fgOrs2l7qDUTA7dqhaZ0AzODtOj9+8FIv?=
 =?us-ascii?Q?q2x3kRfd8/BM3ElkuTuDZZ+rNLPwCPqkoHKpJs5sjSriXQ/JmdhzUjXBkwNh?=
 =?us-ascii?Q?4Bn0Dux66hGETucKUko/z51gIiYM9cxj8AmbrfFWNwSDH2jflVS+VxloTVV0?=
 =?us-ascii?Q?h8MrBapcurbFtxosgUO/V/GWXJjmhGFNjJcsErtvvN2Lqj6Opn47qHGvJ3N2?=
 =?us-ascii?Q?9oK7kPl8y8Og4YLZT5Vn47BooSzNSZm03kcl3nkrDTxvsnDEq+/ErEAh1Jsb?=
 =?us-ascii?Q?IEQ9EKCf6+SgW6cS5GCU+Pf/OWfOX0RTU+xiqG6MEhHGDmnU2G1dWppB2D7G?=
 =?us-ascii?Q?rYa/7rs/flly4uOhoHpvCOQy9Z6O7b2pTYulc8ws0gw+Sc9lKfgpK8j4o3co?=
 =?us-ascii?Q?rbXJOsMCFkIMc6d60J1TCxKJEYIR6iXBvQYIuvr1ZKeDk0Aicl0lHpfH9MWk?=
 =?us-ascii?Q?yYhwk7vhuG0cK2jVE+HRB65xmJj7/Aya7Ozwr2KYqDYCpM9wzg3xwLmcTPtW?=
 =?us-ascii?Q?YYOCsgoM3U+Z2EcbADgxNL0bAIteZaFskCFLbV20mcsUfl7Qe+CTa0pWchok?=
 =?us-ascii?Q?oebdoVhGqs8de9/dDPzjcIYRAYvRv33MapsW4ad9Cyh3rYjtdgt/j+kWfHhN?=
 =?us-ascii?Q?sb3koucMJwhQXDL+YJNAYxhnidl930Ulm/uoBWqTWQaP86CmKs8ajQ27ej8i?=
 =?us-ascii?Q?8GKpvTr6nwJMneIgoV5pZmug84455gALW4tfHA5EPU3CZU0CFma4DjLSJEhT?=
 =?us-ascii?Q?jl0DrzD78bzItlfEzxIEDLZeQsO/4s2nfou2A01YRpB5FaTa6y5w12SHrsT5?=
 =?us-ascii?Q?kyW2vHJ+Z86wk4A/tIMTSzPfyWNlN+qneuO1Yhl6ZoBW2uVhMLlbglorPGCE?=
 =?us-ascii?Q?KCAXe9yH637R8inHTQ/RgvESRGdVpdktyw3ID01maNdK5uEGGngG1gw73xol?=
 =?us-ascii?Q?uk0I8JydI1YNrQpXl1+SUHEmXdJCOWsnT4gf653ThQl1OyhnbpBhVay86HA2?=
 =?us-ascii?Q?uV+lyWY7JWabL/ZsEMq9+/wL75wkBnozQiJGx7mC5UO11DtUJbvj9Upx7qm/?=
 =?us-ascii?Q?zmWawxdT18mgWyWBn73Vm6PEGZpT9ownMdFlFQQyhupWAyBwilF0RfSoyyFH?=
 =?us-ascii?Q?RfliEsYbiCFzioZAs9kFqKw0vlNJ5og1Yd8gLWGHgFDIGthqvI7WmWg7Iany?=
 =?us-ascii?Q?XnECopt9/hafXX54NR4saF5DZ4mgUc2FltWqBgXdMZj9gwN9PlLzXRvT29D9?=
 =?us-ascii?Q?ZjrEgcuTNuqtNXKMpgwSrl5vrfGmEJ5afk4GwEMcRJJbbPjPvmvOxdFPn4rS?=
 =?us-ascii?Q?8vhrnyMlUosqfR7Gi5jh3hkKsQMG8EluQ32h2wqf8q5txifeQ82gpoXqOWC1?=
 =?us-ascii?Q?nIglp3riOQM1HrCtG0KTG9XhJ8m7N6Md0c2MpvbJNrrnIeHe4vOqc91aPNo1?=
 =?us-ascii?Q?YrqQ9FFdqTEc5x9DQXuA/9F7zBk7JGDPE6jRAYsRP+3nRtNO8D8rCVwRG3eP?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7580644b-a39a-4070-b8bd-08dd67cecb92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:46:43.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18vMYz+jeAtSNhnGV4w+lOFmEPINQCPT1TOXbYlx0YjFnHKkkynEN6LYOEnRE9hcuzSB9tu7A4yT8ZcWv3tXpSViUN2ZGhftC6MqC7jFFuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5014

Update socfpga_agilex.dtsi to track the actual hardware description
provided in altr,socfpga-s10-ecc-manager.yaml.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 1235ba5a9865..708cb8e762b6 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -602,8 +602,7 @@ sdr: sdr@f8011100 {
 		};
 
 		eccmgr {
-			compatible = "altr,socfpga-s10-ecc-manager",
-				     "altr,socfpga-a10-ecc-manager";
+			compatible = "altr,socfpga-s10-ecc-manager";
 			altr,sysmgr-syscon = <&sysmgr>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -619,40 +618,35 @@ sdramedac {
 			};
 
 			ocram-ecc@ff8cc000 {
-				compatible = "altr,socfpga-s10-ocram-ecc",
-					     "altr,socfpga-a10-ocram-ecc";
+				compatible = "altr,socfpga-a10-ocram-ecc";
 				reg = <0xff8cc000 0x100>;
 				altr,ecc-parent = <&ocram>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			usb0-ecc@ff8c4000 {
-				compatible = "altr,socfpga-s10-usb-ecc",
-					     "altr,socfpga-usb-ecc";
+				compatible = "altr,socfpga-usb-ecc";
 				reg = <0xff8c4000 0x100>;
 				altr,ecc-parent = <&usb0>;
 				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			emac0-rx-ecc@ff8c0000 {
-				compatible = "altr,socfpga-s10-eth-mac-ecc",
-					     "altr,socfpga-eth-mac-ecc";
+				compatible = "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0000 0x100>;
 				altr,ecc-parent = <&gmac0>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			emac0-tx-ecc@ff8c0400 {
-				compatible = "altr,socfpga-s10-eth-mac-ecc",
-					     "altr,socfpga-eth-mac-ecc";
+				compatible = "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0400 0x100>;
 				altr,ecc-parent = <&gmac0>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sdmmca-ecc@ff8c8c00 {
-				compatible = "altr,socfpga-s10-sdmmc-ecc",
-					     "altr,socfpga-sdmmc-ecc";
+				compatible = "altr,socfpga-sdmmc-ecc";
 				reg = <0xff8c8c00 0x100>;
 				altr,ecc-parent = <&mmc>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.35.3


