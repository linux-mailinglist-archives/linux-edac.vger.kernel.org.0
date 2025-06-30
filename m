Return-Path: <linux-edac+bounces-4286-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA373AEDDBE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CE73A66CE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6F289E05;
	Mon, 30 Jun 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2P02Xhb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329028983B;
	Mon, 30 Jun 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288318; cv=fail; b=YPketgBLcquJ+GIO7pFJvxyCEGXDYpKtGJ7VLrJJar6tjUzgldU9PzJLAjfohi67N1U0vYX4GyZbZNPUyUieNNaxXqAH01sV+noNdznUfSb9996cPb41IJroYAsLWhvn7DLvb0lnJ0nf9Bkf/tM5TOTYZBgU8aksUUFKIh3l7Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288318; c=relaxed/simple;
	bh=HrI9mqzYT8Gxswl8ESu0q5dnWj12WDrXrUPzdjXqrz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kjX86vkmRu6KGReqVlMQ7ZE6Sik/VXZcStPj/DpqO5yFb6r/v9s90nqdjuQ3fQqSSlEYlguqcvrCEYISXyrszTxwtBveLiMMfRdljaeCz3TdluV116eNjI5OEf19ySni/P8vPJmqNkUen5sjDKPK6Xqpk6IXu8iGKrlWgis7O6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2P02Xhb; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVeTsV6WbA3mwyNrei/sjEt+Rgv49GetKqmwtqC3VllQun0uocDQdQPtTwjIOnO0gscoyzMMpevU6mLDkhuDFXrY45dcRR4t2URrj/h9LgD4O74GfQ+yusfm+vcTQASSrOiVQudg0HoeiYoCj0+NbMBmZ89WU2r+SX6wB4yI6lYBFD43DSca57aFAvGNIL9bIDRx25XZonHvaGHpC+KJ1XJj2NvS6Ic1SIelHGXwot9fujF1JHtebug0BGwZUFsFlJgHOU8zh6+UcIqSLUt4FXshlXv195LOPlPi/LntVc9LfWK5NRDRoVSJHygpgTBrOaRjM+Zv4RPInc/FZPkTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/253srCgtlrZnrTaT2f1T+0eUne2760zvhNxs2m3N+Y=;
 b=GnNtYVQxUT78r7/L9DJjpubFOLK14djdr3Zdbr3muYi7Y0tx58BIgzvYyhG36gtkv6DBLj8CetOQp6jIi1tlFYfy7gE2oFsNsKs6w+DOHlq7t+EwkJQ2dzqyWJ/G2Jztdi+mgRrFslqmM7sSR8mnLcNVsRBKhVP+kDzCA01EurnLgio7P+fosteZZHhbn6WzJEPj1uBStlU6umsVZbIhnBPwuykr9y4CTxiR5fT8b8BCEOT0Zm7br5vIKBFoCfnd6qUnY5lqWT0m1jQuqVWTxLq6GqbX0Vd3ZM1kUZymHTTnVetbOxKO7I+ZzsmDf4vcLm8ecesJ/tMUUJSo7L970g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/253srCgtlrZnrTaT2f1T+0eUne2760zvhNxs2m3N+Y=;
 b=a2P02XhbNAlnxowNvXR4F2gRmJjHO2Fr2AeyU/w3yWFJy0oUNEuqE5yQ46k1GUMZ6+e8Eh/AHUlFLrLF8tYT2o4n6g3hxr13cLAvhq0jSUYZXgMYof9MKxuOxiJWAvguevWe5wstSCZFnTzM6O8ip76eDTABDaTxXtrbMYG58Ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 12:58:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 12:58:34 +0000
Date: Mon, 30 Jun 2025 08:58:30 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 10/22] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <20250630125830.GB5995@yaz-khff2.amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-10-236dd74f645f@amd.com>
 <52a37afe-c41b-4f20-bbdc-bddc3ae26260@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a37afe-c41b-4f20-bbdc-bddc3ae26260@suse.com>
