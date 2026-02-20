Return-Path: <linux-edac+bounces-5728-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIF7CaqQmGn9JgMAu9opvQ
	(envelope-from <linux-edac+bounces-5728-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 20 Feb 2026 17:49:46 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C263716976E
	for <lists+linux-edac@lfdr.de>; Fri, 20 Feb 2026 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40EF302E422
	for <lists+linux-edac@lfdr.de>; Fri, 20 Feb 2026 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9412C21DD;
	Fri, 20 Feb 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xvHdkyPs"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938B28727E;
	Fri, 20 Feb 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606173; cv=fail; b=U1DoFDGGh41B70yVCV8myqEVu7pa5AILyb2sb4bAt7dKNXMtos70xz/CVLtihJVa/LKtGGC9ASSmEOzz/Dyfz7yEr2oEfQ5Kgx/QuL2EAZz1L2FnlvQMZIZ0KhlCyeUBFLlTrMbOiN3elN72F6K7zAzkNt/NxXMbNUgBxMNLBfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606173; c=relaxed/simple;
	bh=7GoJEz3h43nqbf3RDjkRLKLCPRnct8/3bK8RsKfxAvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mah9VxQRaiiO/ISEhnHmSC9Li7t1iVoWHQiOEycWq+nx2L/pasfrb029mdt6qvTFtYdQnpc9Xar3NO9FQjNenuJO4mRuUlxh+U9qcfmHKXiFCzZBR9m++5+kL7lknx1/p9NlllpyhmrG+K/zwmR02ezoWZe4lxXc2Rtsrh//xEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xvHdkyPs; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTfhb+ZVQDGf8Xh6biMb/uU67mQyx+jjr4n4Tt3YkcEUibWMq2lclMoc37MjCP4C9RbCwsoxEHskMiSzEspEkDyp7cGIrYh0KMxb9kWuSgTEGQudHFX5RGNonN891ISejb955eubuNQp4EKEIYJFGdjq3fhn8jDAbESOvgbxx3goaD08eYqGMAdjjCGSoNGTzf7OuNLFW3+C/UahD/Ey20GrXtLYfBr1V7GiyS4pIvxhVZ73bgmuUI+rdqNZ8o0q93voIwbVRLPYEfPLmjwifM/AJEEoakGfR86Y4L30KwylVujUGttXOYxq8mvYL7+2Spd7TvV+Vkg94qUHqmstjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5TKsEHtnqaQ+MXG7AAdf2KaVkJ9nWzsh2l8XnmdXzo=;
 b=jNVSlIvYDJZmUx0XH85ON1A+btI583GZndd27xgZdJT5LdT3vvN0ty46enm7o9HKlbpQMSSlRGsXXDmAUEOW/5Hjf3TVjJk5tAhHHFm8lsCh0vNXXqrQ09ihEJPMqgbgPPAaaqGE2C3c7XanGTZTVnU0dDaUKC5eMgrd0cVznS0cvfRyyJMt/Y1LcxB4b/716sIanJ5IJRKTH2KZ4E5X6/Xh25TIkhbfXUI0LZkQaihCqeWcJNpN99AS13fS3iH8oXJI1jQcV0EA+V3+TjNuUey9gmDpET52uDz9BUczfff0Cs51623IKfahGKV/fc1N6pLvTig5f1IjMkfvQ0YiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5TKsEHtnqaQ+MXG7AAdf2KaVkJ9nWzsh2l8XnmdXzo=;
 b=xvHdkyPsBFekzqjaLT6faTTWd87HT6e3OSf9G7W2b8PPwU/FbO4Xb6BzmHfN5cZllzndLIqwqyeJDDU4dZChzlAMJZWEtO9FErkdLAigs/evw2HHqNDyaSfPUkCbi8r3xqVjR7HEe0rRrRHcLCckYbijepeY9jMcEsXbiyBmxfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 16:49:20 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 16:49:20 +0000
Message-ID: <8530d765-6676-4ba4-98b5-07326c8dc924@amd.com>
Date: Fri, 20 Feb 2026 10:49:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
To: Bert Karwatzki <spasswolf@web.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "spasswolf@web.de Borislav Petkov" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
 qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com
References: <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
 <20251009132055.GA472268@yaz-khff2.amd.com>
 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
 <20260216202546.GA420258@yaz-khff2.amd.com>
 <20260219143345.GA5486@yaz-khff2.amd.com>
 <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:610:53::27) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: feec7509-8d3c-4296-472e-08de709ffe20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTZiQXBVRms0UEQvaWt6Q2NtSS9mSEViNW9mTW9vRFB6VkxvdFIzUlBVZjli?=
 =?utf-8?B?cGlEVGF2dXc5ekdTdVZyTnBBOUVRN0E3Z1Z0ZFU5Z2x3NnNIL0dLQllTa2xL?=
 =?utf-8?B?QUFMVUNxSkdoQVBXMG9tbGFKdXNYQ3NkNTBpZ00xRitKUTg1aHcxSmZ3TG9Z?=
 =?utf-8?B?SmEyeHBRMGZES0J1R3hLcXNYWkNpbDFFVlNTNC94UzBvNG9JNjdEZllzWUhy?=
 =?utf-8?B?eW5kTThCdjdXeHFOS0NlaTI1S0JHWmFweGR5ZktNMkRLcXBiMTJBeVg0SlVp?=
 =?utf-8?B?MFB5VnVWK3E0eUdsanQxeFptRFVRd09TY2lpaGcyQlpqc0t3dkhjbmUrQUwx?=
 =?utf-8?B?ZCtiM3EvdUlRTXJaWDdpaERJaitwNmlsaWJHTWNlUzRyY0VIc09vcS9HMFlw?=
 =?utf-8?B?RS9IbU92VEFvRDNic2NvMW5DZHFFQmZFZHdobTkzeDBHVEFUOHd2d0FITitP?=
 =?utf-8?B?UkpPd040OGZzWUl5K1ArSGJ0Y1FKQjd6dDFvTTJQOGNQeXplTGRtS00wY2sx?=
 =?utf-8?B?SEFpcjBSc0JXRmlpRkZqUEcrZVNNeFd5TGNpYncyWllaOHV0T2s1VlZvZzJj?=
 =?utf-8?B?SmxVcGY2SWtzVXZzcU5NWGI3SDk0WVQ4Sk9ibUtGTERhbWJEYWkrUXZSbmw1?=
 =?utf-8?B?RWNwdFNFQU96UzBKNlkwSUNGazloWXd5Umx4SU5hdXpJN1NWcXpSTUJQdjlQ?=
 =?utf-8?B?R2wwVHFteGJMM2E4U2c1WjYrT1I1VDM5VGRva0xtay95NURCZGdrZ05NaEtK?=
 =?utf-8?B?L0hRWkdxeEZkU0ZUVkN3S0JhaU8rWGg1S3ZDNlB1aThKYzhrNUE2SEdWd3Rr?=
 =?utf-8?B?RWdDbDhNaDVtNmVzNm5mbVZwWGN6VHZjRkZ5OHZ5WVlLaWN1ZUp1ekhVSzlM?=
 =?utf-8?B?aFh2d1RXVHRyRmE3enpSbnA3WWJkMnJwTUhzUFhSS29lNkhuK0hqVFhHZUVm?=
 =?utf-8?B?YllUeURtcEhyNlRZYlIyK1NPNDJ5eG9JNGVaTmZ4b25iQzJGT3kvelU1dEI5?=
 =?utf-8?B?WTZIL0U5ZU5UV3dUL3E0RUFBeWI1SThHa1Z2RE9Gc2FoMXRsQWdRck01TmtT?=
 =?utf-8?B?S0hIRURGNUFxdUx5R3Z0WW1SSys4Q3Z6ZnJjSWhsNnBQZ21rKzA4Sk5pKzBr?=
 =?utf-8?B?bzV3NTBXbEFxcjFkZXFJR3NJekEwdUtUdjlqMWF6WFdWajBqUkhQZmJtNGZJ?=
 =?utf-8?B?Qmh4RnFIdWFkejV0dHpmWmpFNm9KTDJlM3FVelVRbFk1bDQrbHlVa2E4UENL?=
 =?utf-8?B?Y2hTVDN4RS9vMjU2TmJaLzNGQ0YzbXNZK29SS3pEaitodkRXZCtNVGk5NUZB?=
 =?utf-8?B?THJiOHlsUVN5R0hNQWNMUTJxZEtybVZOOGwyTnFJZmJkNGJuaERzd3ZEOXNM?=
 =?utf-8?B?SnhmTVN2eFBIL1NSWFNhcVFiQUZWTUtSU3BNclZsTlVKbDRZYmxMSllEMjNF?=
 =?utf-8?B?MCtSVlBzbm5uMmNXeWVqYXdJamVNNjBUOGhxcGtMSnlpbnBmbGxZZUMwa29h?=
 =?utf-8?B?YnhMSzFnL295RGo3MXpIeTBDYm90N3B4cjhOTWErMUhyaStwQjBqL1dVUVpX?=
 =?utf-8?B?TVY5ZmdoRjhhQXhEL1J1VGFGNit2bTJWdDZmS0FCU0ZrWHI0WHc4cUpwTUZ0?=
 =?utf-8?B?QzdONm1abVc1eGkvL20zNFZaUEczK3JBY1AvcHZBV3AvbW5xekRRcDkvcUxS?=
 =?utf-8?B?TllEWlhoY1E3RDNkQzBtWmxUS2dKaFo0NXJ4VEJrbS9aR0F6dmxwMCtPMlcr?=
 =?utf-8?B?TE5PZWNwTjFpbGxwcDJ4WlhDTEgvRDdUZCthWDVKUGhEVXVBVkIwd256cGx3?=
 =?utf-8?B?WVdzTEpocCtMNEplOTIzZk55VW9ucjJvaWZ5TEgraTBoaERWOHdodlg5Sisw?=
 =?utf-8?B?NTg2Tm0wYlFueUwyNnl5WThtSmlPSkpCd3pURlNTdmlSOVA1RTVZWXk3Q2Mw?=
 =?utf-8?B?dGNJdlk0Q0V3Qy93TVN6am5QME9BV0NOTTZNYStGMXpnSXYvSVNhc2VMNVV4?=
 =?utf-8?B?cUtuRVFrNDlxUlZWQ21LUTJNdW5sMXF6b3l1NDEzZVNBNzhMaW8xWUlNcTVN?=
 =?utf-8?Q?4/9ioR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTBTOXdhY0M3ODljRTZzeFlURy9yUDJkVmdIYUc1bEF2cHQwOHcwbm9objdO?=
 =?utf-8?B?d2NOb0lVRFpoYUtYRm55YnUyQ29PQlU4ei9MQU1sTkZhMmJUM2hmSksvdzlH?=
 =?utf-8?B?R2oxK05PWGd4RG9NV1YzTDZjbC9lQjd4ck4vdGhLQkt0a2FrSThUdlEvRXIr?=
 =?utf-8?B?Q3JjZ0RMMzg2QUZ6dGJlazNzS3dkNXdIZTFFdWRCUTN0Yk5aN2o4b3pTa0dE?=
 =?utf-8?B?Q2NhZmRDdXdVTm51Ky91ZVVEbks2MWtPNEJoMlBYWnNaeFVoVDA2UE1NVDFu?=
 =?utf-8?B?OTgyQkNmZ3kzWW1aRlBTVFRWdU1OZ3lQVmYvTUx6WUgzZ2RYSDhtUXJpL2pI?=
 =?utf-8?B?Z0FzOGduYlJNcjJSRmVOUUMxV2tpT21LeEx3ZTJLSjF4L1NCekVDdDQ0LzJn?=
 =?utf-8?B?OGw2a1VadG1MSmFOQTVNVjBZTWJGblpna0Vwd09MVUZvTXllM1IvcC8zT1Vn?=
 =?utf-8?B?aW5ZcVlRUnNFeG5nWW10Zlg3SXFQUWcrVDZDdkJTemhPU2JpSnhLUnRPZlVs?=
 =?utf-8?B?ZHZoSytaZjJFTVFTRmx3YWdXZ2V1d3NuUEo2NmNuQmxjOHB6akxPdDZoaHZz?=
 =?utf-8?B?eDZDZmgwcjJXQTd2d0V0bVVzdTN2dnUyMFp3TGc1eGo5M3hVL1RiN3ZvYlNo?=
 =?utf-8?B?eDQ1eE5PY2swUVRlODV3WUo2ZU1Ibk9VNGtyNnp4STRmRlozTHYxeFNtcHlt?=
 =?utf-8?B?RUhHOHZrd0c2Z0llS0NZQmtWcks4aHV3Zm53eTdrYmNYT1c4alpaNjgwQmx5?=
 =?utf-8?B?ZzZISi9JbDFyenQ2ZWUxaW1HRnVpcHZFd0Nkc1FOTHkwbkJmSmg2bE9McXFG?=
 =?utf-8?B?OVVmcFBjeXJyWnM3ZFYraEdwckdYL0RXWk5kYWVaeUN1cVU4K0Jod08zaFVZ?=
 =?utf-8?B?dGtMZWt4ZUFYeDF1TVBIT1F6dG45MTFHN3h1eDZrYW8xdWxNUWtZRlpvYlcw?=
 =?utf-8?B?Ukx3b1huSWsyRWV4ZXFYUFNoSjVtY2thNWZOYUtRbDRYOWpYZzdzZFhQYzhB?=
 =?utf-8?B?R2Y4dDMxM09yUnNqZmsyU1pjaFdoOGpKaUxyREgwaFMwY1Q3d0swWDg0V0tE?=
 =?utf-8?B?UDFiOFpCb1ByK2Z0WkhIZWhsajRXYS9IUjFobGZJNng3QUZ3YUZTVVN2bnlF?=
 =?utf-8?B?YkRjOW9uUGNjbDlnb0NCeUE4bTNaMTNlcVNydkcvaUZTZXVuMzVKYUo0cnNl?=
 =?utf-8?B?YTNJbkpUTHh0K1kzTUhIUExKdklPNmIyaWgrQWhHRzBOc2w5YkczZFplL2dT?=
 =?utf-8?B?UnRWbEc5bXU5WU1GbDNJT0duWmF1VXpPU25EcjNzQVdMb29SUEtYUVJsSnBQ?=
 =?utf-8?B?KytiVjdPcE1nVm9udzhIK08vQlBnSjRaTkZCYzVEL2JRcnV4Y2tRTTZlVlA5?=
 =?utf-8?B?bDAzbGQzNUc2YmxkcHlhdXlSRXZuaU0wUTFlZ0cwZDRhbWVqbGdZdExQNCs2?=
 =?utf-8?B?SElQMnAvcFdCdU0rS0oxVTA4MnB5bVdlOCsrK1pZd1JsSFBIQndwWitXR0FB?=
 =?utf-8?B?eVl5SWtIZjV6dEtTODFNUmJ3TTVFcmZOTWthL3NXQUZUODhuUmY5MW5pTlg0?=
 =?utf-8?B?ajN4MS9CcHBzMHdDSEltYjV3TlpCV3VOMmtlc0IwOVkrU2w4enFmQVBwQVI2?=
 =?utf-8?B?SW9ocUl5ZjFTRXI0SXp5bGhWYjBKWThBT3J6L1l4V2g1THVVNXR3MytDa0Nv?=
 =?utf-8?B?TzNRblpoZHRXUmVSK0cybDJiL3FneCtFKzgwYmVxTDRxVXl2c1RRNlQxaHF2?=
 =?utf-8?B?bXJ0RGVQSzdBMUdya21yZm5lSm94VXB5NXBvTjhPNHA0STZpYmJHS004ejlZ?=
 =?utf-8?B?OS9LZ1FpaDNBeDVSdlJWYm1UTlRYMiswYnhBNFp0ZWNYSGtub3pTblp2VXFh?=
 =?utf-8?B?UEJSTzNaTFhIdDNlWSthaWc2eXhJaEtXQ3lYQ2Jac2RWNWRZcitrVDFSSTE0?=
 =?utf-8?B?eHpFdFBvbkgybnNmQ1BEcUFzL1NycHFBS21MSkZvRENmMkU1OUZlblBJWUZC?=
 =?utf-8?B?SzBFNVh0amptSFlFV05vNmhmWm5HK2xmQ3l6N1VMUHRoYVUyRWFKUFltWUpE?=
 =?utf-8?B?NVhvTWRLaml0a0QwNVkvM1BiSEZzV3dZYWNvazc5ZFZFY3BwRENDa2hWd3oz?=
 =?utf-8?B?aHRubkMrN2d3T0FHMmJEWGdGVUwvY1dQTWVtRVc5MklUcDZLTEh3bVJWTzhE?=
 =?utf-8?B?UCtLQUtLUFFOd2dMWU9DR0pNVi85eFhoSy96ZXJJeCtPNHZ1eDIyZU9lVnlH?=
 =?utf-8?B?dE5WcXBVN1JUNXBEL0VzMU9nUFR4L2hsTTR2NUg3bzJuUVdZM3BxSnR6TVRJ?=
 =?utf-8?B?bXBBcTNVbHN3MGE0dkFSdFl1VForK0FuajZRVlNSZmdHN1ZlaWoydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feec7509-8d3c-4296-472e-08de709ffe20
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 16:49:20.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cjDwo+CQqzNVDbtPZXR7mILBXH8uKEuyoNDPvIP110/hihe3aQdrD0PO55zts0coSpWglMEd0MgBUH2STTDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-5728-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[web.de,amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msi.com:url,amd.com:mid,amd.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C263716976E
X-Rspamd-Action: no action



On 2/19/2026 9:43 AM, Bert Karwatzki wrote:
> Am Donnerstag, dem 19.02.2026 um 09:33 -0500 schrieb Yazen Ghannam:
>> On Mon, Feb 16, 2026 at 03:25:46PM -0500, Yazen Ghannam wrote:
>>> On Thu, Feb 12, 2026 at 01:50:05PM +0100, Bert Karwatzki wrote:
>>
>> [...]
>>
>>>>
>>>> 2026-02-10T16:15:01.001203+01:00 lisa kernel: [    C0] smca_should_log_poll_error: 1
>>>> 2026-02-10T16:15:01.001815+01:00 lisa kernel: [T45426] mce: [Hardware Error]: Machine check events logged
>>>> 2026-02-10T16:15:01.001818+01:00 lisa kernel: [T45426] [Hardware Error]: Deferred error, no action required.
>>>> 2026-02-10T16:15:01.001819+01:00 lisa kernel: [T45426] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
>>
>> Hi Bert,
>>
>> The CPU stepping indicates that this isn't a production model.
>>
>> Can you please share more info on your system? Is it a production laptop
>> or a pre-production sample?
>>
>> Thanks,
>> Yazenit
> 
> As far as I know is a production Laptop, a MSI Alpha 15 B5EEK/MS-158L model with
> bios version "BIOS E158LAMS.10F 11/11/2024" (the newest version available at
> https://de.msi.com/Laptop/Alpha-15-B5EX/support?sku_id=89840) and without
> preinstalled Windows which I bought in December 2021 at www.alternate.de (a shop
> which MSI lists as a "trusted partner": https://de.msi.com/service/bzq)
> 
> Bert Karwatzki

Do you know if it was purchased "right around" when it launched?  I'm 
wondering if it's possible they used pre-production parts for some 
reason with their initial systems.

The reason for this line of inquiry is if this is what we would have 
considered pre-production silicon, it might be more appropriate to flag 
the CPU accordingly and ignore these MCEs.

