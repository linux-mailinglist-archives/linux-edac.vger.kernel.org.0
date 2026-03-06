Return-Path: <linux-edac+bounces-5778-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGojKpH1qmlYZAEAu9opvQ
	(envelope-from <linux-edac+bounces-5778-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 16:41:05 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2512240A4
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E68F303E1C6
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 15:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7B3E8C6D;
	Fri,  6 Mar 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I1gQkxOd"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94993EB815
	for <linux-edac@vger.kernel.org>; Fri,  6 Mar 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811619; cv=fail; b=Wk/nfNc4Cgz/daYC4FUuXw1MeU80a9r2E/3MoDfvBgw3/qc3DLyzZizokzmupAfPukWBRwuQEcqRtxlmtDBZEqSNBltsoj+kZ8NL6JmqxKGHJiq7IHuDK/dduxi+e603qPl4VrOZLTvE/5pkbra45/rq4awTMgsRs1GnZxhKi9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811619; c=relaxed/simple;
	bh=u7itthWaFAEJn4kD/yOPWtPi/wxYHbtKYJfLCpAh8W4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pN+vn/14klhKUbEnvet650WmD5w+hFdrsq2BpJEtvRODSeaWXKmUgQud/S0WZTOs0l044BJJ99D5nTuvqM6Oq+LCgd1pzDNp6OJ5wzRXDm8x4zyv88Ij7fzDu3laDP4hTNHUi5vm9DbYXfeSHedSDYb/A+Fb7qFV0LE2lhhJ35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I1gQkxOd; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L09V/luDWOSLsCcw3fiZrwm5buv3pxtGQ1/PNxeD1XNUQhkRVq5Qnw9Z6ZsGvZ+tFTJBEPDg+Trhiz5euFzTZXo/K+U5xmUWxU6ZLYnBEV4w8lijGhNaT4oNerTshCb1PTcXS7v+vstmbNiB2vngNYFxvhmCLH3K0jv386sHX4zldmZ4YHLp0GuUYtPzCwq+bW2HpWGsWr5BYGOJguC2ZWROHVNVFGb2GZddWaUHRIdL139rgeBd6C2HaixvPgYDnQu429U3Rz50e7MmkPqfZCHQffaY4TEdGy22t+1/OHWWj5pUVmi1t3yFRSN3yZIyuyUcLzILDQo6wZ8T6mXvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0A1C2ckazeZGBgImkEaPsziXLf1gXeSCta98lx0P6E=;
 b=FkjfsuJ9i+6cHRZnHp+g7gcUnl/t4lBqwEJNu0aUh9Lxe/Pb1UeLh1lZz6ccEMvrfgJ/20a8Vq/BeQwxbsYK2cVHLwAuGV9duz3qho0kENxrYSIXEfzLmypnXCk5U53xXaxkbIMGOev+GoyX6847bxEqoSBmcJiKVBPWLbRc7LvF/o6slj3Ys8W5sdbCHIKYJb9V/s4rvysYCPZOn1Ep1k+UKX8fb8eAXnFug7nhQfby9BvKhjjBeRsgZ0B8s3n4rAIwP44EHfNBNp//vUfJTTled8+07af0tOxxNxAIC/u/jF2BpwJQF7SglylHuB60v4k7B8qKjLn4qCExR1tMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0A1C2ckazeZGBgImkEaPsziXLf1gXeSCta98lx0P6E=;
 b=I1gQkxOdbc5rccZhc2wEmNoKARwYdOSzGKzwyTF+JH0Db+Y1F5rsPec4SY78iUmvOIq70k3+gEXr7xxStPTi8/XP3A4TOLElCVoiqlGq6DqQ6JAmTQrsPjg6o4m1aC6sQJOu8icWOp3vDbvQotHxczmMXTFOQ7Cs+gBigaYZoEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:13 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 15:40:13 +0000
Message-ID: <47075497-6bb8-4da3-b8b3-63901d9f3b05@amd.com>
Date: Fri, 6 Mar 2026 09:40:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision
 to debug
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen.Ghannam@amd.com, Tony Luck <tony.luck@intel.com>,
 superm1@kernel.org, linux-edac@vger.kernel.org
References: <20260305154528.1171999-1-mario.limonciello@amd.com>
 <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
 <a9a4aeb8-a044-476d-845d-0368f90624f2@amd.com>
 <20260306153223.GFaarzhwApsh3Jdqdy@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260306153223.GFaarzhwApsh3Jdqdy@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:610:b3::17) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0d7a8f-ee00-40a6-2a3e-08de7b96a825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	oCH7Wv7RnoRG/QI87IzfXNM4ovUQg2SEqesNnVv/raM5/cMhahcoIVqo1cUfFTYRRCmhbjhuC3A1LQHMt9OliYpAvnFIzt9T6TxlRV6vPc+/wiqNdbeeeFsz6wmyct7bXw0Hd2mTjSABegrWVKVB1nnVInFrHAUdqMzd4UBIPjahy7/mfmozGDPEe+v/17kt5TlwUzD+HVmtDdk7B/tfNbxrutJhYzLvCIOaszPPgUKwcVgZ5e/BLq+EwN2hTixTq90yYbOJ4wMQccutigsi41XSgv5WVrPz4gi2Br90f/i9TG8K0kL2/aEM+14V/eZZ/401yfy2ltnRidqz27M4LqpWB7AYtSWFqc0F0u1kqCGRWhc+KSuFMVC0kvhYbt7xPWlKtvg1dk4vIJ8bDznkkQu+LThlDEuE0GuQVEz7Wu//a1jG7bJPO1f9hycnbmMg2qQiF29K/wLfnOkf2WcLqtM5+nEaJjGZO6I4Tsmhi0+ASUaIC51/EKMmSCjBthbPEJAFsuzvtrTgstt6woNOWzpJSEjvzOylPDsO2ujL9pmkMgUBLBXxCAPEC8/IvwruidSN2PDDInedYdC/rMCRJKoaKT2IFh8fitIZ0UeGdcgYWvkfBHQKuqgQirtjVJCZ6UhwJHOpKPvuxFZ4xXrmSGAXkZy9krFY2iQ64nfn14fTKZbiqiBuAiOsDs2rTpgQzJI7sgQp47UhwxQP8PdCo7161Doj4jpvPUh5qsSQkko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVRucnIySjR4TGE0aVdIQ3ZCQlZKNktsMFRTWkpleXMrUDMvSW0yUmY0RU40?=
 =?utf-8?B?S1Z4Zi9rRGpjYWw5cDRma3c0TjZXNklUbDhSU1pBUUQrSlZTVVhyajluSmhs?=
 =?utf-8?B?QkNPTklPWVg2eVFObnFKWUlXeVJ6VzBCczduMCsxQ1l5MERIQmx1TXZXSVN3?=
 =?utf-8?B?dFh3c2RzRTEzczUyNkhCUTkzSXRXVkFuL1dmRG9BSEZqS0JmTHJVdU5EMHdS?=
 =?utf-8?B?WVc1L0tONGpRdHhqZ0xxMlhPa0FPTmc0Ti9SZ05ua0hzUWZldkZ0cy9DYTM0?=
 =?utf-8?B?Si84S1VsZnBXeVNkRzczUnZyTEdzbklCR0RkZWxOa1FJdElSdXZHbVQ2bHJa?=
 =?utf-8?B?QWFNRE1RdlRnZi9NeHBUTkFYRGZ0N05yU0MwY3lwblVkY1lDRHM2b2dGRXdO?=
 =?utf-8?B?QWlJMmdleThZTXNiRndzRjBJT1FNWTNGZ3dVczlDZHIyM3hYSURkaVVqTW8r?=
 =?utf-8?B?YVROL2RrWG9hTFRqQmozc2ZjNFhOYzBkUE0wQW5HTUFmT3orRXl4RFl5ai9Y?=
 =?utf-8?B?ODR1dnR4QlNXRFkyemFoZ1hTS2NUb05YV2ROdEk0OFpCc1NsU0RZN0NDemht?=
 =?utf-8?B?dERJdnFtMWpYdDRjYUJkNXphWTZ4dmUyZ2pScjJGOW9JY2Jnek5ORzNBV3NW?=
 =?utf-8?B?K2dwTWNQUHg1STRIelRYQVQ1dkcxdFN2T3EwT3czY2xOdFByUnA5eTUwZFNl?=
 =?utf-8?B?TnNud3hDYlJoL3JZWnovaHRzdytCRDRhN2RiK01vcUxtOVQ2eXdKeHJGYld2?=
 =?utf-8?B?N2ljTUhmMytlVmxORVBZNzlkaWwvQ203dkZCWjhHWXF0K3RZUFg0YUlqOHg2?=
 =?utf-8?B?d3BRaWZwcUlDellKWDl2T3AxdkgzRHNXWUp5VXluYWVBaEk1UFVrNW9KNDls?=
 =?utf-8?B?RkVuU0NkSTh4Z294K0VhWUd4YVA5cXdteEoyRWpMY0ZiVm5nd1ZERGNveG41?=
 =?utf-8?B?ZmFQS0FZZURrSDVOSVdSWkVVSVFjZFlUZEFoekx6NE9yVEgxY0lxcmVXK2dV?=
 =?utf-8?B?OUtOQjZPUUZIWUJHMDArem1adWkxb3F3ZXM0TlVQVDg2L3JRWGxPTitvQnlV?=
 =?utf-8?B?RXZFemgzWk9INjBNNFlNVUJZQW9uMHROZ3pia0w2OUl6eENuYXBmT0xEK3dL?=
 =?utf-8?B?ZWRqK2lwNmtZQytTc2pIN1ZqNWltaXptem5rbWpwdWpJekFCTlViOTVNV3FH?=
 =?utf-8?B?QnZlRmxQM0I2dXM1N3dlcEZhSGdobGFYa0tQcEV3TDdKVGlicTZhc2tuakdi?=
 =?utf-8?B?Sy9EU1U4ZXJFaFFUY2pweEdTaURRajRTaDkzaEMvM0FMU1Q0ZDg4ZTB6N2d6?=
 =?utf-8?B?SG1KZVVtTDV4RkxldUF5Z2E0Mmt1aDdDN2JNSVBrTk9RSE1tOHlZYnVsTGJX?=
 =?utf-8?B?SHhqeWhlaEdIZWp1UDZRRXlBMnB2NW9XcXZaUXcrVUZNYjBzVVpxMEtHOG80?=
 =?utf-8?B?c2VKV3pTSHVqNk1FbHpqSFlGZ2htMWpWVENPTEpvUzVzN1VkcElMN00xN1ZP?=
 =?utf-8?B?TmRDcFloNW1GVE1hVm1BeU1vdGRXRndtWnZ6WHB6OFdWODBnN2xFeWUweU5o?=
 =?utf-8?B?UWo1VXAvU2R2Ynl6cVFVUEJ2cFJyUzJJRE03NUhGdnFoNW1hOEZwTVJsd0Zy?=
 =?utf-8?B?a3ZLSE80blptaGd6RUZoMDNFRy9DQ1l3TWEvM3hDZGwyWVBOYXh6b1hIVDJ0?=
 =?utf-8?B?QXI1S01kbHVjS3Z6VGtPZ3pOQlJWM2F6eitwM0FKaTBpSDdOLytOcEk1K1pN?=
 =?utf-8?B?NkRyQVBGdVdRZlFrNUFPdTdDdFk0M3lMQnVWbFJEdkhxSFJyRnpSMm8vby8r?=
 =?utf-8?B?NGF0Y3BJamZlYmtNOHlZWFdBVXVjRWhxdnZCdUhDY21QVEJGZEY3YUh4bU5y?=
 =?utf-8?B?MEFxQU4vLzhXeEJBSVh5T21PZ2RhaGFDTnpMNUpmakJ3dmkrU1FEZVU3TUkr?=
 =?utf-8?B?Q004cTNkMW9FcjA2b0I0bFcyRmRFTWRTUmdiM3p4c25yR0pjRW9ZMFZQM3F6?=
 =?utf-8?B?aWwyVVpJVzRhQlhPYXB2eG13dm5BaVVYV3U1NFlWSTJWU29qMEtQVEFXYS9G?=
 =?utf-8?B?amdNeDc2Z0VlRnRxelhMQUVyeVh0TEEvOXl2VTR4RlQxR0w4OUVnaWRGV0li?=
 =?utf-8?B?Ni9UbnRLeDdaZlpqUHc0L0xQSTZRUGJLTkRvbFZPZnNlU0M4V1BnSnBFbVFx?=
 =?utf-8?B?djZuLzU0R0trWGRRV0dWclNxKzNsTFg1Y0srdmpwODc5NmVuMEdHMC92UDB0?=
 =?utf-8?B?NGt2eWhWRFJITXh5eFZrb1JrZnNiZUppb2pFR3Fjd3BrdGp0TDNJNDRGaXA5?=
 =?utf-8?B?NHQrR0RMN3VSNjkwem4zN3dhb1kxTXFSNXJ6RGVPeUtIS2NHOGNXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0d7a8f-ee00-40a6-2a3e-08de7b96a825
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:13.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRQJIUMd+GXrSSwGTNphmuxyWzNJquQTr2ypcLw4xjRvRqaN1OCLjttjKGAF9gfMlDVNWWJG69grfEAgUVzCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Rspamd-Queue-Id: 6C2512240A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5778-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/6/26 9:32 AM, Borislav Petkov wrote:
> On Fri, Mar 06, 2026 at 09:03:44AM -0600, Mario Limonciello wrote:
>> Well in this case the platform /doesn't/ have PRM.  The implication is we're
>> not going to have DF support either if the system doesn't have PRM.
>>
>> We pass the error codes up so the caller of amd_atl_init() will fail init
>> and thus the UMC decoder won't work.
>>
>> That's all the intended behavior for such systems.
> 
> Yah, I had the hunch you're talking about pure clients... :)
> 
> And as such, they should not even try to load ATL because they don't have ECC
> memory.
> 
> And if so, we probably should check somewhere whether ECC is even enabled on
> the system and then stop loading if not...
> 

But don't you need to use UMC to discover that?  Chicken and egg type of 
issue.

