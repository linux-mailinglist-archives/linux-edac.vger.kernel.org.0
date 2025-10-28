Return-Path: <linux-edac+bounces-5242-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2FC16CDA
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 21:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C81A2481B
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A803333430;
	Tue, 28 Oct 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z99CDsyS"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE472625;
	Tue, 28 Oct 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683848; cv=fail; b=D8UKfGwnXEH8n+/o4IS9oIybC8mSLFjv1TBd95Zl7dkLYBEY/bzKoJCHSu4DiFDDoR5MjIPh5ByV88tPoAr+I3HQPVZkiXMLsGaPhHlyk9lIy/ssen2xMPeYEu4m9Tv3nmVZEMTRhKYpdhIJRJkJgp2sxPUUIUOYVWXeuaSVkxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683848; c=relaxed/simple;
	bh=OgO5e3WV1XdFxZHq/B4aMoDS2q+YJEeo8kAJ+PMq71o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o1NGfjTSTkDbfSgAi0+3D4s82xOjssFbk/1zd5U6PMgJI6Ym47peJUS0vlyqs+buOyckGXr61znHvBBS8ijgqkMGbVYBphvxIRf8iAFFvc5uNZhGk5Ta+7oe79lhBKkpDqlj4SZ3RL6HKu3B3HZNswuqdk4ikKTS4uce2wUGVlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z99CDsyS; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8AaTRR+ljLBIRP7kK1EGCeqPLtUaHFJ2njx0eU74+xI7o0q34Qr5MiJTKmacNDax/mbqzhUuw/GH3I/IjH8dusO+JfYYJXtE5pdJGzWD5DEmJWsXId/JMg8+hFccjR/7RKWeD2q/8KPeAK5CvtQa+PdQWuXP8j6Zd3nB7xPH+/1TYApThcoDZW1ZQVex6jx1sqI+ObjF214alpc1wrgCFwG2uHlNBZlmH/XqRDWlRAKw0Y1xT1RJvZPqYTt5YKck8TK7UfRwX8ERs3qrE7P44VlAwE11rj2ztGMBdxymoaiXWneXa+c1JbJmLBZ6cv25TXHNykuP4pXqHu/VJGYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLUxEF83z+91LscearijkhhyQ9bQNaqZhZOO1IdOsLw=;
 b=jUUJsJ37uMcsqOgnIjgE9HNUWR7A+vI7+bsFY8nWjQJ5VW3EH+R84D3vvEAsCfDPJFC1Hsv9tudcOUjyCzKR52H7D4yNVRtl4i/HmUtPZHr+VQ8iHM5o+LHJ6wzyHtLxJP5sDQR1uk7CH1MgLcU6vWcJBTaFhjpFEKwt41Xhd+1wdxgpgI+IShpJLsdoTOhs05vp1wlFvcxgH7/quxTRnS7hGTYTpEhVkaI4WX/e4FpfoIJq+fM2u+dkSnmFqSsmfGQiNOgxNAatIc9JoFMkvgyECHI/YPNLFBvyXgRFwEczPH3S3MsLLn+0qJ5/xa6YrBgBDM1PyTzDD8Qnka0yiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLUxEF83z+91LscearijkhhyQ9bQNaqZhZOO1IdOsLw=;
 b=z99CDsySDcCAuAmbIva+BoOCc9/ZIoQszZ23KLOe2iweU05te2xavVFpIxc4Ix1EaiJwaPx8FoMdx3lSGMvoX0wriR1DLhdRsE4coblUhEA+pLguANnRfWFmwjAxKPQwuKkAx7FkxZlFohTt9o8RbiHF3JP0Ozov+jvfFK59Spo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 20:37:24 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 20:37:24 +0000
