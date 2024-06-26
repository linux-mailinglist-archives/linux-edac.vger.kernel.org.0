Return-Path: <linux-edac+bounces-1385-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C3918A17
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D47B21000
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E818FDC6;
	Wed, 26 Jun 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SYvpP/zl"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAC18FC63;
	Wed, 26 Jun 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422913; cv=fail; b=gVGZzkm19FzqOwvolat1cK6re9asV8My8kVPtDId5twy5sQEERFcKAl5OD5xPWhr6alb+siXMUYj//SK4blzodrKXhVZ9HcUsEifzXIBmNR1Zeg4+PmJpLQjTRKu09lcmuD48XTWCsuSLxWWKeSOF2pfEQVwZJpthf3aEzckVw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422913; c=relaxed/simple;
	bh=MACAx134DvZ2CeuqdSMMZT0UMKWWa75fOLywKFDIY/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MKhVfIfbcPdPEpOmouVElhgbVhQvxs/Vpm3e7ZGMvjeYixLHd9WkyFVH8xI6e2i08E+GlyUG1Axs6sJJFSWqSjXtBgvVHx2cIYYcBDvCNlbIRyt7MBk+aFDg/k3vv2dCdi+ndAeNv5MLFp+hqBlTFU4r82RFgi7PCRo0IPDFrzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SYvpP/zl; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4a+Z7ijmA3+akDYhU6sm5nwboM+Cv32v3cN+biEnmGBdraTdlWohcTb42Lbw1c3Q00BX0FiWQcmbdmgujxku/vFQX70Aha8vEf9dFOLwnSAMWIzVsrvcq/vOsh5Ox8YP/4YjyWlycmMLnzXnSw20V5w/jQUXdK60I1w2YMu48vBe8H1Mqwp4toZnYHvbmtl6OS8kFeGB5czIX+MV9Yp5cGz863dD4TC0uqx3CgVD+Er+4XxefGAowfY0y7ZmcN0MLNNQ9R22JFfRFfUTyPMajqFDiqefS2EZ29NSCvTF2/i0w1JXd3h7mLViu2rQov7HmRw04BIXrySCvpCwE5FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txTlFNmyJej8Ogg6PzKmdK8Ix6DdCgid3O5dP+OOabg=;
 b=LZELqckmdnMOBOojdiNXMi5tLvVikgw9IVdFP4ampqE34TBf4eyXClxA3ms0hFzvXW90b8dmloytBRUzhkK/lzvGf4gbAuc3eKJGZKwpi9+535JDOfn+keBcDnEZxmBWJaekrvnIz/Svd4b8kinVU91Yl+erUAAALYQcjYIvdyMoZc5DuTCa4sJwkLXhOJ6TjB5WzTXUjl/5yY0R/ZVuUaAD7l6/T2hkySHWPy7PVrWv3rhsJbIW6gx/G6lj5+TnfMrVA52kLZZcafhGqQ9pwjd6dVfQIDc2U9rvUu+NqIr1wpVKgZAw4TpDgL+wfb1iVhHvPxL0dZ/cXzWy8cki9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txTlFNmyJej8Ogg6PzKmdK8Ix6DdCgid3O5dP+OOabg=;
 b=SYvpP/zlr9uq3od3tFSkx8r+hU1IYpu2HTrpsooO0IOfiPw5TujjnvjuvLX/qszgDLRoRKXMzuBnyrmQNIFld3Lg5aaTo+ESAF8FEIsL090cHLBrYxnb2AOm2A/KqvM70REK+2q0+yewR/YjK8eMIxZEHFRDglGUB95IYrsrazk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 17:28:28 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:28:28 +0000
