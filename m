Return-Path: <linux-edac+bounces-4604-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F7B2C5A4
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53987AE853
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2131CA7B;
	Tue, 19 Aug 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3VMLj5vb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A722C11DB;
	Tue, 19 Aug 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610249; cv=fail; b=JbA9saS9o9hQMFZ7EL0glGdOsatlEiaHDMzibGmSXZuDk71SQqdmwv4uegJh/+ecnKccWfX6dbYe81YqRvOi/LapqoTZo9P6xHpvzK3XkC9GekMrDSI7wzerwDgYpiCj6B3fY2HRIWeQ7tXDekSNE4D7oi52qvDN0YkTIoqiDlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610249; c=relaxed/simple;
	bh=nFlYpObinvQWQ4XEgyj4zKG4PsbUBJXi9MpCQ3tF0qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AiACV2RwT22/n37iWRGj8kXTj9/RBYh3go9nsfi9K9ifzIqkfv5D4NJ+sYFEkQK/QfH52CXNahqWoF/cOAJjZTkc3OwW4V4L6JZV7v3oqNf9vSHnp20NDWMEcM7U4HDW7fmc/PGovN431PXrwZyOJCMEnY8mPb7WuEDe99TmxiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3VMLj5vb; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABt2MlifLCo9NDkHiP0j09fBcjtxSWThByLm8EVO1u9qXh13xqo2mPhO4MCCZvm/oMhwmvMJG2ZIxJ6+/B6szgslB+8JksfQh5/MTTevyYooBYIIxAv/8dzTGw6y0B4NHELhfnuR7AwAhnM0PyTb4eH2eCvU6vJOCH5RLVThh2p58zjbQV4n9y81bU73xtY9+I0uTxvFibj9TGdMctnsI2EvP9VIbcOoJ+vnls3byaARhXR9gZrlJnnXxg1y6RJzex9mTYw1il1CXNxCRxrZi/JPsqXRK5N1+Y10BUJ82cNwn4iHihaWjwxXtwC+3Lp8VJ3cihiTCKJtz+Ii149JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMiZOnFO5s1YtfI9cx1uK6V9/P8SL/bGvu9trFQcC44=;
 b=NxgsoqC7Vk8YqVc+H7z17/j5GtpQO7J1yqvG9UIQH9kcVerh8m4ceyt2cr1W35dsMY0QSXHaLh0AWuUmpB/gkooCjtZVzVqXEgdxul+qqXC2mTFwx7aFgCRwG4Xamt3nYqWfodk5uLEqamePXwzRXa+67k+/7/uw2zyc6vIq9t5btAHcMPfGyxJyIeqYmv4SsXJLK13VoZNXJ0I1+ylt7oyxhIEOXsrkCKfHWSwRji4+9r3yJkbzo6uEqpyVKgbN15YysRTqzVjf4MVbIia8+5JLF02bV5IxHm16rnCiSnD37ribYhYL/llsMwtVXbvOFAqzEVBjJ+h317Pr4fqyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMiZOnFO5s1YtfI9cx1uK6V9/P8SL/bGvu9trFQcC44=;
 b=3VMLj5vbVwhe9F9dU7rMOQER2nRc9n8mq7I4PlEl3aZPcRYRbnywHojPKXnyOTWASnT4eXOzkDAGcc+JLYkrk1trDLaB2MSFyoMvneC1fSkPIzExlLs1Is4g/100RBSzGpXw3L2m1dInqheU+8XtrkSg7HzRb3VkCUDBextcGDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 13:30:45 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:30:45 +0000
Date: Tue, 19 Aug 2025 09:30:40 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] EDAC/mc_sysfs: Increase legacy channel support to
 16
