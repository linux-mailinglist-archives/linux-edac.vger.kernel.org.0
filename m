Return-Path: <linux-edac+bounces-1607-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2879453E7
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 23:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED7E281E8D
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 21:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2905814A4E5;
	Thu,  1 Aug 2024 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pupNRO+m"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662B1EB4AF;
	Thu,  1 Aug 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546128; cv=fail; b=cWYNvcGT+3ImE6PecUCbjkBKq5fvQ6v/dxUpXT8AMb8unFOLiCjObDdcb/Xeib9u4yC4g6YZjJwFgYjGXmdwdE09bapd75p6M8NKDciDDfVj+z0M6Q/2jAtaC7oTFK4VuA7n4a6SEkcQqQZDtKznXsZZA5v8dJ1tS+VFMhA9WnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546128; c=relaxed/simple;
	bh=p2Unhe8vWJZTLg/2ebN98wzeXPXrIh6Jxla547FmkwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+EHTtcT8qTaS8lDmlvBzmFehw4xFCnCzyoyWsckdtgsCIWUKoAvc5ybRdVrqPsbujzLYtWo4/gP++qJv8RqzQp4HETDmFoE15QiHbz47O2rnh0S4QJhZgSiqTMVvW8OngwFN4j2XYLmC6g6nspryjRupQ1TlDXhjf0mdBECU9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pupNRO+m; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9W4oBYvsc5cSk5hxymmll3H0tfAOn8bbcMMxotcAU+p2lnpbLdQYWjY7ieufB0/X/QW/QKX87tbu0+dS08HXKF+Dd5mbypZEaBxKfCvTeORbPK8VqAlJsXsXowOxzVRFQ2i2QpR9DfrpEDxSuYAsoCX1uEA673p/BNRXgqxElZuEIy0exQ031bCLX3zTCJy77+4ThMXgznZ6Y7j92ZMXw+3QIrkj6rrX39wSDWlMfBgOOJb+ucxqEdP2rKyxNj7MOSImrBx5KCZI+gWQ59oTVHj/NT+oCwuCH02Be2ASJGiVTe2DVcK8q1+OVJmv9dZoaJyZZKdbVjc/50OOJLPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVMPX1WYrFbKTBwdY6NJmCAtUfZajC2vIdic6ZI+0J8=;
 b=JxgtKFYA7hVs7R313Z3KxsTViaravT+/07/4GMb1nBP8KXGe9Eav1zZdYJo2J7W2aNX9/31zgmBpobha4dD6NK/Oo9ZNFW7TALUI0SwNCDjM+/SiePrJ9Qi8irQZ/OcIPZhG8Viia6I6L+jbXdMauUOQXNkqE5ZEUPYPZvvKQ8SrF1igYetpPVUMdPUeC+cC+ULymlOV0+A84Z4M6qRnPI/YRUgr+9L4Zq4RgLOOmM8rRUAIL8/LIu/WpVDQjwnxb9exfufu6gvihoAFaMwDhYS35B0hBWkw/CUPjIAWmrUTsIcTUeKpgM63yjF/od1ET1ly3YU/RuQXemDONUqGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVMPX1WYrFbKTBwdY6NJmCAtUfZajC2vIdic6ZI+0J8=;
 b=pupNRO+myTCYXIiMRSaOCMS3LV9ej4lFxyQMfFE2e3Q5pjCcnSzUSTlJ/JDLPb+Q9/2by/52sV6Reg/uA54X17zJK37Zk3/R9cvWzPlBNPribHFN3iqfLWl2RJqQnoa96Sy7+uM0B9hz9w9QXy5Ckm4h/c3dZADvym+msAVzKPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 21:02:03 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 21:02:03 +0000