Message-ID: <63b6d952-f024-4ed2-baad-819325deb214@amd.com>
Date: Wed, 26 Jun 2024 12:28:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] x86/mce/apei: Handle variable register array size
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-4-avadhut.naik@amd.com>
 <20240626115641.GPZnwB-QEGYCoI_Fv3@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240626115641.GPZnwB-QEGYCoI_Fv3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ecc4a5-f593-4660-8474-08dc9605646a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3NRZEpaZ0ptUlZvU1N1cHY2eTJxUUxUOTludHkwd3haU3hRLy82Z1JGemln?=
 =?utf-8?B?WlhSZFliaTJOaFJicmJQdHFoMk5CamxlaHp0UmVPbWJKOTBpN05kRW9XQTBN?=
 =?utf-8?B?U2QvSHFVdzNJVUtNLy9WZGpkMkRKL3BQRjNFN1Q5OGZLWk5EUG1xN3U3UDRS?=
 =?utf-8?B?NlVqWHo1bTVDWlpNU2Fmc2JaMTNZT3A0cXBkRHdSRFBNQi9hVnVZTGd1V1dG?=
 =?utf-8?B?d3IvUGkvTS9GaHFPL0JFYXlYNG4zdlQ5bTNFUDRmZ2lYL0twN09BaTcwdEdQ?=
 =?utf-8?B?NFo5QnVSWG5TcURIRURnR1hvREVOVEVQNUVmdGgyaDdrcm9jWWN6WlNzUEZm?=
 =?utf-8?B?M2RVMVNSU1JWTTkzNzB5cXRIUkptVTJ6SHd5TUZva084dDZUOWk5OGQybmRG?=
 =?utf-8?B?Tkd5Zk1xeVdvSTViQzU5WW9BMHg0RmM3UFM1a0RBM3lxeHBEblZ2dHQ3di9n?=
 =?utf-8?B?Qi93QUZISmZsU3lvV25NNXJNNU5PbnMvNVFucmcvZ3YyM1paUFVxS2RnVGpP?=
 =?utf-8?B?ZTJxVG1WR2JBTlJKNTRWaUQvc2hReGdnY0o4NCtKRk4vYjZXV2s2dnNCTnNv?=
 =?utf-8?B?N0JlTjJXRUFFbmdXTTRiMEpTR0I1MUswYnUzQldUNE92bWtLcGh0cURZcnV2?=
 =?utf-8?B?WVZ2QjJ4VXdkakdQSWR3RlNDN1hoN0dCZlhib1ZER1R6SHBkUXBGbmR2bzVM?=
 =?utf-8?B?NEdvMG5NVHQ2ak5oR1dsQlNqb3F3S2gvamcva09WUytCQ2hXUUo5S2czK3gw?=
 =?utf-8?B?WHB2cmxQL2ZGWk9Fams0S01oR0x0USt1K0QvMm5OeklSY3kvVFFGOVU2VER6?=
 =?utf-8?B?eFIwdXpUWWszWVVlTzVtbURJMG9NclQwak5TY1hHL1JiRlJPcDZxZnhqVmhS?=
 =?utf-8?B?YWg5TWR1bjVoRjBoSkhybjV3YzViS2g4NkQvdmhxYWlMOU4veERpZ1o2cFlN?=
 =?utf-8?B?SGhydHdEOUwxR2Evb21KTGNRT3h6dGhLdFNjSVJGZVRzaGN5czAxaTZUaC9I?=
 =?utf-8?B?UEFNZEd3cWgwVktFM3d3SkRKZHNJckRKZkJFSThtbE9ITU4yOVBPTDhQSk93?=
 =?utf-8?B?ejl1dHlCNU9QZ3BwbXhLd0pmVUZKZVNiY2hlOE1oaHhya2F5K3EvWmVOVWxt?=
 =?utf-8?B?WVgzUkwvbDB5VlNudVRDbmxUSjVnbEFkMXh4Ny9DNE9tN0ZMS2Urb0lCTTcz?=
 =?utf-8?B?cnRqendmRFVPU0wzcUFPdlNPajZqaEt5cjQ5SVNzbkI2NVVyb2oyS3ZiV3Jz?=
 =?utf-8?B?TGY5VVIzTFJHV3A0Q3l1NnJPNUh0YTRpY2w0WGp5cVlCSjYwZjE4aTBqTVZM?=
 =?utf-8?B?YVFvYkdSRGZPK2E4aEhyZ0ZYVlJINlRTKzFwdjhITWxuZm55NVNmS2VONStW?=
 =?utf-8?B?YTFoeEdKT3UrVDFEbmthbDBRcGpxTHk3dW5XeHhCM01Hd2dHalc4Tzk0ZU5B?=
 =?utf-8?B?MXY5dXF4M0VZNGZKVmxxakVMc0ZjekxuS1Z6QUx2RHZHYTl4b0V2QldBRU40?=
 =?utf-8?B?dWFJRE1YNmRENitKZS82ZDRhU0xsdkR4ZkVTdi9nWjVwUFRiSFF1N0ZsVDc4?=
 =?utf-8?B?N014WDFRV3BKVUwxbDRNeHVGZXVYb3VVTFFmRU5sMVVaR0g3OVBlMWNIS0Zw?=
 =?utf-8?B?UDhqS0U0YTExWW9sK3ByV2pnOHgzQ25lUEwzU2ZLZ0daWGliaVdNYTlBWG5X?=
 =?utf-8?B?N29jWXBRVktzSGhWb1YwUHNucjlEeGhkN2V5M0NsWkFGMnJLTnlWQi9FNzMr?=
 =?utf-8?B?NTZuaVhycGZVeXY2U0tUN2luTWtvVktyaTJxV1UraFhhMkpWV290TW5JOC9I?=
 =?utf-8?B?dzI1ZFBQLy9hYnpFeVg5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklsbjFMczlCMjM0YUdTTkw0NUtxa3duS2pLbmdTY093eXRuV2FNMkZqQk51?=
 =?utf-8?B?OWpkeEJCeTI5Q0c3VWlUaDdFTDFOdnRObW9LSWFENW40UW9FaDI0MjhWYXUr?=
 =?utf-8?B?M0tLaXJva3FsVDRmbVgxcTZnd2RnV3hOOFk4KzJsWUNDS3pnNkZHemZXcVI1?=
 =?utf-8?B?Uyt2WlV3YlF6YWJxMG9pZXlrOGUxQ3BCdkh1OENQN2dsbWZFbWY0THlpSTJY?=
 =?utf-8?B?SSs2UnJad3poTGZPMXpBSURMcGVVaGE2a3lKS2duUDFnZ0hSazc1MURNRHFh?=
 =?utf-8?B?TnJ0eUpHZGRNNDJGMDZPRVlVWkpGc0J5N0RUaGUzMHIwVk1pQVl1eitLZWRQ?=
 =?utf-8?B?dzRsOWNDY1MweFc1TytVOFVJTnJFWnZJVHVVRVhLODdVZ2UxSWRyUjBESXVB?=
 =?utf-8?B?bnBIV1BGaHlWeXlNdkVBdXNKd2NnNklRSGF1eEN1RGRiRy9uQzFPckFFUGdW?=
 =?utf-8?B?eTRlakc1SDBKT2dBV3VHdDZvUWFiOUhzTUkyWjROQWZucnBLWnBDSHlwdnVR?=
 =?utf-8?B?S1ZTa01hVlJlUWhBU1A5REJjMHMrNDBrQ3NIZC9ycjkzK3AvZy9lVW9td0FL?=
 =?utf-8?B?aWtOSlVueng2TXlTSFIrbVp3dUYvZ001VWNyT2ZjbzdWZkxqczNWcWsxVWpm?=
 =?utf-8?B?NlpiV0M4dXJjRjRlMVQrQU8wY05maTNGM0F1YUdVdUpKWUNhN2hTTTJFTzZm?=
 =?utf-8?B?cU51Y2VsbnM4cjBuUFEyTmc0OFhHOHlBSVd4UERodjJ0R1NzVjd4M211U3Fj?=
 =?utf-8?B?blpTNnpXd2tFaFJXdkIzcFM1b3VOUzVFK0ZCd21oandmMWVqTks4RFNHSHN2?=
 =?utf-8?B?Y3hrR3U2OEZRL1lxa2kyUXNNSFNybDVaZDZOanNoSXNldHl2ckFPcHRUWGNL?=
 =?utf-8?B?d21pQUR1bmREVHMwSlNRM2tmYldUU3A3SVpjL3d6Zjgvc2s2cnArNFRtbmla?=
 =?utf-8?B?UVpWeUdZOFJWVklhckxzTVlGcDJsZ1FKZmc4ekk1Q2hJazRQNlJ1TnVScHNM?=
 =?utf-8?B?Vkk1V2Y3YXBGY1g4dmZkdnVxa1I5NmZZYllOd2M1SThNRW12STNqaVI2YWxV?=
 =?utf-8?B?QldYMVhwa0dvQzhYV0dUVGpPcVlRZTBSSTVPVlcvSWtmcldUU0FjcUZqb0pK?=
 =?utf-8?B?ellvMytINXFwTFRPSXkzMlgydWdWbThxcmpodENGTjN3SnFFMzRxbGQ2TnJ5?=
 =?utf-8?B?d2JHS1BQZjFtVGU4bVBTa1JNS2xIZlBxdHlMRjl6UXg4WCtNQkEyT0FjQ1ly?=
 =?utf-8?B?bm9DaW1scHFFU2R0NjE5bFllbTNQV1BBQ0t6eUZHTE5kcnRlU1V2Q010cFZE?=
 =?utf-8?B?ZVd5UXJZNmxkK0MyNW5PM2dhOHVaWTczTDQrV0t6Z0x3TFZhOFJMaHBNZEhr?=
 =?utf-8?B?QXI1Q0RycVdka1NoVC8rNXlnMUgzNkhNcXlLSUtGdU9pT0tJMlN4SS8wb3lW?=
 =?utf-8?B?TkVxL1FlSXpyNU0vU2tEYXByek1mT2VRZDNKWkh2RlptTnBURFI2dUdRUzlw?=
 =?utf-8?B?OURWMHV6czZZSlpmNjBBUi90R1lSUzQ1V2VkTy9lVEdtWmlZQlpZb2Y0OFZJ?=
 =?utf-8?B?QlRzSGU2dk5kbys1eWtyR1ozWk1xeEQrR1lHaTNqQU42MU1sTXY1SHdSZEZ6?=
 =?utf-8?B?NStaYUlZT0NMTjUvSDM5VjZSUStVL2hNL3dRZ2duN01helpidWUrQzlDRjJN?=
 =?utf-8?B?UCtqZTBmTlJOd1FBc1hnSU43eEZhRmw5NTU3UE91TWNDdk1uMGN1ZXNsTlFP?=
 =?utf-8?B?MWlpK0h2aTNZM1FZN2hpODhmM2hCMmJlZFh0SEQvNEdnbXNVYzdnTEV0U3Rw?=
 =?utf-8?B?aldPTWpqQ2hlbURTV25lMzJsMGdXL0hEUlNPS1FaVFpaaTc1cmtwQXlNZzYz?=
 =?utf-8?B?QjlOMFFLVUdodkN2SGVkSFY0TTEvZGliZUttRFRyc0ZTVHpGWW9XcmR4aXFF?=
 =?utf-8?B?OEJ5ZkpZV2lVa2FCSS9BK08vOVo3c2xKU2ZTc0pvd2tacU5SZUU3TWl4VEtv?=
 =?utf-8?B?Mk1aTVFFWUZFZjBvbllsR25FVlphc2YzWEp0N1prWU1NcjdqT3lkbHdQY3B0?=
 =?utf-8?B?RXpxMkw2NS9tRm5QMUJyWldjQS9EZ0JIWFhZNlU3MnA0N0NpRHptdUFRWWNr?=
 =?utf-8?Q?syFMpWHujQOhswy56o4lRpCTC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ecc4a5-f593-4660-8474-08dc9605646a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:28:28.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0yvdwMEZvIsez2HVc68QggfZpGj4oXywSpJI6Ag81Jjv6SyIf8VibD/h7zH6OpfrYyMy43dCpkpxefXxt+nrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516