Message-ID: <20250819133040.GA359442@yaz-khff2.amd.com>
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
 <20250807201843.4045761-3-avadhut.naik@amd.com>
 <20250818213651.GIaKOc88InL4iy-SGM@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818213651.GIaKOc88InL4iy-SGM@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0443.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb9128c-adc3-4c95-691c-08dddf2499d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzCXfzGnHfvC3NvK3xxWNzQUjAjU3ZwGy2ozVlq0fUohqb8L9Be42tGIvB/V?=
 =?us-ascii?Q?r9LnWN1ZtisNL1Avae40a9rDZUWe3WgPNEnm8bq8J9+D5GVeAJMpdd89tQn+?=
 =?us-ascii?Q?GO5MqvrDBZnT0FLfNKJSz9RySiVD0UpNNBTuCfc6L+ZzbM9sMM3gA+oY+jeq?=
 =?us-ascii?Q?LQUEOA9u8MbDhY0GHtaqDNXstXj6xZsMusG6nwY2PujNDQNXV/F6BVk9rX4U?=
 =?us-ascii?Q?BXhSN+p1lL25p1uWyvP4+woxTmw4eBva3QD0CCrDS8JzEGRmwCOGkWQym/4n?=
 =?us-ascii?Q?UHeMmw8a/osQDY8wlUmic9f7yIZvMCWc4z+HbXbF7SOj4+rloJlAatL1SqHt?=
 =?us-ascii?Q?wjO5RfqJIpM50wCV+MRvb+RRW2dtaTkLJ3k+rF+46C0I3KwzHpnpbzcag/MI?=
 =?us-ascii?Q?MG8rnlKI3YihE58xdVKZ93oO13mQsuikyvb/31dm22YKGzJGYf2xc5CEhhI9?=
 =?us-ascii?Q?UXpq0EHLg1NW76nakDenYpkfEN+ZRsMCC+LiAZygqcKaG+GqdZOHr//nfTou?=
 =?us-ascii?Q?WoVjB+qdWW+ZF0KGU5i+8l8v0bpzVPbHn7HAgQ6zplO5PxZkChOScRRnKdWy?=
 =?us-ascii?Q?dtVaBnfSDlxHHHUNRkankfq6KblHks55tEE6ubKS6jmm0ZYiuDky1DjMVIxN?=
 =?us-ascii?Q?/GY2IMTV5aTwCOv5lwPDli9FsBFsK4ZO1pdjq7DqIFoLMH+vzMAQyV8UbQ20?=
 =?us-ascii?Q?IBHavCxxuGg8oR3bBBh2aPcbixmhwK9XSR+MtWxyfB6g59pImUJUhOptFcKj?=
 =?us-ascii?Q?jt2O01R/Uij9sWKImrDrCW1YIFDJWqrChYSc7foW+B2LgfXjEsvi+UFOmpvK?=
 =?us-ascii?Q?ul3j2DdPmZMZizEs6bovy2g2+t4EiywJsVBolo/utKoChXrDtAt8sHRLzO+C?=
 =?us-ascii?Q?EeBZvG6Kke4h/dDL7D/yJ2+8m1JvLm7ZnJY7UG2rk6KtSvEOOYn52bmHP4cQ?=
 =?us-ascii?Q?crAg45OVeEFfLx2iZG4piQClH09wEvm9UWDSlJSArt8Ht0SrcoDEI69TK3Na?=
 =?us-ascii?Q?g4++Aq+5+6hzk7AZIfAa+qTdvL4bgs5nfYDLVEXFQwfbEGk+HLfjkY1EXDqt?=
 =?us-ascii?Q?IHQE4UAC1MAjvJ/+uQuKgCjB8D4+ncOVNr79TE6HJs00GaF9c3KjYPakUVHm?=
 =?us-ascii?Q?5WknwwPmd+ez9TKJCNpNdZZTx4YqfWzHDwN1kSAOftmbl86mziQ15Ho8domn?=
 =?us-ascii?Q?jzkVgeQmNqs9z3Hx6cqix8fBd9yRA0Q32gNq4oKi8/lVWAkoFYd+ptyMBWEq?=
 =?us-ascii?Q?dacvW4M0hPT24Ay/7+YpmzJT9tq880Iu/WHyELOtGxH7VjrhprDlHQZCoLmo?=
 =?us-ascii?Q?AlPlZiJrnzXs2vRfj6NmZR8cEv5wT16XkaxqKcEGk/eI3sUuoik2tmFFPE49?=
 =?us-ascii?Q?P/n9KfwCXZPeuz/87vyZT/CBJT89vG7ZlcA5v1/tMnbmjx1TQmOhnh4HxSNP?=
 =?us-ascii?Q?cTVWTTVSk5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/uzISaIS45qyHgZN2pDxXK4u4CbkKQ0LM9uOtF6ZHLhwxhV71RDfX4qu2yvt?=
 =?us-ascii?Q?uYk8xeHFo2qyr6JZ9j8X+wW8FX3eOk9YEVA8pfwba9vr4YeQqIwh1loLBJTv?=
 =?us-ascii?Q?ttHN/cGDmZqjQhF0acT4qD5UiIaUemt1kvwC2OIc+SfUQOEz2dN1MROghir4?=
 =?us-ascii?Q?tOBFR1DOJe54ErxxEyYRvHjGGsSlme2AiVb0l4o+2NCK3JEZ/W+5fAS5ASWq?=
 =?us-ascii?Q?IREDvRqqqv9MWP16Ql4QwNqJcgb6nt6tj57YxeTkoUAeg1jDkr/EM+VWI2bo?=
 =?us-ascii?Q?gzJdfPq+b9H8EybU6gQPJsx4TsulrJZoHaih1o1ICqWxlcgCuG6QiZugtEQE?=
 =?us-ascii?Q?mTdYWDbtw/BruGzazlI9d7BiL04PUH5MWgG9pHQITvcuGfVkbS6pR0hoR7LS?=
 =?us-ascii?Q?9UnZwpROWreQk95/hCA0G3oSoqXr5wFBgQIX34Nmqv2ykgKqdskfBFqWbFnm?=
 =?us-ascii?Q?dJo9SLqXTrFJpUHvHQXsIVKrQOxNDOPv6UuPncwFSGKO0Nag8rS8yemqpbNd?=
 =?us-ascii?Q?rubYKMBJsVS5gGqaj1gEz64byjMzaTh4fgjtwnkeUxlPacmbSWx6H4ILh443?=
 =?us-ascii?Q?HQ7MRxTvyHsL0hnFuOh7VN+m4i79TxSt73ZOju0pbfQKZ1iCMX1ECz4beKe2?=
 =?us-ascii?Q?5ATls8oku8jEYEpcPpqKLJn6ejHQUQLB286pl1m60Mt7a2vRqvrGZg5lcfOt?=
 =?us-ascii?Q?kU+WjWX+l3whlYdlU2exf05wgtjSMQGqQSne91lfQVJ06FYqDP1sl2f33FVJ?=
 =?us-ascii?Q?yX3+Oreue6J6KTvjMM7vnWueuk+4EUJT3iWdoEfzR7k3LcRleXb48pslq9AD?=
 =?us-ascii?Q?M305AFkMgzUzhPlkfS8Q36/MRsdqMqomFK9mYlehHycQW2uy7DOTTSc+JAce?=
 =?us-ascii?Q?HPfRh2TDZo8OXvXG2JZHKO4AdeFDQiYKpk3Q5P/qdWJHwHrS4dAc7NWuXzWO?=
 =?us-ascii?Q?LAmjqgeEEcaFuYY8815QruCjAbO59PwNYrchoAKrZ2Jg1UU84+8C3b5ykO44?=
 =?us-ascii?Q?V72lcxU9HPPlAUHYfzUSlGq/hjIfcih4lEwhB+AInZxRytX4j0XcYOF7cEMh?=
 =?us-ascii?Q?PetMMz2CZPcGGXnomRDqYvfzRC3ofy/3E/2imZ8b5NaTIA80WWi0efP/9w8x?=
 =?us-ascii?Q?jtQj43q0iLEVnAs2XquaO8gYzPuHjVtDjZtlnBHBG1B291fPcgqHVFbVWEh1?=
 =?us-ascii?Q?XHkYUKSU4t+mu1ywOGrnMW99+KmSJSAE18xd8A2taf3YC7JTkScaPm6n4bCw?=
 =?us-ascii?Q?ipkj/JO94WKGOIe5aaIyvhVOKAJR7GUVQaBsBlu1xoXg1b5aczJbjdZ5H5cQ?=
 =?us-ascii?Q?Li1JDW3T0d/6rbC7aqE6vkkmRpfsjBbepB9tuGf4dUB7Sheo1P1G9cE64eLd?=
 =?us-ascii?Q?1sswCgFVvfXe5674lL06iXhenvGXDuI8gRthxv/1vBcfMKgRniRsb90YigWM?=
 =?us-ascii?Q?2iHz6SPRSi9GcvcXYZQ6KLMCJie2mcz5FiUZOxF5/rcDwu9m3n5/QKTqdAao?=
 =?us-ascii?Q?+4goAIbSm2sfZb4GyiiiAQrtD2A9tuVcvb2yOpuI/XvR2Hr1dP5wUCIFWMsO?=
 =?us-ascii?Q?GgQ1+D9zyB0TFm1trJsuX82HDbX4CIEE81Lq4X2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb9128c-adc3-4c95-691c-08dddf2499d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:30:45.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zXX2TdAsmIuu80AtbPFwT0UK3K9saxj+gm4Lxfb8WI1OWrXThixgS5sOLB/7GzkqpiS1B0qo/yo/H8vKmX2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232

