Return-Path: <linux-edac+bounces-2329-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2799B51A4
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 19:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33E71F2404D
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD031DDC16;
	Tue, 29 Oct 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cx7ujqGp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5021CC17A;
	Tue, 29 Oct 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225666; cv=fail; b=DhWKHpWOuuE8oQ0jFMuF4GQ+nCQOuAITKgODZTEr/eehIgGHfM8YWltC0dTuzgnot9W8YGl5RFw3hxBaeGt3UcDXM6fAloTSjA4e6Et3Z2X+27tCNmwtr6Piq5ghBFiyG9o/EAsGdfEYONqQW97rC/7TIYsJmAL4Qm/1OV0zxhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225666; c=relaxed/simple;
	bh=qqdU7c7o2knEY0MrKKWl8ayUaymlKUYrdAY11Ar40zE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IGVes38rc/2LEwiXI+aolSCTXhx7OdzuKSVvmQrrsrRp1mYXvKm2n/J4MKzpueksidtOnEy6vsBRnJlKsDHKYnyf7Nn3YQnfKbbo1o0tyGSz1oD8h7g8zjCq5p2lXMqGgLTP1QQW7FAGcIW4NGxp/2gcon9iaf2sF3c9t/oT2cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cx7ujqGp; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvAFG3Y2J6KcOav588urnJW7wH6sprMYm4mRUHyAy95YbB30uOtwTgqrPi6oiJRHuLkiTSU8gpvKHo2PWvIZSWxjkMEsHoE/UI8THw1+oLAPjclo+rhWMPGhtW0CJKLP1UFN/K26wgvGNc9TQl94M8dtNW5zHTz7zyFgWdDJvlr0YRh6jj6lr99DVjFXFaeiXgZ/M8ehkZwskdEgAewGBXrYlg0ZtSU2muenw2qat4gpK3BeNHyBrEiX5hquGd7PSK1SOS8Tp6HAYkP+LPjrinPIumS1pmvh4Sxjut+B9VlTDkYpmmxYo+fOXgeVnJD763gH3lK5Litgu34H/7ygMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Eqv/J/HbJ2y1nizhk7sfaki51wMeYazfEf98DHbLo=;
 b=hzTuyMAEF5F9Lqov6Y30uRsmRULQyDyHr9mMOkOXZhq775D77IeqwkTuqXRyYT13wPsdBNUtnIxw7bsXsBCZ+5wieqgqQujgfswF8EV7U86t0mMka4De4vpdYU6BknZJnX0jy/R00GXpUjIoBc52WhOaC7TGnG+w+8SBrwdYNVSRuLQajhaH/eGbDGsKOZCCbx5+JlL5CflO3ZfaNK8Y9MtVYTeAL6pc1jvna9yfxUaaLmdzksx7hLMzmCKwrmPfMMW2oNrRXodJzjrtWvr6vtgcZMnGSqjvYdD0r+sx5Xldk81HzElMuCz3NmO5Y/dgaR4Np+dvnLuX89Nx/wowrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+Eqv/J/HbJ2y1nizhk7sfaki51wMeYazfEf98DHbLo=;
 b=Cx7ujqGpV/tN8WeI0Fr47AgEiVYltdKveAMY4f7JUXe2JWKloaVBer16U/AdSjrwcyJUy/aMreCA/M08k8ofgtbOIyTHJpBro1aKAzDLjARDmGXVa673gI0BGzlt1/M9UpVi/eX99wsGB3eOeJraHhUlEh0Q632+pLbZlFoIfJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 18:14:19 +0000
Received: from BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::a4e4:56cf:a5fd:84b4]) by BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::a4e4:56cf:a5fd:84b4%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 18:14:19 +0000
Message-ID: <eb851a8c-73ee-4828-a0e3-2a021d56ad2b@amd.com>
Date: Tue, 29 Oct 2024 13:14:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] MCE wrapper and support for new SMCA syndrome MSRs
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, qiuxu.zhuo@intel.com,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org,
 mchehab@kernel.org, yazen.ghannam@amd.com, john.allen@amd.com,
 linux-trace-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>,
 x86@kernel.org, linux-edac@vger.kernel.org