On 6/26/2024 06:57, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 02:56:23PM -0500, Avadhut Naik wrote:
>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>> ACPI Boot Error Record Table (BERT) is being used by the kernel to
>> report errors that occurred in a previous boot. On some modern AMD
>> systems, these very errors within the BERT are reported through the
>> x86 Common Platform Error Record (CPER) format which consists of one
>> or more Processor Context Information Structures. These context
>> structures provide a starting address and represent an x86 MSR range
>> in which the data constitutes a contiguous set of MSRs starting from,
>> and including the starting address.
>>
>> It's common, for AMD systems that implement this behavior, that the
>> MSR range represents the MCAX register space used for the Scalable MCA
>> feature. The apei_smca_report_x86_error() function decodes and passes
>> this information through the MCE notifier chain. However, this function
>> assumes a fixed register size based on the original HW/FW implementation.
>>
>> This assumption breaks with the addition of two new MCAX registers viz.
>> MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
>> MCAX register space, so they won't be included when decoding the CPER
>> data.
>>
>> Rework apei_smca_report_x86_error() to support a variable register array
>> size. This covers any case where the MSR context information starts at
>> the MCAX address for MCA_STATUS and ends at any other register within
>> the MCAX register space.
>>
>> Add code comments indicating the MCAX register at each offset.
>>
>> [Yazen: Add Avadhut as co-developer for wrapper changes.]
>>
>> Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> This needs Avadhut's SOB after Yazen's.
> 
Will do. Will change to the below format:

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