Date: Tue, 28 Oct 2025 16:37:19 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251028203719.GA655216@yaz-khff2.amd.com>
References: <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
 <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
 <20251028154258.GA526743@yaz-khff2.amd.com>
 <20251028174656.GBaQEBkOErfNAJbJsf@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028174656.GBaQEBkOErfNAJbJsf@fat_crate.local>
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 071ad02f-dbf0-4c9d-a4a5-08de1661ccd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0x4BHgU5JVAu4p+o2Xu03o+XbFyudGEFVPwpYihu27NPf83LEnp9+wZnLpI?=
 =?us-ascii?Q?vo2RVZM50dSNgosT14WQ8CaouMcThJr6Ogu926D1PV7rLWQV+ZxrfFNWNNmm?=
 =?us-ascii?Q?sk5LWWxO2YKauj2cSZyZzhfVQmPxx3l9anv/ifNiBtc2S2S30HjZoc+gprGy?=
 =?us-ascii?Q?YGO7fXFvh1waaiLClDYHYs1K9I3Nh9S6LMkpF1SJ1Aou6tkpGH5gj2v/WNCb?=
 =?us-ascii?Q?seU5m88Ut54rhmCXmaWZnfoCt3OZJdQ6BAbsrVQHQZLv5fkZCoHUBHpU19MS?=
 =?us-ascii?Q?s7BQl9M9S9EkBIW4M6PuVAXff5FmRR6gd7UumvzBwPs/UKqVshIp6DloA18a?=
 =?us-ascii?Q?UaRCFuBvnyIjEM4Xb/h6dFMWt++LchNVZ9HeM5dml8jRU/OSWwh57+N9bm0l?=
 =?us-ascii?Q?SOSiWazOrwGW/ybQQlX8Fnne+tkGjjz+8sC5UCQkzCAPexm2O4yzn8Qlq1e+?=
 =?us-ascii?Q?ljWOvUdwArkLBbN2vlk+Gt7cGD9Sw3MOdooYqLk0zmM8ndEiQ+FWyw7ZV92M?=
 =?us-ascii?Q?0Sv5VPcwQ415Kkyb4VGS5S7CGvUuIsUx0uak12k3INA9kApX2KYcc1uRZXnp?=
 =?us-ascii?Q?eWxIuVzDv3dqha3MjfSt3BuPpQ3rHe18t++krIdPTxLl8E55x/vdNVxWcDpy?=
 =?us-ascii?Q?Y36kT4mWPmZzD/jKFOeVYZKlxv22yoJwh/tM/uliWvmLUrOsqdXc0rDu4ZS3?=
 =?us-ascii?Q?Xk6ZOc5KSMFJsUxf70jIt1MbxLTeKkA4xMWjstB/IDwp4bLgmPFMXMI0t5R7?=
 =?us-ascii?Q?TT0nuUiPQWRFPY8BfmavotsLCHRCzeFN3PWxCSY8WxcubnCOcj1cSpwljYt+?=
 =?us-ascii?Q?nrqA8vIAN5kaFNyAIyp9Jm9lPLSauXlJ+TPkkMLvsI731DDDCz45xbS0kRbe?=
 =?us-ascii?Q?4M9Jt4Vqpi8QV67Bn8p+oGoWMW+021YQ69RNhVHhPGic1PZxLcPasKCO7CLC?=
 =?us-ascii?Q?0bbpMBk35OxAulnp6A9bFPpiyqQF+hbu7jccNHiAxK4FJNCwxwhNQR+mJ/th?=
 =?us-ascii?Q?WNzklrzMfrZZZlLmhOXNoUX4IQW1jkZiLw9tnnwO3KHekc3KN58OUiO4gsV7?=
 =?us-ascii?Q?sMVEBjkSF6AYATOWe9sI6gLrk0ABp0/cs7GMpHl9ceTvabFBSBzngMyBEits?=
 =?us-ascii?Q?Im48XVRcmGulcuBHZ8drPmRw2ENhmdWporHvEV+A/+EKSTfW5Gb89Xhn6qbC?=
 =?us-ascii?Q?z31Vjrb3LnEPEsaMdl12SuX8QxAKOp79ZHJjF2Qd75/qSpeDLbQkl8PtOHuu?=
 =?us-ascii?Q?oeoUkjMY4cts0WEc1y36czmi6yJksKAgmt9mOp+hys6QMNnB1oMV0jDoEaKG?=
 =?us-ascii?Q?z79Xmz25D6N4Hc8Rt6oOHHLQvTnC4imNVOCx5uIT4BntEYcJn6508UR391SE?=
 =?us-ascii?Q?jr9YmmXaSon5EEODmHOF7t4ewLHaP0lKQRsgjdoLvAWyVxi6rQGO/li4PidP?=
 =?us-ascii?Q?CArBSWnFa2Zayn4wf61gIvwswPXBQaHx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaFNPIqucVeVnpHpzg/JewY6K/iqpiSk6vfxOI2oHlAOeUYv6QE5OZXsuEIy?=
 =?us-ascii?Q?ApwEJRH4DR0VkS8hc/GpoNo2eX2lDt+HtaGjGRNFmvCnhS4LE/RrHd8l4Tad?=
 =?us-ascii?Q?SOrGu6XUTqxjTb9ERSBc5y4BNO9Q83nKRhSCjBQ0EYwUX4dxyMjt41lRyn9a?=
 =?us-ascii?Q?PQHlQG/q9sNNNgZkqPJV2cW+zfFyd8BXoqPVFaYEmmkZldAYcgK3EOCCG65/?=
 =?us-ascii?Q?SOxJtbqF7k770JNOfuPQgYnmyiPYW23yJrWmXqyiXbuvzVNjU6fW/lvW8csE?=
 =?us-ascii?Q?RNT55AoB4HDUBZEEM/iEKyld7ay9Z38KwRTo8HLpASzeWnbPZ8SENIjXvfsF?=
 =?us-ascii?Q?Bz0F/S6pUzt7vnoczg4W8Ke5+EMfde09ybcDigO1MnkGIxMtQYsN1J5s4Tyb?=
 =?us-ascii?Q?2Gkntn1UgUGe0GAgis7WPhBJFHGfa8QQC355rKwywVx1Md+ktQ3UqjYaCSas?=
 =?us-ascii?Q?mIbsRq/j18xkAaEt/NemTw/0y+ga0oV5TyA76D4mFvaILqCVKlCc31yooBdj?=
 =?us-ascii?Q?dTJsllFkbR//iZCIYSR0LU/i8HkO2916kIxII7c8y4dk3zadDAeUZ4P3hNie?=
 =?us-ascii?Q?1j6+FuAoj+o/2ybj8T4EjfiaCgpYs+sOV1GTq0XrS8s+EO2QgGYJthl0MLDv?=
 =?us-ascii?Q?XkGAxFTWJ7FSws5RlG3b16zQ9EYXbkeMD4o51nonr6NcpNx3NZgviO6Rt7v2?=
 =?us-ascii?Q?iaKxEZ3ajEssiGpE9E5155oJYyea0hoAjmnT4nf03YBDIHYluU8/iLRSC72a?=
 =?us-ascii?Q?dMp0+8liOOso8eAbbHU/nJ0E2J8NeFhCHBmU2r9ukMlrVZd3RYcg2991hPaX?=
 =?us-ascii?Q?nf8538nf4NcPgExMnGkWBR59YY8a4e5DZ67w7CK4iMtDQwDVsiYAfJtET1kr?=
 =?us-ascii?Q?1RQMTuGOs3r/sbn72DpdRU2jXolt+0jx85nMWyhvh1L/ge9GPEeRCwVAqiH0?=
 =?us-ascii?Q?C/UETR+XjuJPOg8321GKL/CQPK8Oh8v24nmOAaLygXrV+aTQV8MLWkubuzno?=
 =?us-ascii?Q?Lm5oe0oTKyw0LZS/EjkbUzGs5Uu/1RMGSXKyY0ivPvffXkEc7C+KplsQ9QDW?=
 =?us-ascii?Q?KZmxZohfFvrKkz5p6a1kx4JqR/P9S0gIvctZA2fjwyK9K5QySnSQGi+Rdn3V?=
 =?us-ascii?Q?BHuNLTXSUXeeoHhz6KX2OmjgkEekkwD3wy7Q6gRRBLiuOCgMOf1G1x6nxlqs?=
 =?us-ascii?Q?+lmLhrRd6R737rhoFPdaG7G52SpiZ1xiO9CpP7UHPM1KZAFYs10XO1YeqK40?=
 =?us-ascii?Q?c7REfy7ZeqUosy0laSNknAUkIk+0KiccDdOUgHgtO37q/fRuT0+Ety0UN9IS?=
 =?us-ascii?Q?C/4WfSZLfWFhZ83OngmAsW/LupMiXLWzkfsKFBZZFcCxN+tz/0bEul9PnvA2?=
 =?us-ascii?Q?QLF/a/NH6jMAkKQKFxrRGGFX7YsVM6FVMXZGUWfi5T3apGFD0p8iyqtROjmN?=
 =?us-ascii?Q?cfN73MlGUWuo3USYgb9R9o9m0NqfbR2R7ZdJ7/qSyhFK+Mfy+5h1PakwR+9w?=
 =?us-ascii?Q?acWj5tKi89XnpJ60uCsJNKyE+GSMsqLA/OwWqAKk7/CVx/NGg1V7VEuLNfmP?=
 =?us-ascii?Q?VWiifxsWkRKiA68lyFES4GY/HAwDtimkHi4sJQgJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ad02f-dbf0-4c9d-a4a5-08de1661ccd9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:37:23.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBPDjxFY53khpI4+8WRMxN0egyk39XBegtwhyYtAvHwb3AkQovgtfuZPMJBh9BEVI4jipJrYanXYCrBMk0o3gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