X-ClientProxiedBy: BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a1f220-1dc7-42c8-516b-08ddb7d5d298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzk2UQbIb31ZUQlfGdmHcBMZCLh39c5GO4W+rICvvrDoYqMkF+HGuru6+yjn?=
 =?us-ascii?Q?HLRWgFN+4xqnTEtNvHF0OvYGsNz6oORl00gEPPpMQlE17QjnykOGPJPikxch?=
 =?us-ascii?Q?a9qworIMbvTYlz5i9Qq5Wq3AcagJdyEmB4uqy6eJKM76BaEGHY6bbo0+AB1y?=
 =?us-ascii?Q?nJAnAJQJTmh5xmc9QmPio8D3l+ZWd2HygVsvAeJUS77pgGzi/VzOb0J3fRFK?=
 =?us-ascii?Q?5HjXXNUfLqvVB3DIxszedBRYAmSr8kSxrnMI05V70ZTnTzABvB2FmABpklwS?=
 =?us-ascii?Q?7md0q5JKkEI+SrRCm9dhPIVk53wKSepu3P/ZpOjMggeL/CtwRDEDY5X8nJ+w?=
 =?us-ascii?Q?ISyYlexVkNNW21pOtYXdCkpk5eP+yOgndUonLMlmV3Y5atXuM6B1N9VHGzjD?=
 =?us-ascii?Q?F0KcrnXEpwKq1loHvesEkwaBuTrPrvZxUZlvIQuT49ibLdNDXoit7Gxz5yCW?=
 =?us-ascii?Q?zmKhQpxd6zLJ85xaU7IcMMeafHr2QbLE7LA1s117xmvbCdolJgGph7ew07DL?=
 =?us-ascii?Q?mawWIhbLc4sGqQZYWTro6beGE81EDWsWFKD79iTTqpLeHwUU3auW8m/XfHLm?=
 =?us-ascii?Q?DKLpvCudGXJmopPvLM5MHAUQY/k45FwLEVjWyK8wQPUpjZcymnqOczhEyfpJ?=
 =?us-ascii?Q?cdfc6uLEcH5RwgxyXjNAvslw/ejUg6b/W+zmN9Wat7LkjaEYj/d/G0CUdR2s?=
 =?us-ascii?Q?NN5WRQS29ufFSbuMEHdreHOYP7alGYC8xQHwgKFOSvzrq5jTXkEWRCsv32kF?=
 =?us-ascii?Q?XTcN5A81d48cqpjzBSOzx+Lz86ceCQvvnTwkw9gtHS0qOrniMPCA5bcxwe1+?=
 =?us-ascii?Q?FQsCS1WOizUW7FbSmgN3BnStN9lgN3KeHofulMCHrMQl+OEPKTk6QRQVrcW5?=
 =?us-ascii?Q?qU9761Z8prDSc6+V7TZorvvfjdQjgtBhYlDcEdx4S0yVNU6I8xvCj18PuDVF?=
 =?us-ascii?Q?lzLoFeIhTfTrSTpIgw0r892eL5/GU0q23XfdzCVM5Xvt7SWeh3nisAy2c7qe?=
 =?us-ascii?Q?o/2fRzGnSkp2f3mZ+ODajUkDszlCbYKdVKmSVYtTJgtPMtIFw3W1uZIrbvPG?=
 =?us-ascii?Q?d5+mNPNly0CJpgKjiiAzmCkLP0dRJu8cYh7dDPFqmXPrHrbxhr/mXN2dIyFf?=
 =?us-ascii?Q?XR5mOQn7rLq8X769QTFj/2EqB8NGm4ofH5+F+O616d54QiEdwbpWRJ8ilzcy?=
 =?us-ascii?Q?p4dr0rnspTI2/zfOn3rysQeEKZhgSRcJmFKvfkVFCpiv5tsvwImJqDMMX3+G?=
 =?us-ascii?Q?VfcNYh/gw8fJsoTs4oPRi1FrkkxTeTjw8756HDBNeFEA08yAUSggWY4Os9dJ?=
 =?us-ascii?Q?90p5m4P5G8bScOw4sA80ZhEHuj8UiboyphRcqOA0f2eli3eRqBFWSlv0DVuP?=
 =?us-ascii?Q?RhJYH/smSYzRmyCIbON9ICmyQQhnak3JD/YsqnGyf+chUfRcD/mzQ2YGKwN5?=
 =?us-ascii?Q?WmMvNLXbqCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLrZEpxCIZjvNEQVanobY6pNPFxLoPAiAK4zssxKg8Otc0HRkRQGzXMpEarm?=
 =?us-ascii?Q?zOz38mA91SfykVyrNSP7SGRBE/gOgeRt8e0g1AOfVbXuiSOGIyErv0KQJK0x?=
 =?us-ascii?Q?CKnF5YGbFrKqeZtgGcEOMVaZpxwVFe0glHIcKHMzIt6hsHJd2SJwpVu/0e0F?=
 =?us-ascii?Q?TSFgNGKmOPQuctz0CeWtLWaV8gYNCcpwPxHrFiZ9UMtpj8jVwh9Bluc62aui?=
 =?us-ascii?Q?K4A5Dn2YVd2ZHzUcJmxT02zMPGIPZVLA9wHe9AAUX/3J9umfHi7M6RCiBLvN?=
 =?us-ascii?Q?byLt3Bi2Hibbyehyj0YOMpW+LjGzIWCnAanrNqqpPlG2OKlaIQLfn/EJbX+d?=
 =?us-ascii?Q?yDxrqcjVScIBUq2/Z7B2dbW+701j/dPUvheBSq6nNdQHAgiIEeiJXEXuoLLf?=
 =?us-ascii?Q?mjrNcvULuqtsClHyrYCoVHJP0HzW9/FKGsb/30Yy8ItJfkWemr/gMmyjWD94?=
 =?us-ascii?Q?qROOE6OgDvbCtsS7k/kwAn4pJPCghlNcGLO0grZTyJrnAsJDr9x/GZihx5Cc?=
 =?us-ascii?Q?TKcD174zoT5gfwfWpzuP7jNtPde+PnnRl9KjIRcT3a2s+F78/5FEhCfpZwLf?=
 =?us-ascii?Q?ybrqkAQQBokLDLeMHi3o7hnaG1vpTTpGBOLOlqEMk9mlyUOftzS8o6u/70RF?=
 =?us-ascii?Q?lKEdLa5kzS+HJaVF+NCc/QgdtyH4mwVYndJOhqjACW4F8xmnJYZgi5I+W3sr?=
 =?us-ascii?Q?DvZuonhW/ozANqoSg2kooWCXXP3FBFXfc9OABbE1SxfThFXVXKMih2LKImWs?=
 =?us-ascii?Q?7H6uiWqnUZPsH2ee7PMldR6bUcHHgkXEjQYvI8WTs7beERcaLujywEkRxAwu?=
 =?us-ascii?Q?xhlVVjlCK6D1esLFA4Fvjig5fInzPtGuqtLXTzG8F0+P2zRkIclArogOkwGR?=
 =?us-ascii?Q?W7VYL8v2bYw+5ipRRxDHd2iGeeeonU3fXsR2njLY9c8PzBX3IVH0fe2Z6Gcm?=
 =?us-ascii?Q?UPsc9Cd0xhazsGKwnEj9ZlpHEgjJavErVshT2IuUVjNO+xCEZYsIRI4SPE6U?=
 =?us-ascii?Q?9OcOx/JqU27XwC59q/a7xjbzxHjEAmf/cQnk2TqTYkQKThqlEl5XR7jfty8N?=
 =?us-ascii?Q?RquTv9AXN01KWyqYsB9cka5Fduxg1QQFqMzRnefysM37NUA5u94darGygmf/?=
 =?us-ascii?Q?dzCQRKDXsW5TD1WrwvHpF4hXyi0RNFSmQirtjx10jcMehHffQ6St8FKAJI27?=
 =?us-ascii?Q?2IJC6jMUSwKxwGE2RfpYPj1qyCN19RCXx20NYYncef/TIgKBuvigYXG6cvnc?=
 =?us-ascii?Q?f1V5aqhGo5GEmHjCMbzvRUhzrA7PjR4A9MmnAPISYKQSaOP2drJX7snMfzME?=
 =?us-ascii?Q?4Ey2HvxP/mUTrZfyXRy1r3fCvkfCib30SJDFXa5Qbqzzv3QkXQYgUM4kkt13?=
 =?us-ascii?Q?QV8+Je0ZPM8nQpicm6SnFv6nRxOxEFH10QdHkYHKp2baLswFrfFjVSU7AQiX?=
 =?us-ascii?Q?Kg0Mgk/uKYJdQ625Pw8KkTpKxvaWgd28nGXQnHLorAbVJil3dL8X8t8efv9U?=
 =?us-ascii?Q?BSq8tGyj2YeASgUN3sbluuIvtnamneml66ZqTJw5nmLSDfTFehVo698hE13e?=
 =?us-ascii?Q?uk8n5aZJGLuM8cc7cDnuBFiohHwgh/0I82SkDz/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a1f220-1dc7-42c8-516b-08ddb7d5d298
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:58:34.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGB8B0I2mTqpIyRR4f3RcPDUSaXtqy/tsPabQVLUFN7hVfpYdG8qsamJILaNum2bwTbLhZSMJVZ0tyKiz1alZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

