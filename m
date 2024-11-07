Return-Path: <linux-edac+bounces-2467-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0A9C0919
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2024 15:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CB3B22B25
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC8212D11;
	Thu,  7 Nov 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WtDFXhPl"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9271E049C;
	Thu,  7 Nov 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990531; cv=fail; b=hm5xJ9iNs6ZUdTiLj7Jec+bIjly9BnVxBOimGaxQGK6oIfLSEDWVjRVaZuunI5OSarTxiVSd5F5XCwnmFarixZUwNE3wP4s7CMMd5LNwkPOHaKxGIvzo69BeUWQFDUIEorjJw4Q6zzfXqyoy07mkeC7hxSCUoIgMqxeYOaeAa0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990531; c=relaxed/simple;
	bh=G6lx1VTN7CvCDhA5JqnkTxghARuTDLWRH/BAimRhcPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kfD4SpQYrqZVxVRO7KRnGvfmUC2rBkeuMrgI/pQLZ5LFklWsw96kCL2sJlAZbLneOaPz8dM82ABi/ZE1ufdxC6dqL1vAWWnoGZBxNyQrqyIJEUFcVnUnymoRxLhrMoUK9Jfg9aEVNC1JQV+6rW3iWzFV1ot0D/kHqskg5DwkvQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WtDFXhPl; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQtZFNSMVBCYzDdcCn4QiyetvbStRXye9lprw40+j7tXMDlNyy2niqIur3msTUEnhhIP678PTISJJQoNtCQKiwXCtN7XTKbzQs91M/MpiicilLOwEDos7sK2JzCCKSCeNjyqOVNgkA/KGXs/FwcfZemUgOSVlwRML5pkV37O81OIMw3n3nwtf5FlYYrt9epBD9bd0+2TKb6EHP+aLYRYT+rrsedy4om8HgKcpFXNjPjV08Q5Sg0so/aYvDJEgt4FTNRam7eY7L5khC4/kVIShsxeam83WFo+bIzUPXfv9iIB5wdRu3ONu+2c/e+d0lTXyXhmkB6ca5y6uDoKd+k54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zptZDPptZ/2YHxb8j76WRr6lrDFRKrkskb1y9FiN4w=;
 b=sAVJUQKNViTqG5lefbTei4g0P1V0NrXV5YGJVXmw1sjUgfmjtMPtMDAPZXdpOmV8xTSeC4KGMvJnj1rziHK6ZM3AZQnPCviC2LptbQUj+xFiJJ0hNWNMDhYlNoNb65yWwzscN/NMcJiHoEqykd+trTalWcSZTfVCedT1vVTdI9Pl5+wsq6zxk2d73LWQoG2YVcrU01D6qs5g6DYZfbkM+3b1HLmMn9vbVqV4T992UQyb2/XpeH3NzFjTjrE0i/1nEUKRRneEmOwyEbzD9EVSVgQRgfwnVU9pM3KSCKL5LXrCv6nn4KWMNALLDYTFdjKDarrW3bbgxQV/0ihRri5Wsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zptZDPptZ/2YHxb8j76WRr6lrDFRKrkskb1y9FiN4w=;
 b=WtDFXhPly1ieFVTPGy29T2c1BBRNBTQn8YauQ5318s1w5tbbx/SXy+7h4YMovI6hJI/0QHGyoAA0JJkvKO02UMrW6sDsZ+g81Ip+0bE9EzZCQsP8WKs7C4y0ruXl9EBbQJXjm1kpveQE0MXzYkr7tgUlzFELLcSqeCWqF4jEkho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 14:42:03 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:42:03 +0000
Date: Thu, 7 Nov 2024 09:41:56 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <20241107144156.GA2236807@yaz-khff2.amd.com>
References: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
 <3c347f99-485c-453d-9b9a-9924abf1e868@linuxfoundation.org>
 <rk37tcrlpnziymqpj72f2glu4kh7v5pgxnurhnmuwhwkyuyfpm@iqvzvuicy3xu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rk37tcrlpnziymqpj72f2glu4kh7v5pgxnurhnmuwhwkyuyfpm@iqvzvuicy3xu>