References: <20241022194158.110073-1-avadhut.naik@amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241022194158.110073-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:806:27::14) To BL1PR12MB5378.namprd12.prod.outlook.com
 (2603:10b6:208:31d::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: cffc6201-8917-4a6e-0d19-08dcf845818b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZiUHBxK21ZdlpOVDZRWUhWL0NGSHpoUS9pc0NZb2F5dVd0d1ExSkw5YVVz?=
 =?utf-8?B?R0ZuVzArV0Z4YXBSQkZVSkdNSWRqdjVKV3ZMdktNWmlkeVJ4anVzZ1FoUmJn?=
 =?utf-8?B?M1BtUldqY21JMXY2T0pDSU5hay85bWlick0yRWM3NVZzakVGdHA5bzdrck1l?=
 =?utf-8?B?dEtGMkJKb1dVMUhOZE0xT2NDZ2FaV1lBaTZEd3JPbmRnaEtzaVMxY3NEQ1FE?=
 =?utf-8?B?S3lSZElWUGxjTGRSbUJpUUwydE1NbmR0UGRaWGVjM2lRZk51RkJoU3hlSWFt?=
 =?utf-8?B?V3VTV2JEa29Ga3hDVm8wUm5LdXlsSlhDRy9FdXJ1OE5EUmlvdkZBMW9sUXBN?=
 =?utf-8?B?a1dGYk03V1pGbk9pUkN3VG1kd2pLT2t1aTBVNHlMNGdzcE9nMDVBSG5sU0gy?=
 =?utf-8?B?OUMza2NJdWw2VzUvZ2NrV0d1UGlnNGg5ZURLM2dUTkMvb3ZJK0pCbll4QmIv?=
 =?utf-8?B?S05PK3lpSGhab1Y2cC9qRGZWZ1IwZDRIU25qQUZhcGY0UDhTS215WUdSREt3?=
 =?utf-8?B?SFFVa3ZESG50WjdjUTFmQmVOeDNNRlhVcFhWalZrUU96SVdhc29TYnJtQmsw?=
 =?utf-8?B?MEFsMEpUU0ZHYTR0Z3dWL3dSVmVKZzh3SjNvdEhKRkJIeldmSklzM1pmTDdD?=
 =?utf-8?B?RWJmNUFMb0lBU0s0Tk1tZUFwMEpuS3luMUltcXVHZzBHRjFmb3VHbEJIR1lQ?=
 =?utf-8?B?dGJtYzBpRlhxS0VtNEZuRlVmdy83aVVsUm53NDNKSDA4YklPOGRwazUwbWgv?=
 =?utf-8?B?eXRqcSt4WldmWFJNeUxxbVZtVHdHR3RlSFZqYitLT3d3U2JzTHowK3ByMHVp?=
 =?utf-8?B?bURzWUR4U3VudFBuSW1FMWhHYWVDaWFnZWN6Q0sxaEFlSmNLT25ZTkthUzEw?=
 =?utf-8?B?U2JLMzcrbk1uQ3ZWNWduRmxINDlXK1hxTzhZVjYxTHB5K3RqTnE4YXJsMDNY?=
 =?utf-8?B?Ny8xeXdKT1c2UlR1ckJ0MFF2RGVLNzNuSXhWMHJlVWpURkNLQm4xR3U2ejVm?=
 =?utf-8?B?SGh5N1lwZE5XMTFrUDFPaXZBN1MrOFFOS0dILzRIVGFnQkx1UkV1Q0pROTk2?=
 =?utf-8?B?bDE4T3R4YkMzQTNGdnJ4QkY3ZVRtUEhqajNOdTdCOUhEQlJMa0NMZUgxVW5P?=
 =?utf-8?B?Z1JEeVdOaUIvZEExSTZNMmd4MlVHRlEvWlV0eEJMSjNlSEpVT2U5N2RQVHpu?=
 =?utf-8?B?Snltd1FqSmdFRm5rVmxlNVQwQ042VHhPbGtjZ0M2My9ndEFjRklIamFKVkRB?=
 =?utf-8?B?eGxUcjJTVE1kYzN4U2hYYnU2SkdDMUFlV3Iwd0Z3T3F6SzM5bDhwWjNOZHFr?=
 =?utf-8?B?d3pJcWN6TlgvbjA3Qy9WVWh2QmhJK2VpUVJhQXFBYmkvYVNydkpHWG1xSHp4?=
 =?utf-8?B?d29yZlY2UVJRTjM1QjFoWlpmMUxLWnpsWWpTYmtTRlRCTmZoR2tpcmJtdHFI?=
 =?utf-8?B?OEhka0swcThmUkJtcGNzOXRBV3d3L0YzQlhUU2ZoN0FBSVR0dTJvSTVJVWhH?=
 =?utf-8?B?ZldYOHhHR2xtbFhwb3dIemxDaXl0ZzhLN3dtU0huWi9WZnd5cHBJMEs0ZXI1?=
 =?utf-8?B?MjFSb05qMkE3bXRjMWZmc1dEdC9HQVgrMWljOUdCdlExV3A3a3ErbkRpNmgy?=
 =?utf-8?B?QmZBZkdRYlFXanRiRWlXRGt0RGlWd1FHaWJZOFhwTDB3UHV5Z3ErN3RvVnVO?=
 =?utf-8?B?a3Y0ODgxZm12dldaY0cvalczeGRLTHEyRk9HRFZMQkhTQmQ4STl0SjZrbnFu?=
 =?utf-8?Q?qHMp0B6M0C/5aXKrkFWbmJDmyAxgqilkPgIO3YI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5378.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEhxMnRFdk1IMmNONklBVE9wZC9vWUM5TDFMekRkSnBDeDlMY2NDNXRsSlBm?=
 =?utf-8?B?UnBWekxTQjJXUUw0K2pNUUgzZTJoVXdsZ1NDNXhQckdrd1BHc0ZGTm91REFn?=
 =?utf-8?B?VVZlRWxjdjNDeXhiRnl3MGw3NmNjMVhzRUg0RWNlN1AvNkpjOXJONU1vUXFL?=
 =?utf-8?B?WnM5WjNZeUZZS291ODVPOUgvVEZlRGtQZ0pjZHV1WXJSWnRCUkZOY3plT1Rz?=
 =?utf-8?B?L1FPRXU3MmJZOUF4M0U4b0ZycXZZTWs3ektSS0MrWGd6TmlJNXcwaVlIR01w?=
 =?utf-8?B?NTFXYUZ3ZXplR3Q5VzgxakhxbzM2dWRWRitHMFFqMEwyamdkT2J2eWhXREsw?=
 =?utf-8?B?dms3L25nQlpPOXpwMngrcGErV2NDVzFZQXhQcFJUODVCVm1La1Nhc0FtMFFS?=
 =?utf-8?B?ZExFTmwxMHE4TElmQWs5Mzlsa2pFT3lHalhlMDFtWlVDa0szNFlMZHlMMVNt?=
 =?utf-8?B?d2ZRMStqTUtOM3ZlQ1kzRjU5VkZOYzBxZVNTWEdBbkhvTHFoWVNjYzNWSmZi?=
 =?utf-8?B?MStaSGZmc0d1ZUR3KzNPNkRML2tabG9TaVY0U3dGNnhYUkxieVd1MG1KNERu?=
 =?utf-8?B?TG5oQ0xnZTdWMFk2cVlQbkhBUHlCVk9KOGlKT1JubS9RaXpwcFpkOHJDYy9X?=
 =?utf-8?B?anREWk9jRHNNQk14dCtKYjVLV3hGbVpETGR2TVQyc2xNc3Zhck42ZVUzeVFt?=
 =?utf-8?B?c0hmQWpVODhBcThlNmpLSTFCT3VnYU5MUUNkZWMxYVhOZmV6aEt0U3Jkbkdq?=
 =?utf-8?B?NkZwOHdwVUlpWVpMclh1S3pwa3l0a1NKcjFSa1k1Y2VpUVg3VUp1Y0Rxc0gx?=
 =?utf-8?B?WGpOTHc2V1N0S0Y5S28xSDlldm9SaEo4ak5pNEhGUFZOQTJTVDMxS3F4VE5n?=
 =?utf-8?B?RDlLNFE1UGkwLzFFYW1ZVGRSbWFOMU9oWFFCSVp4OFZ0bnlCQVYyTE5IU2Rp?=
 =?utf-8?B?NnpQK2hmTTcvc3hvMEU2YmdpTlpsbjZlRFg2ZDZBYWhUQTBhaXVERjFiVDhW?=
 =?utf-8?B?LzhvMW5TZE1ucm8vYUVCWk82bDNjcEY4VlpKSnpWY2pBMVZpZG1PV1AwOTZ2?=
 =?utf-8?B?S1l3bUJhTHRQQ2RINWNqRTU3TWNjWW5tNGFZcUd0YnFrek5BdmtJU2Y1RlhB?=
 =?utf-8?B?YTdsdmlFSmN5ZDd1ak1qWEVDSWtSVXZucTZab0lRNEtBQU91SGc5QmZqamdk?=
 =?utf-8?B?VTNjMENHUTNUdkdRaGZ2N1A3UkNKMnVGOG93N1U2VDdoWUdqMHJQeHlrdnFs?=
 =?utf-8?B?bnpDNDhsQVIxOC9uTnJLdHZ3QUtGRGdQd2JXaWVoWVQrNEFRdVJ0RExKN2Jo?=
 =?utf-8?B?bzQvb1puejBvbURjakE1aVZvNE9wV0RxSHdxVWFHWUU5MUM3SXhkNjltTVM3?=
 =?utf-8?B?ZVgvU3FhelZTc09JZUFJU2dFNDNkd1FEL3RyMGZCNDNhN0NGWW1jQ01wSW5k?=
 =?utf-8?B?dWxSRWw1dVJBbTNJcVJUYVZXdU1xR1JpSE9BazBiKzMvK0tiSXlsSmJtbTBI?=
 =?utf-8?B?dEdFQ05TR1I1THhZeUNVSzFjenJTK3pSK3Voa3FnYW8zK1F5OEdQMDA0SkVK?=
 =?utf-8?B?eitMQjlWc1VvUW9BVDExM0RuSnBiaWRRT2ZReEhua216MFJmd2xnTEpTK1JY?=
 =?utf-8?B?V2VESkhaODhXMjdpVkVGRFBDaG1IUkZJVm1XS1VGSytWcUo1bmo3UlRXdnRw?=
 =?utf-8?B?WEVkbEwyZnJ4NGJhZjFacHJOczYzZG9FTWd3K2xJQ3kwcFNDYTlCcm12Q2lt?=
 =?utf-8?B?RTRlMklHcGRGZEpuMU9heVV1S0pTRW1iUmlseUk0YTJzbFd1UkRyS0VwS1Yv?=
 =?utf-8?B?djJyb1NvK2NWd3BmZWxYcDdQZ3N0TXgyU1hxQzhxbk1NWHRRMVRRbUNOWTRs?=
 =?utf-8?B?bk9uM3NIRXZOakhxWFAvSXQyaXJ0Tnc4RjJWWjNjalR4VDJwU21PaWRtZDht?=
 =?utf-8?B?UCtnMkpaRlVNdGp3RFpOd09xc1kxNGxad3IzSnBEa0xqRTROUWEyWExYZDRx?=
 =?utf-8?B?VVBRM3RRTkJmTEZ5N3Y1UWVGMktwcUkzZnNnektvZmIyQ2YvZUJwTHF6Mk5m?=
 =?utf-8?B?WWJjMis3KzhOYWwvWUtuN2NGcm9ibjlQZ1pTbFRybGN1aDNtT3pmNkVRbnpz?=
 =?utf-8?Q?zYaWNHwiMlOl5p507EoJ19F5n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc6201-8917-4a6e-0d19-08dcf845818b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5378.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:14:19.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO9yM6ukUNO1kJhDHSpBpqVcVXCO5Uld9m82zyD8zKqy99n8TZG1y7AEESD9UCDdFUR5nhpPqHHdVfcc1AAm3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

Hi,

Any further feedback on this set?
If not, can this please be considered for merging in?

On 10/22/2024 14:36, Avadhut Naik wrote:
> This patchset adds a new wrapper for struct mce to prevent its bloating
> and export vendor specific error information. Additionally, support is
> also introduced for two new "syndrome" MSRs used in newer AMD Scalable
> MCA (SMCA) systems. Also, a new "FRU Text in MCA" feature that uses these
> new "syndrome" MSRs has been addded.
[...]
> base-commit: d7ec15ce8bdc955ce383123c4f01ad0a8155fb90

-- 
Thanks,
Avadhut Naik

