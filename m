Return-Path: <linux-edac+bounces-1339-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44890912CF4
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B197F1F24A89
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC33178CEC;
	Fri, 21 Jun 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ogS24POi"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2110.outbound.protection.outlook.com [40.107.93.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011832E417;
	Fri, 21 Jun 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993206; cv=fail; b=kh5dJ5IGtRldS8B84cTL6omTfbRHGMSgQA4i6aJmrJzhoazCWNqS3wgQm0lFjWNwxObY7uJDMz+PdBzH355mKsfO2mS5bU/PW1vOLrUfrSfiNJ7SXOpo+AOnkA8ZChWi9yq57t7knDaKD3SEkIkzX8w8Wb21wMiSvyVDVRA264c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993206; c=relaxed/simple;
	bh=5TfGGsLAKo4fmwLj9Oygg5s+jMiMEah3Oamkr85k2xU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFa8o0wdWGDvKJ3FgSmvMc822hn526WYOg9up7LO/glBkC/AJv60LnJbKxuHtD83RZDYG0BMG9sgTM1/EFbSlqUQrO9FYZlBKQ3YGGg9ahjx+ekeJSe4qvkGvEDMqwbT4fTQBOg5MWEAL/SbaeQk3gGhZz3df/B4cke9vALJCIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ogS24POi; arc=fail smtp.client-ip=40.107.93.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALwntIfMYf/f/Uedgzxvher2El+z9JJe4KF3MeEgQ47NVfEJPIH7ay2pxHqfGDa4tuuhtntEEOdIpaCTqOSFgpKfSA1PZRQ3BnJDs98niUcWiSAspwIcdbqvN8V0v+Py3/pizxoLALhP94Ypyuz+QIotLo6a/15gfltWXmeWacPH5Ovnv+4ogdUJdAJJUO56RZUQHyk00bl5H7TUqa2a9hdvhIoAxvEyS/GG35L8kg4A1nDk0sjCLQSY5RoQemDeTbh32zgSd6xZs6eLmyHxWe2hEtgTg26IExvSJgX6/dU7euH8hFnKRfJYqNl8y8ppDdGwSE+5gYbAu8RY1sZlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBrPu+ke8gCbBJiNJ7wFwrpHG1FtOctEsNzRCF5KNx0=;
 b=fP5UYlouLbViVcAdrh9uiQWGV3vEtCMUmF0fiOkabtPeeANM8qnCwbdyCMpNSqh6Cy+p7nwKeebWwTW4N7SykUYRLsXjG68ySoou8CaPxWmLB+2AZI75x8GM5DGviRzDaNZ0BJYQqPaPlJfdn07Wm9JqxYncnFdSkJg2YamFVwh90i3p1OfDMKVBQGdnxPiv5I8bHvUPbrFcJBmBesV/cm6Pk12AZ5NT+CdXHgZMTusSMnndvhbgHCfjQwTwmlipAr4+bdUeJET1oFNuwYvr535hHblKc5+3EnTncjBPGHGhqrz+6AZXATfE0A7X0HdRaVuo44u9KYsM83KC/Q4QmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBrPu+ke8gCbBJiNJ7wFwrpHG1FtOctEsNzRCF5KNx0=;
 b=ogS24POiy9ljW3onowEvVDUuo96wLFsrlb6aiGAmZayuRhEAxMbF0k9QnFS2kk0+WDBPwbECP8js8/kwsnjVbRyBQfTyJ7cOozHO5hxHDtB1xzMVWEy5CMqqz2kpBiaq6ivrkt22und5nEEwb0Cjy/Yvj5jA0YL6wtJHT+LaLss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 CO1PR01MB6743.prod.exchangelabs.com (2603:10b6:303:d5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.33; Fri, 21 Jun 2024 18:06:39 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73%3]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 18:06:39 +0000