Message-ID: <80c5bfdf-e255-48ac-a185-6b8172710c3e@amd.com>
Date: Thu, 1 Aug 2024 16:02:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Rework mce_setup()
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com
References: <20240730182958.4117158-1-yazen.ghannam@amd.com>
Content-Language: en-US
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20240730182958.4117158-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9bee23-ee56-42fa-b0d7-08dcb26d3184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlBwekZpbVhxUWpieDUyNDNad0NXSmRyN3FLNTVFeC9jam84aXRBT0Vib1FM?=
 =?utf-8?B?ZnJjZVZqZjJwRW5IQm9rckptbzNNMXJjcHBRMVE4U0FJY3FLM2NmNVJGbVJq?=
 =?utf-8?B?a3VuMFlUYTV4TkpQS3ZkMEFYeHJxVTdVd1VLWUtOS25Gckw5K0kzalgvb0s0?=
 =?utf-8?B?UWkwOVRsY1JISy9SNm1SaUFKYWhYMnRVYnppMjJKVXVLbjlLaXJqNkR6MUxG?=
 =?utf-8?B?eFowaWtaTm5pMUxtMGpvcVU3cGNtRmE5bk9IOUZaUDgrTmoyeDR2M3k3SnZJ?=
 =?utf-8?B?Vnc5VWVmRzJLbWU4N3hQZFErY0VqRHd2TEI2OVZ5SUl1bkVRczkycURGay90?=
 =?utf-8?B?Q25LSmVIQ1l2N2ZLeWxpN0loZ1krRGZtaTgyQTBBendueklBNmJEYUFKZFpE?=
 =?utf-8?B?eWwxK1g5azlEZmxYSFB1TnREVlNqRHhpV0xmMHJtUURvdGdIMjNaU3JiR3ZK?=
 =?utf-8?B?WFNGQzd3WHIwWmRJQmZNaFdUeVN1U3k2Wnc4K1A3c2VxZjBzcEVmOXJRejA1?=
 =?utf-8?B?WEZjbVEyeTM0dVNQNXpNRXZDcnF2c205WE0rNmttNVQ2Z3lUUkdYa3BhWGMy?=
 =?utf-8?B?TnN6elBiSHl2Wkgzem1jUjh1RW5DVG1wRVhWMGxReEVHSTFMNGlqYVBGT2Zw?=
 =?utf-8?B?RzJQb2RFUCtCdHJ1TlFpMzdwVHB3MUJIYUswU0tEUjh1YTBWdzZrQ3lYUzZ3?=
 =?utf-8?B?NHgvdmtkVW52b0R6QklmYUlSbmorb2lVcG1OZmtmNXZlNWhEYlN1VzNyd2hV?=
 =?utf-8?B?ck5hYUdtOC90SWtiUGx5Smd0M0UvcnFaRFI0NWtDMTlrOTFMMXBaampqck5k?=
 =?utf-8?B?Y1VpRGszOUE1eDdvY255V0FOQU1qdU84TThhajV3WXVDYzRwN1VoVjM1NVZr?=
 =?utf-8?B?YUtrVHY1MC9rRHAxMDhPQWxYOGNSUXZ2VmVVbEwwL0ZNSEVKY2RiY1Fnbkgz?=
 =?utf-8?B?QzN0Sk83SGlURXVEQU9aK2Z6bk5tcjRXWFhDb0JDQzcvR0JkRCsrTFFGM1hv?=
 =?utf-8?B?NThOKytwUDA2VTNUT0hvWlNTV1YxVjN3ZFdkQStxRUFVdWU0REw1NCt1TWhH?=
 =?utf-8?B?ZFdoWEp4a1ptL0ViNWY2K3ltcFBIT1N1K3huYVdMWHl2aG5YajRqN2NHV1RQ?=
 =?utf-8?B?WHpEMGxOVCtaS1hlY0cwWkU2ZXpjTzRJQ1lyTjdkQXlJeXZVdis2MFFha2E1?=
 =?utf-8?B?MXQxelJyM3FTUTZQcjFRN1lhejMwZ0Jzd3p5cE5rSHhvTDdwWUdXY2ZnT0t4?=
 =?utf-8?B?MEVHR3UrK3RzZjcrTVNvWmIrcmsvM3dOUU1LdlRmaDVzRHdXTkVkZXQxMitQ?=
 =?utf-8?B?cmU0YlNXQmN2WVczL3lPSmtiS1Zpem5QL21ZZEFzQ2RPQzJKL2xwWDZ3RzVF?=
 =?utf-8?B?OUZFcjNRMnQ0WTA0UHdlVlRmc1hFbHRWQzlWeHFnVVZNbWNaY2YwR3AwYU1j?=
 =?utf-8?B?MkZRV2NuWG9JM2h0ZllwWEVLb3hyN0hHdEdGZTF0UkFENCtxQ09PajM5OGJK?=
 =?utf-8?B?THl4MVRCRmpPTXBDUUR4dnk3dDJHaTN5bktCQWhldlFHMEFmR1krQzdrOEZl?=
 =?utf-8?B?SWRSSHVFYWtVZG11ZmxsK2lPM0VWZko5cExycU53V1JiTTVjY1ljanVaZ2dN?=
 =?utf-8?B?NnJqaHpURmR0aHpiSWlhamxIblNpOW5xVjQxeEVEZUtwenprUG9nMlhjMit0?=
 =?utf-8?B?VThmbGdjVk5ONCtqYUdLVFJocTFNREMxYVZOWFI3cGplaC95ZzNnWFZOUDlG?=
 =?utf-8?Q?Z/+YAQDp2zpgT8QoUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2Z6V21kNzNzYS9BY2ZzQ3M4a252NlFiQVZMMEVLamZpMTZVUkVwc3FpN1k0?=
 =?utf-8?B?VUJFWHdXaXZRUGZWUTU0QldleFRZN3RHcGU5TDJMYzZ6UExlUlREek03cEVZ?=
 =?utf-8?B?K0l1V240dDcrZmhLQXRzaTBsOElRSFFqZ1czM0c3azdIT1dVbTlLYnBRUE52?=
 =?utf-8?B?TVZhdURMWGNuRUxrMFM0ZFY0QnBUeEF1K055S2FqdjZnQk9ZelZwWjVNUHkw?=
 =?utf-8?B?QU9vd3BvQS85UzJlNWtJOWxFcEZINm9RMGpBazBOWW9tdEI3eEZLV1ZHNjdw?=
 =?utf-8?B?MGpxYzdWYkIxdW80SHBRc3N2bFBoU3AxbWliajM1eDdZczJOODFOejZPbnNo?=
 =?utf-8?B?WmxlY29IVkYvSHkxd3JtVG82dHVSQVVyS3Q3ZlJZUDBhVUdOVVVwMnZXUHRp?=
 =?utf-8?B?MkluelZETk5wWnMxMmJhY3FiblI1NTdmbDJJdlNUK3ErNHpoSUlZcFl4aUVC?=
 =?utf-8?B?TjVpMUdsS3g5Zm1RWDBYblFaTm1vZkRIbDN1djdLMFRVTzV1Y09zT2ZnS1h4?=
 =?utf-8?B?MWc2VjR5S09WSzRnOE0xVmg3RFErQXFyY3htWXc5N0VWcXBuUzVPVUNDYk1a?=
 =?utf-8?B?cnBHY1V6KzZPS1kyaVlpcmNoSzFHWGM3SG95RDIvUlplallhT3dMTzZoL1U3?=
 =?utf-8?B?Mk0ybnRzVXNLNldZdk5kRVc0V2R2REZiSzJIYklKclgxSzQxZWdoSTJTK0lo?=
 =?utf-8?B?ekNSYUV2T0ZpOGdXRGoxV3g4djZzNmF5cW9NZVVKeGZyb0FyNjlubXV5WmZG?=
 =?utf-8?B?dndnb2dNdklDd09nUXkxaklJbXJ3aEoyVDVaRC9LVjdlWlIzb0J4dnVDUEhI?=
 =?utf-8?B?VmxaTEU1ZGgrM3RrZ0FNREk0czNMVWtXalpVaEphOEdDbXoySVNvSW1jTk92?=
 =?utf-8?B?a2lyOWo4TGZmOVF1VjJUVSs3NUR6Z0szWUU5ZWswVGFaV0VFMmlla05sSkRx?=
 =?utf-8?B?aENMUExhMTBvK0pMa3JMZWhhVU5Mb0pKdmJCdEVHYjVXQURXaW9nQmtWa3VL?=
 =?utf-8?B?Q2tISEZ3SWorSVZmZ1d4TkZKWVRzNS9VOTNXem1pSXMrbDFlSHNla09lRE8y?=
 =?utf-8?B?cDdtWmd2eUNzWWlQTHV2OHhFSFhhUk9PMTUwU2JKSnJTYVArbWJvbXhkSGhq?=
 =?utf-8?B?c2tLcmZ5TVRQdmIvdlNTVWNTL2U4aEZvdlcxZUxaV0V5dVcrQjZuSDVCMmFY?=
 =?utf-8?B?bFlNYS85MVh5R2VGSWQ1RkhYUTNmNFZyaVQzUUlxb2NIVWFudDdVRkhGVlRl?=
 =?utf-8?B?TWd4TUxnS09WcExyVXpsYm8vSklrV09yOFA4cEpuN3N0OENjb0k1UXJKVEEz?=
 =?utf-8?B?NmVHL3cxSUplYVl3Q2p1aFZzT2JBQnlNTERhWGdOa0N1Z000anhpQWJjSUZ4?=
 =?utf-8?B?akFhc1MwZEwzN216bTVSQ0FBaGlDRXFVcUwvTmtYdElaK2RXQXY1N0JoOXdt?=
 =?utf-8?B?bE9QUWtMTzJzQzB3ekh4VUwwWjN5Yk5ONDNWMmJ0c0ZsMlBlbTVjM1I4RWRV?=
 =?utf-8?B?TlYyajdRVmhIbnBIUVkrUGdJc054T1AzN0s0TkJaSXlYZDF1UExjekorWlNy?=
 =?utf-8?B?VXpqV3RFeE0vVXk1eS8yQnJQZ1dxZVo5amovZEpRREdpcXc3MytQL05QRlFF?=
 =?utf-8?B?dEsxcGpIVWR4SXl4Mm9PdnlKREdNbUhMRDNFZ3FudzYyeFVqQVo3QlVYbGU3?=
 =?utf-8?B?U25NOEUwbkR1ZVRQalNmZDlydmU4dmk0Z0FKVFNDR3l1dXJhVEFjRVBRYTNB?=
 =?utf-8?B?cmNZd0oxNmJEU3BCNzVpRGpEWlNvd2ZKTk9xKytzNy9rZGJWOUwvSnhXK2pk?=
 =?utf-8?B?T3Zpd0k5QUlnOXpNNkIvWTUyeGRvaXJBcm5Fc2ROc1VodXpkTmJzZzNzQTlq?=
 =?utf-8?B?N3hoZDZoS0M1V3ZDNnpvZDRWRXV3VWMwa2cvSGdYeWJOM2p2b0pzR25rSnJ3?=
 =?utf-8?B?L0hxU1EwRTRRSlFvY2ZBaXd4NHpTT21Ba3JlODlkQ2VJZkpVZlNlM0JRY2pS?=
 =?utf-8?B?ZFhkQjdiQlFTbjlpWlpzK1NSdEZSYnZ5dDhGUkJMbGhUVmIyVHVEYVdWb0oy?=
 =?utf-8?B?MmQvOUtlM1RGeFNzckwweTBvang4bCtDTnRveEY0M3lrUThpWGR5T253ZVQy?=
 =?utf-8?Q?YHkvPTFDjAN192xBVdll4pver?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9bee23-ee56-42fa-b0d7-08dcb26d3184
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:02:03.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGnOXGJKJD7X6+UiLKAXi9wkKZcpuQpc03kZMu7BPBr5BKrzqNUdD9p0j6q1Sfg0tdOzfEBvXyqgIVBxS0neXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703



On 7/30/24 13:29, Yazen Ghannam wrote:
> Hi all,
> 
> This revision drops the topology export idea from v2. It seemed to add
> more complexity than just doing a local search. 
> 
> Thanks,
> Yazen
> 
> Link:
> https://lkml.kernel.org/r/20240624212008.663832-1-yazen.ghannam@amd.com
> 
> Yazen Ghannam (3):
>   x86/mce: Rename mce_setup() to mce_prep_record()
>   x86/mce: Define mce_prep_record() helpers for common and per-CPU
>     fields
>   x86/mce: Use mce_prep_record() helpers for
>     apei_smca_report_x86_error()
> 
>  arch/x86/include/asm/mce.h         |  2 +-
>  arch/x86/kernel/cpu/mce/amd.c      |  2 +-
>  arch/x86/kernel/cpu/mce/apei.c     | 18 +++++++-------
>  arch/x86/kernel/cpu/mce/core.c     | 38 ++++++++++++++++++++----------
>  arch/x86/kernel/cpu/mce/internal.h |  2 ++
>  5 files changed, 38 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 1cd27e88888d54de5fefbeb0b44c26194ffa83ce

LGTM.

Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

-- 
Thanks,
Avadhut Naik