On Thu, Jun 26, 2025 at 11:03:20AM +0300, Nikolay Borisov wrote:
> 
> 
> On 6/24/25 17:16, Yazen Ghannam wrote:
> > The __mcheck_cpu_init_early() function was introduced so that some
> > vendor-specific features are detected before the first MCA polling event
> > done in __mcheck_cpu_init_generic().
> > 
> > Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
> > additional code will be needed to support various system configurations.
> > 
> > However, the current and future vendor-specific code should be done during
> > vendor init. This keeps all the vendor code in a common location and
> > simplifies the generic init flow.
> > 
> > Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().
> > 
> > Also, move __mcheck_cpu_init_generic() after
> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> > MCA polling event.
> > 
> > Additionally, this brings the MCA init flow closer to what is described
> > in the x86 docs.
> > 
> > The AMD PPRs say
> >    "The operating system must initialize the MCA_CONFIG registers prior to
> >    initialization of the MCA_CTL registers.
> > 
> >    The MCA_CTL registers must be initialized prior to enabling the error
> >    reporting banks in MCG_CTL".
> > 
> > However, the Intel SDM "Machine-Check Initialization Pseudocode" says
> > MCG_CTL first then MCi_CTL.
> > 
> > But both agree that CR4.MCE should be set last.
> > 
> > Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> 
> IMO the change which moves __mcheck_cpu_init_generic should be in a separate
> patch so that in the changelog it's abundantly clear that it's a "world
> switch" function and its invocation timing is important.
> 
> <snip>
> 
> 
> In any case:
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thanks for the review. I can split this in the next revision if needed.

Thanks,
Yazen

