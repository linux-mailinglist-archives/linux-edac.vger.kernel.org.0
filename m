Return-Path: <linux-edac+bounces-4718-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E2B40BC8
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 19:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BE67AAC52
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01528343D60;
	Tue,  2 Sep 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dD2jXS0r"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4D2DF132;
	Tue,  2 Sep 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833308; cv=fail; b=E0Pbb9rjot2y+Unl5A1idnuAhxD/m1BwVy9rNj80K2LvXTAoxtG4pSBY8iDDPM52/AVzTtu+b5ZT/JVXuBk8SUj0X0ZI/ACpH7Ehy/A0kAqYtk+u1ooh8uZgJXC5OtW96Gu6+4heR/XgY2M/aUktdWXGXhrc4DpvMY9hKD5XLKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833308; c=relaxed/simple;
	bh=Defyo6BK5Jf29mhcntBuh8bttNG6vvVTr+6aArmKP4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZOLWnjsl2Rifj2/+p5pzL/mUmc/qwTnrarFDNmm8+5wz2a3ItQ6/P80qvS7BY/74bozViFWnGeSmrh8GA1SAFsBXL2nz3j+608iAZyziRVR7HfW2HPZIvp5i+nU71WinItRmS3UrJMR6HhPKjJf6xZ+qGSITxzoUY4+EcgYdY8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dD2jXS0r; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaSVwH39Fa1RtLnBD84VO8cj4MWWzEIkko7YiU9qC3//vDLsc/fim2efrRhBS1IuAFC5gyJeQxRiUc7n0ZWUC1HgcLv5gRbtIGaylSaKQO8myLVuaGR8mno12I5JmoXn6PMDZKErHwGGKKSKUMhHgXfXMmalgeOIuPut1d+dBExDC6THgq9Wo6uT6EuoH49MswH9DDteq9vjsxMaMo5vyRjpJh6Z8Ho2PRSL27XBoHfwpet7wEJECARkU7jXRt2u5+AtOMqtz3yK+oQKzn+rHjhS9lVprinNrTLsVDvXhflB9HQGzl7hXOPvO/TdGic6rNV89PllYT4c4N7bwTSg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVhldzF7KIaaWHTQsd2ckk/rP/NRGPvRlUh2aTVJobQ=;
 b=c/PBeovmSwdZ4uhZzLbDn4doPEigatqXGXapUhjIAknhkx5BFEB0gi/aLvv2qMcqPEiqTMhsQYHoO6V6xi6HYW8LBKgxD+mPJnw2CCJQ9IgDopGyhbpl6feMgROky3MRDzLtNqXHeqpp906rC4rzrnskVnQ6a/5wER+8s6RUJxVGiqzZ1yJvkm93W0dqqaD6fANo1JMSIMH+L6ySLOHSaHqGHa8Giooq4YtUZJEVg+5HiuaWzi37vP3ILulPgYhmgzT4ryOwcDrQyZ7jghhArvd/7WOKKUDuTbRlo3lV7UhlbjV6yT6meoFQNEu7TMV6+NvU47ohr5EccQ0n7DdMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVhldzF7KIaaWHTQsd2ckk/rP/NRGPvRlUh2aTVJobQ=;
 b=dD2jXS0rmAicp9yl77IYqTPPOUjUqrtvq1z7xkWiG+tMabojb8lvNkjet3wvfGIHnudX6R/brV8dZ08UiQjNpHZ8UXJtFz6zGH3Z7q9zK3Vf9xu96OyLlBUdpmqNlWr0pOJcPbSZJV/+QAefogvA99C2zyPK8XSNjt7i5wIRkmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 17:15:02 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:15:02 +0000
Date: Tue, 2 Sep 2025 13:14:57 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 07/20] x86/mce: Reorder __mcheck_cpu_init_generic()
 call
Message-ID: <20250902171457.GA273005@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com>
 <20250901170741.GCaLXS3bUdUPksnMs8@fat_crate.local>
 <20250902133015.GA18483@yaz-khff2.amd.com>
 <20250902162657.GFaLca0ebBdk9j1DHO@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902162657.GFaLca0ebBdk9j1DHO@fat_crate.local>
