Return-Path: <linux-edac+bounces-4834-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6DB86FB5
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AD47BAD69
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170082F4A06;
	Thu, 18 Sep 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kKtkCXXy"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8B2E1754;
	Thu, 18 Sep 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229222; cv=fail; b=MDENriZHrl2JN4/E4i3r7C9iF8X/YNWEYL337uD4nwQCmfYwk6wBw4REbaT9Df3CHrscIAQ5OrTzN4zzznD5ZPFm/FhSW3ixEQbDNdtEVxjazpYtFmfzZgNFaXBE03TdFdqceqSEM/9JSVVtThe52sX5fDrQ5uqa/5gmvsWT9z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229222; c=relaxed/simple;
	bh=YV+84ZMJZFzme6okzDkQYLYcKlMEQqsyCBk7ByqlRcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhVx9qZehdIEKOzrF6aG5bJ8QBtU6VA/gY5lg91btfFwkbqp5vr+TJ1yfU0grR0eVMOWk25lxJ2gAhhpza1VJcY7MxwDm0IUC42i3Z04VSwJCbOFHvGrg06Hdjrgk8LG1ssyB26Lqrip9Fm4pmuc8/756zT6QIBp4teE5vhoWqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kKtkCXXy; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHyAmLQUSig7F90QXOQKcHnk9lZ/2DgfIToLeoDk3swYNZGlMtAFEu8lM8FTiCTieJAVpPCwqbWkyY9c0YaPAjPcSFKtbP1OPVgL+w2NaS/B7vKmhm05FkF5ss4818+qGzaGGdAfMaKdV8U63EPoSlNaoIngaWOMtv7RmMxfL+NnLlFlioa/GbIo5uXBs0Jy2Wtk3tKIkAylfmIb7PgABOck90o7fc8h7w44ryovfkkzY7y+V2oaTVDxA29K9QORQI6gt4pR/PD/YMrh1UZknRN5hZxSKdXVTSs2m656rY6POP7CfQNoaxX8j/OKXAjd7K6EZgjaHR+Xm4fp6t2sLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgeAmmHijD4fbw2PIXlsQIWgp1UA0ZazTqJdPojDIkU=;
 b=QP4IPiszdtgtHHRQ89A1t5tZi1bTDLhEF9uHmbF7cnT5JshA4VIQowTM2gc5WLz2FGzSPv9TWbSyNtYlAly2EfCiCRa1TRy7zlx3O5jn/KOAAE+3DsU9BCj6GkGG7yQXaWdFLiQRfxxP5Lktp9KAY/KT3GGADr+fGmT4lLrAAvmNbCgmGC+X1fhk0I8eQUeWwi8Ra4jDvEIPHe7jVn4hb3Etul3DGt0NvGKsWsCgov7ljxeqvnIqNRk3QLjzrFS0/JB3oJgJ2gFPQqYndIbJMqnhKaiexlVorPg8rlW1E6/JGtU6UvmuzAhrzofw8c6EiT0/glHAo3yRzhVZli4Aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgeAmmHijD4fbw2PIXlsQIWgp1UA0ZazTqJdPojDIkU=;
 b=kKtkCXXyaurdlO3CO3HwE9vT8pSUyk/DH26ITLpk7O5imrkdmO5nbMGM4rhER/DlRawxN9uHUM7rpoFWPYy501AlSnBSvW4jeE4J39v2e/nfHbqunXf9ZJkT7g3pSUMPMwSBqQfav0CsjEtZt+Lnd5DLY7Jt30K45Vuo+xU1vNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 21:00:15 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 21:00:15 +0000
