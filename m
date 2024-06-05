Return-Path: <linux-edac+bounces-1195-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CA8FD60E
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C91A1F2364D
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2B13AA5F;
	Wed,  5 Jun 2024 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JraeWS6M"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D822615;
	Wed,  5 Jun 2024 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613480; cv=fail; b=oPZFnbFEuIkjxk/reZUzTUvsXoi97DVk8/dEJOuP6tWkZbFCLbLFHThAhsY8y8fuGSeCjRMCbVZz4hsHNRJPVkySGTxzE+0XFC8bguwZ+VZXijPhx57gGB00mHENJr4z41qHM5hnbXZJY4+6toFYV5uU9qBzR7VxfkbUXeDTgOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613480; c=relaxed/simple;
	bh=2Oz0IKk9vVFtgd4FqXmlh/RsC7chDMbzZ5JQHymN5QY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jh2Lp59kromD1LXg1XNPd4mSwxZ38MpLjR5vfd2aA5dNUKXXAqz7830EtXbSd4LBF+LsUdk0zHrMeyylZPPw67PV43buTTQgH2XZ6zqaDipryhxMkNWfjnhTG4j2YuIk7Ks81DkE82iO5vLZUXsdGdU4qj5BYcZOdQjglhFzEXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JraeWS6M; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/azUZloFlT7Q0yrWpcsyT3hc9QYWgsZeZiFhCKw5rztzEITFHkrALTkPEP8KTUuk5hbgFLNV9QQWNXRew0ZuQBGGFx1hqlUrXBUUpp3OOpq/n6+lyuTkEUmMVg5GOWNet4a6ywCHVFAhebRqmhLz80IVthp48QK+G0olxkaUr2hqNvgnwdN28nAW41STDzeUWk7ghnxck6yXn8A8uFu/lQO9wxZMYKIYLnxCPNMSwkzHDySl6BcI3UVcpbAUcGthANskZWAFPMM4SN+BxVqOEFhDvoVon6edSKpE/VPfdovWJdn5LxJSDqSoaI8Bt+qntCBRd5I+8BP6BVlrcrW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAbta2PtgI3GdJlQksM4FrnKzHoN1k9b+Gr8DsG6afU=;
 b=fbnDA0VUNhPJvyGBRJ3ZKGf1PL9zB6ZW7TpfpvZBLbTjJ8nfYcXsDHSxQUZKPx7boer5sr0SIfBbP0VLoMEFyNjklrHt3qtPedRGsdXcY8TarvvCxmWszBJi+b8bzDJOKyU5W2D+s9pGijRnBGOsdPXuka8urClj9dqtsLrrKsqamXpjoVTmqbFtLWS5Z+t7hQBRfTg8BnFS0iKJzBf5wpFcCuQTda4fQnd60V/szlC83s5eLTSgRWwhxwmB8Ysn4HQ7BWFd0Ic7uqhZyDkU/pjf1KH1bOBQq3Nl5Hpn6+tmhqLPUpEnx/L4GqkKcJo5X4ixIutrefuU9J6hNxgwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAbta2PtgI3GdJlQksM4FrnKzHoN1k9b+Gr8DsG6afU=;
 b=JraeWS6MlAZL1whr/wyxjZ44IAwhJslT7cTpf1ThIXUwlrMXW2WO3OrdArJ6H3vEm9uVFKjRCgh+twFmWYk0v0egmJb5GhfWy3g/SpBQP/PDsbYJlbCrL/Cd9qGnRbGXDJ8kz2IMns68Kt8KANZHQpgcivfKlQSTqEH/Xp4HjJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 18:51:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 18:51:15 +0000
