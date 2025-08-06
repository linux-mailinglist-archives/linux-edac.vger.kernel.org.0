Return-Path: <linux-edac+bounces-4532-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F2B1CE84
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 23:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5895647A3
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF5022A4E5;
	Wed,  6 Aug 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpOUATMI"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD021FF33;
	Wed,  6 Aug 2025 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516240; cv=fail; b=YHulXUmHfpM/QNlGTJolfo/FOCRxr8l93xBg4WPRIVdk0lWQFlUFwCXYpLLP4VxQspCALxcUeMGYBxErO8qupXwZt/XPfrU10cuHgpX02PF1gALOnUZaLHhomTpbKkIIXes8BZOnNvrZnySSLmAajn1y185HLroAsrMIMjGyp6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516240; c=relaxed/simple;
	bh=MjlK2NahbFlzVJ/x90oPpGbJg0+dvOJGnhnPmzrkN5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeLpbCdEZl4VNLzPXthNMXSv0Tn36OkAg6DbuHQYWWh//o2U/pjiRePPT8ybDMWaT+nXy+eLhp25pQ4dVjqiv6pF6TnUtprGHCpN4UnTqteZmpdOg9oeLWB2tX0XANB5jaLEqXPDNbWPCssWNhKGubfEUvhA/SNQc8OE33fb0WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpOUATMI; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNf+EA+NHpc93ifBhNcjF6/s7AcPi3x5FiQtbbb7BgXb9bqTVame7hmPGG8AqhE/kAv0Fad/YyUwcibgsBgDpPF8h7zrnBN5aLlktot0JP9UY1U7BEr47jzFWUJ3VVDMDDnhmrvpH/8fmi8VqmyM4dSh8wdX8daypPbagKO05rGM8K94c+v/ea4F0aewLkzfIaIuNBWm7PqxMNxl6w0NbKD6Rck8or4qUF2RU2VYuqLWb4yK6/oPASl/Py5QciWdOqbkjed1bxoJDIjRS0SQ28kTz+IpAjZnFH8V3ipfjVG7NQcHREtIMggquwE9olMhvP5uO7o8dkOl94mBBEANFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnJfsfki2mtwTjbNp7es7+Wwy4UknPtcOv9thdqqsUk=;
 b=fjfLZtqbdt+tIUl+Hxi2aWVkwuk+HMlg5pWpMeKPEXDgW69dd2NMyWzG4OWPUZ9iN7HZyLENf8XrvhcFUpMeSBJ26/elWUvgcvAFUClDnh5HgD7IA+ZyXOpFSAxZBpctAEko/j9mha8wWOQwSGRoLZvKcFmSn7S22Mc/tLpfKFrEL5IXaVxZBgMSHDuGYrGxZilkNM7QYn2k7JgSGJsR68JNGSBN168jIWlyTNmk7IbWfQ3H6+ktLFYeKiaCjkbR2qSn4h582EE6gfzl6OIwSMezt6UbCk0cLM5TstnL5zOT+asAA0e5FJ+KSFJUlbG+MsXN0+l/PDHE0ZD5RQwXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnJfsfki2mtwTjbNp7es7+Wwy4UknPtcOv9thdqqsUk=;
 b=mpOUATMIlnII0L0EM/ByxUXEiHuqC+N7leI7wXfjj+w7NWVtadcC1lg+gACOezzchRHMbOzpmTd7B1xEimGWa9RPLoUitSTT1wCTxlCgqOzVScUj9ndDL1N5v3H03+h21s0Kruh3/5RIbu9x+1XoXBT+bs0MVD2SSW1hgUSYqtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Wed, 6 Aug 2025 21:37:15 +0000
Received: from BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135]) by BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135%5]) with mapi id 15.20.8989.015; Wed, 6 Aug 2025
 21:37:15 +0000
