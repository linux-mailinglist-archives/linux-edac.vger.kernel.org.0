Return-Path: <linux-edac+bounces-4784-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0EB51B85
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C63AE585
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67F31C59E;
	Wed, 10 Sep 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z0AT4xmQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0EE224220;
	Wed, 10 Sep 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517876; cv=fail; b=a1uh49Tu0Hi8KCBKj6UbDlGUWIRLxaRFGCH5j1phbpB6jPTs4WQtxAJWEckVqAH5qyz67ccObdiFMWC2rR74LlJ78UfgifAKmCdYYDO9ysveYVhaaLnvO3TVzM0FuWe+EWvVMx+oY7iYQERhzCrWHGkCzrS7MDRj2FiFjWOBl8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517876; c=relaxed/simple;
	bh=wjE5Q/TVHqFchE7+Q6KKs1rBEMSYvkUVmiD/lOw9V/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QaEzhqW7Yksm7KDq0nJGRVDg9pxfhs5Xhbw2gQ8jtdBTPkGe9EpWxaHnMq8qro6rWguOOx61ov0f1VbG144wliNfSRTVgUNQ+SAxYo6vYoRewBjIF8Y4hhKI1eTcb4Sj3KvtilXqf5qbE6w3tiFvr71IeIhy06yVgTyCVsEnjCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z0AT4xmQ; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnZ7L+NupiElFWE+y/kEG0RcByv06qiuxqUUn9N8Vh7p8n15dg8o3HKjtywugaAhgNqoQlTLw9L+EmCUAfZ/fI8PNDCrUWNhRgNusMbroYg3N6GyUtZDVwJDkcNtJrdgiEV4+/6w2QBy/woVG63RW/UP0UpjBJj4cJTPLvIkVTxGCbeGfvcSU0xeCeBzaRm3Ototh0HzV8uvB73231p+dRde9libCs8c1ZTQaNBYdfchW1F9sRhi27vwbpZbSE80qtsY6+GzsA5eC5ghsaLMQmfbK84SdO/38Q3eOa7nnZ7GFms4/SuDc/bVbBTAGvL2sCbflRUQQkyCfVHXs95RKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW2XVEmC4dz2q7Q6gFUVucEO4+lI1+fYSLpecEp9Izo=;
 b=Pb7B25BtSCalDBC2oOmg/JC7LxEutdU4okioI8fTlS3mYr061Il/AzS0LgtZmDWr7iaGB1y1YKyymwiiCED+s/zo3E1WMk33ijHNmDh8bGufAqpe8H83NsOITV1lOGcnw7hDicr7svOC3BI9+MN1DecE36CtPQHyjzKh8b2j6ehwGIN36Z5ugFsRw5Z6OMIr+25CAndaEd5P8kbWeRgcqHVNqSsNOiJ9fE0dWbmbxzBrsLqtJVziIU7ghWgwQ9Ajcn6AGGBlHvcvW98xzct8LQ81Oy3P/bUoBUgFr2Kr84jHD0pXEnUuvT8z3HxRieg/TLZCwD9xAXmFAoI/lId7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW2XVEmC4dz2q7Q6gFUVucEO4+lI1+fYSLpecEp9Izo=;
 b=z0AT4xmQwnM4Pdz1h1rbPcmWZNtqA8RRGFDFYnScrV7fx6K0kCt9L51snStjGOsG1zdQw0Untg3hGHd5CEKYAbiRdgC1jKEXw8+ZFNcO/fK8N+LweHeuFUT/1FS2n39sGErXtLdjjy7yI0FSOf7ZMiRJFvhYhEizXnmYWEjgBdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:24:31 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:24:31 +0000
Date: Wed, 10 Sep 2025 11:24:27 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] EDAC/mc_sysfs: Begin deprecating legacy sysfs
 EDAC interface