> Touchups ontop:
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 7a15f0ca1bd1..6bbeb29125a9 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -69,7 +69,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  {
>  	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
> -	unsigned int cpu, num_registers;
> +	unsigned int cpu, num_regs;
>  	struct mce_hw_err err;
>  	struct mce *m = &err.m;
>  
> @@ -93,10 +93,10 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  	/*
>  	 * The number of registers in the register array is determined by
>  	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
> -	 * Ensure that the array size includes at least 1 register.
> +	 * Sanity-check registers array size.
>  	 */
> -	num_registers = ctx_info->reg_arr_size >> 3;
> -	if (!num_registers)
> +	num_regs = ctx_info->reg_arr_size >> 3;
> +	if (!num_regs)
>  		return -EINVAL;
>  
>  	mce_setup(m);
> @@ -118,13 +118,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  	/*
>  	 * The SMCA register layout is fixed and includes 16 registers.
>  	 * The end of the array may be variable, but the beginning is known.
> -	 * Switch on the number of registers. Cap the number of registers to
> -	 * expected max (15).
> +	 * Cap the number of registers to expected max (15).
>  	 */
> -	if (num_registers > 15)
> -		num_registers = 15;
> +	if (num_regs > 15)
> +		num_regs = 15;
>  
> -	switch (num_registers) {
> +	switch (num_regs) {
>  	/* MCA_SYND2 */
>  	case 15:
>  		err.vi.amd.synd2 = *(i_mce + 14);
> 
Will incorporate these.

-- 
Thanks,
Avadhut Naik