On Tue, Oct 28, 2025 at 06:46:56PM +0100, Borislav Petkov wrote:
> On Tue, Oct 28, 2025 at 11:42:58AM -0400, Yazen Ghannam wrote:
> > Yes, fair point. How about this?
> > 
> > 	/*
> > 	 * If MCA_STATUS has a valid error of any type, then use it.
> > 	 *
> > 	 * If the error happens to be a deferred error, then the copy
> > 	 * saved in MCA_DESTAT will be cleared at the end of the
> > 	 * handler.
> > 	 *
> > 	 * If MCA_STATUS does not have a valid error, then check
> > 	 * MCA_DESTAT for a valid deferred error.
> > 	 */
> 
> Well, we already have this at the top:
> 
> /* 
>  * We have three scenarios for checking for Deferred errors:
>  * 
>  * 1) Non-SMCA systems check MCA_STATUS and log error if found.
>  * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
>  *    clear MCA_DESTAT.
>  * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
>  *    log it.
>  */
> 
>  and that is good enough IMO. The rest people can read out from the code.

Okay, sounds good.

> 
> > Okay, agreed. I think this entire second comment can be removed.
> 
> Gone.
> 
> IOW, this:
> 
> /* 
>  * We have three scenarios for checking for Deferred errors:
>  * 
>  * 1) Non-SMCA systems check MCA_STATUS and log error if found.
>  * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
>  *    clear MCA_DESTAT.
>  * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
>  *    log it.
>  */
> static bool smca_should_log_poll_error(struct mce *m)
> {
>         if (m->status & MCI_STATUS_VAL)
>                 return true;
>  
>         m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
>         if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
>                 m->kflags |= MCE_CHECK_DFR_REGS;
>                 return true;
>         }
>  
>         return false;
> }
> 

Yep, that's it. Much cleaner. :)

Thanks,
Yazen

