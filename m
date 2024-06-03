Return-Path: <linux-edac+bounces-1168-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD998D8523
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95FCB26968
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E412F59B;
	Mon,  3 Jun 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkWSoOMb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78012CDAE;
	Mon,  3 Jun 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425255; cv=fail; b=FvMQn4cD+Ec4reXlCilPXYLeosss5xyX50/j1Y6eLI1oTiS14r1e1dr4kCMxvzHG+MWBKHucvE1lyR3PtzWdqQiNDuN1y9736/9OoRko9SXO1Ct7oowJfMUPTtAmvQiK7oLIMQfj5q8k/29JSKiOsOkza/Y7TpsnK5zVa/o5g5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425255; c=relaxed/simple;
	bh=wuBLl6bP1jOPfiOVh0CyAFz5Xv7wL2rMryqKeTc3l8E=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fx0aDNtcnXVtUwUpugY8ViEdRe/mnk1jr50T1f6EeQT6bVUO94DkgfdkWgAkx8Ibcl8mX1k/c07dFEobkAg/GA3c7kM39nKYeRjbsmqkov4nECU8Xp1y6A5BP3QNUV7Jqun9azlEZC2begL0NAacwU/cOJzwUUEwLvfzcShMNd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkWSoOMb; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5t2LfjQ7vDbi5/zzVh9chW/ip2FLnBKjHnkLcTPRY2dMwE57fOj6N6pptScd+yTdaHu3JWTooAu1solkS0iynNiPdPBW51VtvrnPStQldNY7vt8tJ2oFgD9+czaLAwQgCVqNCki1kWuWYrZTtk9APZrUfn4Gj2/H+HNVYOWoZveK3l1BU2brAhhP1Iz6Ny6/ewQdC8BodqCElLFMmrJjad5zw02kgayI6r++9ht0xIKABRBh3KH6KGyteIRbZVLcsA0C5iKnsnpS/GpSUqrA4qn38TfDWFFaOitEJsJp6J7SCRhkwPHEyACJxYnQbg4E+tOafFYLmZAIFVjRbtVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3oYdalYIyoIsui4OwqwAoO5BFkfACMef5yU1886xQQ=;
 b=HpMiz69pUqg3ycDuSC8Na+sC13bpyDPdvRq5TN7tL3+lc1Z8WjTgg6nHdKhN+KOlzfH3IseAlVbsa13yWPIJnQZ2PYVmhnk/gc20HnO1UW3XmWwYFobxOrJxbdSwFJwa7W0CntuZfTeLQf+1f2m7OJdWFP1rCzbYace7a56pnzmjFtB89d1QlTri2OWSx/kAF0r1AWBgFDN1o8OFFfj1uGxPYzBpwEh40xjTZ2HWn9/fI7SLnDvsdiyylZBdCf6HUIH0A/nWomMJ7nV5rR+0Q7MWxLY5OZ9eFQmIujseEqikIz8NPuto+EzR/isiY5JTgvcFErTcAln66LPBFBEbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3oYdalYIyoIsui4OwqwAoO5BFkfACMef5yU1886xQQ=;
 b=zkWSoOMbuK0HYW7aGcf4cLpf4MFUqvIEHlviMD7e9s5c4yuq8OO/BjVrT+c4AorDwSjlo8ieNBp/A5zHGoDkrGJrqlFZaTe6VDBF31shgsoow1tlMtQX4LbWIsvJrwUO2fs+XsyLoPBopktW/NdK+igDo0k5Log89RpZNWa0gQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 14:34:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:34:11 +0000
