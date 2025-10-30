Return-Path: <linux-edac+bounces-5266-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D1C20C77
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE1784F06FB
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22827FD68;
	Thu, 30 Oct 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiDoOFmi"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E027F759;
	Thu, 30 Oct 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835937; cv=fail; b=IubHyxjgjRPNuVV6SziZNnYS66Mcl0nzbzl/27I+OiaLh6gvWir4RGFEsX0CPdj5m5GhrbpIYRxAv1ATO6Y0wz0cnKSfWGz+aUB+fMHKgSUFY2M6z/b/ZA/vR7+i7yW3hpJgC8mrlXvVxkcU/w/ec+ijMlApnzWyQnVO9z1vfho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835937; c=relaxed/simple;
	bh=Rymly9my9JQ36mqHcpl9sBL5apQcmHRzpddDzSNFUFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GW00miWu2qH7G7iWcoWG7/+z8yiKaBLjnpyWICha+F+FifIWPi85FMa3OBgVcHKmmvF6m5rQC9BHHpOxu5XMxOzuXgLeI2a05mswej/vigkthmPHCSOcc57y2B4SGHpjDgt3RU/UT+wTneBFCY1OQUYhgqyTj4+uYZt7WHRwHBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiDoOFmi; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trpO0vRyGAPMsmkCM9IauM0EAzN1NRP4w4WLcyxAhBvRSmnAnAeE/brey2FaZGlqP+yqKaG04IQpvkXZQzmmd4rgTsepaKN46rp9bNxc5sizYVJUgztNryovAaJ7E0j5ApGKFGziLg0JuzaKC8twKfGR+sg60TZBY3zB7h0NcryO22/+4tBfZCIf95RmxXP3J5Zu45HVgG2QLjcBiBIkhdgkbS8b3FT7XR7XB9kyWPDPpJbptQ6OG2Wqd0KNKUUmW7MeMRwU02Twbx0dihEyGQqpkrYRutO3b7Mpxr8aQkjg8Qewmrgp2N0AyBixpDfp4uJIFhzAoc+Y4glfEmkrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlRGRMTeMXTU0NZO+rP9URGya2nO4gPFAOLHgqGcaKg=;
 b=lfEdNSWJv8BDGOx+gkk08qcGUGxQnRAGJPP6okO+S2Tx3M2yoYrdsCJMRz/txAFIdBuUL/6Kpe5WOTepZyGL1DzQ1qvNOSAYUfUUh8u1ls8XFLF9ptg0B7EZwo1uI0tAgbfmfGPOHgs7nmIa1kyjAT7b+CAyXHDSCU9LPoS5mJH8tXpvEMowWPlSGEqXNj7Sa6ctAi/gUAJTBCH9iK4ESD8sUbaL7bDwNQfZfCFg15Djhk4kw4bVSYIBPESQmNPTAY6f/Eh5O8qcIe4vcCixRWeVqCzmvWeuv3qqLVxKPOakaBVNGew9OX9UrZ0JgVWkgKiVfKcuWl93Dw/Y1jZ58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlRGRMTeMXTU0NZO+rP9URGya2nO4gPFAOLHgqGcaKg=;
 b=jiDoOFmiIF+CnmcOwR4cGXROR331kqavct9AYEjPV80t1WVUeUrvlKdFtEFLOdiwcXP+7G6pDDcQ6NPGQijfIzLU0VtyhhIwHFNvEeoegWDtIsAyE+O3TvPFixMpiQ0i8JxXH2eyLOYRsa4inNYtOANGqleYjNxaGeFb7VJH5/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:52:11 +0000