X-ClientProxiedBy: MN0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:52f::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aca563-6dba-4808-7ce4-08dcff3a5802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mid0xGD9F/uWKU2fyhMijJKQwZKtSptefE0gO7iUMLjRNIgCWqWB6EK8/dVd?=
 =?us-ascii?Q?OXPB3e5YdS5DZA5GioHGsI060lX4qItY2xp+vlZNhvuw+vcLiUaqmBNqlgCc?=
 =?us-ascii?Q?V5B11yAep3ri1EY9OkmQaiffAMlfu2WNSI+56xMeaVi1gSECcXmmm4b1Dce2?=
 =?us-ascii?Q?iO45Fff+qzaAGTY+E/CsnUqk85PYg+zZT6U7fSF10N6i5MNiAGEFp+qZ5FBG?=
 =?us-ascii?Q?vyWssHuwnD5AumKxZhxyl1aHHor0mUIsbNGlBzzDdBB/AksAaafTY9dFhTqB?=
 =?us-ascii?Q?xjRgBcC7RorzsayoW3LCr+Nu1G/4gN54WZ5+NGLAEy9+x9ScUQEAzBrj0bG2?=
 =?us-ascii?Q?p+FtADcrw9bW5ChY+EXYSgGbxMfy8be+/V5KF/L5FpkMkkQ9WVTdHau8gAaS?=
 =?us-ascii?Q?O4ReslpkKdD5uNm+TMtHEE/RJaxctAfNQks3CGB220ZOZm7LaOJ33vHR8sWm?=
 =?us-ascii?Q?pGpCdODDNw8Vwsx1WMfkPu96XYKpeAHk/0SlgpgGotDCDoO2kCWVodGNOf74?=
 =?us-ascii?Q?SrBMBNcAuLA5+Bi2Rwh5VFemTBIIwkz+5/7HOuaD5OrhX9iyg92tkgtCuG3Q?=
 =?us-ascii?Q?LoTxuLoF/5Aasl7Ous9YES/NUggDRKOnE17zfzXr2D3ETaN1l+QoCR31rRVx?=
 =?us-ascii?Q?xMSdd6Y9GTBW54fYFDLaCp0UtO/GN1hBIbg8pjbta7VeGfdqQPw2w56ui8Fw?=
 =?us-ascii?Q?OP8seuFBrnUkExxQJmjxXw6t+8l9gSTTU9MYj2AhCA4TXDU/xkx3AeP4VZda?=
 =?us-ascii?Q?NG5jhnyg02ucs2o7eqgE3NjYZIHyi+kPxf+19N1eGzjzxIkhDGdGpSkMpb0L?=
 =?us-ascii?Q?jyb0xAr+so+xn55QuKs26xpRU3dVkjrfybd0CEIRsKUvp/Ii0X9xDHTJRxEz?=
 =?us-ascii?Q?AmrP+q9UTNNisAoTebQsPhy7BGE6gdwsKVYKcbAsrzO6Q6bUzB36oZjrE0SG?=
 =?us-ascii?Q?6CZDNGGcTV5GKYxNwQBd55dP2M5I/j5mR8JSckOQFAAvprtdmwi3tvb9kGah?=
 =?us-ascii?Q?qxSxdB6b93C9YhTjDNt4JYnuBysC1nrhv8xnc98XfuMbVx0M3PlTnVwHUOe4?=
 =?us-ascii?Q?eKp8/3Zkc+28uGhRg4ZL/mlkL/UonhA5L5/xWCoYx5NHqRxj/4KIDHJc6D/N?=
 =?us-ascii?Q?Hv1OC7c4OYNRsbimhNmOSRU6+Pdyvu6pVs+oj4jjOLYzey7zIZGY1yNJskBw?=
 =?us-ascii?Q?XYfG3Eg0Wx0bZo417h29cY+GycSfyK7GvPhkNguGLuK8KD8ROrSx4DLAJ0dK?=
 =?us-ascii?Q?h46mT6Dwa0JMn/YztQXE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2KOygEySYxD/+wViEujrlYXt2ysn2Z2nYjSt1B6aLjkQfVw7ztO6+V5K7cIn?=
 =?us-ascii?Q?WFsI4Tl/vogjUI303RXFlW2k9+YVpn9pX8MXe4RyiFccMa1t6+SVFD6BWMvp?=
 =?us-ascii?Q?mdQWVg3yDpsAAnOzEkZA/4lsx1IwJbJpk/WRYsmpGiAFcVMdNMZ6rkGqzKSt?=
 =?us-ascii?Q?F8Nkm+BTuXa6wPtwEE7L7V7q7gUe+SMTMiGIiN5YKBwWUa6tnTwi5tBKPPsh?=
 =?us-ascii?Q?r/ZkzlAQbvrlICz5x0AC+0UIYyjQoBJothGh5NQH2F+7fqOXPROkVmfnJUO/?=
 =?us-ascii?Q?IEVx0+sZMsLXuwUROpEgKqzMhduOaVq4QEtNKdDtKGHTGllKunrYCy58V9np?=
 =?us-ascii?Q?PzBxGi/wouNEAsDZH4Kn8rqvdR+Q1QIBcnEJk2lAzfLOtzuvKi5oHIWdy7+I?=
 =?us-ascii?Q?mTUG5Niotk/qbjwHNiouhfr5OGtEIpik+lRiCdY6l9a1i9C+llSLOyTLD05n?=
 =?us-ascii?Q?/Gqkeh48CLP6OkcQAdEAq7HWaKi7fz5wKLOYlo4IXBY7gavkqjGV2+D/FrB/?=
 =?us-ascii?Q?ujF9MLlv3SM1hpxIbfAS+F79e3m/zGqz0a7UiwPKgozhkhJsfayrdt5DhLfN?=
 =?us-ascii?Q?/YPZX8JJAdM5cey6Rl7DFx1VOZ5LruVnHiNIpzHgPZcoj4a7tZJeA8N6R9OY?=
 =?us-ascii?Q?nYViaj7G1J+JA3uGJNlYdKb+/Cfqm14o7Z6C1NC/Ix1KX8OSrn11Q06alKnt?=
 =?us-ascii?Q?93QQ7mAnRcQ6P3/OlRIwJvk9SWznF6TdV6vkCb5cITrLWV3lwOVDJEYNMV7/?=
 =?us-ascii?Q?yjv8n2cScTMXk5C/n4ukiExcXuKrdFTuvLd+g+FKdlM0wNDCJ9IotuvV9+/A?=
 =?us-ascii?Q?arpmErzzCzQwlQq8VBoAJD4wmIIzJANZWtYhBZCDaxikO1vqjoIiahN0Dv7s?=
 =?us-ascii?Q?CS/pYR2enDOzDQ4SEasak0zyN00QKnV+O+llecOEK/h4VRAzc/W928GNkGTn?=
 =?us-ascii?Q?xhRN0n8MMkOo5RnBZMaZmWPqtrJNDhIlJj/JTduTEe9W9+D5zmdq8uAKHW8B?=
 =?us-ascii?Q?NrR4Dr2iIB9R3n0wMw5KN1jfz46+rrsM3TH/m4zK9t053ubG13KDkJEh+Mc5?=
 =?us-ascii?Q?RZFtI+OLZOEqXGrk16t6WGFyGry4T0EYClLxqT3A9ucY1tPTY4NPIxEO74GI?=
 =?us-ascii?Q?UJemb9LT3qxTUveLuYjLMaA44E8TOXkxyZvMITinYrkrA1GMnEwLgqpFkVhQ?=
 =?us-ascii?Q?bjH/+uokhIM6GSX1H+cMQNHDrnjoa4S3elFZFnIo7lHlpkS9QG0vk4Z1BSro?=
 =?us-ascii?Q?h9EH7nieX/n67T9als52OdikFkJyw5PMCndqt6ccgiCNYJ/mQnMA8t+j57ex?=
 =?us-ascii?Q?+5CnkKFLmv1UZl6j0x1MTU5RiqyEfjTOFeRWUAlUKEIovXtVh9jiXsDlqjzN?=
 =?us-ascii?Q?jzyoVXFGAc1PjQicfMHAhiucH46fj+6RH9ap5Cnuv5Dp30A0DURgqg8dHbaf?=
 =?us-ascii?Q?s8xpaAehfdzq9c+HZmOTcsy88cvdg5/mMX+JsZmeKyQ6PsOpDvEPYp2vMrtj?=
 =?us-ascii?Q?DSNguqh9YMNtK8GZeKjaE8A6ltXO8TW7v0w1pfR4TkCWLipaYhbOMDxJQ4Pp?=
 =?us-ascii?Q?nr1I7gAYkSdsBM39W6qgqlN5Ie+NIDbntXO2/HiN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aca563-6dba-4808-7ce4-08dcff3a5802
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:42:03.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Nspyz69xJqdD/cGPMjRezVDCZp+7ocdiiyyRA/C4TGqQZDwGZy0o2kDGW0qdp/S+eKnYxG/rpdF8sYU10tXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