Date: Thu, 18 Sep 2025 17:00:05 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250918210005.GA2150610@yaz-khff2.amd.com>
References: <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb78649-2045-4ae7-6808-08ddf6f65d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmtHTWpoaFVLOFNGUzFWdzZNWURSL1duUTREdWM4ZVVVS0R3bEFYYXBNdUNQ?=
 =?utf-8?B?bW1OWHMwcllQRVl0Mk85Vk9EM0ZNYVVhVjlLdVQ2MFBMS2haU0RnU0paNE03?=
 =?utf-8?B?elI5M3RqMEsrTXI1dTdNR2ZySXcxZUpOeWZlVGJaUFRiQkJucGU2YkZ4aFpl?=
 =?utf-8?B?YkUrelIxRHRKK3E3YUx2Tk5HU1p0ZGpRWm1lODNINTVUMTI3dGNjZ3JDWmk4?=
 =?utf-8?B?QkYzMFRNOEJrdVJPMXltakE5T1BnUGVxUjN1L3RNMWdRQ2IzWFQyTDR5MDkz?=
 =?utf-8?B?Z2J1L1BXQnRVb3ZMbEZ5OWF3RnVqVnpLendYRTBVRG13cEcrR3FoaHpWV3pQ?=
 =?utf-8?B?emlBL082WHMyc2pUV3VlV05nR1NhckJiTEVRU04vNkJ1bis5aUNNVXhhd253?=
 =?utf-8?B?K0FISVJxVGF2dVl3aENLTTBjMFZ6NXpRZ0RhMVlibitQTUZFR1RkVWZxRmJn?=
 =?utf-8?B?TWVDMlMzdlRYRnlxM0syaGFUT042Sm9LZm15aUR2UnNLcXdnbTlzbWtOdjJU?=
 =?utf-8?B?ekEzZ1RGaUcvRS9ZR2wrcGUwb3BJK0hMTlR2eVpoRVZhR2JPcmtaeXpPK1hs?=
 =?utf-8?B?bSthSTFtNmt5U2ZmQlFyY3pjLzZhWmNsRW5acDNMb0RrQUIvell0NTdiajJo?=
 =?utf-8?B?S1dqOEhPREl0WW1QWGlNUnVLNU5ONFIrRFhrTjFMUG9lSENCTEF6NWNDVDh1?=
 =?utf-8?B?cFNTV05ReXN0V2RmcnRpRnpUcGt3VjNLTjA5K09IN25ua3pUVnZrWUtzK0lY?=
 =?utf-8?B?VzFkcmhTc3M4ZGtubklXVCsvRERtNzh2WGhsOVJxZ0tuYzNIU3lRY3l2U1NP?=
 =?utf-8?B?SkVFWThLZnY2SEloSlkzbjBEUFZ3a0FyQjVHTUhXYWNmaU4wTUd3bGNOOGFm?=
 =?utf-8?B?Snl2YWorU1NGb2w5cGtmTUhHWjdkbDQxVW5YTDBMdkJaM1d5amVRQUVhcmdi?=
 =?utf-8?B?c1J3VWViQW5kZXl5amp6TlZOWDlHblVRTEtzVnYwd3VSb0VGNG0wVTZqbWVy?=
 =?utf-8?B?WExZb24yRjVLcnNGNGpvb1ZOa1ZMck90VTVLTEJDU2hBaVptQnVaMklWVFNu?=
 =?utf-8?B?MXQ5enlGU0VjU0ZlbDhnL1VhT05DT0ZYdXR4eFVsUzRvTzhUazZHUUZQZTNz?=
 =?utf-8?B?ank0ZG94V1NObHY5ZGRaRitzY1YwSmdhNnhNQzB2UXQwOENqU3JKLzJXa3Uv?=
 =?utf-8?B?RytXOFFib2dhRGlUR3RBaWtWTllrRGRoMnN4YXV4c1gzUFIwbktwY05GcmV3?=
 =?utf-8?B?dTdZNHZKQnczcGFvOFp3TDdtZmJjTFZJbDM3NEFvOGRhOXNBNHBXN2dLaWIw?=
 =?utf-8?B?QUtxZUY3SkxqYkpWOXQ4NDV3MGtETGVxTVVJT3FFRlVaK0FjeDgrK1VKWW1O?=
 =?utf-8?B?TysrTEV1YXpGU3JCMEF1R2hQb1ZoME5IYUlOZ0FEZVVWcFg0bFc2blZGTnlh?=
 =?utf-8?B?RHdsMHM2d3NkZFprc2xNSzZETDYrUEF5ejM3ZWs0WTRxc21GM0ZUQWpYdDJl?=
 =?utf-8?B?NHN4dkgwSEFOeDh2bm9hbWQ3TzVBdndOLzlHUkM3U2ZWMks3MWxsbThNeU9y?=
 =?utf-8?B?MTJHc2NmVXdrdzVSTC9vSDVoRVN6UCtOS09vTEdUSnNLblRzV1AyTFpmOGNo?=
 =?utf-8?B?RUpnN1dKTE5DVEhDaVFsNkNWRlV6TDdNTUdyeVVFcnNuSlBlYllJZGRlN2tJ?=
 =?utf-8?B?Y2NBL0FCUnZmUm5DeDY5aUVIazFCTHNQeG9EOFc3eHRTTlNFN01QYVFHd1U5?=
 =?utf-8?B?RmJGYmYzVUJGWlZGSWZhUmFKRTlObkUwZ09sSkNJQnFoYUQzSjlaaEQrT3dZ?=
 =?utf-8?B?dDJPVHYrQVV1eFFOZTZueS9mSlRlcUV0U09mSEVJWWZzdEwvenFXUGt4K3hp?=
 =?utf-8?B?VEJMcnZQSVJraEJhWWhZY0c5dElUcTJvYTFCK3JBZjYyT2RMeU1JUnlGM0VM?=
 =?utf-8?Q?JuTu2CS92cw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTVwUnBsTXBNb1lISWxiaVovRVFrTk1EcVd2Y3NSQWJPSmpBaTRJY25oNkVl?=
 =?utf-8?B?NjFqWk15L1NoaDk2aWdWWGgwR01hVGp5MGN5QXZlS3hEVmlTV2dhejdqdUxD?=
 =?utf-8?B?UUZCZGlGY1ZyY0VIWnNhc1R5UW5pMWc5MTd0WUFjS3paWE9xaHc1dE5WVFp3?=
 =?utf-8?B?SHdHT2Zmb0FLMTZqVGVDWVc2UjFPSkRCdWNiaEFKNWJVdGhVNGFqQWRoeVpU?=
 =?utf-8?B?VUcvaVp0azN0YWgzSHZRb0JEdFV2UjVBQVlqTGhhN0J4MGRkN1hGaGtYTXFi?=
 =?utf-8?B?RWpuYis5bmVZL3J3TS92S2ptdmpROFdjNWpZMzA4NE16ZDNhYzBMSEs3cVFX?=
 =?utf-8?B?MWdBMjVGU3FrTWpiNWJMV2ppNmZ4L1E4SmxrN3Jsc0U0WlZKQ3dWbWFMcUta?=
 =?utf-8?B?VDJwa0hLWWR5QTYxWitSaU90RDVSWGplbVBESmQ3SVUwdkJucitETlhyMlN5?=
 =?utf-8?B?TUFubVdZd0U3dWxLd1dxTThydzIxRlFqaTZNTTVzT2dXcDMxZEZNcTE1MkVo?=
 =?utf-8?B?N1A5ZWtuaDF4YVp4c3RGajBlSUZSNU9YTGx4SVB6czVSZ2RuZjRVbW1uc3Jx?=
 =?utf-8?B?WnRLeXNIR21aU0ZrWlVONHVRUmQ3QmNnUkhTdE53cmYvT3Y1V0xDaitiTGl0?=
 =?utf-8?B?YnZaQVhkWHU1UTJiMmxZcDgyMWRReUk4K284MG1Zc1ZWRUVMRCtYSTU5WGNT?=
 =?utf-8?B?TjNSK1AvMHRBT0pheFJvVURPbTJVZ2FjS0J4SjhGdGxaOFNGaTN0cGZiWlpE?=
 =?utf-8?B?aTdEZkI5OUFYQm9yVk0yTXpaRkNIU0xOMHZPSXRwMWN0VjVabDdROEJWbDBG?=
 =?utf-8?B?SHBDeHFneTdkaUxNMVhOZWJUV0xUcnhHSFJWeGdaejZMK0dJV2d6Y3NqTXpE?=
 =?utf-8?B?NVhsNElqUm5oc3BubEQ3OEUzbGVTMkZpeDZPSVJ4Sko4RG1wbUJ2S2txZlJn?=
 =?utf-8?B?eVA1dXB3WW5YTnBFK2NaaWhpNGhHVzJzOXZQNlI1Q05JeVZ3azJyRmxTTnpW?=
 =?utf-8?B?RXV3Z2pERmRmQTAwZXpONk8rNjZ6cEU2K2RJVE1DaGY5RHpHOTgxM3FZc3dX?=
 =?utf-8?B?ZEdhR3FRUzN6dy9hZ0ZMTDFzNWF6U0FoTkc5cTYvYU9HN0xya1lwbEU2c044?=
 =?utf-8?B?Y3EzNm1FRE5URVFYcGN6VFgvY3haTDRKYVRMYTNrNmllcDN6b1N6YlpDK2pF?=
 =?utf-8?B?b3UxV2JVSXJSYUViVm5DMy9LZEhjVFJmaTZPNWVpaEZhL09lZWJpbXdYVWNa?=
 =?utf-8?B?VDNxN1N3d0xubjhjRldGb3VnQWZqcEhLS285WGJGeDhpaktYZEY1MFZHWXdV?=
 =?utf-8?B?MUc3TmYzOCtzSE5YTXZjN1BwSWszbUExRFJmaENoVU1odXZLWmVEb0swQXR6?=
 =?utf-8?B?U3lzVnNGMTlFVWQrdTQvVktoTWt1MFlDcGtkSG84bXRrRkJzbFQweUZqT29w?=
 =?utf-8?B?bVpadkV3akNNVEtDMWRrNkR1a0F4ejdZbFQ4bXNyTXJLWnNGZTZ6YitFZDdL?=
 =?utf-8?B?aUk1M1JacTcyOUowUlU3eUViYUJDeVo4dHJ0aHBkajIyRzBBSmJwLzNiY2ZF?=
 =?utf-8?B?UmFLV3VRVXRaM0JaL1AyNW9VYW5IQjVCZnVtLzlOeWI0ZDR5U2cyY21KbE1a?=
 =?utf-8?B?RkNvOWRBTG1KMWpRbEhWTHB5d2lXSnl6eXo3ckVkZ3ZaRUZCalBiY0pwUmpE?=
 =?utf-8?B?WFc3OVN0TW5NL0dFcmlzeFcwY09Sbzhvbmx2aHBxWkJDdU9NTitGSmhZS2NG?=
 =?utf-8?B?RTl1UmhUODI3MGNLSjhZcFlSRzhKVXJDRVFrOThnZ1JzV3VwNGVNQU5tekp5?=
 =?utf-8?B?RFZZSUZCZ2d5NjYxNFBmNFNkUmNMZWF4S3BhZVdwWlRZTGplKzlwS05wS1VE?=
 =?utf-8?B?N0p6RWY2YUdxdkpoTENYSlYveWE0Y29JQk9mWXk5dU1JUnhPQTdNV3ZzQVYr?=
 =?utf-8?B?aXlLQ0p0eDU1aHhxbG5MaWN5K1RydGJHTkdYR3pqbEZFc2pvRjYrZ3hHalFl?=
 =?utf-8?B?bmpZRUpjWkFiZEdGMDdaMVVBa1A4M3N4SnAyOVc2b3laektVVWg3Wm5vc3pY?=
 =?utf-8?B?dVlGV3ZhMThWS0VyQW5uMG1FVWpPTXF6KzlJcHJ0SitVVG9qZndna0xKWGhs?=
 =?utf-8?Q?GG9Gq/vJPFOsdIaRvZAbxcm1X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb78649-2045-4ae7-6808-08ddf6f65d91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 21:00:15.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi3yh49dOf9Wa19WBJXGp1V3GjQ4s0Qv0GihYmHyCCeYbxN2Cr22LN/gGhQkDBsx5y9KbW9AZMHojYQDsFOZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

