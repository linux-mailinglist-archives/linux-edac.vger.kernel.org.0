Return-Path: <linux-edac+bounces-2957-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB33A23491
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BA0163978
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E019199939;
	Thu, 30 Jan 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KlS1ku3I"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020135.outbound.protection.outlook.com [52.101.56.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA54B660;
	Thu, 30 Jan 2025 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264709; cv=fail; b=VTwaUmSPeu/OWLfxT7AHMaMkC7oIr/cItavfm74i2GWDb7iaMaYfS8l38dysDP6ixdTRe9TZ3zCSG4Hlfi0/NuczN0VrZ/D9rFELpEf2lM0K2gHfIZberidAa8LJo+k+1yiVAiN+TN/Go3Z+qkZCB9aKi+WRarW1N3QtgWndmFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264709; c=relaxed/simple;
	bh=S1iqBEy3dzYEm5PTL2tMof1x8/zIiZ09qP4rVs5rJg4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilV6bxLOixrjCL4i+dyt3BU8O57tQJsJ3CrN9p8/5tg80QjCahxWpyzVVKQ239568SMAY47rBuWxkRWxOe6kFwChD5KcAQ/ero27LzvC11k1nkzqzITBXHY+J/BD5hYRPXKFOnP2PEufX64/xqoD+axNT1TLecfH4uHTrX3C/G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KlS1ku3I; arc=fail smtp.client-ip=52.101.56.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFMmpRFGegIMmp87rt1k2O42PaLUZyFQE7NWkZM7g0SH4c6mLYwsUEegUJoemDTJXBECULaAL5cnmPoCIOjRnI8xeLkdreLv4SFLbnuBqT4gzDgbdEWE7Yak0PgLrKPAhd4zfruB8BnYLrD6l5LPM1Ey/lUum3w2KGW9/leAj5Qo/G4iD5g/za4YvUjkj4RtzDYu1Q9Y8Pzd9JfZ/PLsyaSA/AERzbJjyt2eKtkrpRvGoUfVQZU3RpA48mgrK2RTFe90HgFW4xrm3/nv/zfhFdiztrCpWA5Pyeu6Lv2vIL+5knL+zKYi4M+903DLVYUM6teQ8Kga7PspTbIptWUjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1iqBEy3dzYEm5PTL2tMof1x8/zIiZ09qP4rVs5rJg4=;
 b=LQQj4lILsn+ntTnnRHGunHx+1C1ZUFpQjddDQUNNP656KPKIVf1IiR3NBrBvjXVYWKiQzWldmWYZ1XcvmIbqKZLwGVjOXjoUjJAOCzSOzzvUyhmbqCM1ZBh2i42dcLtHs6XUN5QWbdRrb5L05IdFWs7w3G8hvt219/tjVcrmN/MrEGTVaaOR6l/eFEnNBpEwiz5rJsjHCOhwF9+bcXPoqvAnoiiDWkjPx2piF+zNPoZrQ/OF67dZal/W7hNc+nLaofUrkc4p9RAjh8jHtF9PjKl8sW/VGQwT88EDkV4ngBFt7lVm5kRqiyebKVdh1GpDN/nSk8YwBSvTiV+UDniXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1iqBEy3dzYEm5PTL2tMof1x8/zIiZ09qP4rVs5rJg4=;
 b=KlS1ku3IBRc96dJN0NGmrYLoHzN9ZDx0XFQB0Vpp7DZ4m+0B51Ru+wWc6oE1xI6FWYEulxM5jLz6GSKl2j0Ku3lOl54sJtJ0tNfYNrtGyeau9jrPortFi1Gm81Ii1p/fwU0/yfH0+p6kaCKs0rd1fnav7cVJe0zHnPpZNmtX0dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW6PR01MB8599.prod.exchangelabs.com (2603:10b6:303:23e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.5; Thu, 30 Jan 2025 19:18:22 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%3]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 19:18:22 +0000