On Tue, Nov 05, 2024 at 04:20:27PM +0000, Karan Sanghavi wrote:
> On Mon, Nov 04, 2024 at 02:51:56PM -0700, Shuah Khan wrote:
> > On 11/4/24 11:34, Karan Sanghavi wrote:
> > > Explicit cast pc to u32 to avoid sign extension while left shift
> > > 
> > > Issue reported by coverity with CID: 1593397
> > > 
> > > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > > ---
> > > Coverity  Link:
> > > https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
> > 
> > Please include the coverity message instead of this link so
> > reviewers without coverity accounts can see the report.
> >
> sure will keep it in mind. 

Please do share this as it'll help provide context.

> > > ---
> > >   drivers/ras/amd/atl/umc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> > > index dc8aa12f63c8..916c867faaf8 100644
> > > --- a/drivers/ras/amd/atl/umc.c
> > > +++ b/drivers/ras/amd/atl/umc.c
> > > @@ -293,7 +293,7 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
> > >   	}
> > >   	/* PC bit */
> > > -	addr |= pc << bit_shifts.pc;
> > > +	addr |= (u32)pc << bit_shifts.pc;
> > 
> > How did you determine this is the right fix and how did
> > test this change?
> >
> #define ADDR_SEL_2_CHAN GENMASK(15, 12)
> 
> bit_shifts.pc = 5 + FIELD_GET(ADDR_SEL_2_CHAN, temp);
> 
> After reviewing the code, I found that bit_shifts.pc can reach a maximum value of 20. 
> Left-shifting a u16 pc by this amount results in an implicit promotion to an int64_t, 
> which can cause sign extension and lead to unintended negative values.
> 

The 'pc' variable holds a single bit in practice.

	#define MI300_UMC_MCA_PC        BIT(25)
	pc   = FIELD_GET(MI300_UMC_MCA_PC,   addr);

> To avoid this, casting to a larger data type (such as u64) woulbe be most 
> appropriate solution here. 
> 
> Also,using u64 would be more appropriate rather than u32. 
> 
> Should I send a new patch with u64?  
>

Another option is to follow the style in the rest of the function and
use the 'temp' variable.


	        /* PC bit */
		-       addr |= pc << bit_shifts.pc;
		+       temp  = pc;
		+       addr |= temp << bit_shifts.pc;


Or we can change the variable declarations to all be 'unsigned long' to
match input/return value.

Thanks,
Yazen