On Thu, Sep 18, 2025 at 01:20:58PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9/17/25 22:26, Yazen Ghannam wrote:
> <snip>
> 
> 
> > Right, so it seems we have bogus data logged in these registers. And
> > this is unrelated to the recent patches.
> > 
> > We have some combination of bits set in MCA_DESTAT registers. The
> > deferred error interrupt hasn't fired (at least from the latest
> > example).
> > 
> > There does seem to be some combination of bits that are always set and
> > others flip between examples.
> > 
> > I'll highlight this to our hardware folks. But I don't think there's
> > much we can do other than filter these out somehow.
> > 
> > I can add two checks to the patch to make it more like the current
> > behavior.
> > 
> > 1) Check for 'Deferred' status bit when logging from the MCA_DESTAT.
> > This was in the debug patch I shared.
> 
> According to AMD APM 9.3.3.4:
> 
> "If the error being logged is a deferred error, then the error will be
> logged to MCA_DESTAT."
> 
> So this means that when Valid is set in DESTAT then the error MUST BE
> deferred. I.e I think it's in valid to have valid && !deferred in DESTAT, no
> ?

Yes, correct. That is why this issue is perplexing.

> 
> Additionally nowhere in the APM is ti mentioned what's the default value of
> MCA_CONFIG.LogDeferredEn so as it stands you are now working with the
> assumption that it's 1 and DESTAT is always a redundant copy of STATUS.
> 