X-ClientProxiedBy: BN9P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a47e9b4-86db-4fb9-f572-08ddea4440bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFN1P7wuc5qI/oT83FQ1NPoh1T/gP5CoGdLbY2JeNa7j4WjIIvhAQb+o07Y8?=
 =?us-ascii?Q?7UXnaEZCndyP/v5arrutBCPg0V7/G3Qy08G5Q/bRHhnTpWOnA4iKGxZcS0BF?=
 =?us-ascii?Q?bMMN4bx6MqJu03+a9hcYzf9wrk6ygbHSgkJFrzsSmjkIitLiwq47r6od5xFd?=
 =?us-ascii?Q?RWYqOBV0pfBeOReVJxSBofmtnnWGS8zoptJBdQGY2UYXacBRXiH2fhrfQ3os?=
 =?us-ascii?Q?2pQt3OwCER9R/emRWl+s1OyfTK2kiXQf85g8DmovzYcZq8oHxOCKa0zstj92?=
 =?us-ascii?Q?ZuUQ8Tr57gH0Mq1nA8iVaBQZjiHDLsFDjzEQX5OsoMDMFOvS6GFEH/SyMZPf?=
 =?us-ascii?Q?fBpiMuVtaIcD/PEW0giCttrkLbpW0z5cwifUrGVtcmuS8dMYuJDHKlw9ZCon?=
 =?us-ascii?Q?TIWeokpcKf/eY4zzGclmXq+LIB7Oe9OeCXR0sGcici/u802RA/ug86mhLMRl?=
 =?us-ascii?Q?c7QKltgnDZCgK9DwofHQaonFdPZneNDcUCweXCiN0mVTL2aqCPxeMOHX5KDk?=
 =?us-ascii?Q?FSgDD/AqFtLJ6WpoWqbcK1KWEZm99HGSe3Z8Tj9IpMGlMgbzY5ZLkssGwLrS?=
 =?us-ascii?Q?HYp5tZsV3mDO2wZZpQ3d7YS7VDP9nasCQpkGDk5HuB7ZlBjBlgnVD6/CkUCA?=
 =?us-ascii?Q?vxXlEHcj0OvuU+6nGrEoKIjWrRBBE42E3NanJ/GtvDWAb+VdyAlCLCG70UEt?=
 =?us-ascii?Q?dptRIBgSjNKNu9V1qm53dJpsVW81C+aicYjJ7zAtopry3TongfqnWYxMAhk0?=
 =?us-ascii?Q?E+gs3QcCdqYMi9FqPncDhtiIyQPkhWts3YGmFGMuckLzJWSKB2/1MRKXtgTJ?=
 =?us-ascii?Q?xKr42mgH9Hnl1Mt6a1NdZnhEBP2ZrspxSI/ERVg0/6h4hvBoNLoQDnntqU1J?=
 =?us-ascii?Q?JBmOZ2LHqWg2XAi0MhbI/5C9awx45v4STHTBofxggMZKBRjkxRerzX2xo4uA?=
 =?us-ascii?Q?G8de6icdLTUgI9lNLLLSIp8EXgANnGNsbzHsF+G1veu5BT4VWhknyQVUCTXA?=
 =?us-ascii?Q?y7ZSTve6+RJTcb2ni3nyVuEN3T/PzoHOMGlGaK0eVD2Cq/RtmmslEUGV3BDB?=
 =?us-ascii?Q?4CxCLboA2E3cU8PqrTk+ETsFO+LuE3pc8U9hZlVcDAHk6ek6MIFwOWLAb8+Q?=
 =?us-ascii?Q?Ozu8OuyU+jxBp85YDQ3as7siDAyBQbEmOu/UuAvJOTGhiaUC21VHF7Xo6rDw?=
 =?us-ascii?Q?uFwDxq4XfZgTddr4REf5Oj1Lcd68xganuns9AdTLJ6/52ng0qvOxNmh5gIaB?=
 =?us-ascii?Q?mHxynfocaSkx+AyKzinLobWfiTImsnGblKau5uFa9aagnWpmJDZumUZQyUkI?=
 =?us-ascii?Q?fDMLxsiG52JUabUXJ/RiTTXk/5RT9a9c7f59AP8zIh7zYc3tul0zEWPm3WKB?=
 =?us-ascii?Q?q4CKrf8S/dMuOAY3v/aRi0wZZ2PLL4GkjXPhIelSSYVax9UPIpgQQVxfXiNA?=
 =?us-ascii?Q?B05VWxaJ3kg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlyuDetIPmK3iVCDfy7bCYEbGmV4SGIClIA2yXFCrKNZwNnypVe/ngygeBvP?=
 =?us-ascii?Q?kFKkSapOgCWABfftogWrtb5RWsO1pjWnoUdX2GUKc/j9oBG+oBWYrZZTPomf?=
 =?us-ascii?Q?yilT7Uz1uZTZhFj7f60csFCL/u6Ax2XyzYUFgt5yQZdT2miyohUka9iUwES2?=
 =?us-ascii?Q?Sz6sX3+/mRe4kHw623EygdVWQcY8jRY3Vyrh3lpmgildRuAzKRtmpapL5bdo?=
 =?us-ascii?Q?Us3pCeuXbTz8xhPnI8vGfM32oZKu/VnO1k7rrPARqRBk4Ob70mPdsQSrCaXd?=
 =?us-ascii?Q?+iAQGnSjb89fA/1V81lGjJ5LSXat/ItpGC5gFrLk4J4GWCr1DI3QE4w2125h?=
 =?us-ascii?Q?akycfZ8hBLwQHK2goc5YuTXgAm1Cw8WE99dXsSn2ta4vdKkO4HfC8gAubrrr?=
 =?us-ascii?Q?fNF1FcIIRZCYyFj9YuFVNm24tsbaOe/9IIJKJiG8iX5CaCCAUtfyQ1jgyW3q?=
 =?us-ascii?Q?I3DieUvKUTy6eetWyMHvWBfdfN0UNj4KfawjIueFXYcPTKhZETPoqJeom96b?=
 =?us-ascii?Q?xC36K4lqvYb60lII5l5vn6iI7VwkPC/ZT9qA5z/1XhmSmKRO639euYhsP9QD?=
 =?us-ascii?Q?q/99CnqLC5geeqt8zop42D6+vpDHE7l8qu4uALSJJnk8CFY8cCxyPKxhL/bG?=
 =?us-ascii?Q?zkgRYDNmm+OGurJ9ZhO6Hkf4xkgYRlrHCOdy4xyGzBsL7hmujvkKhpwfichF?=
 =?us-ascii?Q?NEM3W7ksbTBMCtriAT+N88G+sdz/0rJf+gCVelZUtdCI4U2NIFFH7KWwC4Jg?=
 =?us-ascii?Q?aQsF3JnN+lb6rM34t+S6uuClRLbDiMD13NDqLHhwsYhJRuAEoxL+OWPj87vd?=
 =?us-ascii?Q?5tRmiCraaY8tIEflSyx57xwCTUmKhtzOl4Kl5cVYDcfN7ISx9l8YSMKNe7cl?=
 =?us-ascii?Q?AJd9zvdkRXHIsgVSzY8wKksWljCKC4MGYXh3SzPLY6fWQabYXkNKtQh9dHUt?=
 =?us-ascii?Q?ZwPo47HH7O+gy7iiAfoPDGIMheEQazNtnTViilwRnqiCKOxaXUyCyDrxAr1Q?=
 =?us-ascii?Q?RiKTm4feG9wKNE6/Zf1DJ4KSsbSLKe4HtS4JUJitKkpbVuY59hn6YNe6s+5j?=
 =?us-ascii?Q?jI0MGDeOpQW9z2LQUciPJw7MdPrv5sI0QSxvp4HdTVPn8fBdHF5xNj5s0O1C?=
 =?us-ascii?Q?tSNgvVaPb+08Nv45CGg+kbWhUggdtQkiW/WORC3ntJY20yxq9Sl3gkHfTqnU?=
 =?us-ascii?Q?MLIJF3c/HCdfKKg5kI+ZvcEwxkXYbeEpaKxfeYV+WHawmbk7cCYPwcRCCBFY?=
 =?us-ascii?Q?qxAxRKqxu0XzQRK9lvXTPasNk59CPU3ACGKpG2Bb8UYl/HdNng75oJ5/AMku?=
 =?us-ascii?Q?rOpZDK/AD33piLUAh+b5D/v1nVdr3AIGjgExzkdnBALVKVfnXoFYx4h0I9bX?=
 =?us-ascii?Q?CrSkBVSlkNtkJWK9sHW5nmeasd+pyWqn57RzULHCls4y5LcQU3yil1EwVM1v?=
 =?us-ascii?Q?HPmU5B2KYc44+QGNoXryFPIzRB1xHuOUD4ZOVNrnvipk1DgzJQkCCy9R2sMr?=
 =?us-ascii?Q?rzB8Idprg6CfEaVU9Ymid62LV35R+wbYs7+7j0MsFDZr1x3aN2iUSv0R9sxh?=
 =?us-ascii?Q?YoBKzZn1oXNMj9otpEgiW7J9YE9+9RvMRbuRDg4E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a47e9b4-86db-4fb9-f572-08ddea4440bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:15:02.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GODwAvzaIfCf8H3ktAh3kFQ/eI5WgYhmN1jWCYgLsK1VunqhArgJJmmnTY1n+TSrlD6Y4AtCNYO4f80GdueiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

On Tue, Sep 02, 2025 at 06:26:57PM +0200, Borislav Petkov wrote:
> On Tue, Sep 02, 2025 at 09:30:15AM -0400, Yazen Ghannam wrote:
> > Moving CR4.MCE last should be okay, but deciding when to do MCG_CTL
> > needs some more thought. Maybe we can have an early call for Intel and
> > a late call for AMD?
> 
> I'd say move only the CR4 write and leave everything else as-is. It has worked
> fine until now. Unless someone comes hands-a-waving that we need to fix it all
> of a sudden...
> 

Okay, will do.

Thanks,
Yazen

