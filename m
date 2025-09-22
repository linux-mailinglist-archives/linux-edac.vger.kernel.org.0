Return-Path: <linux-edac+bounces-4902-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A13B918A9
	for <lists+linux-edac@lfdr.de>; Mon, 22 Sep 2025 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201042A1603
	for <lists+linux-edac@lfdr.de>; Mon, 22 Sep 2025 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3D30E852;
	Mon, 22 Sep 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MM5eSd7r"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C7221F0C;
	Mon, 22 Sep 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549523; cv=fail; b=AVxTC7CZScp7yzQFFvWySngxslqhMrT8fAanD5rTRtGlpWJuUuQSUbqlNj1GPJYZtGxYH2qO+Ar+c4ZEgX+2vKlJO2byCXw+MVJ5LXAYuhv2SeVN7oBibQ7ufHQawFTr98/leZTC+hU7+Si4E5c5lty46Yr5V56FGFRCbfxCME0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549523; c=relaxed/simple;
	bh=gdluk1HJgXQ9LI+Q1z3op9ftgOi0c/jOmToOe26PBp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VJcmpC21b3ltUVUT8tr/GgxIxnw98LXxAWhdyZBJ+IP2TFtcFjdawAax8kho3IN3gWSBb23TnWSHjqYDzXusto2zOwJHJv1FZYsipQPuFqnlW8ZuVrZ30yyz9pOHzKf61+tSBx9W4Xd36f7SRU3qWd+eagIaSZki4PIyORRtXbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MM5eSd7r; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1Ok2qcvdGdhWHQroNFoBx2TK8ZOZww71WHTejNE6e3S4B7cxcqx7BGowpZP8VYsFpA0uOY1UETlE0BuISe3JZ+m1Euwp0e6gFzMPfAWC8mX3iCL8n73O7iHzaJks1+wA478J7XkOrShjTcWu65B381JyKki/rtCYyy6j4yquzH/S2oakBCbP/MmVQdHSzRydUHkahyUaNtePjsaBI9bgdRgZqrtd49W6p7O+meHE9/zxXIABIAr9YnMET6WkH1cmmaLDHjP6ndi7agd0/KTPnmH5YRos2bfkOsZdDPMfSIxgKoAHRxAkUxRYLrP23GoAJt08Z4uNp0W7C42oiBo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yj22cHR+VQURXPm4RtFFlp5I4svTDxfCz0+extyZuw=;
 b=BeXEVRLzK6SBybbBJYNjIDrtbVUfYCw1F/JgV+hcQ/mvOxzZh8K/eRY5VHB55rtJJG+1DUmStqAVxFzm8XhxqZPYyAY4FqynYE7egrawBV71AcTxBfemhtle7YUdgj6yiuvF/9WbMbUkY9tni7FTgF3Hf7H3oeSYfgnCEG31jrPMTCQwC7xEKmR/FbMjGEexgLRMvQaFgMR+k8qK0SD3ntXc61bXZLFlJPfospx1YtXOYKHXxhsjsnrAP1qLHVFL5T94QB3VO3/kXZNQ6hhYG4Du99bT3sjC2IFuHIcFSY4Efh+wsPLNIVCygQ/f69Ls+Zgozo974rkuC/tHvpLHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yj22cHR+VQURXPm4RtFFlp5I4svTDxfCz0+extyZuw=;
 b=MM5eSd7r65G9dQ3Rz6ZxZkIAd/FkmMQvkSNZGfwLyJ0E7HdnorAqtfKmUO1bFQ6LgbILffDnpjfCM0lP1JhoYLcgFBakVVoq1HwDElmC2VvGv7V9H9Xtusy23bwl0uiSVn0NWhU9d/Md49sUx457FYN1e7EMb/R0rubv+E3mYpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 13:58:36 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:58:36 +0000
Date: Mon, 22 Sep 2025 09:58:24 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 15/15] x86/mce: Save and use APEI corrected threshold
 limit
Message-ID: <20250922135824.GA31279@yaz-khff2.amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com>
 <64314c7a-5212-4bf0-8181-8bbada0e81b5@suse.com>
 <20250915173332.GA869676@yaz-khff2.amd.com>
 <6e2d5351-dbd2-4e28-8bdb-b961fade5ebc@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2d5351-dbd2-4e28-8bdb-b961fade5ebc@suse.com>