The value is determined by the platform. The Linux code is structured so
the data is gathered from any possible source. That's why there are a
few checks to determine which register to look at.

> Btw looking at the output that Bert has provided it seems that indeed
> MCA_CONFIG.LogDeferredEn is 0 by default:

Banks 9 to 14 seem to have bogus values. And this seems to be the cause
of our mishandling here.

You can see the difference compared to the other banks. Banks 7 and 8
are good comparisons as they are of the same "type" (L3 cache).

> 
> "
> LogDeferredEn—Bit 34. Enable logging of deferred errors in MCA_STATUS. 0=Log
> deferred errors only in MCA_DESTAT and MCA_DEADDR. 1=Log deferred errors in
> MCA_STATUS and MCA_ADDR in addition to MCA_DESTAT and MCA_DEADDR. This bit
> does not affect logging of deferred errors in MCA_SYND or MCA_MISCx.
> "
> 
> 
> I think the polling code is slightly broken now for AMD. The order of
> operation per poll cycle should be:
> 
> 1. Check MCA_STATUS -> report if there is anything, clear it the bank
> 2. (In the same cycle) -> Check DEFERRED and report if there is anything,
> clear the deferred.
>

It is unlikely to have two independent errors in MCA_STATUS and
MCA_DESTAT due to how errors can be overwritten by more severe errors.
By default, our reference platform implementation has
MCA_CONFIG[LogDeferredInMcaStat] enabled. So a deferred error in
MCA_STATUS will only be overwritten by an uncorrectable (#MC) error. In
this case, MCA_STATUS will be cleared by the #MC handler. And so
MCA_DESTAT acts as a backup.

But you're right there is a gap here that we can try to fill if a
platform ever changes this config bit.



For the current issue, it does seem that the registers contain junk
values. And we are only now seeing this with the recent rework.

Bert, can you please provide two more register dumps from the script?

Our hardware team is interested to see if the values remain consistent
or change between reads.

Thanks,
Yazen