Message-ID: <20250910152427.GH11602@yaz-khff2.amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-6-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909185748.1621098-6-avadhut.naik@amd.com>
X-ClientProxiedBy: MN0P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::35) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dbb972-5f9c-40dd-33f1-08ddf07e23f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbWyzthC5h1u/YYQVmLPJHMy8W57n5GoFznSeHgQUj5KQ4rOTzjLA0eRmCSq?=
 =?us-ascii?Q?KQFAZixOepxKYwzFwQn9FhrkpSKcA+UJsukXXRa8MmFBJi1SWZ9KFzylDro+?=
 =?us-ascii?Q?o8i+5wj4zoPN8iY+/ecyeKUnlVQWl8GPeV/CkKKTu+4j/ptV7z67aD0XGc7R?=
 =?us-ascii?Q?c9zJ7SGcgSUwKUcPodh4HP5o1nAvanuGzNQIk5AGf+gzH3W5EJWJz2K3tMCC?=
 =?us-ascii?Q?590kLJEQPRKm2Sjq+8p88b1w90UVC7UjOyZUzvsPtcbYYSB/uPxNWUCinYrU?=
 =?us-ascii?Q?8ZR+EPLwJWwXctmC0mqOxB5mVLl3pDMLDMVoTspS2bEDjXKbDcSsMW4s4ox6?=
 =?us-ascii?Q?UwvZ6XJSK9gK9ZFGG0qrEV9L1g6D6/CmIIabWCeZNcNR5aBFzOx+atKUy1gx?=
 =?us-ascii?Q?64upIqGYcnik+fr/Xp/kZfq9WaXFzKq/PkGgXI2ddVa8DxrWLdfpkgrwiw5+?=
 =?us-ascii?Q?LHEQDPxY7ZyZpzoUeudiFboieU+BlohkVkt7AheTDgfycQhkmyyzAte2vLNH?=
 =?us-ascii?Q?Xgu5GeEHWQKREAg0T0UhviTsdTJnn4fI6OOUDpIgBUvlNSKDz02IRrN0qrb3?=
 =?us-ascii?Q?/ymgUOViaDmaZybhXqxdDkkcNxcsz329uq31I2SRxvzc8v36cIL8/kPnkRSv?=
 =?us-ascii?Q?CZDBvZ8IGm2DlCR4VlSq8nJGTR2tZam2M1wYiX3t748BFm7BeU8B3d9eIkAL?=
 =?us-ascii?Q?+LpcTFhrfhdaueAZD8UIinLmrZGxnmMhfUsMMXP/WxIUh4C+DIe5hGPwYlVx?=
 =?us-ascii?Q?GQP2bUjIRq/b73M1Kc5gUkJq1hyu+jR2cx4pi1SzWYggBnbB1t9KShjxiwLC?=
 =?us-ascii?Q?cmrKIGbWz0HQFrSteeGTgnfWB7mrksRQVQBFBcrJbkDJIQ4CTRosyOtrFUDI?=
 =?us-ascii?Q?lPMwhCPiEcYJq/D3dML4F2QfYs0wXTnigAVY8z1S2XsgIdmZAIwkvQOEXRwR?=
 =?us-ascii?Q?SOHm5zP+ZMsTU7fUzJHDWRZfZuQQltwvNahpYCALxkKcyn5TbnYa8fQbdnlA?=
 =?us-ascii?Q?OWUZf3eU5SUyef29tVHg+3F6qWtEn1XTSLjitEuuQu2YvsjKHrnT2UhzjFmd?=
 =?us-ascii?Q?jJEJmwgJCc+jLt1lsYj0JJ1fqgu3dSGKXRCLypNOj+l4Vcre80nrgSXUM+Ex?=
 =?us-ascii?Q?TqEM3vlIFUatp7uyanf6+aAAdiKn8a8PuJRrvGQcqwTXQC5tXrTiVeOFqtDq?=
 =?us-ascii?Q?to8zP5ZAuoUSRYcUQeGC7hwiH/J2B/2UaR4EM/dluV7drXY7z6whSfOuh3bs?=
 =?us-ascii?Q?vPBCzH4+PDU7CYxKPFiuI+FM3ApID2y3LFCitk6wSsbnqyB51jOUAVeAUKCd?=
 =?us-ascii?Q?DmQAon7JvvB+4m5pUSiMrkkVdRpd226pZchdhyv+xxq8HnMY5dllVVDEW6P8?=
 =?us-ascii?Q?KIOvdCvNwdhjg+OB2XhS8oyQaFapYZ82ZoosENB3BFT2G8dsdjqNkX6lxtDh?=
 =?us-ascii?Q?RwzQLdP+oXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oqu5f4cY1x4N9D8DfXJPaPFckZV5tUgZUQ1qGz1m602/me2Ao9x5sq103c9V?=
 =?us-ascii?Q?wX3FEwamqxrtduC9WwMkpJTmBPNvbmRr6Swq+Z7EPrqTm/RRJfF1Ul6/JO8E?=
 =?us-ascii?Q?S6FIDXL/cptPCVcPKjctZEFv1sMIS3b53WP9vvWyuhvR/d1kRCPEI//whVhK?=
 =?us-ascii?Q?QDn7upQ+IFNatnQiJzhVElc3b1P5UIMrGSBbo2GOZxfrdjZh4Gx5NbgwZblk?=
 =?us-ascii?Q?DCtjpjGYwPQU8y3L9eb/TpXh750KoY2dEgbS5fARx2TNfGGxHgKSluQgl+0e?=
 =?us-ascii?Q?KHbu0q4qfqhwj1zB4TorDwQ+CDsr6yKYssPTUNoIYSRNsKtaZ6vRPbuDxGyh?=
 =?us-ascii?Q?fH1YCWiVAaAOcrDmXMXyniMi+8fHIWbiJ+605Vzknrs57BZif5n6yPmqYDrI?=
 =?us-ascii?Q?gcOZUDw3R2/50Loqp4+CClRfe6jk3pEBn3kECzKILXYA+4kVNmB90zP94qOx?=
 =?us-ascii?Q?Z6hNJ9PXtTgp4XRFzEaO+eM77wIbSXmSuqs5ap/PcwgxeHLKSc2IjtvD1lcS?=
 =?us-ascii?Q?Pu6A9MbKXeBNJGfO/08+vQpTRe0OGHPUT6QzmwMlRcEuroe2tzWtS9glTi2C?=
 =?us-ascii?Q?bgtUbUYI6JsF9lXPUdiYZFe/HGVWrvKTfr8jEJULcD59/j4IBh+HvwLADoDV?=
 =?us-ascii?Q?iQ0raZdFq+PcU+OI5ils7a6ve0HAQjaZ2TNn/C816N0EFNYtVaAVB8MMaED/?=
 =?us-ascii?Q?T6cwR5GIr8HPrRj+FqvZC3pmru8XDTuHr2IeDKtnD4bA7hcpTAn6Hg/l4pdz?=
 =?us-ascii?Q?h1NUMjmQ+lDVVvR0WYagQIFlI9Aqky4Mq5emoPq+8FbZmf8whl7kJWDtudf0?=
 =?us-ascii?Q?PpZDlJ+OmWns2OTxT14Yfzzl52NDhja0GQBYi0KUZWVxBjzx8+P9yesvOhMa?=
 =?us-ascii?Q?Xx9nRwnH4fUQ+lzyN3tUFXUod9a+btauaoKabFfpxDWEj1pDmoO6NPOajuQ/?=
 =?us-ascii?Q?13XXpPS7cBtrvpG1GZJ6FkLId1lfX0t0PRJoqvu9eCsvRPux6JJ6BbJMPgLv?=
 =?us-ascii?Q?c/QCjwpqO9DgpdiE3OercyWMymcdthHEroipynhSIsb0qr1kPygV/k0iotKa?=
 =?us-ascii?Q?9TSkf8Wvx492EMK/Y83RHqKjTcLI31kXciliuIuX+GKThKvTQY9S6o4yjfUH?=
 =?us-ascii?Q?lH41OhR8Oe0+2QIahMqE1xTVWfMWH63wrHruvzKvg0od8DqxFOfQMutJWBih?=
 =?us-ascii?Q?EhLJM6Q45JbqHsuXfXeua7jtl+NjBNy+4ODrSQ4Bg//JhG77WKjClbOReXkJ?=
 =?us-ascii?Q?eVXtRtG1sLbDd3RUSPjEohcQuTtbuDRLgEGai/PxkWGeXdTteS8Yo50FUNce?=
 =?us-ascii?Q?zHvH5D/P8jZdEGAOIofkEsrHcW+hnTqsfCfQZ6ozVESYRGvmGRkx+BiUi5Ij?=
 =?us-ascii?Q?K9SusW+FLJODWdYHFyQQLsNLZUjkMOxNEdx4tackwkNg7mn/GNMYqp1DToe1?=
 =?us-ascii?Q?tyWbZBjlYlSkQfZknXExt7WA/FKUmcMRPZyd32V1MRGKxAD5QGXImqkD+u7R?=
 =?us-ascii?Q?3LaFkNggP8aarV3GAv9b0dvnEPH4ui9v6FvsYttaLYRNLKsd3Ti6ZT8h824y?=
 =?us-ascii?Q?bF/Q4a3CG1SHTDhNBoOpKVBzdu27D/3R0mssF2it?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dbb972-5f9c-40dd-33f1-08ddf07e23f7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:24:31.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DII4g019QmJlXHX6gyH0yOZ1W/4sA8z82adVzdb0TEB2IPIfTrLSvc20OZ4tMc15cQBFd9VniHKvo1qn1voqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