Message-ID: <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>
Date: Mon, 3 Jun 2024 10:34:10 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
To: Borislav Petkov <bp@alien8.de>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
 <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:408:ee::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: c9817726-7d34-4fed-c5ef-08dc83da3bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVU5TDdUREV1YUU0dmVRYWNhMnRSVkE0aHpIcllaNHFQd0VuYytGb2owV29H?=
 =?utf-8?B?bDJXN2NNeWpLazNDQmQ0cXpxOEsxbmlNSFBmcTZhUG5BdXJPSjF0bjJxNm9J?=
 =?utf-8?B?UGs4VVVSYVdYYXdNRUVSVEVQZE1JaHIzSXZIL0tFdWw4YWlIcDgybVdFa0Fa?=
 =?utf-8?B?RHg0M1J1ZjNUYm1OWjZsSzNwSFA0UWZZUU1BdnpJV1Z2czR0aEpSQ2c4Ym9r?=
 =?utf-8?B?bFRScGYrd0h2bHhvTGVKUGFHbXFnMUNkR2IrbVFPWFdZdktGN1d5T21SN0x5?=
 =?utf-8?B?SDV1QUpCRmNISndGUk5MNThlWmIreU1hMkRrenhBVVo5U1NkaXBMUlNFRE5Z?=
 =?utf-8?B?eWhCRUJUaDZ5SkRuS0trMVlKalR0MENPVGRxN3dMS0NNSFdFR2VqSFBpL3Zh?=
 =?utf-8?B?TUpNSXZMS1FCRFg4VC9YTUhiR2laNGlvZHBRU0VFaTVyN3JQalVzbEMrdjFN?=
 =?utf-8?B?VUFza0dIVnZZZS96TFZnb3NLb3lsUm5EL0RMdjZIeEVreUE3VnpONURVdWtB?=
 =?utf-8?B?eW9UdXpMWHU2YjVXNkJnNEdmcFJKeHVrK2hoZHczalJMZFBZMkpKdnMwSjZw?=
 =?utf-8?B?ZDJyN1U5QVFnRnFRaTBoWjNRQTNnZk5HU2RjWVJSQ0ZubDg2WmR6TjhxdUJu?=
 =?utf-8?B?ZFJZbzJLWnAwRFN1UkpaWTZwVGpBR2lYWHJENHhRRm5GQjZ2eHptei9pN3or?=
 =?utf-8?B?emxWOGtvRFI4VlFnRU9lblk0M0FsMW9XenN5a1RWWTJ6VTlhMEhDK0Y2VEcr?=
 =?utf-8?B?ZnZkVkdsV1JOSXhON0pweCs4QzRqTmoyY1FmNk9lbHZJMEJ6VFNUNVBvUFRi?=
 =?utf-8?B?b213N1dVTzY1Q2FRWjRIeS9Fc0hUMUhEU1dacTlTYjN1ZnZOaWxrSnA3Zm5J?=
 =?utf-8?B?U001S052ck9VcHlPRjFBYjNrQm8xYlFmd3lySFZNVlZ4U3NWS1hSbDZzclhk?=
 =?utf-8?B?UGh0cEFlYXAwV2FrMG1xWmI0SjBXdVRLdks5Z2pPRlZYUmpKbkRxYTRqN3V1?=
 =?utf-8?B?SWJMeTJKaXVDU3AyV1pJSkJmamJrUGxWZnNJY3BpWThvSVdsenRZVTgyNXRC?=
 =?utf-8?B?OUVBYnVoRTd0TjNoaVFjZGd3d2FKNVU3OVJzaEFNY1FBSVJUTmdRWEFMY0VN?=
 =?utf-8?B?ZytDaFg3eG9rNHV2dGdKTE83cHVUVU9NRmdtZFUrSzFqT09ma0gyU3pGZ0FD?=
 =?utf-8?B?a0pQVE5adm5OcmFwWkc1TzJ3dVZiMUsrcVZWSEhuaytNcFNEQ0Jha0w4OWpo?=
 =?utf-8?B?UFUybS9kVURQcGxXdjhVeDFrNmZyNk41aEIxQWpXRXlhL0t3cVpENE1tZHNj?=
 =?utf-8?B?Q0FVZ3VMWlJGMzU0MURNZkR6Q0kzUGgwVlJTRWNBWmpYN3YwYUtWbXN6UUxn?=
 =?utf-8?B?MDB4cWprZVdYNnd3MnBSeEM5b21XWGNwbTErZTQ2cHY4RW5uYUdkdXJQQU53?=
 =?utf-8?B?UTBSZHpoVFh1ZEsvL05OazdvV0YvZnZvUFJIaEgvNFlFT3pGZ2JWU3NiM2hi?=
 =?utf-8?B?aERwVTlNRkgxL3Z6d3pUcWZ1SnNuOWhzeUQ4VEJXM1V4L3JHZmhLWVl3RGla?=
 =?utf-8?B?MEFVdjZwcHo4SnBHY3BQYi9mUzNTNjdFa2thR2NyWHJxRU8yTDdNR0M2ZkJW?=
 =?utf-8?B?L2Fqa0l4dHVlZUlzTml5VHRzd1hacis1LzI1NXMrNngvQUNTdTZSeTNSOVcz?=
 =?utf-8?B?dldjNyt6K3NuYkJoUlVVWVRDTmxQRlk3b3lqWCtXOC9GUDhyd2FNbTNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRQbG1GUVgrZkFQRjBJeWNmSnRKazZZQUhUVmNqWFBQcXF0NmhSMXZZNkxw?=
 =?utf-8?B?L1c5Y3pkcEhuRFJnSll3UFlDdzdDMElDaEVMazl6end5SFdrck1seFRXL1Rk?=
 =?utf-8?B?UDhpenh0bThLZXNBNElTaGNDY3l6emc3TzZTekRRdkR2VTcycnBSV3RCcW5V?=
 =?utf-8?B?VmRaNTM0ekF0WW9Pd3Y1YzhXRkxLaFdhWWtQYTNkdXRmYlovbWpMWmpwY2cv?=
 =?utf-8?B?U2JRUlhGcGJsaVNIbmVzTlpkZjRCNTZCbHY0TS9sVXp2a08yTDVYdzl3Vk95?=
 =?utf-8?B?dDYya1NmM0hLSFFhUUxNbFR2VnJFTXNVaWh4T3BZOFVFcU5NdWFoSitvMlN4?=
 =?utf-8?B?R21WbHZqOXE1b09ZL0ZiNTdxclpoSld6VHR1M2lzeTNBbDVOM2hsRmRDeXNW?=
 =?utf-8?B?WitGUkk3Vmo5QXp3dFJadXpFZmE5NElHVWJWd0RISGEybi82VjJJVjdzcSti?=
 =?utf-8?B?bGczZU1oTzl5azlLSExvV1l4c0xldlNYcVNlc0RNUHg1ZXJ5Y1hqaE56djI4?=
 =?utf-8?B?bVJjajFQbnZWcG5BT0lRdGdYUUN5c05hNU9Sbm0rQ29Cb05CZVluVlg2TFl5?=
 =?utf-8?B?LzY0bXR2ZW9UZ2tXVWJkanh6YThlZFRBbG53K1NRUjllcE1nbCsxMXFRV2dl?=
 =?utf-8?B?dVROQkd3R2ovK29qUjhDL3FBUExyZ1g4NnlHSkZUalhBbXpLanV0U2oyby9i?=
 =?utf-8?B?Y25NQ25yRXcwdHRoUnlFZkxLaDlDQjN4Z2ppKzlCNFR3ZThTR25TNGNBbXJa?=
 =?utf-8?B?V01GRW5SNnM2ZFFXNTZHOE1BSm92Q3I0WTNVcFphMGo2VXVXTnhPTUFiRkZ2?=
 =?utf-8?B?d0ZjYzRBVWN0cy9BWWt3b3dPTzg5enUrVlNoMFlRRlVXSnNqNUtJc3RFalht?=
 =?utf-8?B?S1U0dzZrMjJNdk5vM0drNGZXbit1Q0tDdzF2alI1anJOejhIL0Z6c2NxQmFV?=
 =?utf-8?B?Z3BSTTRkQmVTenhLa051UUsxVFdlRzc1QzJuQUpOUVdsNUF3NGNraUQrRkhL?=
 =?utf-8?B?VG9DbkIxNGVHVDJhOXA2ajkxS2k5KzIzOVV3SHprWEZlOW1NRkdqbEpWUzZ5?=
 =?utf-8?B?WXU4VzdWbjcyQ2YrRk0zaUtISGdyZlRjNXg3bmZNTlFCVFpzSFZyZWVLZlp4?=
 =?utf-8?B?WHpvNDFxZWp2bDJKMG5DdmJGVXRQTGpDYWFNME0yZXo0bFdQaUJMbzRQS3J1?=
 =?utf-8?B?N1dVUGtodHF0cGRuVlVkL1IzamtMM0dOdWhlc3Vzbzd2VDE2RzhHVTZSWlQ3?=
 =?utf-8?B?VklPd1JTaHFpSDV3OFhWVGJhejFESEZ0OXlvcmc5SnUxR00wMWFBb3kyQ2JV?=
 =?utf-8?B?Qm12UmJheHJPQnNTd29hZC9hQnZYWTJHVDc2K1hBeGlYVWpGSS9YSEM3TUMx?=
 =?utf-8?B?dkQvSlh6a2NENFdZVndWdUxmSEhvSnhoU043azdiamlnK0hyQmpWMzhjTFZX?=
 =?utf-8?B?QnAvYW1Ubm1xRlZJQ1FWT2hRbGp3VUJnYndCSE9wa0FLOWhhdmVLRHVGUFBL?=
 =?utf-8?B?VFJ2d0VwbStYU2pCeStidzFTYU1Jam5JczJkZzBPb1V1ekcwakNlZDZXNDg0?=
 =?utf-8?B?QXhldFRjdWU2QTZMVGF4QTdoZDNRU3RNdVdSWlBKZkwwUkpXRWlUenJJQ3Zj?=
 =?utf-8?B?Z055d0R5Q05xQVNZWGo1YmUwa1VLREFJV1ZFRWlDQXQreDFZbUJiY1RiSDRR?=
 =?utf-8?B?VEF6UlZTNWwxZi9yRTNUQmVWTjFsd2hpcXg4M3FzKys3aGFHMWdCaFFBbXc4?=
 =?utf-8?B?T3drRjdWbWhIUU1yNTY3clpuRnJlRVFZQVIxeDJDSTFWQ28vME1td0xYSGht?=
 =?utf-8?B?VFVEWVZhSG0xYzNKYkFRUG9Tei9TWGR2RXZjTFh6dEpEZFA4N2I4RUZiY0c4?=
 =?utf-8?B?TXUvSk5JblVScERBWmhoeTBHc0VBQ21qVUMrNDlQVVBlZzIwQU9WWGdCMVdR?=
 =?utf-8?B?dmhkWEYzNlBNYklsdmI4VmhEOENWL3A5cVF2bnFrbVk5b292NFNvL2poSE9j?=
 =?utf-8?B?QmFMRWNkWGRTdUV3WWY0SnEzUlFkQlU3emRKUEhqVU43enpFK3Q5d1U1d2li?=
 =?utf-8?B?NmxXeEhtU25JR0U2R1V1V0xXWi8rcnR3WDBKS2RUVEFCRUtQNHp5dHRWWUFn?=
 =?utf-8?Q?sC6ivpX68/GsjNvEfsWtXxeo+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9817726-7d34-4fed-c5ef-08dc83da3bdc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:34:11.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPeoVCzGoNcM85LgcjD3XVHO9O5g5x2FDZLx9FdlEuS+uYIaq/WVTwDz4keauhQbzpewUodoKd2wtAFjEusaTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