Message-ID: <080cf3e7-6422-4149-8c5c-f2a6762c385d@amd.com>
Date: Wed, 6 Aug 2025 16:37:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik
 <avadhut.naik@amd.com>, linux-edac@vger.kernel.org, john.allen@amd.com,
 linux-kernel@vger.kernel.org
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-3-avadhut.naik@amd.com>
 <20250728151440.GB33292@yaz-khff2.amd.com>
 <c9ae8b26-e254-47a7-8e2f-b5da90f50030@amd.com>
 <20250806211524.GFaJPF7Bk2dooZOVzc@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250806211524.GFaJPF7Bk2dooZOVzc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::33) To BL1PR12MB5378.namprd12.prod.outlook.com
 (2603:10b6:208:31d::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1b5f19-5043-4688-fe56-08ddd53168e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtUenNhWEVlZWNpRWlVTFBKUWtXS1dNU0V3MmViTTFReWgvWHp3bGNaVE5Q?=
 =?utf-8?B?ZUkxVk9KdUFzRVFDVlRja2hGckIyS2dhSTR5L1UrenZIVDNuWUtxd1plZzdT?=
 =?utf-8?B?T0h4S3RYS0Vudk5mamFQdmZhMzVQd2pVc2dLVkw4UkM3aTRiKzlLRmZSUXhN?=
 =?utf-8?B?VEZkUXpJTXp0OU9LcVRXSlRYNjZxZ2o1R3lhQi9rTHpNS0lJQWlpZmx0WHBy?=
 =?utf-8?B?ZU5TSERNSEpWWWNFdlk3dnpPQStYMGVjbkdmOFlDVlRROENDNmJGbkVqeENn?=
 =?utf-8?B?ZEFvRzZNcTJEbDJPd1MrZnYya3czNjd5b3ZDaDJvV0FnUFRYemNYaE5TQXJS?=
 =?utf-8?B?dml3cldxVi9hcnROcmVmN25tSVo5Q0ZtWk9EVmdhbllzRFV5QW5RZitjSWdF?=
 =?utf-8?B?Tkthamg2MlEvRjk5K0NNYnF4aGJNRWRiOXlkanJCY2d4N0JkTE1NblRyTitL?=
 =?utf-8?B?d1AxL3BRQkRTb0pYZVdDWlcwMmM4TjNvRUNub1BxZ1M3cXNETENpT2t1c3E4?=
 =?utf-8?B?cE5xbUh6WlVvaXVhNjR3K1lOV3dZckNJUHhNYnJoakxsYUZqTFlpVHNRWWkx?=
 =?utf-8?B?NmpGQnl2OVlwaHdTcVZUK2o5K0RrMk5QeG5yb0xYZW9DdkczYjZ5KzJBd0N1?=
 =?utf-8?B?emllVUtYTnJhT3hKc2pmeGVjeXJpOHdTY0M3WXFKSHRNZFlFUWFvUmxLSEhM?=
 =?utf-8?B?ZjdmbUZkb1ZjZ3paVW9NUk8zZFh0dk4rZ1U0djg0c2J1N1Y5VFJ3bWovVGRj?=
 =?utf-8?B?VUlKT3RBYWhLTldQclk5VS9ZcG55ajVXOC9uTjE5SjErdkpGVHRxTDg0OEdE?=
 =?utf-8?B?V0NoVWJ1UmdiMHhzYm5vUGJmdXRFQ0g5cDJRMlpVcTNlK0FpNWdKL2hLMzVn?=
 =?utf-8?B?UmlOVUlGcCtmVjIvV2pPN3ZKN1VVc1NqaXdrSGlGcVpDMk0yUUZLSnFPRzc4?=
 =?utf-8?B?a09qRzJGeXpCMXlZUW10TWh3VnFKVkhwblN3SXJuUFJaSUhxSHNCRjA5MGs5?=
 =?utf-8?B?b3NSVmlZbWpGVlN6Tm1pVHB6azY2YzdrN1FRNUg1b1ZVSTNybUZiSk5hSElM?=
 =?utf-8?B?OWxzcFNIelcvcGE1VEMyaDM4VEY2TmE4NnM3NDk0K3FLQW5HeFFPWE5Gd3BP?=
 =?utf-8?B?d0QraSt6SDNDTHRPdDlsbEJTRzJBUlVVWEp3VVpkdUVKLzJpWHcyMUJablNH?=
 =?utf-8?B?WUIxdFN0OTZkUmhwMmZhaHpyaXprK0sza1RRVThlelJXLytwQmFVNWliTVZD?=
 =?utf-8?B?U2FkME1mRVFJUFB2NUhLaEJsNGRSdG4wZVU5NmtoNkppUnUxRU02dVZVbGt4?=
 =?utf-8?B?UCtUd012M3k1eXNDL3BQbVZpZGZmeE9iMXNtM3F2NXlpcjU1YWNNeFNNZ21V?=
 =?utf-8?B?R2lOVWlOZVJrcUF5WG1iU29UZk81NWM2L2d2M29TakhMWnoyeS8wV0NNUTN4?=
 =?utf-8?B?T1pUaUtHcVN1ODI0VUxISGlHM2k2QmFrZXRRWjBrejQyY1VZV2J5UWpIVDV6?=
 =?utf-8?B?dnBhaDlzWi93L0JEaUlpTWpoczhwZGdvOXdhQzlhNkZRL0theDdTS3EwL3Nr?=
 =?utf-8?B?Q0JsTTNSakRVeUMwRExNOUJkZFlvUnFWMXBwM29kMW1HaWErRmgxV01PNWtj?=
 =?utf-8?B?aXBaUHdNWE9yQldZS1ZwanFEbEUwWVJRdlIwMkYxM0d1dmZKMXpuVkRLZEY4?=
 =?utf-8?B?WTF2N2lJbzBCS0hGZWlPTG1TUVd2VForZUQvbDlQUmhhOTFLbWpReUEwdTRP?=
 =?utf-8?B?bmtJWVlnSit0YWZ1YmVKUUtDOTlLSjIyUWpVNkp0M0VSaHN2T2F1eVhuY0dD?=
 =?utf-8?B?dGpTKytoWm5VQUlKK2dTU251M0xZRm5GcGJXNjhCd3FIbFBod0ZER1M5K3hk?=
 =?utf-8?B?U2V5bDlnZ0dFd2lraG5NUjIzbW9kUk1xcGN0Umh6Vm1vMXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5378.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ZRaVdFakIyQTJaTW92M3BCNWlLZFcxclFkNzc3RHVoamUzTXpZc1Vndng2?=
 =?utf-8?B?TzNRT2hlVmo4eTR1Sm1Eang5cjVkdDhDZzRTWHdBOWZrTlhzVUdmQmZqWU9L?=
 =?utf-8?B?L2tNM29GU2g1NUViTmZqMFV6ZU5KNDZIR2t2NmFkeE9BYmlSejZSeUxEMFAy?=
 =?utf-8?B?bEpiVThrSFJKMFZsQkVEQnFNbFdFZ2hVTWNoV28xNE1ZZTJFMnlQWFh2SXhJ?=
 =?utf-8?B?UXN2dit3bDl2NFdXZThkcTQ3QVNXU0JsMWtFTmJXeE1WejZneVpFc2FqdjI5?=
 =?utf-8?B?LzVqNGZJdG85N0RNNmU5LzhVVDhPZ0l2dDg5TEJhWldMV0ZzTE9LUVRDM1ZC?=
 =?utf-8?B?U0I5eUhBakZ6cjBFaEN1aG5CU1R2cGRKcHAyWlpNOTZ3SWl6RUwvZG1rV2pp?=
 =?utf-8?B?Q3FZOEdWNHQ3bDRHaGRoTFhKdm96WGw1MFdWdExkUXBTbG9yR3N5ZExueUJl?=
 =?utf-8?B?dE9zR21ra3dqSlNmMVJZSHZXa3Fyck16Zkh6S0xHeENSQ0I1U0FyTTRGYXBW?=
 =?utf-8?B?MURSeG5yQi9uVkh0QWdkQWZFV3ZtSmZaUDdlWEZsU0lVbWl1amFPbkFYc0px?=
 =?utf-8?B?aTZDZ0g2eG8yMS9LSEdvbTV6RDdFdHQ3YVlzMGhSU1lVdFhIVUR6MWcrcUxV?=
 =?utf-8?B?eGo0SHREVzkxTFFROEdXL0poVWtVaEhwWGV4bkRrbm1tTnRZNm9kUlB2ZFgy?=
 =?utf-8?B?UzRaNkZvc0dRb1RSRUxDOTFoaDY0dVlMNjNOSVVURVUzbXdhTndQVHdELzhW?=
 =?utf-8?B?alFrMjBIVWdweEd3aWhJa05HZzl0RGRPSUl6QXk2NVh1eVZRMDJUL0tvRmVE?=
 =?utf-8?B?ekdNVDJZMkxXeUkwRHlFNG51WDk0eFM4c1p3Y2RRdjgrT2I4T252UkVweUcw?=
 =?utf-8?B?RTR6ZFNQdVA4NVQ1SUNGMlp0aWw3dms4bDQ4MGVSZUhLY2wrNFpvSGlpb1dL?=
 =?utf-8?B?VWNnL0xhTFkvYlVlMXZHLzVqUlBibTYvYllUK1pxY29VNmxlZUVYYWJETmkr?=
 =?utf-8?B?TE1haitNUklFU3MzTjNyNDE4M2o0WDZyQkJWM3h1YnRKQXVaNVZaNTZpeXFS?=
 =?utf-8?B?WWhFTDJGTjV4NGFobnVYVkUxeHkwaXRiVUJONmJHdnhCejRFMTE4MGFIZUx6?=
 =?utf-8?B?ajRqb2JQTEgzOEc1clBWaU1rN0I1cG1NZ0Q5ODNFdnBKR2RmeWJYYVlzeDIz?=
 =?utf-8?B?eHdsUXVBSXJSaEtXYkhrbkN6UHpLV01oekpBWEhVYTd6aVgxN0U4ZzlxMmJs?=
 =?utf-8?B?Q3FtdU90OG8wKzlOdUV3LzlEQUZRSEJqUFJoYWFrTXNWdHRmdVp0MHRPZDRu?=
 =?utf-8?B?WVhPRVhoN2t0aXhwdlB4L215MW50T2IxVm1SOVBDSG1pR29nYnFrcGR1ZGtG?=
 =?utf-8?B?d3p2aTlGdHZGVzVjbkRnUDhnT2MwWU9zSDRvN3hGQ3JXb0ZSOFRERkVVSVZh?=
 =?utf-8?B?Z3RVbzNmVWU2dE1PcUZPQktSVFliUWY0VEJucVpKQ2JFWVQwa0djR3d1SGs3?=
 =?utf-8?B?ZG9kbm1KbjVpbFA2S0Z3WkpkU0lxVDQvT2pYNUhUMk10b0liQnpvM1Y0dXlv?=
 =?utf-8?B?NTVaOE1JNFNXbjJMck42YktZWGdqTVVjcjF5NCt4NyszdjQxWFQ3ejJESm91?=
 =?utf-8?B?T3A5ekY2RGdRZ2trQlNtcmlCSlZXdmorMjhHK2gzSUcrVWlBQm90VG94YjJQ?=
 =?utf-8?B?N1dSTjlTUThGQzArNEpqbHduN21IWC8vekd0VWVJbDAvVjhXYjBUbUlqTjBa?=
 =?utf-8?B?VktHbWk1cFhWdEI1VFJwTlBFN0wvd25ZZXFlclBXS0M2SjZiUWpuVjVLNjli?=
 =?utf-8?B?VzM0M0ZjMHB2d05aNXRjaVJwY2NuVG5LNUZKd3JDVFh1MHQ4SWp2dHFIRFJP?=
 =?utf-8?B?Ni9yakFlcU9XNEZ3TUNhKytCdGs2VEExM25HeExuOHFVaUtTOFVKYzQ0Znpn?=
 =?utf-8?B?V0FLR2VaN1Q2R2xLNDBWMnpCYlkzSEZERWNRc3lrZGhRNWtoQ3ZybmJrVWli?=
 =?utf-8?B?dk1lSjliRXpWRmdvRG0yWFQ0dW9kRDR1TW0yMFMvN2wzN0N3OFQ1RnluWTRw?=
 =?utf-8?B?cGk0ZWdMeXRpWm5NcWhEMlQreFEwNllHTjB3ZE1LU0lLYXJ1MmxtejVUeWMz?=
 =?utf-8?Q?808RkwA+tHJr4pb4qTYMyxP0Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1b5f19-5043-4688-fe56-08ddd53168e7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5378.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:37:14.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvLifSsNyXBMxcYK1aP2nDiNNLkyNuu2hh8ApSp8P9slvvRscEwp8I/Y/YsZ0Bf2vcAjrvVscByLPB2wWl1Nyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010



On 8/6/2025 16:15, Borislav Petkov wrote:
> On Wed, Aug 06, 2025 at 04:08:07PM -0500, Naik, Avadhut wrote:
>>>> +			sprintf(s, "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x"
>>>> +					   " Row: 0x%x Column: 0x%x"
>>>> +					   " RankMul: 0x%x SubChannel: 0x%x",
>>>
>>> There's a checkpatch warning here about splitting user-visible strings.
>>>
>>> Why not use scnprintf() or the like?
>>>
>> Had noticed the checkpatch warning initially.
>> IIRC, it was for splitting the quoted string across multiple lines.
>> Can use scnprintf here. But wont the warning still prevail?
> 
> Just do one long line. The idea is to be able to grep the code when you see
> the string issued in dmesg.
> 
Okay, sounds good! Will change it to something like below:

scnprintf(s, 100, "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x Row: 0x%x Column: 0x%x RankMul: 0x%x SubChannel: 0x%x",
          err->dram_addr->chip_select,
          err->dram_addr->bank_group,
          err->dram_addr->bank_addr,
          err->dram_addr->row_addr,
          err->dram_addr->col_addr,
          err->dram_addr->rank_mul,
          err->dram_addr->sub_ch);

-- 
Thanks,
Avadhut Naik