On Tue, Sep 09, 2025 at 06:53:14PM +0000, Avadhut Naik wrote:
> The legacy sysfs EDAC interface has been made obsolete more than a decade
> ago through the introduction of a new per-DIMM interface.
> 
> The legacy interface however, hasn't been removed till date.
> 
> Begin deprecating it so that it can eventually be removed two releases
> later.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v3:
> Patch introduced.
> ---
>  drivers/edac/Kconfig         |  2 +-
>  drivers/edac/edac_mc_sysfs.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index b824472208c4..19470f4efee7 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -25,7 +25,7 @@ if EDAC
>  
>  config EDAC_LEGACY_SYSFS
>  	bool "EDAC legacy sysfs"
> -	default y
> +	default n
>  	help
>  	  Enable the compatibility sysfs nodes.
>  	  Use 'Y' if your edac utilities aren't ported to work with the newer
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 8689631f1905..3840eef942f8 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -144,6 +144,8 @@ struct dev_ch_attribute {
>  static ssize_t csrow_ue_count_show(struct device *dev,
>  				   struct device_attribute *mattr, char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
> +
>  	struct csrow_info *csrow = to_csrow(dev);
>  
>  	return sysfs_emit(data, "%u\n", csrow->ue_count);
> @@ -152,6 +154,8 @@ static ssize_t csrow_ue_count_show(struct device *dev,
>  static ssize_t csrow_ce_count_show(struct device *dev,
>  				   struct device_attribute *mattr, char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
> +
>  	struct csrow_info *csrow = to_csrow(dev);
>  
>  	return sysfs_emit(data, "%u\n", csrow->ce_count);
> @@ -160,6 +164,8 @@ static ssize_t csrow_ce_count_show(struct device *dev,
>  static ssize_t csrow_size_show(struct device *dev,
>  			       struct device_attribute *mattr, char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
> +
>  	struct csrow_info *csrow = to_csrow(dev);
>  	int i;
>  	u32 nr_pages = 0;
> @@ -172,6 +178,8 @@ static ssize_t csrow_size_show(struct device *dev,
>  static ssize_t csrow_mem_type_show(struct device *dev,
>  				   struct device_attribute *mattr, char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
> +
>  	struct csrow_info *csrow = to_csrow(dev);
>  
>  	return sysfs_emit(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
> @@ -180,6 +188,8 @@ static ssize_t csrow_mem_type_show(struct device *dev,
>  static ssize_t csrow_dev_type_show(struct device *dev,
>  				   struct device_attribute *mattr, char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
> +
>  	struct csrow_info *csrow = to_csrow(dev);
>  
>  	return sysfs_emit(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
> @@ -189,6 +199,8 @@ static ssize_t csrow_edac_mode_show(struct device *dev,
>  				    struct device_attribute *mattr,
>  				    char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
> +
>  	struct csrow_info *csrow = to_csrow(dev);
>  
>  	return sysfs_emit(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
> @@ -199,6 +211,7 @@ static ssize_t channel_dimm_label_show(struct device *dev,
>  				       struct device_attribute *mattr,
>  				       char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>  	struct csrow_info *csrow = to_csrow(dev);
>  	unsigned int chan = to_channel(mattr);
>  	struct rank_info *rank = csrow->channels[chan];
> @@ -238,6 +251,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
>  static ssize_t channel_ce_count_show(struct device *dev,
>  				     struct device_attribute *mattr, char *data)
>  {
> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>  	struct csrow_info *csrow = to_csrow(dev);
>  	unsigned int chan = to_channel(mattr);
>  	struct rank_info *rank = csrow->channels[chan];
> -- 

Depcreated -> Deprecated

And maybe the warning can go in an short inline function? Sorry, I
forgot if this came up already.

Also, "two future releases" is vague. And it may be confusing if this is
backported.

Does anyone have a better suggestion, or is this good as-is?

Thanks,
Yazen