Received: from CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1715:5a3e:9044:94f0]) by CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1715:5a3e:9044:94f0%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:52:11 +0000
Message-ID: <c11b001a-3642-48a4-93a0-fcde6cf8f54e@amd.com>
Date: Thu, 30 Oct 2025 09:52:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
 <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0130.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::21) To CY3PR12MB9680.namprd12.prod.outlook.com
 (2603:10b6:930:100::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9680:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca8130e-ef4b-4299-4dc4-08de17c3e7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTRJbnlwY1drdFVDNHBkZTBzdzJkU3FJaytxVm91dmkrTUY1ckNrOTZHaURK?=
 =?utf-8?B?cnR3T1g5Uyt3Z1g4cktwU1RUN0FMdlFYOEhrMTIrOUV2ZS9EL1FKRXc5ZGMz?=
 =?utf-8?B?STRJU2t4SnRFQzhJQUpTSDRlQ29MUGFVUDZ5dVExQjJvcGxJQlFUd2JUUUc4?=
 =?utf-8?B?TGRxbWtHMEJnMTlueHA1NVNSbFU1TS9pUFhScHBrc1ZYM2MwU2hQb1JEUTFX?=
 =?utf-8?B?aDZPdVZGMXhjMjR2aTN6MHJTVmN1YzIvSmExTjd1cFFiQUthYnN2V1VxaGtt?=
 =?utf-8?B?VERKRTBOeXV0Qzl3QnlxTFVTNkZpa1BwTHpxU2x4VjFwaTQ2dms1OFc4Skxn?=
 =?utf-8?B?dmRTTmVvd0ZkL2s3aUJjS3J5bE5XK2NQUzQzQ0doYk84MDF4Z3FjbmdvbUNx?=
 =?utf-8?B?R2l4NmZVNVhVSDhMczY5dnpnek13UzdjOURDSC9ra1ZmU2pETE9aUU85OGlD?=
 =?utf-8?B?OEJQTEt0R2t4TCtkaWNLS2dKb3JqMXlPQms3N3dzR0JFbVlzTzJOUVQ2eW1o?=
 =?utf-8?B?ZEhtcXU2WnVQV3RGMlBtQ2hwclF2M2Y3N29zK0JxYWcxamJBZm1uV3owMmhu?=
 =?utf-8?B?eVJ0MG1aUDRjRllENGlYZkVkSHdtcFhaZlBWenlhRXU5bHZ1RExhY3ZrSEhw?=
 =?utf-8?B?SkdSbHFuUFZuQTR5MHJsYUtSd0dwS29jdXpndG12RFdsUVh3SlN0SGU1U0FI?=
 =?utf-8?B?N2taL2cydmRkUW1aRmtxU1czVXRUYitVTys1b0RBeHFnTXFPNHh2TmlRUFlY?=
 =?utf-8?B?Y3JTdGh6MUtqeWRWQmhUektNT2tKREFEcEhoaFNqcWpxS3RTYklPQ3NTZlpj?=
 =?utf-8?B?SEpuSnFjUjczbUFURlllell6Ylh6Nkx4NDNqdHFLakR0cm5XWkFpUWo1NDRF?=
 =?utf-8?B?RnQ2Tk1JMmRqOThKZ2dmbVduVHdEamZzbGZHYUNEWFpsWkYvbjROWnFTWWpw?=
 =?utf-8?B?Y0dRODAxdVkrei9TcVNKc0RuMUQrc2hrZkdLTmk1U0Z1R1h4Z1hSQXlwMEdi?=
 =?utf-8?B?OVc5NXV4bGpUZWptbkZtanMzZnU5MzdZWTlCN0xuZStnWFd5L1NJK2Q1WFJj?=
 =?utf-8?B?YmZqUy8yUmJLaTN1VVdyMGVTbHEzRjNJdDZ1VkFDaHZPMCtlREFQbXN4RXJ1?=
 =?utf-8?B?THRLb3RFL1M5a2VBd08vWlE4L01xTnVMRGxCdWMzN3lpNEdWdGRSSjNnUFlj?=
 =?utf-8?B?bGkwVVZvd0hXRDZzUFRjdnNwVCsvU0NHcVhac1A1SENrTE1Pckh1cVhkaTlG?=
 =?utf-8?B?UjM5eEk0d2Z2V0lKY1MzVG92dnRMREx4SDRFVWpheFVOQlBOVjB5NzBQUzZu?=
 =?utf-8?B?MTBVa3pMeTNaL2tvVkdtU0pORE5oTkQzYmc0Rml5djliMHBSZ1NOeVFieWZC?=
 =?utf-8?B?alJaWW0zeVFaYVAxQXI5YmFKV0sra3psWk9Sb1huUkM5MG1pTDNNMk5lRHV5?=
 =?utf-8?B?Y1kzZ0xBQW9pWjVXWUdpUGlCcU9xampVYWtlNUxOMkZRMVNxS2ZEVUJKV3RJ?=
 =?utf-8?B?eUlXcm1MR3FHOUFZU21ZelN6RXJNbW5xanU4OVdpbVhZU2h3RWhDc1pRMnlo?=
 =?utf-8?B?MXgzdlpFaVdSOUtKSktRaE45d2hvUEhnaGdCV2NhS09RK2pONlh2NDcxMndj?=
 =?utf-8?B?enFXRUR4U1NBdjRWdStnelZvSUVrSXhjMyt4UlhTamozY0tzU1pzMUNWbytR?=
 =?utf-8?B?QmxEdlk4UUJNdEhTNU1OQ21pU3owUjRCMVNUbmh2V2o2aS9BMFNBYlk2YTBo?=
 =?utf-8?B?dmthc0pOandKQUxiWVVhcXJmQzV6K3BicVg3V0lUTTF3V2lrWUU4enNmaUp6?=
 =?utf-8?B?R0pHNU1yOGJiV1NyeC9JMjltaHB2bDR0NEppQnVsYkN1cVM0SmZTWTFiOW85?=
 =?utf-8?B?cno4NkkzS3BJRm40VGNFRlZ5ZG9HMHJDcU9UT0p3akhGendmVEVCV0V2a2Qz?=
 =?utf-8?Q?1rkWd4qcR67TTmHNBYxVWXGfoAYdjsTk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9680.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWQ2UmFid1BYSTRJbGhDV3VyU3VIcVdpOTZqc1paSFZqMk02a1BobWJ0ZHM3?=
 =?utf-8?B?djBDbnhTQUk3MFVaOW90d1g1UEJLWDdpeFFiS0JUamlZUnczQU1peHVYMTJz?=
 =?utf-8?B?Y2FKVmx6bzRBdUw5VUNFNVFPU045QnNYSUlIS1RLeGs1QVRsVlNkWm9oRUJ5?=
 =?utf-8?B?WU9Cc2xqbUVzYXg3VGFJZEhlcWF5NkhvMkhsUCtlblpQWklBRlhSRHFqSmYw?=
 =?utf-8?B?YnZUV01oTDY5eEtBZmZjUDZ5UjFpa0h3S1d6NmJEWXI4eUtXbFdkRmVoVWt5?=
 =?utf-8?B?Y3BuOG9HL1lQa0x6NU5ZZGpPaThDUTZYWGNaWDBWVW9KMXpSNUlNRUxMUWJj?=
 =?utf-8?B?dU15ZkJYcmtaK29hMzlmYTF6bk42ZTZvRjUrL284UnE2azJ2aC9zVzY4ejZD?=
 =?utf-8?B?dm9JTkJieVYyTFdZRUpKd3BWQmpjWmQxM3E3MHAwTlF3bXNyWFArSUsrRm1r?=
 =?utf-8?B?eGVHMWJCUmJKSHBZek1xM2hKcnFMWStTRkIwcmVtYWNkcXhnMTB6Z1drSWFw?=
 =?utf-8?B?dFdPOW5QQm4zMUtxNTZCSk9qekRtc0N5TUJNc0tZbnNyekl4K1gzaFc5YU92?=
 =?utf-8?B?ZUh2Z1hVSzUybEpFRnQxTDNnSlljL0RMRmk2b0hEbjFLRS9Ud1FzTzlTL0Zq?=
 =?utf-8?B?VFZ1UFZtUjkyMWFZOTBMVk5WZ1M3d1h6M0xyd1AzbDlLNlR5R1BMemZlL21U?=
 =?utf-8?B?ejJvaGNSYjB6TGh4WXZySUx3ejkrSFBaU2FPd213RFIrbXdCaGxKZk05cjly?=
 =?utf-8?B?My9qMjR0QlUrdUFrOWQ5UVI4OGtXR0daamd6ME51czRWZG81ZnVCV05YaHVr?=
 =?utf-8?B?aFJTN2NrSWR1QXErV1lwQTFmVXRhV2FGNzNwYXUxcnUwL2w0U0tteWhtRWlY?=
 =?utf-8?B?N0sxUXdOR2FqdWNiZ21RVE1ZRGlXWkNqNTRrUzlMSFp0VUVsWGhPeklpTWpu?=
 =?utf-8?B?dmFHQklNOXNJWUY0ZFl1ekdDVkViTGtyTFRDMkg1bFAraS9TK1M5VnczVWYw?=
 =?utf-8?B?VTJnRXhETVdBWWw1dWVnS1NBTEJHT1U1R0NqNFc2UEVIUGR3eHVEVmNHa1Ja?=
 =?utf-8?B?NVdoaXJHSWdpUDh6Yzk4TjVld21GbURLb3ZxcEZFdDBpdS91OHdXTG4wWE5y?=
 =?utf-8?B?alEzZC9EeVlnS0xuRUE2em1ETStOMnNrb0Q2blV3QVRab0FwUk5kcXhjS3lV?=
 =?utf-8?B?QXBJRUo0aEc5SlFZVEZnZldOVW9xQS9iOEhUNS96enZnVHR6dnU2M1MyZ0JC?=
 =?utf-8?B?bTFMQzBuQitkSi9jMDdmRjJjNEpZRGF2NzBZbERpclBicGY3UnhsQWo4SDNP?=
 =?utf-8?B?NDNuaDNDMStGZUtWei9GdjdId0JrSTdTSnJaV1JjYUo5cnBLYzE0M1JkUEEr?=
 =?utf-8?B?K0NZLytRa3c2UzBPTUZCcmErbUtQUE5UYUR1T25qMnJQL3p5bVU3NEZEbStk?=
 =?utf-8?B?VFVBZFJNeGg2RktBZVdPaXlOa2VFUTRObGtZMXM5dlNMTU1mS0R2WTV3MG9J?=
 =?utf-8?B?VWYycE92SEIrSEVYNzkyL2xQdlBCcXcxMVM2a3VaZTRjSU5uMDdFanBwdVRk?=
 =?utf-8?B?UTNwSmtJamZuR3kyb0MzMkJSQmdEOTFQM2dTWnppM20zbWpyQzFWWkZRcUhZ?=
 =?utf-8?B?ZzQzSmN1d2tkNUF5RWF1TUFFV1dPeWJYamxlVUV5MFcxZm84NldnMlpIek5H?=
 =?utf-8?B?elJMZXFRV0kzb1VJVWVFSjlTS3paTFUxcnhzcGxlZGtPYmttc2s1aU1NNlJ2?=
 =?utf-8?B?R1Zib3dZTEVmTkttMnpjemVVVjhocjNvWXdnUGhMbU1TTkFad0ZaN3dCOVpQ?=
 =?utf-8?B?b3MreUNTTmtlbWlhZzNnanVvLzc3NlkwMFhmSFVkSTd0ektxVmxlSDl3alpq?=
 =?utf-8?B?RWJCYlo4UCtjZDB5bEcwenpBV292SG5oSmo4Nk5oT2tTV2gvVWlEK0R5Mmtp?=
 =?utf-8?B?MFNKdlROYXpiY0FsNjBOT1RtUUI1MWdWdzhyYzhvejEvd2tWK1k3ZEF6Vnd5?=
 =?utf-8?B?c0JpbTRrdThBUStEcTBpbmVFY3R3ZHU4Q2F3K3IvYVhvUW9NeHVIL0xtbGVi?=
 =?utf-8?B?YTdoT0ZSQ1NmRWlSWmJlQ1pvOENHMktYL2ZBMWZHOW5qb29zUHNuR2txeDVO?=
 =?utf-8?Q?Ew2dtv7Zi4EZQajktIC85F2c5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca8130e-ef4b-4299-4dc4-08de17c3e7e3
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:52:11.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZdRqTkbIPfc8+77B6vZo/nHRGhhQUF7AYAqNTn0RvvNP+iHzLpAMR7Ju8ND/SAEbdBf1tZLF7TPV+1hzqxJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763



On 10/29/2025 12:24, Borislav Petkov wrote:
> + Greg to tell us whether that would be a proper deprecation strategy.
> 
> On Mon, Oct 13, 2025 at 05:30:43PM +0000, Avadhut Naik wrote:
>> The legacy sysfs EDAC interface has been made obsolete more than a decade
>> ago through the introduction of a new per-DIMM interface.
>>
>> The legacy interface however, hasn't been removed till date.
>>
>> Begin deprecating it so that it can eventually be removed by v6.21.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/edac/Kconfig         |  2 +-
>>  drivers/edac/edac_mc.h       |  5 +++++
>>  drivers/edac/edac_mc_sysfs.c | 16 ++++++++++++++++
>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 39352b9b7a7e..fdfeba848114 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -25,7 +25,7 @@ if EDAC
>>  
>>  config EDAC_LEGACY_SYSFS
>>  	bool "EDAC legacy sysfs"
> 
> Add "DEPRECATED: EDAC ..."
> 
> here.
> 
Okay!
>> -	default y
>> +	default n
>>  	help
>>  	  Enable the compatibility sysfs nodes.
>>  	  Use 'Y' if your edac utilities aren't ported to work with the newer
>> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
>> index 881b00eadf7a..78b49d6906fd 100644
>> --- a/drivers/edac/edac_mc.h
>> +++ b/drivers/edac/edac_mc.h
>> @@ -95,6 +95,11 @@ do {									\
>>  
>>  #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
>>  
>> +static inline void deprecate_interface(void)
>> +{
>> +	pr_warn_once("NOTICE: The legacy EDAC sysfs interface has been deprecated and will be removed by v6.21. Please switch to the new interface!\n");
>> +}
> 
> You don't need to have a function which you replicate everywhere. Simply dump
> this notice once...
> 
> edac_create_sysfs_mci_device:
> 
> 	...
> 
> #ifdef CONFIG_EDAC_LEGACY_SYSFS
> 
> <--- here.
> 
>         err = edac_create_csrow_objects(mci);
>         if (err < 0)
>                 goto fail;
> #endif
> 
> So that it gets issued and hopefully someone sees it.
> 
> Then, I'd say around 6.19 we should make those functions return an error
> unconditionally and then zap them in 6.21.
> 
> That is, if no one comes crawling out of the woodwork with a valid use case.
> 
> Thx.
> 
Sounds good! Will do!

Just one question:

Wouldn't it be more prudent to have a log of our intentions available when someone
tries to access or read stuff the old interface too?

-- 
Thanks,
Avadhut Naik