Message-ID: <a6af63e2-227a-4909-9b87-8eff96be088b@os.amperecomputing.com>
Date: Thu, 30 Jan 2025 11:18:18 -0800
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250106121017.1620-1-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250106121017.1620-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0358.namprd04.prod.outlook.com
 (2603:10b6:303:8a::33) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW6PR01MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: b7514eac-9627-458f-7dd0-08dd4162dccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE1FS1k1MXJoRlM0Rng2c0hISmp2WXFFUUNzdHB2UTdVSnB3SmZFeVlmUHhL?=
 =?utf-8?B?QlhnUU1XR2paUEhCSmdjMU1HSU1ad2VJZWo5VVFXNk5SV3hmT1FJNHV5WkRv?=
 =?utf-8?B?dkdqUmU4VlZ3WjZuMjBlTnFrZkg1K2VTSE1XTlN0Ym9xMTd5dHRVTTV0Y2d0?=
 =?utf-8?B?cmtSdHdlSWxHNFU2blY3c09iWW9tUVpnbExqV2xCUy9zUUhRVDBva1RuUFdI?=
 =?utf-8?B?TSt3Z083ZHNtalJSUjNobWlOZklJejNuMys3QTNPZFIrYTUveXNZYTNlbUEx?=
 =?utf-8?B?VkFRYWhFb1ZhOEhNaVE0eS9wU2NVdEg0bldMcHYxNFNJL04wUCt0dnBIdHhD?=
 =?utf-8?B?K3BCY2I3R2dZRlhWNGJ0bGwySkplUjNyeUVScC9CeTBvaFRjZGhDN2I3MWRv?=
 =?utf-8?B?R0prTHhBU0dHdE90SFFQTVg1V1AyM3UwMHU2UGlhb2drSEVpaUZSSkJnMlRk?=
 =?utf-8?B?U2pSOVc1N0daZll3dDhINW54SGFKcHhyRHpBTFF4blZsd0lFN2RkR1BKT2lQ?=
 =?utf-8?B?NFhQZGRKU2lFWXg3RU12a3hiOUFNN2FScmREdHFoNE0xZTVOQ3BSVW4yVFZL?=
 =?utf-8?B?eEVSWlJnY3R0WHNQaEJDQXlZT0pwVjlKRzZuUVR0U1F6Tkx4OTlFa0lpM08v?=
 =?utf-8?B?Mzdwa3JIMjhVUzRpekhzUUhUbXhNQitGVktCd2paZEdaUTVRMGVqSHVROW1N?=
 =?utf-8?B?RzlCajFDSzRKRlkxaENpZnFoc3VDSUl3U1lvNG1oYmtsaEJpU3o3UG5WOWRY?=
 =?utf-8?B?VlBhbzd6QkVRQTk4T2dsTTVvdG9XUGd5QW4rZHZaWnJkbWNlKytyKzVnOGx6?=
 =?utf-8?B?Z0hMbllpa2wxWmtGZ0NmR1NqUGpBeFp3alRUZTNtbDJqTWFHSE9KMC9Yd29X?=
 =?utf-8?B?czQwdDE3RExKaVZ1T3RBaUVTQmw2YVcwYmRLNWRpR0dRTldTU1VGZ2dsR3Ro?=
 =?utf-8?B?UXZCMStkcDY2cGxnNFVsNzRQSEpqNUJ0cktER0tWbTJreVhEVktrNTM0eE0r?=
 =?utf-8?B?Mk9FOG4vOFlTb2M4NVJOTFRPdlNCMzJzdFF2NENBYTJuMGpITmJ4VElVQ1E1?=
 =?utf-8?B?NndYWmVOOUpiR1VvejRudEd2SGNzMkdpRDczeVR0eDNzak9LSXczSXpGamJB?=
 =?utf-8?B?VWhhOStWeGJ4TmZSZFUyMXNLSkhFalgzb3ZjbzVJQjRaYk1pZmNqTjJ6SWNN?=
 =?utf-8?B?ZHhOTFdmZTZXNFYwZVRVT1NpY0ZiOFdpeXBTb25sdCtKVFdVdm1KUWs0WU05?=
 =?utf-8?B?VTQwSGt6dEt5S0xCMjN3a1ZIK01hZ28xMTRXWmc0bG93VncrbGFaS29nUmYv?=
 =?utf-8?B?dCt0V3Q0VHMxUHF2NGRqOEROVnZvWm5ibDA5ZXArTTVTUGxBRytwb2tSSFkv?=
 =?utf-8?B?Rk95RUh3cGMrbHRpYUx0TmJYeE56aTRXeW0yMnRqOTlKYUsxV0VYYWpqSnB2?=
 =?utf-8?B?dHduWTBPNGdLc0ZHZ2FZcU9JWHhFaG5NOXJmdlZrOWc3SEtKTHVYeHRBTWUz?=
 =?utf-8?B?SlIrbE9CNzdMSTRVUEkxMjhtODNncVBlZ1JpUWJsRjd1aUNXU3Z0d1YveVh2?=
 =?utf-8?B?Z2o0anVqeFFjUnNSem9mckh5ald3eDl4NkRlaDljaGZ1eWRzOGhKY0pscDNt?=
 =?utf-8?B?TlF4V0NiY0crTmxOSTVCd2pwNzYzUWZSdjRTUHdGNTh6VEUwZlF3cUhnNHJn?=
 =?utf-8?B?QVBHc1Fid1N5NEVyQ0tZaW5YMEtFSm9JT3pEdU5zWDUwNEJLMmtETTRvZ0lw?=
 =?utf-8?B?MWFuMjVIR1pCWUJxUW1xMjNOMGZuSXR0QWtRQjFYdXMyc0dqOGpxZnZLRjJS?=
 =?utf-8?B?a2dYVWJEUGoxRWtNMEZqU3ZzZEloU3daczRiUTBoRTZwYUw5VFV3RXRqSG5x?=
 =?utf-8?B?OGhPQUx3czBzZ1lZR2lqWHZBK3dHOVhKNW9KNXZmZzZDdkdZczNrNHhCOGo1?=
 =?utf-8?Q?f5E6f7hYBq+yHTnSIxN/y7AhwtfTqKMi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTQydU5tZHlJTHJjMWxVSlY2STNnVkFuZkhRTDNid3pYSUh0YXBhS3VDb1NU?=
 =?utf-8?B?QXZycHczZWZHN24xZHNid3oxUWsvTVVTeHduTXF4Rk5aNGhQY0RhYkwyQ2JT?=
 =?utf-8?B?YUwvNCtod0o3TDFnR2RwVjViNEJWV2JjLzJIVHdlSmJhRVArVG9Bb2hzb2Qv?=
 =?utf-8?B?aVlENmh5Vis0OXArRmxrWkZWdXJHYnRjU2FPWk95V09XL3BSWEJJKzNlalVD?=
 =?utf-8?B?aUhmeHFuS0MwNGZHMDBEY3dNcmpjU2FtR043TENuYUFqQkpLRWgzcnBjV3pu?=
 =?utf-8?B?SGthMXNxLzhmK3lNcHZmUXBPa2Y4OTdIdDNtVUx0c2lUdE00SUFuUzRldWpI?=
 =?utf-8?B?TVdYWERZaytGL3JtKzdzZTFxZ2dESkxBSVF1bzU2N2JlcGc1Zm9XRzNKaElT?=
 =?utf-8?B?VmpuVUgxRENOSkVNd3ZoWWNEUXVMcGlDWmV2Kzhhck84b1gybnRqSjFRVDB1?=
 =?utf-8?B?SitEU2p5VjZOcGJYZmxrMjlDWWJEbnNzemlVVjdmdlgyN214TGZPcjRsOHI1?=
 =?utf-8?B?N0N5Mks0RDBWWUY5S3Yrc05YVVVYdG1UY3dLM0NjRU1jV3QvNmM0ZDJlZkRK?=
 =?utf-8?B?d0ZpWUpac2RJbGF0OHZ4ZCtheWhxKzZKOXZPZTh4U3c4cmcyUnMyVkFWbVd1?=
 =?utf-8?B?azMzYzJRbVdUVHp1blVLR09VNXNFZHNLTms4QkxnWUpYNFBDa1BncjdBWGFu?=
 =?utf-8?B?eGZnekFBd0xIQVZtVXVFVUJOV09aNjVBajhhVldKcjlkVklOUW1La0FBdlFa?=
 =?utf-8?B?d2VRenVOMm1JVjN4eDVoY254YWJUV3F1TUhqWkVWa3NGR3NkYzcxTVZDL2Ew?=
 =?utf-8?B?S2tiakNWZUxpS2xoakZqY1l4c1o0SzNnSjhhOVlvWjNiM0tnMTJvOHE5UzU2?=
 =?utf-8?B?bWZyanllMW1BRWFDMGJOS1JONDYwYkRsNmFuSDN4QmlQN3l4M1hKcm9iS2M2?=
 =?utf-8?B?STRjdHA2Wmt6dDNjUlAzeS9UNVNTM1ZsVkJETEt0SHdkSWdaZUd0VCt0Snpt?=
 =?utf-8?B?Nk5aaUV2dUtuR3ZuRGR1cHMwUkM5ODhyMHp3TUtUc001ZWpyL0M0T0xrUkZi?=
 =?utf-8?B?WDZZdVpWWFFaMTlEYTZ3L05GWGI3Q2F3dS9zR3ZrcjN5b1lNRE9aVE9GdXE2?=
 =?utf-8?B?WEZheTh1bTBxRFMvU0d4UEhYVlUrOUFxR09sYjhHRWxSMjBKY3dMTFlIY01R?=
 =?utf-8?B?ZkIzZHRhQnVIUlMzczQwR3MwTXUzOU9DMGw0b1VlcmZCU1ZnaU1CSzFBVHJF?=
 =?utf-8?B?YXV5SllxWmNtSTZ2bVJBaHB2Y0djVDZSRUxoSEs0dithQXNiRWUxR3NDaXNH?=
 =?utf-8?B?VmtKNUdtVDJTZXBhWkgyL3lXR21MTFdQcWlicVl0SDRraGZMOEFoTjNJdkJS?=
 =?utf-8?B?Tk4rUHp3N3ViNjNsRi8vNTJBSlB1WnhQV0x3RUlORDYrS1lsZDdpanJNS1Vt?=
 =?utf-8?B?LzZSaitSZDA5NDRqdXQwSkIwQTRRdUREb2NjZklSQXlLMlBHb2pkVDV4dllM?=
 =?utf-8?B?VHpRdmF0K3kzeWU4SlBIazRMUlByWkppbFZKY1Z3WmJGVWJPNlhuLzY2YUpP?=
 =?utf-8?B?Ujd1dEJ3T0xrSEZSTnFWUzFqK1E3OXNSajZENmcxV0RZM2xoYVVpMVhDTFRn?=
 =?utf-8?B?dE10NVNRUVZ2NkdlUVZHdXhJTDVzZGRXbGR2ZFdya0Y0NXZheWRZbTkwREhh?=
 =?utf-8?B?RGhFaWR2N3QrQk1DSjlwWjFwS08yNlkxSUgwUlkzOGRLbDUxZDVGaG9QYXZI?=
 =?utf-8?B?a2JRSDcrWm85bTgrS0hzNHVxVzVjT0x3cG4xbk5yL3B2U01Zd2Vyc0lKd0Vu?=
 =?utf-8?B?NEVicmhwd3JnQTFuZVJ2VklnU2ZCWHRvOS9sY3NtSlNBS09HNUppWi9tNjZ1?=
 =?utf-8?B?VGw2TjBlMUU5Z2V0MWlVbk5haVAwTlovOVpoNElYUFRtMlRNVGJ4dWUzVFIx?=
 =?utf-8?B?MFNXSVBBR3B1Y2ZJSkFDNzh4RVFMeVdRRnNoRlZEK1E5UWpiOG16OXRZQytK?=
 =?utf-8?B?OFk2aTVUOWtHZjMxTzdKNzVTUXNBeWNSS3djSnFONElmOVlKSFRFZGJNQTdP?=
 =?utf-8?B?WmlMUnVDdTVTTmJWVWdEQ1dOdFhGYlBCUTNMeGgwMVdoMGZ1bVdFTFlVRUpi?=
 =?utf-8?B?R3IvZHppdmFmSUtHS2p5RG1leUROV1dIdk9XdDJNV2tjNnpGelp2c1h6dC80?=
 =?utf-8?Q?qvIwAQGW1uAMHZBsX27j4nQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7514eac-9627-458f-7dd0-08dd4162dccc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 19:18:22.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3nLnvxRCobDJHxTGJJGN4RL7f9/MPKfRl3NH3WTo3neAQJ3koBseKtjo/Gle7E0Qw43BU5TzfxCHtLqSa0NE89izOMQUd53MuEIy7lBbJ+67AZvDndJkO/O0ayFdKNk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8599

Hi Shiju,

I've tested the Scrub specific pieces and the EDAC infrastructure pieces(as far
as how it relates to the Scrub pieces). I am using an ARM64 platform for this
testing. I would like to offer my tested-by to those pieces I have personal
experience with. I will send them as replies to their respective patches.

Thank you,
~Daniel