On Mon, Aug 18, 2025 at 11:36:51PM +0200, Borislav Petkov wrote:
> On Thu, Aug 07, 2025 at 08:14:54PM +0000, Avadhut Naik wrote:
> > Newer AMD systems can support up to 16 channels per EDAC "mc" device.
> > These are detected by the EDAC module running on the device, and the
> > current EDAC interface is appropriately enumerated.
> > 
> > The legacy EDAC sysfs interface however, provides device attributes for
> > channels 0 through 11 only. Consequently, the last four channels, 12
> > through 15, will not be enumerated and will not be visible through the
> > legacy sysfs interface.
> > 
> > Add additional device attributes to ensure that all 16 channels, if
> > present, are enumerated by and visible through the legacy EDAC sysfs
> > interface.
> > 
> > Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> > ---
> >  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> > index 0f338adf7d93..8689631f1905 100644
> > --- a/drivers/edac/edac_mc_sysfs.c
> > +++ b/drivers/edac/edac_mc_sysfs.c
> > @@ -305,6 +305,14 @@ DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
> >  	channel_dimm_label_show, channel_dimm_label_store, 10);
> >  DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
> >  	channel_dimm_label_show, channel_dimm_label_store, 11);
> > +DEVICE_CHANNEL(ch12_dimm_label, S_IRUGO | S_IWUSR,
> > +	channel_dimm_label_show, channel_dimm_label_store, 12);
> > +DEVICE_CHANNEL(ch13_dimm_label, S_IRUGO | S_IWUSR,
> > +	channel_dimm_label_show, channel_dimm_label_store, 13);
> > +DEVICE_CHANNEL(ch14_dimm_label, S_IRUGO | S_IWUSR,
> > +	channel_dimm_label_show, channel_dimm_label_store, 14);
> > +DEVICE_CHANNEL(ch15_dimm_label, S_IRUGO | S_IWUSR,
> > +	channel_dimm_label_show, channel_dimm_label_store, 15);
> >  
> >  /* Total possible dynamic DIMM Label attribute file table */
> >  static struct attribute *dynamic_csrow_dimm_attr[] = {
> > @@ -320,6 +328,10 @@ static struct attribute *dynamic_csrow_dimm_attr[] = {
> >  	&dev_attr_legacy_ch9_dimm_label.attr.attr,
> >  	&dev_attr_legacy_ch10_dimm_label.attr.attr,
> >  	&dev_attr_legacy_ch11_dimm_label.attr.attr,
> > +	&dev_attr_legacy_ch12_dimm_label.attr.attr,
> > +	&dev_attr_legacy_ch13_dimm_label.attr.attr,
> > +	&dev_attr_legacy_ch14_dimm_label.attr.attr,
> > +	&dev_attr_legacy_ch15_dimm_label.attr.attr,
> >  	NULL
> >  };
> >  
> > @@ -348,6 +360,14 @@ DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
> >  		   channel_ce_count_show, NULL, 10);
> >  DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
> >  		   channel_ce_count_show, NULL, 11);
> > +DEVICE_CHANNEL(ch12_ce_count, S_IRUGO,
> > +		   channel_ce_count_show, NULL, 12);
> > +DEVICE_CHANNEL(ch13_ce_count, S_IRUGO,
> > +		   channel_ce_count_show, NULL, 13);
> > +DEVICE_CHANNEL(ch14_ce_count, S_IRUGO,
> > +		   channel_ce_count_show, NULL, 14);
> > +DEVICE_CHANNEL(ch15_ce_count, S_IRUGO,
> > +		   channel_ce_count_show, NULL, 15);
> >  
> >  /* Total possible dynamic ce_count attribute file table */
> >  static struct attribute *dynamic_csrow_ce_count_attr[] = {
> > @@ -363,6 +383,10 @@ static struct attribute *dynamic_csrow_ce_count_attr[] = {
> >  	&dev_attr_legacy_ch9_ce_count.attr.attr,
> >  	&dev_attr_legacy_ch10_ce_count.attr.attr,
> >  	&dev_attr_legacy_ch11_ce_count.attr.attr,
> > +	&dev_attr_legacy_ch12_ce_count.attr.attr,
> > +	&dev_attr_legacy_ch13_ce_count.attr.attr,
> > +	&dev_attr_legacy_ch14_ce_count.attr.attr,
> > +	&dev_attr_legacy_ch15_ce_count.attr.attr,
> >  	NULL
> >  };
> 
> This is also slowly getting out of hand. All those should be allocated
> and initialized dynamically based on a number of MCs but not keep adding them
> here ad absurdum.
> 
> Because if we were doing them dynamically, we'd never ever miss any new
> channels when the hw grows...
> 

Maybe it's time to final remove this legacy interface? It's been
obsolete for more than a decade now.

199747106934 ("edac: add a new per-dimm API and make the old per-virtual-rank API obsolete")

Any guidance on the best way to remove this?

Thanks,
Yazen