X-ClientProxiedBy: DS7PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:8:2f::30) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: b28cf055-19dc-4974-4049-08ddf9e01f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZSiq7B+ivxopB4PFzipIr7r35DDWFOCutQs8ERiz4vSvba9xwFmgqG2bg/m?=
 =?us-ascii?Q?2EB8ZCPffvkrjBenS/vEnZQaANIRwVIRm/wvkwHYoYrX0qPq5xfIuMF7lvh5?=
 =?us-ascii?Q?KqGlnXN2Z70NNQzL3fSxGJrnhMy6lXYF9lUz9xD/jtKrKZqVVgn64lfE/tjN?=
 =?us-ascii?Q?H6l1AKm+p2qh5+M0fdFnhYaS2HMl8nOZvLx7tsh3SjLN4LFVzembJtWkAIlb?=
 =?us-ascii?Q?kCx0rHZUVyC20k/DbR8Ie1zWCL6Pk0E2mDRnvb0DjRGD18YXcoZJQsA2OV57?=
 =?us-ascii?Q?IUgAWtHFgUlYu3ieZ1vHuWXT0iRE1lnMZ5cQ3d+hzUM+HCvW9SB6HjzMA4FW?=
 =?us-ascii?Q?aaZFacZYSbG6g6YONIKcRrA8rWDkOLSWt4sS0R74heBmxfIhj1wIxKMi6OML?=
 =?us-ascii?Q?Ekn+WmaahoBVkP7/bqLwI5PcuYrYoPLQkBHPtS3nvY4ORnw6dwEGWkv+zIHX?=
 =?us-ascii?Q?huDpwTP8kJ33CcX+N3jQ4WmUR7rgqUkkxP2ux5fC6zEwzIdRf8tFMsHPE6LY?=
 =?us-ascii?Q?DBOB59xrAd/8mt63P7RuJ7KaH7AwQr28GOE3CxjIP5TylAEIdv7r/gQXFInh?=
 =?us-ascii?Q?VX8pW1930fQMYYqwTEZA8F6/2a5ltA9mxIMpzBalfUSh8OSMztoCSE0Ik0oq?=
 =?us-ascii?Q?9nRDxbo56Y785x06Y3oKSnllXK507KxW0ajwG+5Q5b/w6THWcGYvJ8gpSEEd?=
 =?us-ascii?Q?TZ5e1A8/muNhyHiFg7JSYA+8qvH3wesBowDhACZESjxzs2ixiw9ymNczzr4W?=
 =?us-ascii?Q?IMN2qOpY4fzRBw0ytnsL4lSve5pLEWCnue6nOet7g+/ZaxUFFwjbXYCpbIVz?=
 =?us-ascii?Q?MAkDwdekcqGUPFEPU7UZU4ezp5XWsK10IY6EVe6/tI/GnjLbO1ZLsPgtakTl?=
 =?us-ascii?Q?Cvjx3sq1fVF7Tl1REnBjMDSPt7qb+BwaqplzD/uqVyUEeI8m9B1vPiWTbmhY?=
 =?us-ascii?Q?Siwxe49jrX+N8Ih+hpYjUuGOUzQmQD1/bYYBweQJ7UozEkT55foXqW6Gh6Yt?=
 =?us-ascii?Q?rXyJGK1Q2/mcKUZUArKyIdfyflbVbdYsu4rmUX/nwNuYxMo9O5AWTf+4NBTr?=
 =?us-ascii?Q?P64yDQDFiTHcZ8WNJF6Ljv1Www2MjUvMmyMkxtpf78BX2SBFQ9r57iqXhljt?=
 =?us-ascii?Q?6Qosvr/n4jVMlLGBRTNlAjN7vmaXFTc4Xumia3/RmD+W5ZsWM3DGgbIlv+4P?=
 =?us-ascii?Q?New1FEDnBDbIU+XvXC65GqVbddKMCXBF4eo2XpbSl7GKxlt1rq1reIU1aOMv?=
 =?us-ascii?Q?BbUv8xSScBUNBW8KIvYEbAWVD68U3pb2JWu1nWWNaZh0buyX3AFsX1AF4Hrf?=
 =?us-ascii?Q?EVvLqjQiYYyAVs4hTnIBkefrlXsBfZiVfTPX+vHuY0tlpYTGnaoEjcpjUF+H?=
 =?us-ascii?Q?kjtb6nX+kDrpfLr9p/6n9Q8MQKNuY78jrOFkolFbDPJ9+Ozg5e939uYhclcR?=
 =?us-ascii?Q?NIqbOnX710I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xJzBCK2ET6dov0+tzkqOY8GFgompOoSAKVpFIEEY9XErMYFh2O1bBvQtwe6?=
 =?us-ascii?Q?Ju0880PPuIh+Dr21ifPv/HRchsL4CcHdJqK1IT3m5opbFDL6LdgcQOqGmnt+?=
 =?us-ascii?Q?sCgpRdsu4hqcmBcLzDrTFdoCrtQMaLk7cqIgSqrhvFzLbpjqx78IZh+FVlNJ?=
 =?us-ascii?Q?eRjS0QV3RvMCHUTGBl7ZJodcuFjKEZy8JO2bsGX+1dGM1W1pK7oOu8pWkrv6?=
 =?us-ascii?Q?QghNH/VkCqpFVAHzpJ2Dkn+LFDBnw22sYZluGBIHSE5m6lP0SVrCJ9pTY78h?=
 =?us-ascii?Q?lwqNVizMgMzsruEz9Afw3ZvoeNPbJ4jJjWVM7+QO1tBSFmJz1S0fxK8hHV0u?=
 =?us-ascii?Q?V0a8nX56hXXh/hdwUHcv8XE9f8uqc6wMalc4xA0q4/IOE04kWE0rEFpqqy5p?=
 =?us-ascii?Q?wOnUWF12Bic/EZFrNHdbQ1FyEfHRGnaycDL7DT0i05z9AA9q6zhiqvyRY+JL?=
 =?us-ascii?Q?sU2YSCI1F1XupNFGjpvRy62/wOfZUu9ed4WEOVPzgoOu1CdLgSErk7PhAnC0?=
 =?us-ascii?Q?6QUt9ImSXIlQqgtpcMTbMAlu43N5xJAU/uHvE70y04+YAsHhU1geGjE80+gp?=
 =?us-ascii?Q?Sve+wSXa9KgVhlPatiHdYGFaH6+oSFzBqryxq5y3BRkN2To7ggP5phKGG2GY?=
 =?us-ascii?Q?50cTNS23Ktux12TzaagiCbLvVG8ZIXOqT12rpa0l62yI66FOncmEu8OAHLfM?=
 =?us-ascii?Q?HZSnFgbfjhtFVKmM3PuioXQYySR7HWy4iP6g9A+0+hJ8JBqRlUFT50gUbNvF?=
 =?us-ascii?Q?8HjRm6ViozElgEdoueUZIgTIA6xaABv5e3jkVoOhT635V9TaAjGErSWqwX6e?=
 =?us-ascii?Q?2OBwYcdYwC6HJSVT+q1tkJ+BZGy491OYQjJccpvpAjKv0FtjY3MlGm2mYJfp?=
 =?us-ascii?Q?EuNKu/5OCEyjOh1UW7czaJNPmee/ASQyaHpFrGHqVbHNTrq3UHDQjSFB9Cfv?=
 =?us-ascii?Q?OArNSCIJWDfwZlEhUCP21FLCaCRPwsE0bGthOIU3G/qEEMFQmcnXWvVNmquO?=
 =?us-ascii?Q?zk7KANqjaNBfRzGuFfsOLdnSxz0+8Crk6ou3ZUO0XoKINZuOnrgIhdN0o6fB?=
 =?us-ascii?Q?7uAkdzXeygIzNo43TXP7lWa6Z6VTBh2YXYwAg/A/3xgX0OExFVyNS/CYFLN4?=
 =?us-ascii?Q?nXXe9KqWM9m9lQdWUPZVG5OqswVqD2wPbd9UiFTjDMUHOw+euPocbzZpweaf?=
 =?us-ascii?Q?MD7C1yQyBmwaX4JEAjVKGT8jsOvK6dCJb0FE7BLB1FPkuEltnPsH6KGylHHo?=
 =?us-ascii?Q?QcFm3GGXOEm0fmKoUIKHXSaaeeJmb1yakopgE1n2J70cx817nzONBO9uHmnQ?=
 =?us-ascii?Q?YdxAfUv6UQecUuOKGJ0mGtg+SELVPiXhjYr7PK14Xb+CmwJI1ep5CovLVCJO?=
 =?us-ascii?Q?QgR8HE0zXb+S8TM//geiXckMg2HLLAnBbHYd9VF34mAt3LlB0MGZz0ohpFDj?=
 =?us-ascii?Q?hrsVM+w5Idk9EhKdykFDElkHU/PLZiNY1nZztlGa47edZ8jKWyNBIgEJGqDh?=
 =?us-ascii?Q?DPNok0ISpiph3BVtM08wwUEzvHH5SCbayltvXlUJhf2k/AZU+P9kX0CQuUmH?=
 =?us-ascii?Q?xQrEnlF8/4QxnYrdzCX4JpL0Qq3ZBMaGu/sHLzmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28cf055-19dc-4974-4049-08ddf9e01f64
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:58:35.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ4eBqXYseq1VioSN00gESbQ7gFRyXIXkhQyF+wk1CbJkksOKxXZYkRTyHx3+G/G0JFBZKww/i6emsawm938VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