Message-ID: <f5b9aa86-f8a2-49ac-bc7c-7121a1bdb342@amd.com>
Date: Wed, 5 Jun 2024 13:41:36 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
To: Borislav Petkov <bp@alien8.de>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
 <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
 <7a7c2f41-1608-4348-9183-d99aaa51398e@amd.com>
 <20240605161236.GIZmCOdP-CRPJ8-3sY@fat_crate.local>
 <e17b38fe-97cb-4559-be97-36af0ab14789@amd.com>
 <20240605164505.GKZmCWEROq9QByGDRn@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240605164505.GKZmCWEROq9QByGDRn@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0598.namprd03.prod.outlook.com
 (2603:10b6:408:10d::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 596cae5b-7b07-47ae-d05c-08dc85907a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnR2aUlPK1g1dWZsd21UcGN5U09WdW8xcWVqeWRubFhmckpHcGRSNTVHUEk2?=
 =?utf-8?B?b3IrVmM5aDE3L0s0R3dIMnU5NjRvN1M0MFJDZit2NndXRUpmbTFvUkJqNVNG?=
 =?utf-8?B?enZuc1luSjZSRzVKVHhaMVBEZklDUlpWdDJobi9tS0tDRlhTVnMzam54Wjd2?=
 =?utf-8?B?UG9GTlZoV0dzdHFSb3RYNlhNNDZIaG1NYVRKbmw5TDJlUGlaY2hFaUZQQitv?=
 =?utf-8?B?M0tvYzE2NFhYZG5rRytsOHlPRTVXTlJKMVh1b1Z0YVEvMVlwR3hMcGRRM3dP?=
 =?utf-8?B?VUNwMzlTdjA5MDU4Q2FGcmZYSzV3UDJmQTV0ZzNoeGxWdkxNOHhmcHE3bS9K?=
 =?utf-8?B?Y21neC9rSHZvSWxRb2FVbC9BTUR5MXE0NU9aeFdLRzFzSlpqMS8xNXhNa0tZ?=
 =?utf-8?B?TDNzSHlGQzBlSnI4Wi9kMytHZUN1T0ZXSFBJTENzWVBMRW5tMW1FdXZXTWhR?=
 =?utf-8?B?SDZmdklHNHRYTDUvNU5Gem0xS1FVQXN5dHIwSlkwb1YwVlFuOFJuejc3RzY2?=
 =?utf-8?B?YnZTdXRhMysyN1c0YXlBaFN3WWpIVEpCeUgwdlk1S1BWMm1pRUJQendwM3JH?=
 =?utf-8?B?TzNZRDNsL1NISEN2RDY3UGptSWFNVGE0NE0yVUZWc3JtNENjTHJTQUNBUmM3?=
 =?utf-8?B?c1pGREoyQk9aUGRDTjhqbmtMOU4xY2RraVkwYWx3VE4zOFlreFZOdnE0T3FJ?=
 =?utf-8?B?UWs5VjRkZ2NMTmx2Q010T0s0ek9uMXVhbnNlRHNuMkxGbSt2OUZBMEtqV3Iw?=
 =?utf-8?B?dTdWbFI1TlkrdmtCbHZlL3hqTGVjNFNZYkNTbytJQzBSRXk1VkdjekQxK3l3?=
 =?utf-8?B?YXJ6eU94WlIrWC9zOVVQcXhycGp0eTVLMzZBUlpmdXRSYXhQdy9UMytQbkw2?=
 =?utf-8?B?MzNCMzZZSFZKZkpFTUhuelhSL000QjBaRXpQOGR1SE92QzUyeHkxcUhHYTF0?=
 =?utf-8?B?amhQNTdzdGJkSStsbU9VcnB0OTlMU1ZjVnd1bXlGZVNXRTZkbFJtendPbGF2?=
 =?utf-8?B?NjA2WWVxSG96aUxlaWJnK2l4RVFGNmxrNzEvZnJhQlFUYVIyVEF0eTNJUkNv?=
 =?utf-8?B?RlhPcFFZeEJvajYwZHU3QWxuV0JjQXdOMEhPZjN4d1dwTlBYMEdPSjBtaWJ6?=
 =?utf-8?B?eVJ5Tmxjdm4yZVRGT1AwdFplbnBYWGUyWUxIdzJzbGdKU0xsaG05cWNMZE0v?=
 =?utf-8?B?RVdWVjIrMlhvdU5uYndPbzZwWnMybmdnRmVuQ0RhdGVIZnNkdEtJMlR0M1RH?=
 =?utf-8?B?S3R0b2hKQ3I4bUg3TXVEb2ZwdE1oODViRVpXQnd5SmRseStkeFdCcllvSVo3?=
 =?utf-8?B?YXM2NUlXSldTbjVLNnppS2ozdDc0OGljc1FjaXprT1hrMXlkeDY1K2RRZmNW?=
 =?utf-8?B?NFJYbE9EYTBwV0hhV09tam9FZEdHZW96MDZBMXg2NnVUSXBzamM5TTF3Yks0?=
 =?utf-8?B?VFFpbk8vUHVmaThUdjQzeWFhM2ZEbEdrbktqUm5NK1JUTDF2UWx1cTc1VnpT?=
 =?utf-8?B?UXlib0haeitURnMyYy9ROGNQZ2czVm5tamVuZ1BCclc0UlBuZ1RwbkNvczFK?=
 =?utf-8?B?L2dxT2swbnI2SXhXTklIMFVBNGJnKzhlMWFYRzFTMFFoLzlpRGU2NUhTamdk?=
 =?utf-8?B?SG50MWVrcU45eEZwQVIyVUIrS09hZnFJWUU5UUYvT0ZpbDBIODh0U29xM0k2?=
 =?utf-8?B?WjNsenh1bk5VWDZJVmNBNFJGaFBpR0l5TGFmbU5DbFBBcUdkeDJoblZsVU9o?=
 =?utf-8?Q?Pc4QnXcGRrjpIFneyDG3z1CCj7KTpItDM80fW2w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWttQ3QrQTJGRHJkMDRBUFZGMmh5Vk1EVVdZWDBtSWZtVUFFdnlvaVJJcE5N?=
 =?utf-8?B?ODJndEJLYURJcVlpTkFTNkx4Qk1uajU5ZmsrYWxUTytURWdVMUkzWHM5Vk84?=
 =?utf-8?B?ZjNHVW9QelZ0Q3hFNnFxc1NVVGhhWXQxVCtkbFdYc2kzQmZnaWtLTU4yWk9q?=
 =?utf-8?B?bnp5aDNIMWFpZkhhSjlBZjNkZEUyTFpKU2ZxT0MvU0hUcEpNUUQzRlFZOFhT?=
 =?utf-8?B?aVUrVkdBNm9zMU9YVUF0T3BDd3JraFhFQnNjWWZiTmN6Qk9SOTJuN1NodS9r?=
 =?utf-8?B?Mkd2QVBDUzZMWE05RGlmQTlPaHE0YlZ4TjVSRE1LeXBGK0xZMFlRVXNkZmtP?=
 =?utf-8?B?R3ZUUVZKVmMybmZEQTR4Qm9nM0szU3c1ZGx4Z3YyOUpaQTkxbHBWY1diWW9l?=
 =?utf-8?B?b242WExWUjRrZlM4R005UTlaK1dzRnVyNHhWVGdwVDRHNllmQ1V0ZjNjWGo2?=
 =?utf-8?B?b1JJOTRqYVhJY0FKbVVqTHZURy9RRmtZa0ZsSUptYVVpdmY5ZnVsQWZKa0pr?=
 =?utf-8?B?a29NTDFzNnROYWhyaFhFTURqbnZNQlpiZm9KRXdQaWh3Y2FmWG9XTTJ3dWpP?=
 =?utf-8?B?dnpnaUFybFBJQXVnVXlSc1cvTkt2ZHFMekM2WGt4alAwMXJLUk53SkJ6R096?=
 =?utf-8?B?V1pVWm9rQ0IrRFdLVU9wNmdBcHhzWmpJMTJkcWZhQVBaR29obkNScmZUSXpu?=
 =?utf-8?B?Y0V3Y09QbG9jKzVtWm5EVnBnTHMzUVI3OGFuMm1zcHRTUXBiSkx1Mno5ZHNC?=
 =?utf-8?B?N0dFKzVmeE1XY3NIL3VJN0pQSXpyZTlsclJCejJnZEFrTzV5aW5tR09oYWlJ?=
 =?utf-8?B?WXYrdmZuZVJxcFNlamhYRmJKL0dCcWpYVUlxSVQ0aytpTStNSnBDSXVyZkJR?=
 =?utf-8?B?dGFWMjcybHNMSTNYdC9OZXgxT3I2WE53d3BwMEJKb245TnI0T2Y3VVdKRE5G?=
 =?utf-8?B?aEhDV05QNmNoaHpBU0MvK29xdjRqbDFnMDF6MU5XWXVYZ3JveTk0ekY4RTZE?=
 =?utf-8?B?dlRabzFwN3Q2OVdXT1ZCK1U4Z2dkazcrWEZzTFl3NmJFcjkyMHhQbThHZXI2?=
 =?utf-8?B?ZVhFWTJDWEhSL0JjZ1pFeDUvcXEzNy9QZkRZdkdkQVBZcFMxVjI3ZVZ3SUFV?=
 =?utf-8?B?SWVpNXpObTFwd0tFbk54amJKNWdZdEswV0UycXpwSTNUR1M0dWpHblB5aWt6?=
 =?utf-8?B?WE5SSGlMeE9pZkNiTDhwVzNUcllHWitscG9XOVppNmtSR3krUjl3aUVEZG9J?=
 =?utf-8?B?ZlY5bHRFd1FGMjk1bE9vYXkrVHZHUXJ3YlVzMFhxSkVJMVVjcVBlTkkwcXJt?=
 =?utf-8?B?V2JlMW5McmZWN2FjYm8ydHBwaXhHMnQxU0JqSVd6S25JWE1sWGkzN0xVWmZV?=
 =?utf-8?B?RGpGdXA5aExmYmtUei9pajFHVG5UR2FFdFlMZTgxTGltZWc4cWp2c2FPS3or?=
 =?utf-8?B?VGE3TFQzaEQ1MUpuK1BJeDBIME5ndTZNazNscGEzUGhhNlBzZ2dlOGxsbkJW?=
 =?utf-8?B?c1hnOHE3WTZXT0VZNWpWWlhRUkp3TlV0VFNuZi9ST3VCaDZoMWdUV2ptQllt?=
 =?utf-8?B?MXZIb0pmaXh2MEgzZG1nRis2bG1QVEl5ZnBjWHFhWmtiSDdGblcvay9iNVpu?=
 =?utf-8?B?MjlHc0JmdzBMM0NIVG5NRlBXek00T0pEYitVVGJLZ0lhSXRHQ3k3M3ZpY1FD?=
 =?utf-8?B?UWdrRGc4d3M2bmx4bzY3MVEzT2ZEYXdvalRXeWEzVzN2V0RhLzNvY0pzTFU4?=
 =?utf-8?B?TEQ2N3ExNEd2bmRBVldFd2pwQWtaZTgrMDJUclVFWXBjb1JQQ0MydXBraTlM?=
 =?utf-8?B?ZDcreVVmemhCNGlKWnNpcWlDUnJpMk84eTF0SytwSEFXWEVpNjhTZ3ViSUdG?=
 =?utf-8?B?ajB3NEVpbkpNV1hSUXdlSFZJaVRaM0dENCtZb3AyYmI2bTcvSDRaV3AyNkth?=
 =?utf-8?B?TW9uekVSUXBDK0hiclRKd3oyWmg4VFFzTDZ1cGo5TzFZTW5YV3ZlY1dLWkdy?=
 =?utf-8?B?dWZDY3dCOUlYbkhXQk10T010UTNIdUpwYytwbWpxZWt0ZjNWRG1pT2NRSDM2?=
 =?utf-8?B?eEtzMHhTS25ibnF1cmVOejVTbDNycE0vdkNtbXE0bXZJcGNVZ2RkZ1YrTjhu?=
 =?utf-8?Q?N2leeWfvU94tgb3KUrtYemA64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596cae5b-7b07-47ae-d05c-08dc85907a6a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 18:51:15.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyjYSJUCysOYuWMHdcYhDcoEwmndIleOKMOgCTe6pzt0+i4/NhWS/yCbPFYz5EWusCWa+s928Hil75QfMDZx8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418

On 6/5/24 12:45 PM, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 12:30:35PM -0400, Yazen Ghannam wrote:
>> "It fixes a problem like ... a hardware quirk ..."
> 
> I'm pretty sure that means a patch which sets a magic bit in some MSR or
> does something else to make the hardware work again. Errata fix and some
> other hackery we get to do from time to time. Or my favourite - fix
> a BIOS f*ckup.
>

Yeah, makes sense. I agree.

>> Most systems will return 0 for SMN addresses that are not accessible.
>> This is in line with AMD convention that unavailable registers are
>> Read-as-Zero/Writes-Ignored.
>>
>> However, some systems will return a "PCI Error Response" instead. This
>> value, along with an error code of 0 from the PCI config access, will
>> confuse callers of the amd_smn_read() function.
> 
> Yes, but it hasn't so far. It is all pretty-much, a hypothetical, "what
> if" thing.
> 
> Sure, if that error would cause a serious issue on some system, by any
> means. But just because it might potentially happen... Meh.
> 
>> But I think it's fine to drop the stable tag after reading through the
>> rules again. I'll do option 2 or 3 if there's interest for specific
>> branches. And the cherry-pick thing should be easy to do if all the
>> prerequisites are already upstream.
> 
> Just wait until some real issue happens. Otherwise, you'll be pretty
> much wasting time and energy.
> 
> And, btw, people should upgrade their kernels on a regular basis - not
> run old, Frankenstein backported crap and think they've got the best of
> both worlds.
>

Okay, no problem.

Thanks,
Yazen