Message-ID: <84e75542-026f-4c99-a8e0-f07dbf1695e8@os.amperecomputing.com>
Date: Fri, 21 Jun 2024 11:06:36 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v8 10/10] ras: scrub: ACPI RAS2: Add memory ACPI RAS2
 driver
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "david@redhat.com" <david@redhat.com>,
 "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
 "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "duenwen@google.com" <duenwen@google.com>,
 "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
 "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>,
 "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-11-shiju.jose@huawei.com>
 <fcd0621b-dd68-4e0d-96e1-15c16a3278d0@os.amperecomputing.com>
 <d1986e8e1d8549c588f7488dfd5dd374@huawei.com>
Content-Language: en-US
In-Reply-To: <d1986e8e1d8549c588f7488dfd5dd374@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:303:6b::15) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|CO1PR01MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9d7b1d-c054-4531-2dba-08dc921ce5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|7416011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WktsS1BGb1ZLaEZvSUhBU2RlL29yV0NsUG9BeWhnQm5WWHRXMmZPcXdmUDNY?=
 =?utf-8?B?NWs0bno0ODE3UUJIZVhkWGlnT0JjZDdBamFFQXg4NTFvcWFtV1Q1dGxxZ051?=
 =?utf-8?B?L1hZcFRWV01pZ1pSUU05aG9NM2l2elVIbjBkNlhVallBalltb0RsWHE3SWpn?=
 =?utf-8?B?NFVGNGcyQ0NXK2hIWHBtWDl6LzlOK3M5KzVPRFVzdkYyMUlzWWxnc21LWUIz?=
 =?utf-8?B?SFNYS1RXVit2VGgrOHVXL0cvd2tDUE5EcnVySFY4aUNtdHhsTTlrMlBteWVl?=
 =?utf-8?B?VE1uanRoRDB3QjF0VnNtK3lSemlrbDMxVTZLTS9PRlhoKzJHbTU3RXArS2JK?=
 =?utf-8?B?OGlZbDJwMVZDRDQ4bFhORno2ZzhaMkdpeEFqeUV2cDRjbkNjeUgra1FIU01o?=
 =?utf-8?B?UWhkMXpCWnpSYUVxY3hmVkFCSFlqVk4rTGFwL1c5ZlZSSStqRSs3enhiSkpo?=
 =?utf-8?B?c2ZwVHFWVC9LYU5zWHFFVGloTVBSNS9oMTNEYjlTd3pIUmV6Tnpkd2cvMlho?=
 =?utf-8?B?Y3ZYZ1Jsa25LV09qb1BIM2V2ODhJN0FkUmpYdmFUMlZ2Ti9nV2k0OFhqV1lV?=
 =?utf-8?B?V2dvRCs4N005djlXZ0I0d1dXYzNKN0FaQXpBamRNbEh4REVlbGJqTUxqZWdv?=
 =?utf-8?B?VHRkVFVyNkNXbGFrMk5Lang2SkRHTWxCWER4MmdNYVhDU3JVQ1hsUUwvVTJL?=
 =?utf-8?B?L1VsbG5GRW8wYUJXeTdzejJ2L0hqSFNOT1FNM2NMY0xmN1Bnc1U0VU1qSU5n?=
 =?utf-8?B?eXNXbGFDbkM4K1cyaU1qQ1ViVnhGS1NsZUZrK3kvVGcrQTMza3JmWTZEa2ly?=
 =?utf-8?B?T2pEMVdlcFozaER1T2lJM3JvTzhrWTZGMzdiVGdwUStIbW1SSnJ1YUpYZytH?=
 =?utf-8?B?eU9ZN25BN0FlaW4rM2JIYVlSZCtHYWRFUlpFNmQrMzBuQWM5TEM3R2xCMUtz?=
 =?utf-8?B?aWxTUlIycWRzQUY5R2syZ0pPOHk3S3dhRmRTaitiZFkvT1dvUFNTTzMzQ1h1?=
 =?utf-8?B?WmI2SDZtbTVKKzJuOURuWVNQN25mb0JWWkxlaGVDbUFtLzdHTzUxNGdLczFL?=
 =?utf-8?B?Wmc1SzBGeDhWck5yUmY2dEY5aEZuQmpPdlJBSVZPSStvaGMrN2NxelNoVm0v?=
 =?utf-8?B?amVlN3c5eXVXNmNDRUR3eEFqZUUybnlUVlhVWEhFUHVFMjV5aHdnYUFFK2d1?=
 =?utf-8?B?eUp5Z1V2N3pKTTgyNU1sSnRjRmpkdVNLcHVTUXA4d05hNWg0WWQ0RTlDV25x?=
 =?utf-8?B?SGFWT2sxdE9yb2V3WkhUcENibVZrbGpRRWFobGU5Q1YxRm1YY0RnbkhMc1Bk?=
 =?utf-8?B?aEdhK1ZLcE1Jc0xBSnNKTXBGNDlGcmt2eDErNkFlM3hSUDBXMUMzMlVoaFJJ?=
 =?utf-8?B?YWhJZmJpRHZhS2swRWtxb040ODF0OWE2SUp2WXhrZXl0Q2FGNWJkREZDOHhp?=
 =?utf-8?B?UUU5OGcvUVpsQTJ3WkxQWDJheHhYYVE2WSs4UnFrS25EcW83dnowS0dWSzkz?=
 =?utf-8?B?bUFZdHVVaS8yQ3BPeVV2Lzl0ZGNwTG84d3VvYTZBd2xMekV6clUxTzRnSXhI?=
 =?utf-8?B?UjNhWkRmUnpqdzBiYXg3RWhXTDZyWDhYSzhGMnl2WGdZdlRuUy9QWWVzMkZ3?=
 =?utf-8?B?NjJweUQwZ3VtZDBNQ1U1eko2aDVJbnV0U09WZzg4NHRFWjV5ajEyNkZZbUlr?=
 =?utf-8?B?eXVpM0ZtdmtIdzV2cTlBdUJtNUl4RmNTeTBkM1R3bkxROTVNcDM1N1hHdjNT?=
 =?utf-8?B?TEZ3L2lNMHJqRGR4bHQzNVYxNExqbTBKOENEWllxWVBjV0NlK002ajFJTVVP?=
 =?utf-8?Q?LNEQ6Sk2SNdN/o8W/qOXgWycsC337MXY08Of8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(7416011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek9CaWEzNnNuRHVkRi9yVmNmdEZ0Y0xBVlNsejhFUWdDakFDVXAvV095YUYy?=
 =?utf-8?B?MEE3bC96cFdvaEhkYmtDajhNdGdYNSs2ZzdNVGtBRXRwZ1VMNUNyV1ZmQWUx?=
 =?utf-8?B?cm1leDF6a3p2VW9HdHhyN1UrVHlYdllWYWFTUGJrUFhqdkFpaHBuQ2plVGVO?=
 =?utf-8?B?RWhMZ1hXN29mSGtFZC8rSUNoL3piU1JrNzdBaUxCSU5xRTU0VzdBWUd1Z3RY?=
 =?utf-8?B?SjF5SjB2d0xTTjZ6WDdnS08vL3g1dmpOZ3lHWFF4TjU5LzdiOVJobFFHZndP?=
 =?utf-8?B?VjlHNXliTndMdzhqcm9IdDRZOEh6dHpRbG5zbDRNNncvNFgySjZuYUV3N3JK?=
 =?utf-8?B?OWFZNWUyT3NBb2U1YUwyWnZCVWpDUyt6WS9YU3o1SE43bmk0L2hXeHFhMHVF?=
 =?utf-8?B?cE8rcUFwNUhXU1hnYzZPbENwUnd4R1RBUUtJWFI4NlMyWkl2WVhyRmYrakta?=
 =?utf-8?B?dlFJeE5ORDNLWmJoUnlEamRoTzRBLzRYTVB0N1lWZmxMbnFUTkJ4ZEZ1TXBW?=
 =?utf-8?B?dkROR1RIYnpvQkcxeW1GQkZMc0tneXhXSE9sOWhYOWIwQkJwZVZpRks2dEkx?=
 =?utf-8?B?UjhVUldFWVZLZGlTUy9tSnowelNJZnlRTlR2K3gzQ0kweEVhbE1IUDhWT3h1?=
 =?utf-8?B?Ukhrb1VwaC9pVHY2bndMZ1BlZUJHRDNNWTUwZXRac09ZQjB3bEpkOGlvQ1dk?=
 =?utf-8?B?aGV6ZnU4MnBIVkJ5Y0JNWkFsSUtXQUR6aHB6TDVYWXQ5SEk5Wms3RU5SbDBW?=
 =?utf-8?B?ZEI5RWk5Zk5HblY3UVV4Vk51amU2MzRzeEhVOG5UWVRlT0NmaVkyb3ZCSEFz?=
 =?utf-8?B?L3ZOdENYaUtPeFFRREtkMVV2cWFwM0JNcUc0LzV5L2VUenZuN05XWjY3aTBa?=
 =?utf-8?B?UnU3ejFBSXBEWVF0eFA3UDF0emllckluNTdlaU5EeWxYVVgvUVhVTTNhU21K?=
 =?utf-8?B?VTBmdVg0RmYyUmZVUTFvWmpucGdhcnBZbWlSazdwMEt4b3pMc3Rta3J0QUE2?=
 =?utf-8?B?bHI0djU2VWpobjhHRVR0SnRONGlWdWI5ZUdwdFE4Rkp3LzRTSjgvcWN6Zldx?=
 =?utf-8?B?eU9IZEZwN2tobzJ0d0ZENmZRKytBZ1g2VG1uUEUwU2l0Y3lRY2ZmcE14dXZO?=
 =?utf-8?B?YXJXYWhuREpoZW13d3lMTWxteUFQb0NONldBd0U1N1hsYWRHUlhlajJlUkNE?=
 =?utf-8?B?dHZCUlFKSXA1dlZ3V3JTUzRWMlpheE9CQy96d0dJMmYxZE5nRlBFYzFRSzRh?=
 =?utf-8?B?NEZSeHhvYW9FeDNCdkM1RmRTL3pTUThnTzdSaDd4SXMyZEk3cEE4Z1BFM1ZY?=
 =?utf-8?B?blNhYXRMckYzcHFpd01RbHhhYzVpeUxLWmVqK1RyWnVTRTBJMG9uaVVOUUtG?=
 =?utf-8?B?ZXVJWGRDRis4SHNydHJBKzJFQ2wwTVJlREJFeGhpNU9jSU9KVHJoTm9MT2h5?=
 =?utf-8?B?NzJJaVNwZy8vdEZiLzZ2MFFFaWk4UEtHeURMeXh3V0hqdEs2ZGU4UFRJNEZZ?=
 =?utf-8?B?N2I5Y0FTNGhVRC8wczF6RWFQckZMSy9hcSszSUNHRU9sVWx2MjV1VUx4Ukph?=
 =?utf-8?B?Nk92Q3hYQW5TalhKZ1NsQUJLMkw5d0F4eklLVlAwT2VWUldZd1hQc0NFc0x1?=
 =?utf-8?B?aE0rK1d5c1R4N3ViTno4VmhLRldabVdoZFFjNktyRmhMTC92MDFxWGxCRUFp?=
 =?utf-8?B?bnZodzFmQlRTSjY4UFo2R3U5SnFKYTFlOVhlSWFlZTRDZy9MZEdQcEkvdVN6?=
 =?utf-8?B?QjduVWtlTjF6d2ZROVM1UFV3ZzZXVWVhajVSc2wvODhETmc0d2xadnJNN0ZQ?=
 =?utf-8?B?QlpzUDkxemQvcXdUVVBHSnhpVjc3RUo4cGdZSy9Ib3dteWhZdFIyeDEzV0Ry?=
 =?utf-8?B?Mmllc2o2b2FVdTVPem9heldjVlprY1BmSzVHM0Frc0RlbFVlL3dDdHkyL2o0?=
 =?utf-8?B?T2RLamFuMzBYaEc3L3VIbjg4WDNKaWVVVlBkTDRNMldJNkFNZmNoaVI0V3dz?=
 =?utf-8?B?NXpVbFlraDBLdWt4OHpTaHYxZ25iemNJNGhtY3Fxd3VEQ25tU28vVU05UWFP?=
 =?utf-8?B?S3plOTJIemNwV2UwcGZQVVZ0TzJDU1ptUldTcENQekRaaDhJTHUvcndlWnRv?=
 =?utf-8?B?N01SNTNNZER0VStnbHRQWmlvSVdHaU11TE5ya3JHOGg1THBrR3k4WGdQOFhF?=
 =?utf-8?Q?h7UeyK4ol4bQQYC8wjGltHE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d7b1d-c054-4531-2dba-08dc921ce5d9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 18:06:39.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb9JCTaTD2sTF3kpSEJHDubv3Vp07BYc3tqVKTF4e+7H8PipkkDfStCwey8HHM0gntX3Xab4KJVZxZuBJ8b4Wc5tOIrRx1dbtqWRT7Vi4uoxS624slY4Yibe4qfA3PnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6743



On 6/7/2024 8:46 AM, Shiju Jose wrote:
> Hi Daniel,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Daniel Ferguson <danielf@os.amperecomputing.com>
>> Sent: 05 June 2024 22:33
>> To: Shiju Jose <shiju.jose@huawei.com>
>> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
>> david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>> Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>> tony.luck@intel.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>> rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
>> james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>> erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>> mike.malvestuto@intel.com; gthelen@google.com;
>> wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>> wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
>> <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
>> kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>> Linuxarm <linuxarm@huawei.com>; ira.weiny@intel.com;
>> vishal.l.verma@intel.com; alison.schofield@intel.com; dave.jiang@intel.com;
>> Jonathan Cameron <jonathan.cameron@huawei.com>; dave@stgolabs.net;
>> dan.j.williams@intel.com; linux-mm@kvack.org; linux-acpi@vger.kernel.org;
>> linux-cxl@vger.kernel.org
>> Subject: Re: [RFC PATCH v8 10/10] ras: scrub: ACPI RAS2: Add memory ACPI
>> RAS2 driver
>>
>>> +/* Context - lock must be held */
>>> +static int ras2_get_patrol_scrub_running(struct ras2_scrub_ctx *ras2_ctx,
>>> +					 bool *running)
>>> +{
>>> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
>>> +					ras2_ctx->pcc_subspace-
>>> pcc_comm_addr;
>>> +	int ret;
>>> +
>>> +	if (ras2_ctx->bg)
>>> +		*running = true;
>>> +
>>> +	ps_sm->common.set_capabilities[0] =
>> RAS2_SUPPORT_HW_PARTOL_SCRUB;
>>> +	ps_sm->params.patrol_scrub_command =
>> RAS2_GET_PATROL_PARAMETERS;
>>
>> Need to reset the address range (base and size). A user may have previously
>> called "Enable Background" where the code zeros out these parameters.
>> 	ps_sm->params.requested_address_range[0] = ras2_ctx->base;
>> 	ps_sm->params.requested_address_range[1] = ras2_ctx->size;
> The address range is being set to the above in the ras2_hw_scrub_set_enabled_od(), because they are
> valid for on-demand scrubbing only. 
> 
> However the ras2_ctx->base and ras2_ctx->size are set to the  
> ras2_ctx->base = ps_sm->params.actual_address_range[0];
> ras2_ctx->size = ps_sm->params.actual_address_range[1];
> in the ras2_update_patrol_scrub_params_cache(), which is called after enabling bg scrub and on-demand scrub. 
> Thus ras2_ctx->base and ras2_ctx->size may have a 0 or garbage value for bg scrub because address range is not valid for bg scrubbing as perc ACPI specification. I will add checks to retain the cached address range if bg scrub is enabled. 
>>
>>
>>> +
>>> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
>>> +	if (ret) {
>>> +		dev_err(ras2_ctx->dev, "failed to read parameters\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	*running = ps_sm->params.flags &
>>> +RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_write_rate(struct device *dev, u64 rate) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +	bool running;
>>> +	int ret;
>>> +
>>> +	guard(mutex)(&ras2_ctx->lock);
>>> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (running)
>>> +		return -EBUSY;
>>
>>
>> I suggest we do not check if the patrol scrub is running when we are merely
>> updating cached values. More importantly, if we had previously wrote an invalid
>> value (that is only invalidated by firmware after executing a command), then
>> when we try to write a correct value, this "ras2_get_patrol_scrub_running"
>> check will always fail, therefore preventing us from correcting our error.
> 
> In our opinion, write the rate and range etc, though updating the cached values, should be allowed only when the scrub is NOT running to avoid confusion thinking they are actually set in the running scrubber, when read them back in the userspace.


It may be that I didn't explain myself properly last time. Let me try
again.

1) This driver code does not currently check to see if an
'addr_range_base' is valid or not. Validation occurs in the platform
firmware, when either GET_PATROL_PARAMETERS or START_PATROL_SCRUBBER is
executed. If our platform firmware detects an invalid address, it raises
an error.

2) Therefore, a user can specify an invalid address, and the user will
not know that the address is invalid until after the cached parameters
(used to check if the patrol scrubber is running) are written to.

3) Now, every time the user attempts to write a value to either base,
size, or rate; the preceding call to ras2_get_patrol_scrub_running will
result in an error, and the attempt to write a different value fails.

To Conclude:
If a user specifies an invalid address, the only way to correct the
invalid address is to reboot or module reload. To me, that seems like a
show-stopper.

>>
>>> +
>>> +	if (rate < ras2_ctx->rate_min || rate > ras2_ctx->rate_max)
>>> +		return -EINVAL;
>>> +
>>> +	ras2_ctx->rate = rate;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_read_rate(struct device *dev, u64 *rate) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +
>>> +	*rate = ras2_ctx->rate;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_read_rate_avail(struct device *dev, u64
>>> +*min, u64 *max) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +
>>> +	*min = ras2_ctx->rate_min;
>>> +	*max = ras2_ctx->rate_max;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_read_range(struct device *dev, u64 *base,
>>> +u64 *size) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +
>>> +	*base = ras2_ctx->base;
>>> +	*size = ras2_ctx->size;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_write_range(struct device *dev, u64 base,
>>> +u64 size) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +	bool running;
>>> +	int ret;
>>> +
>>> +	guard(mutex)(&ras2_ctx->lock);
>>> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (running)
>>> +		return -EBUSY;
>>
>> I suggest we do not check if the patrol scrub is running. See previous comment
>> above.
> Same as above.
> 
>>
>>> +
>>> +	ras2_ctx->base = base;
>>> +	ras2_ctx->size = size;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_set_enabled_bg(struct device *dev, bool
>>> +enable) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
>>> +					ras2_ctx->pcc_subspace-
>>> pcc_comm_addr;
>>> +	int ret;
>>> +
>>> +	guard(mutex)(&ras2_ctx->lock);
>>> +	ps_sm->common.set_capabilities[0] =
>> RAS2_SUPPORT_HW_PARTOL_SCRUB;
>>> +	if (enable) {
>>> +		ps_sm->params.requested_address_range[0] = 0;
>>> +		ps_sm->params.requested_address_range[1] = 0;
>>> +		ps_sm->params.scrub_params_in &=
>> ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
>>> +		ps_sm->params.scrub_params_in |=
>> FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
>>> +							    ras2_ctx->rate);
>>> +		ps_sm->params.patrol_scrub_command =
>> RAS2_START_PATROL_SCRUBBER;
>>> +	} else {
>>> +		ps_sm->params.patrol_scrub_command =
>> RAS2_STOP_PATROL_SCRUBBER;
>>> +	}
>>> +	ps_sm->params.scrub_params_in &=
>> ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
>>> +	ps_sm->params.scrub_params_in |=
>> FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
>>> +						    enable);
>>> +
>>> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
>>> +	if (ret) {
>>> +		dev_err(ras2_ctx->dev, "%s: failed to enable(%d) background
>> scrubbing\n",
>>> +			__func__, enable);
>>> +		return ret;
>>> +	}
>>> +	ras2_ctx->bg = true;
>>> +
>>> +	/* Update the cache to account for rounding of supplied parameters and
>> similar */
>>> +	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
>>> +}
>>> +
>>> +static int ras2_hw_scrub_get_enabled_bg(struct device *dev, bool
>>> +*enabled) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +
>>> +	*enabled = ras2_ctx->bg;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ras2_hw_scrub_set_enabled_od(struct device *dev, bool
>>> +enable) {
>>> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
>>> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
>>> +					ras2_ctx->pcc_subspace-
>>> pcc_comm_addr;
>>> +	bool enabled;
>>> +	int ret;
>>> +
>>> +	guard(mutex)(&ras2_ctx->lock);
>>> +	ps_sm->common.set_capabilities[0] =
>> RAS2_SUPPORT_HW_PARTOL_SCRUB;
>>> +	if (enable) {
>>> +		if (!ras2_ctx->size) {
>>> +			dev_warn(ras2_ctx->dev,
>>> +				 "%s: Invalid requested address range,
>> requested_address_range[0]=0x%llx "
>>> +				 "requested_address_range[1]=0x%llx\n",
>> __func__,
>>> +				 ps_sm->params.requested_address_range[0],
>>> +				 ps_sm->params.requested_address_range[1]);
>>> +			return -ERANGE;
>>> +		}
>>> +		ret = ras2_get_patrol_scrub_running(ras2_ctx, &enabled);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (enabled)
>>> +			return 0;
>>> +
>>> +		ps_sm->params.scrub_params_in &=
>> ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
>>> +		ps_sm->params.scrub_params_in |=
>> FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
>>> +							    ras2_ctx->rate);
>>> +		ps_sm->params.requested_address_range[0] = ras2_ctx->base;
>>> +		ps_sm->params.requested_address_range[1] = ras2_ctx->size;
>>
>>
>> We need to clear the RAS2_PATROL_SCRUB_EN_BACKGROUND bit in the input
>> parameters.
>> This is in case "Enable Background" was previously called, and this bit was set.
>>
>> 		ps_sm->params.scrub_params_in &=
>> ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
> We need to stop background scrub if it is already running before start an on-demand scrubbing. 
> The RAS2_PATROL_SCRUB_EN_BACKGROUND bit would be cleared with disable  bg scrub
> with the following code
> in ras2_hw_scrub_set_enabled_bg() when disable background scrub('enable' is 0 in this case).
> ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
> ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
> 						    enable);
> Hope it make sense?


Yes, this makes sense. But, on our platform, we automatically enable
background when on-demand finishes(or is stopped). Similarly, if we
enable on-demand then we automatically disable background. So, some sort
of patrol is always on-going. The user is unable to turn them both off
at the same time.

Due to our implementation choices, this causes some weirdness with how
the driver represents enable_background and enable_on_demand
independently, since our scrubbers are not independent.

I'm going to leave this conversation here for now, because on different
platforms, maybe having independent control for background and on-demand
is desired.

>>
>>
>>> +		ps_sm->params.patrol_scrub_command =
>> RAS2_START_PATROL_SCRUBBER;
>>> +	} else {
>>> +		ps_sm->params.patrol_scrub_command =
>> RAS2_STOP_PATROL_SCRUBBER;
>>> +	}
>>> +
>>> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
>>> +	if (ret) {
>>> +		dev_err(ras2_ctx->dev, "failed to enable(%d) the demand
>> scrubbing\n", enable);
>>> +		return ret;
>>> +	}
>>> +	ras2_ctx->bg = false;
>>> +
>>> +	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
>>> +}
>>
>>
> Thanks,
> Shiju