On Fri, Sep 19, 2025 at 01:42:57PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9/15/25 20:33, Yazen Ghannam wrote:
> > On Thu, Sep 11, 2025 at 08:01:17PM +0300, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 9/8/25 18:40, Yazen Ghannam wrote:
> > > > The MCA threshold limit generally is not something that needs to change
> > > > during runtime. It is common for a system administrator to decide on a
> > > > policy for their managed systems.
> > > > 
> > > > If MCA thresholding is OS-managed, then the threshold limit must be set
> > > > at every boot. However, many systems allow the user to set a value in
> > > > their BIOS. And this is reported through an APEI HEST entry even if
> > > > thresholding is not in FW-First mode.
> > > > 
> > > > Use this value, if available, to set the OS-managed threshold limit.
> > > > Users can still override it through sysfs if desired for testing or
> > > > debug.
> > > > 
> > > > APEI is parsed after MCE is initialized. So reset the thresholding
> > > > blocks later to pick up the threshold limit.
> > > > 
> > > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >       Link:
> > > >       https://lore.kernel.org/r/20250825-wip-mca-updates-v5-20-865768a2eef8@amd.com
> > > >       v5->v6:
> > > >       * No change.
> > > >       v4->v5:
> > > >       * No change.
> > > >       v3->v4:
> > > >       * New in v4.
> > > > 
> > > >    arch/x86/include/asm/mce.h          |  6 ++++++
> > > >    arch/x86/kernel/acpi/apei.c         |  2 ++
> > > >    arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
> > > >    arch/x86/kernel/cpu/mce/internal.h  |  2 ++
> > > >    arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
> > > >    5 files changed, 39 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > > > index 7d6588195d56..1cfbfff0be3f 100644
> > > > --- a/arch/x86/include/asm/mce.h
> > > > +++ b/arch/x86/include/asm/mce.h
> > > > @@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
> > > >    /* Disable CMCI/polling for MCA bank claimed by firmware */
> > > >    extern void mce_disable_bank(int bank);
> > > > +#ifdef CONFIG_X86_MCE_THRESHOLD
> > > > +void mce_save_apei_thr_limit(u32 thr_limit);
> > > > +#else
> > > > +static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
> > > > +#endif /* CONFIG_X86_MCE_THRESHOLD */
> > > > +
> > > >    /*
> > > >     * Exception handler
> > > >     */
> > > > diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> > > > index 0916f00a992e..e21419e686eb 100644
> > > > --- a/arch/x86/kernel/acpi/apei.c
> > > > +++ b/arch/x86/kernel/acpi/apei.c
> > > > @@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
> > > >    	if (!cmc->enabled)
> > > >    		return 0;
> > > > +	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
> > > > +
> > > >    	/*
> > > >    	 * We expect HEST to provide a list of MC banks that report errors
> > > >    	 * in firmware first mode. Otherwise, return non-zero value to
> > > > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > > > index b895559e80ad..9b746080351f 100644
> > > > --- a/arch/x86/kernel/cpu/mce/amd.c
> > > > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > > > @@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
> > > >    	}
> > > >    }
> > > > +/* Try to use the threshold limit reported through APEI. */
> > > > +static u16 get_thr_limit(void)
> > > > +{
> > > > +	u32 thr_limit = mce_get_apei_thr_limit();
> > > > +
> > > > +	/* Fallback to old default if APEI limit is not available. */
> > > > +	if (!thr_limit)
> > > > +		return THRESHOLD_MAX;
> > > > +
> > > > +	return min(thr_limit, THRESHOLD_MAX);
> > > > +}
> > > > +
> > > >    static void mce_threshold_block_init(struct threshold_block *b, int offset)
> > > >    {
> > > >    	struct thresh_restart tr = {
> > > > @@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
> > > >    		.lvt_off		= offset,
> > > >    	};
> > > > -	b->threshold_limit		= THRESHOLD_MAX;
> > > > +	b->threshold_limit		= get_thr_limit();
> > > >    	threshold_restart_block(&tr);
> > > >    };
> > > > @@ -1071,7 +1083,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
> > > >    	b->address		= address;
> > > >    	b->interrupt_enable	= 0;
> > > >    	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
> > > > -	b->threshold_limit	= THRESHOLD_MAX;
> > > > +	b->threshold_limit	= get_thr_limit();
> > > >    	if (b->interrupt_capable) {
> > > >    		default_attrs[2] = &interrupt_enable.attr;
> > > > @@ -1082,6 +1094,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
> > > >    	list_add(&b->miscj, &tb->miscj);
> > > > +	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
> > > 
> > > Why is this necessary? Shouldn't this patch consist of mainly
> > > s/THRESHOLD_MAX/get_thr_limit();
> > > 
> > > 
> > > In allocate_threshold_block have already properly set threshold_limit. So
> > > this change really ensures threshold_restart_block is being called for the
> > > given block being initialized. Ignoring the changed threshold limit logic,
> > > why is this extra call necessary now and wasn't before?
> > > 
> > 
> > It is necessary to apply the threshold limit to the hardware register.
> > The MCA thresholding registers are accessed in two passes: first during
> > per-CPU init, and second when the MCE subsystem devices are created.
> > 
> > The hardware registers are updated in the first pass, and they are left
> > as-is in the second pass assuming no configuration has changed. That's
> > why there isn't a "reset" in the second pass.
> > 
> > The APEI tables are parsed between the first and second passes. So now
> > we need to update the registers during the second pass to apply the
> > value found from HEST.
> 
> So APEI is initialized as part of the subsys_initcall which is processed
> via:
> 
> start_kernel
> rest_init
> kernel_init
> kernel_init_freeable
> do_basic_setup
> do_initcalls
> 
> And the first mce_threshold_block_init() happens from :
> 
> start_kernel
> arch_cpu_finalize_init <---- way before rest_init()
> identify_boot_cpu
> identify_cpu
> mcheck_cpu_init
> mcheck_cpu_init_vendor
> mce_amd_feature_init
> prepare_threshold_block
> mce_threshold_block_init
> 
> 
> Finally the per-cpu hotplug callback is installed via:
> 
> mcheck_init_device <- initiated from a device_initcall, happens after APEI
> subsys init.
> mce_cpu_online  - called on every cpu from the HP machinery
> mce_threshold_create_device
> threshold_create_bank
> allocate_threshold_blocks
> mce_threshold_block_init - newly added call in alloc block, used to update
> the register with the new limit
> 
> 
> Given that mce_cpu_online is already called on every online cpu at the time
> of installation of the callback, and every subsequent cpu that will come
> online I can't help but wonder why do we have to do the mce initialization
> from start_kernel, can't we move the mcheck_cpu_init call into
> mce_cpu_online, or have the latter subsume the former?
> 
> Sorry if I'm being too nitpicky, I just want to have proper understanding of
> the subsystem and the various (implicit) requirements it has.
>

No worries. It is a bit convoluted. I'd like to clean this up
eventually. I have an old attempt here:
https://github.com/AMDESE/linux/commit/640db92eca07804e889fac88856904552a4466bd

In general, I'd like to do the hardware and data structure init in a
single pass. And the sysfs interface can be optionally added separately.

> 
> At the very least I believe this commit message should at least allude to
> the fact that mce threshold devices have a strict requirement to be created
> after the APEI subsys has been created.
> 
> 

The commit message has this:

"APEI is parsed after MCE is initialized. So reset the thresholding
blocks later to pick up the threshold limit."

The "devices" are already created after APEI subsys init. The missing
step is updating the hardware registers.

Thanks,
Yazen