On 5/29/24 1:28 PM, Borislav Petkov wrote:
> On Tue, May 21, 2024 at 07:54:34AM -0500, Yazen Ghannam wrote:
>> Current AMD systems can report MCA errors using the ACPI Boot Error
>> Record Table (BERT). The BERT entries for MCA errors will be an x86
>> Common Platform Error Record (CPER) with an MSR register context that
>> matches the MCAX/SMCA register space.
>>
>> However, the BERT will not necessarily be processed on the CPU that
>> reported the MCA errors. Therefore, the correct CPU number needs to be
>> determined and the information saved in struct mce.
>>
>> The CPU number is determined by searching all possible CPUs for a Local
>> APIC ID matching the value in the x86 CPER.
> 
> You're explaining the code again. :)
> 

One day I'll break this habit. Thanks again for the reminder. :)

>>  	for_each_possible_cpu(cpu) {
>> -		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
>> -			m.extcpu = cpu;
>> -			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
>> +		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
>>  			break;
>> -		}
>>  	}
>>  
>> -	m.apicid = lapic_id;
>> +	if (!cpu_possible(cpu))
>> +		return -EINVAL;
> 
> What's that test for? You just iterated over the possible CPUs using
> "cpu" as the iterator there...
> 

This is to catch the case where there was no break from the loop.

If there is no match during the iterator, then "cpu" will be equal to
nr_cpu_ids.

I wanted to use a helper that goes with with the iterator rather than
checking against nr_cpu_ids directly.

Thanks,
Yazen

